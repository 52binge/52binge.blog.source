---
title: Data Analysis - SQL 50
toc: true
date: 2021-01-05 09:07:21
categories: [data-warehouse]
tags: [data warehouse]
---

<img src="/images/sql/sql-50-logo.jpg" width="550" alt="" />

<!-- more -->

> 其中重点为：1/2/5/6/7/10/11/12/13/15/17/18/19/22/23/25/31/35/36/40/41/42/45/46 共16题
>
> 超级重点 18和23、 22和25 、 41、46

**(1). 查询课程编号为“01”的课程比“02”的课程成绩高的所有学生的学号（重点）**

```sql
SELECT
    t1.s_id as t1_s_id,
    t2.s_id as t2_s_id,
    t3.s_name,
    t1.s_score as s_score_01,
    t2.s_score as s_score_02
FROM
    (select s_id, c_id, s_score from Score WHERE c_id = '01') as t1
INNER JOIN
    (select s_id, c_id, s_score from Score WHERE c_id = '02') as t2
ON t1.s_id = t2.s_id
INNER JOIN
    Student as t3 
ON t1.s_id = t3.s_id
where t1.s_score > t2.s_score
```

## DISTINCT


```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;

SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND condition3 ...;
```

```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);

SELECT MIN(column_name), MAX(column_name), COUNT, AVG, SUM
FROM table_name
WHERE condition;
```

## BETWEEN ... AND

```sql
SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value1 AND value2;

SELECT *
FROM Orders
LEFT JOIN Customers

SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;
```

## HAVING


```sql
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;
```

## UNION

```sql
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;
```

