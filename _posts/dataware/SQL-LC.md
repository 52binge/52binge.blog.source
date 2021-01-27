---
top: 8
title: SQL@Leetcode
toc: true
date: 2021-01-26 09:07:21
categories: [data-warehouse]
tags: [data warehouse]
---

<img src="/images/sql/sql-50-logo.jpg" width="550" alt="" />

<!-- more -->

## [SQL Practice](https://leetcode-cn.com/problemset/database/)

No. | Question | Flag
:---: | --- | :---:
1. | ~~[175. Combine Two Tables](https://leetcode-cn.com/problems/combine-two-tables/)~~ | ❎
2. | [176. Second Highest Salary](https://leetcode-cn.com/problems/second-highest-salary/), **ORDER BY, OFFSET, IFNULL(xxx, NULL)** | ✔️
<br>3. | [177. Nth Highest Salary](https://leetcode-cn.com/problems/nth-highest-salary/), **CREATE FUNCTION func_name RETURNS INT** <br><br> [6种方案诠释MySQL通用查询策略](https://leetcode-cn.com/problems/nth-highest-salary/solution/mysql-zi-ding-yi-bian-liang-by-luanz/), BEGIN RETURN xxx/select END, SET | <br>✔️
4. | [178. Rank Scores](https://leetcode-cn.com/problems/rank-scores/),  摘要: [专用窗口函数rank, dense_rank, row_number有什么区别呢？](https://leetcode-cn.com/problems/rank-scores/solution/tu-jie-sqlmian-shi-ti-jing-dian-pai-ming-wen-ti-by/) <br><br> [《通俗易懂的学会：SQL窗口函数》](https://mp.weixin.qq.com/s?__biz=MzAxMTMwNTMxMQ==&mid=2649247566&idx=1&sn=f9c7018c299498673b38221db2ecd5cd&chksm=835fc77eb4284e68b7528fd7f75eedb8868a6740704af8559f8a5cbdd2867a49ffa21bf4e531&token=426730634&lang=zh_CN#rd)<br><br> &nbsp;&nbsp; select score, **dense_rank() over(order by Score desc)** as Ranking from Scores;
 | 
5. | [180. Consecutive Numbers](https://leetcode-cn.com/problems/consecutive-numbers/), <br> &nbsp;&nbsp; `l1.Id=l2.Id-1 AND l2.Id=l3.Id-1 AND l1.Num=l2.Num AND l2.Num=l3.Num` | ❎
6. | [184. Department Highest Salary](https://leetcode-cn.com/problems/department-highest-salary/), (Employee.DepartmentId , Salary) IN | ❎

### 176. Second Highest Salary

```
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
```

> If there is no second highest salary, then the query should return null.

```sql
SELECT IFNULL( 
    (SELECT DISTINCT Salary
    FROM Employee
    ORDER BY Salary DESC LIMIT 1 OFFSET 1),
         NULL) AS SecondHighestSalary 
```

### 177. Nth Highest Salary

MYSQL: CREATE FUNCTION 

```sql
CREATE FUNCTION func_name ( [func_parameter] ) //括号是必须的，参数是可选的
RETURNS type
[ characteristic ...] routine_body
```

LIMIT 用法：

```sql
mysql> SELECT * FROM orange LIMIT 5; 
mysql> SELECT * FROM orange LIMIT 0,5; 
mysql> SELECT * FROM orange LIMIT 10,15;  // 检索记录11-25

mysql> SELECT * FROM orange LIMIT 2 OFFSET 3;//查询4-5两条记录
mysql> SELECT * FROM orange  LIMIT 3,2;

mysql> SELECT * FROM orange LIMIT 95,-1; // 检索记录96-last
```

**getNthHighestSalary(N INT)**


```sql
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N := N-1; // 赋值语句 N = N-1
  RETURN (
      # Write your MySQL query statement below.
      SELECT 
            salary
      FROM 
            employee
      GROUP BY 
            salary
      ORDER BY 
            salary DESC
      LIMIT N, 1
  );
END
```

### 180. Consecutive Numbers

```sql
SELECT DISTINCT
    #l2.*,
    l1.Num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num
;
```

### 184. Department Highest Salary

```sql
SELECT
    Department.name AS 'Department',
    Employee.name AS 'Employee',
    Salary
FROM
    Employee
        JOIN
    Department ON Employee.DepartmentId = Department.Id
WHERE
    (Employee.DepartmentId , Salary) IN
    (   SELECT
            DepartmentId, MAX(Salary)
        FROM
            Employee
        GROUP BY DepartmentId
	)
;
```

## Reference

- [Mysql自定义变量的使用](https://www.jianshu.com/p/357a02fb2d64)
- [常见的SQL面试题：经典50题 - 知乎](https://zhuanlan.zhihu.com/p/38354000)


