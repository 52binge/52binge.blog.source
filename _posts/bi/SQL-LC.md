---
title: SQL@Leetcode
date: 2021-01-26 09:07:21
categories: sql
tags: [SQL]
---

{% image "/images/sql/sql-50-logo.jpg", width="500px", alt="" %}

<!-- more -->

## [SQL Practice](https://leetcode-cn.com/problemset/database/)

## [图解SQL面试题：经典50题](https://zhuanlan.zhihu.com/p/38354000)

No. | Question | Flag
:---: | --- | :---:
1. | ~~[175. Combine Two Tables](https://leetcode-cn.com/problems/combine-two-tables/)~~ | ❎
2. | [176. Second Highest Salary](https://leetcode-cn.com/problems/second-highest-salary/), **ORDER BY, OFFSET, IFNULL(xxx, NULL)** <br> SELECT DISTINCT Salary FROM Employee <br> ORDER BY Salary DESC LIMIT 1 OFFSET 1 | ✔️
<br>3. | [177. Nth Highest Salary](https://leetcode-cn.com/problems/nth-highest-salary/), **CREATE FUNCTION func_name RETURNS INT** <br><br> [6种方案诠释MySQL通用查询策略](https://leetcode-cn.com/problems/nth-highest-salary/solution/mysql-zi-ding-yi-bian-liang-by-luanz/), BEGIN RETURN xxx/select END, SET | <br>✔️
4. | [178. Rank Scores](https://leetcode-cn.com/problems/rank-scores/),  摘要: [专用窗口函数rank, dense_rank, row_number有什么区别呢？](https://leetcode-cn.com/problems/rank-scores/solution/tu-jie-sqlmian-shi-ti-jing-dian-pai-ming-wen-ti-by/) <br><br> [《通俗易懂的学会：SQL窗口函数》](https://mp.weixin.qq.com/s?__biz=MzAxMTMwNTMxMQ==&mid=2649247566&idx=1&sn=f9c7018c299498673b38221db2ecd5cd&chksm=835fc77eb4284e68b7528fd7f75eedb8868a6740704af8559f8a5cbdd2867a49ffa21bf4e531&token=426730634&lang=zh_CN#rd)<br><br> &nbsp;&nbsp; select score, **dense_rank() over(order by Score desc)** as Ranking from Scores;
 | 
5. | [180. Consecutive Numbers](https://leetcode-cn.com/problems/consecutive-numbers/), <br> &nbsp;&nbsp; `l1.Id=l2.Id-1 AND l2.Id=l3.Id-1 AND l1.Num=l2.Num AND l2.Num=l3.Num` | ❎
6. | [185 Department Top Three Salaries](https://leetcode-cn.com/problems/department-top-three-salaries), dense_rank() over (partition by x order by y desc) | ❎  
7. | [184. Department Highest Salary](https://leetcode-cn.com/problems/department-highest-salary/), (Employee.DepartmentId , Salary) IN | ❎
8. | .. | ..
9. | [196. Delete Duplicate Emails](https://leetcode-cn.com/problems/delete-duplicate-emails/), &nbsp;&nbsp; ["delete" 和 ">" 的解释，推荐！](https://leetcode-cn.com/problems/delete-duplicate-emails/solution/dui-guan-fang-ti-jie-zhong-delete-he-de-jie-shi-by/) | ❎
10. | [181. Employees Earning More Than Their Managers](https://leetcode-cn.com/problems/employees-earning-more-than-their-managers/), 1. 笛卡尔积+WHERE 2. 自连接+ON | ❎
11. | [1179. Reformat Department Table](https://leetcode-cn.com/problems/reformat-department-table/), CASE WHEN condition1 THEN result1 END  |
12. | [182. Duplicate Emails](https://leetcode-cn.com/problems/duplicate-emails/), 使用 GROUP BY 和 HAVING 条件 | ❎
13. | [197. Rising Temperature](https://leetcode-cn.com/problems/rising-temperature/), JOIN ... ON DATEDIFF(w1.recordDate, w2.recordDate) = 1 | 
14. | [601. Human Traffic of Stadium](https://leetcode-cn.com/problems/human-traffic-of-stadium/) | 未
15. | ~~[183. 从不订购的客户](https://leetcode-cn.com/problems/customers-who-never-order/)~~ NOT IN | ❎
16. | [627. Swap Salary 变更性别](https://leetcode-cn.com/problems/swap-salary/)， sex=`CASE WHEN sex='m' THEN 'f' ELSE 'm' END`; | ❎
17. | [626. Exchange Seats 换座位](https://leetcode-cn.com/problems/exchange-seats/), (CASE WHEN MOD(id,2) END) AS id FROM table1, 5  | ❎

### 627. Swap Salary 变更性别

```sql
UPDATE salary
SET
    sex = 
        CASE
            WHEN sex='m' THEN 'f'
            ELSE 'm'
        END;

学习要点：     
SELECT OrderID, Quantity,
CASE 
  WHEN Quantity > 30 THEN 'The quantity is greater than 30'
  WHEN Quantity = 30 THEN 'The quantity is 30'
  ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;
```

### 626. Exchange Seats 换座位

```sql
SELECT
    (CASE
        WHEN MOD(id, 2) != 0 AND counts != id THEN id + 1
        WHEN MOD(id, 2) != 0 AND counts = id THEN id
        ELSE id - 1
    END) AS id,
    student
FROM
    seat,
    (SELECT
        COUNT(*) AS counts
    FROM
        seat) AS seat_counts
ORDER BY id ASC;
```

---

```sql
DELETE p1 FROM Person p1,
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id
```

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

学习要点： OFFSET 
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

### 185. Department Top Three Salaries

```sql
# Write your MySQL query statement below
SELECT 
    t2.Name as Department, 
    t1.Name as Employee, 
    t1.Salary
FROM
(
SELECT DepartmentId,Name,Salary
FROM (
   SELECT *, 
          dense_rank() over (partition by DepartmentId
                       order by Salary desc) as ranking
   FROM Employee) as a
WHERE ranking <= 3
) t1
JOIN Department t2
ON t1.DepartmentId = t2.Id
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


### 181. Employees Earning More Than Their Managers


```sql
SELECT
     a.NAME AS Employee
FROM Employee AS a JOIN Employee AS b
     ON a.ManagerId = b.Id
     AND a.Salary > b.Salary
;
```

### 1179. Reformat Department Table

```sql
# Write your MySQL query statement below
select id,
    sum(case month when 'Jan' then revenue end) as Jan_Revenue,
    sum(case month when 'Feb' then revenue end) as Feb_Revenue,
    sum(case month when 'Mar' then revenue end) as Mar_Revenue,
    sum(case month when 'Apr' then revenue end) as Apr_Revenue,
    sum(case month when 'May' then revenue end) as May_Revenue,
    sum(case month when 'Jun' then revenue end) as Jun_Revenue,
    sum(case month when 'Jul' then revenue end) as Jul_Revenue,
    sum(case month when 'Aug' then revenue end) as Aug_Revenue,
    sum(case month when 'Sep' then revenue end) as Sep_Revenue,
    sum(case month when 'Oct' then revenue end) as Oct_Revenue,
    sum(case month when 'Nov' then revenue end) as Nov_Revenue,
    sum(case month when 'Dec' then revenue end) as Dec_Revenue
from Department
group by id
```

CASE WHEN condition1 THEN result1 END 

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;

SELECT CustomerName, City, Country
FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END);

CASE case_value
    WHEN when_value THEN statement_list
    [WHEN when_value THEN statement_list] ...
    [ELSE statement_list]
END CASE

CASE
    WHEN search_condition THEN statement_list
    [WHEN search_condition THEN statement_list] ...
    [ELSE statement_list]
END CASE
```

### 197. Rising Temperature

```sql
SELECT
    w1.id AS 'Id'
FROM
    weather as w1
        JOIN
    weather as w2 
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
AND w1.Temperature > w2.Temperature;
```

## concat_ws

```sql
SELECT CONCAT_WS("-", "SQL", "Tutorial", "is", "fun!") AS ConcatenatedString;

# output:
#
# ConcatenatedString
# SQL-Tutorial-is-fun!        
```





<details>
<summary>EVT Topic</summary>
## Data Warehouse

建模： 说白了就是表字段设计

1. 了解业务场景


平台维度
  平台的收入，平台订单完成率 平台订单数量变化
最近7日，15日，30日，60日，90日

建模

主题确定，维度退化，轻度聚合

如何把建模说的高大上一些：

atlas

jdbc会把tinyint 认为是java.sql.Types.BIT，然后sqoop就会转为Boolean了。
在连接上加上一句话tinyInt1isBit=false

Mysql中存在tinyint(1)时，在数据导入到HDFS时，该字段默认会被转化为boolean数据类型。导致数据内容丢失。

tinyInt1isBit=false

[sqoop从mysql导入hive中tinyint类型变成了boolean类型的问题](https://blog.csdn.net/qq_36579777/article/details/86475680?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.control)
</details>

```
mysql.server restart --init-file=/Users/blair/init.sql
```

## Reference

- [hive lateral view 与 explode详解](https://blog.csdn.net/bitcarmanlee/article/details/51926530)
- [w3schools sql](https://www.w3schools.com/sql/func_mysql_concat_ws.asp)
- [Mysql自定义变量的使用](https://www.jianshu.com/p/357a02fb2d64)
- [常见的SQL面试题：经典50题 - 知乎](https://zhuanlan.zhihu.com/p/38354000)
- [Spark SQL 和 传统 SQL 的区别](https://blog.csdn.net/Han_Lin_/article/details/86541482)
- [MySQL root密码忘记，原来还有更优雅的解法！](https://www.cnblogs.com/ivictor/p/9243259.html)

[hive 行转列 lateral view explode](https://blog.csdn.net/weixin_38987362/article/details/80702388?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.control)
[Hive Lateral view介绍](https://blog.csdn.net/youziguo/article/details/6837368?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.control)

[缓慢变化维的10种方式](https://juejin.cn/post/6844904137419669517)


