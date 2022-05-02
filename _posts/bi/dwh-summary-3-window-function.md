---
title: data-warehouse review 3 - Window Function
date: 2021-02-20 09:07:21
categories: bi
tags: [data warehouse, SQL]
---

{% image "/images/sql/sql-window-fun-4.png", width="500px", alt="（Window Function）是 SQL2003 标准中定义的一项新特性，并在 SQL2011、SQL2016 中完善" %}

<!-- more -->

`Window Function` 不同于 普通函数和聚合函数，它为每行数据进行一次计算：**输入多行(一个窗口), 返回一个值**. 

## 1. Window Function, SQL

特点就是 OVER 关键字:

```sql
window_function (expression) OVER (
   [ PARTITION BY part_list ]
   [ ORDER BY order_list ]
   [ { ROWS | RANGE } BETWEEN frame_start AND frame_end ] )

# 1. PARTITION BY 表示将数据先按 part_list 进行分区
# 2. ORDER BY 表示将各个分区内的数据按 order_list 进行排序
```

{% image "/images/sql/sql-window-fun-5.jpg", width="780px", alt="" %}

最后一项表示 Frame 的定义，即：当前窗口包含哪些数据？

type | frame sql | example
:---: | --- | :---:
**ROWS** | ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING | 表示往前 3 行到往后 3 行，一共 7 行数据（或小于 7 行，如果碰到了边界）
**RANGE** | RANGE BETWEEN 3 PRECEDING AND 3 FOLLOWING | 表示所有值在 $[c-3,c+3]$ 这个范围内的行，$c$ 为当前行的值

{% image "/images/sql/sql-window-fun-6.png", width="780px", alt="" %}

逻辑语义上说，一个窗口函数的计算“过程”如下：

> 1. 按窗口定义，将所有输入数据分区、再排序（如果需要的话）
> 2. 对每一行数据，计算它的 Frame 范围
> 3. 将 Frame 内的行集合输入窗口函数，计算结果填入当前行

举个例子：

```sql
SELECT dealer_id, emp_name, sales,
       ROW_NUMBER() OVER (PARTITION BY dealer_id ORDER BY sales) AS rank,
       AVG(sales) OVER (PARTITION BY dealer_id) AS avgsales 
FROM sales

# 上述查询中，rank 列表示在当前经销商下，该雇员的销售排名；
# avgsales 表示当前经销商下所有雇员的平均销售额。查询结果如下
+------------+-----------------+--------+------+---------------+
| dealer_id  | emp_name        | sales  | rank | avgsales      |
+------------+-----------------+--------+------+---------------+
| 1          | Raphael Hull    | 8227   | 1    | 14356         |
| 1          | Jack Salazar    | 9710   | 2    | 14356         |
| 1          | Ferris Brown    | 19745  | 3    | 14356         |
| 1          | Noel Meyer      | 19745  | 4    | 14356         |
| 2          | Haviva Montoya  | 9308   | 1    | 13924         |
| 2          | Beverly Lang    | 16233  | 2    | 13924         |
| 2          | Kameko French   | 16233  | 3    | 13924         |
| 3          | May Stout       | 9308   | 1    | 12368         |
| 3          | Abel Kim        | 12369  | 2    | 12368         |
| 3          | Ursa George     | 15427  | 3    | 12368         |
+------------+-----------------+--------+------+---------------+

# 注：Frame 定义并非所有窗口函数都适用，比如 ROW_NUMBER()、RANK()、LEAD() 等。这些函数总是应用于整个分区，而非当前 Frame
```

{% image "/images/sql/sql-window-fun-7.png", width="780px", alt="SQL 各部分的逻辑执行顺序" %}

## 2. Window Function, Hive/Spark

```sql
create table window_test_table (
    id int,    --用户id
    sq string,  --可以标识每个商品
    cell_type int, --标识每个商品的类型，比如广告，非广告
    rank int  --这次搜索下商品的位置，比如第一个广告商品就是1，后面的依次2，3，4...
)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
```

{% image "/images/sql/sql-window-fun-1.jpg", width="580px", alt="" %}

{% image "/images/sql/sql-window-fun-2.jpg", width="580px", alt="" %}


业务方的实现方法：

```sql
--业务方的写法
select 
    id,
    sq,
    cell_type,
    rank,
    if(cell_type!=26,row_number() over(partition by id order by rank),null) naturl_rank  
from window_test_table order by rank;
```

{% image "/images/sql/sql-window-fun-3.jpg", width="580px", alt="" %}

## 2. Window Function Principle

```sql
select
    row_number() over( partition by col1 order by col2 ) 
from table
```

### 2.1 window function part

windows函数部分就是所要在窗口上执行的函数，spark支持三中类型的窗口函数：

No. | title | example
:---: | --- | :---:
1. | Aggregate functions (聚合函数) | AVG(), COUNT(), MIN(), MAX(), SUM()
2. | Ranking functions (排序函数) | RANK(), DENSE_RANK(), ROW_NUMBER(), NTILE()
3. | Analytic functions (分析窗口函数) | FIRST_VALUE(), LAST_VALUE(), LEAD(), LAG() <br> cume_dist函数计算当前值在窗口中的百分位数

### 2.2 window Function 实现原理

窗口函数的实现，主要借助 Partitioned Table Function （即PTF）；

```sql
 select 
    id,
    sq,
    cell_type,
    rank,
    row_number() over(partition by id  order by rank ) naturl_rank,
    rank() over(partition by id order by rank) as r,
    dense_rank() over(partition by  cell_type order by id) as dr  
 from window_test_table 
 group by id,sq,cell_type,rank;
```

数据流转如下图：

{% image "/images/sql/sql-window-fun-8.jpg", width="880px", alt="" %}


## Reference

- [SQL 窗口函数的优化和执行](https://zhuanlan.zhihu.com/p/80051518)
- [【社招】快手_数据仓库_面试题整理](https://blog.csdn.net/weixin_43619485/article/details/107164729)
- [2020年大厂面试题-数据仓库篇](https://my.oschina.net/u/4631230/blog/4688808)
- [『 Spark 』14. 一次 Spark SQL 性能提升10倍的经历](http://bigdatastudy.net/show.aspx?id=450&cid=9)
- [Spark教程-Spark 性能优化——和 shuffle 搏斗](http://bigdatastudy.net/show.aspx?id=544&cid=9)
- [spark中的spark Shuffle详解1](http://bigdatastudy.net/show.aspx?id=531&cid=9)
- [Spark-SQL性能优化](https://blog.csdn.net/S_Running_snail/article/details/89282009) 