# [1454. 活跃用户](https://leetcode.cn/problems/active-users)

[English Version](/solution/1400-1499/1454.Active%20Users/README_EN.md)

## 题目描述

<!-- 这里写题目描述 -->

<p>表 <code>Accounts</code>:</p>

<pre>
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id 是该表主键.
该表包含账户 id 和账户的用户名.
</pre>

<p> </p>

<p>表 <code>Logins</code>:</p>

<pre>
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| login_date    | date    |
+---------------+---------+
该表无主键, 可能包含重复项.
该表包含登录用户的账户 id 和登录日期. 用户也许一天内登录多次.
</pre>

<p> </p>

<p>写一个 SQL 查询,  找到活跃用户的 id 和 name.</p>

<p>活跃用户是指那些至少连续 5 天登录账户的用户.</p>

<p>返回的结果表按照 id 排序.</p>

<p>结果表格式如下例所示:</p>

<pre>
Accounts 表:
+----+----------+
| id | name     |
+----+----------+
| 1  | Winston  |
| 7  | Jonathan |
+----+----------+

Logins 表:
+----+------------+
| id | login_date |
+----+------------+
| 7  | 2020-05-30 |
| 1  | 2020-05-30 |
| 7  | 2020-05-31 |
| 7  | 2020-06-01 |
| 7  | 2020-06-02 |
| 7  | 2020-06-02 |
| 7  | 2020-06-03 |
| 1  | 2020-06-07 |
| 7  | 2020-06-10 |
+----+------------+

Result 表:
+----+----------+
| id | name     |
+----+----------+
| 7  | Jonathan |
+----+----------+
id = 1 的用户 Winston 仅仅在不同的 2 天内登录了 2 次, 所以, Winston 不是活跃用户.
id = 7 的用户 Jonathon 在不同的 6 天内登录了 7 次, , 6 天中有 5 天是连续的, 所以, Jonathan 是活跃用户.
</pre>

<p> </p>

<p><strong>进阶问题:</strong><br />
如果活跃用户是那些至少连续 <code>n</code> 天登录账户的用户, 你能否写出通用的解决方案?</p>

## 解法

<!-- 这里可写通用的实现逻辑 -->

<!-- tabs:start -->

### **SQL**

```sql
# Write your MySQL query statement below
WITH t AS
    (SELECT *,
		 sum(id) over(partition by id
    ORDER BY  login_date range interval 4 day preceding)/id cnt
    FROM
        (SELECT DISTINCT *
        FROM Accounts
        JOIN Logins using(id) ) tt )
    SELECT DISTINCT id,
		 name
FROM t
WHERE cnt=5;
```

<!-- tabs:end -->
