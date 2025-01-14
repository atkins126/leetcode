SELECT
    student_id,
    course_id,
    grade
FROM
    (
        SELECT
            *,
            RANK() OVER (
                PARTITION BY student_id
                ORDER BY grade DESC, course_id
            ) AS rk
        FROM Enrollments
    ) AS a
WHERE a.rk = 1;
