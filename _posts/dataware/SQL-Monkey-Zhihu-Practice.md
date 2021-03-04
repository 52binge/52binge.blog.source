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


### [1. SQL： 如何查找重复数据？](https://zhuanlan.zhihu.com/p/353564155)

<img src="/images/sql/monkey-sql-having-count.png" width="590" alt="select 列名 from table group by 列名 having count(列名) > n;" />

### [2. SQL：如何查找第N高的数据？](https://zhuanlan.zhihu.com/p/101716138)

```sql
select 
    ifNull(
        (select distinct salary from Employee  order by Salary Desc limit 1,1),
        null
    ) as SecondHighestSalary;
```

> limit 1,n

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

### [7. SQL：经典topN问题](https://zhuanlan.zhihu.com/p/93346220)


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
