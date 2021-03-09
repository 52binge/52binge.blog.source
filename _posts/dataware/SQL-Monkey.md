---
top: 8
title: 猴子的图解SQL 学习笔记
toc: true
date: 2021-03-03 09:07:21
categories: [data-warehouse]
tags: [data warehouse]
---

<img src="/images/sql/sql-50-logo.jpg" width="550" alt="" />

<!-- more -->

1. SQL 的书写规则是什么？
2. 如何指定查询条件？
3. SQL 是如何运行的？

> 学生表：student(学号,学生姓名,出生年月,性别)
>
> 成绩表：score(学号,课程号,成绩)
>
> 课程表：course(课程号,课程名称,教师号)
>
> 教师表：teacher(教师号,教师姓名)


### [1. SQL：查找重复数据？](https://zhuanlan.zhihu.com/p/353564155)

知识: **`group by 列名 having count(列名) > n`**

<img src="/images/sql/monkey-sql-having-count.png" width="590" alt="select 列名 from table group by 列名 having count(列名) > n;" />

### [2. SQL：如何查找第N高的数据？](https://zhuanlan.zhihu.com/p/101716138)

```sql
select 
    ifNull(
        (select distinct salary from Employee  order by Salary Desc limit 1,1),
        null
    ) as SecondHighestSalary;
```

知识: `limit 1,n`

### [3. SQL：查找不在表里的数据](https://zhuanlan.zhihu.com/p/88351106)

<img src="/images/sql/monkey-sql-join-1.jpg" width="590" alt="left join, inner join" />

<img src="/images/sql/monkey-sql-join-2.jpg" width="590" alt="" />

```sql
select 
    a.Name as Customers
from 
    Customers as a left join Orders as b
on a.Id=b.CustomerId
where b.CustomerId is null;
```

### [4. SQL：你有多久没涨过工资了？](https://zhuanlan.zhihu.com/p/142872080)

<img src="/images/sql/monkey-sql-salary.jpg" width="590" alt="left join, inner join" />

### [5. SQL：如何比较日期数据？](https://zhuanlan.zhihu.com/p/95768329)

<img src="/images/sql/monkey-sql-date-compare-1.jpg" width="590" alt="" />

<img src="/images/sql/monkey-sql-date-compare-2.jpg" width="590" alt="" />


[举一反三： Weather](https://leetcode-cn.com/problems/rising-temperature/solution/shang-sheng-de-wen-du-by-leetcode/)

```sql
select a.ID, a.date
from weather as a cross join weather as b 
     on timestampdiff(day, a.date, b.date) = -1
where a.temp > b.temp;
```

### [6. DiDi: 如何找出最小的N个数？](https://zhuanlan.zhihu.com/p/338648536)

1.筛选出2017年入学的“计算机”专业年龄最小的3位同学名单（姓名、年龄）
2.统计每个班同学各科成绩平均分大于80分的人数和人数占比

<img src="/images/sql/monkey-sql-min_N_nums-1.png" width="590" alt="" />

<img src="/images/sql/monkey-sql-min_N_nums-2.jpg" width="590" alt="" />

<img src="/images/sql/monkey-sql-min_N_nums-4.jpg" width="590" alt="" />

<img src="/images/sql/monkey-sql-min_N_nums-5.jpg" width="590" alt="" />

<img src="/images/sql/monkey-sql-min_N_nums-6.png" width="590" alt="" />

<img src="/images/sql/monkey-sql-min_N_nums-7.jpg" width="590" alt="" />



考点:

1.使用逻辑树分析方法将复杂问题变成简单问题的能力
2.当遇到“每个”问题的时候，要想到用分组汇总
3.查询最小n个数据的问题：先排序（order by），然后使用limit取出前n行数据
4.遇到有筛选条件的统计数量问题时，使用case表达式筛选出符合条件的行为1，否则为0。然后用汇总函数（sum）对case表达式输出列求和。



## [7. 拼夕夕：连续出现N次的内容？](https://zhuanlan.zhihu.com/p/348022888)

#### 方法1： 自连接

```sql
SELECT
    *
FROM
    Score AS a,
    Score AS b,
    Score AS c
WHERE
    a.s_id = b.s_id - 1 
    AND b.s_id = c.s_id - 1 
    AND a.s_score = b.s_score 
    AND b.s_score = c.s_score; 


SELECT
    DISTINCT a.s_score as 最终答案
FROM
    Score AS a,
    Score AS b,
    Score AS c
WHERE
    a.s_id = b.s_id - 1 
    AND b.s_id = c.s_id - 1 
    AND a.s_score = b.s_score 
    AND b.s_score = c.s_score; 
```

#### 方法2： window function

```sql
SELECT DISTINCT
    球员姓名 
FROM
    (
    SELECT
        球员姓名,
        lead ( 球员姓名, 1 ) over ( PARTITION BY 球队 ORDER BY 得分时间 ) AS 姓名1,
        lead ( 球员姓名, 2 ) over ( PARTITION BY 球队 ORDER BY 得分时间 ) AS 姓名2 
    FROM
        分数表 
    ) AS a 
WHERE
    (
        a.球员姓名 = a.姓名1
    AND a.球员姓名 = a.姓名2
    );
```

### [10. SQL：经典topN问题](https://zhuanlan.zhihu.com/p/93346220)


```sql
select *
from (
   select *, 
          row_number() over (partition by 姓名
                       order by 成绩 desc) as ranking
   from 成绩表) as a
where ranking <=2
```

## Reference

- [图解SQL面试题：经典50题](https://zhuanlan.zhihu.com/p/38354000)
- [7张图学会SQL](https://mp.weixin.qq.com/s?__biz=MzAxMTMwNTMxMQ==&mid=2649245863&idx=1&sn=2c3a1e3e8cacf5e4e211758c47619f3e&chksm=835fc097b4284981de23eb6e09259d34963fbd3c1e6bf6c56b7d97bf3f7be816b29572f32d85&scene=21#wechat_redirect)
- [图解面试题](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzAxMTMwNTMxMQ==&action=getalbum&album_id=1398781984763428865&scene=173&from_msgid=2649245863&from_itemidx=1&count=3#wechat_redirect)
- [数据仓库工具箱 维度建模权威指南 第3版.pdf](https://www.cnblogs.com/fly-bird/articles/11332515.html)