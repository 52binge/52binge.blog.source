---
title: Leetcode SQL - Summary 1
date: 2022-06-09 09:07:21
categories: sql
tags: [BI]
icons: [fas fa-fire red, fas fa-star green]
thumbnail: https://cdn.jsdelivr.net/gh/xaoxuu/cdn-assets/proj/heartmate/icon.png
---

{% image "/images/bi/interview_make_rocket.jpg", width="400px", alt="" %}

<!-- more -->

## [猴子SQL](https://www.zhihu.com/people/houziliaorenwu)

## 1. SQL

[SQL Leetcode Plan](https://leetcode.cn/study-plan/sql/?progress=8qjpxl7)

### 1.1 IF / GROUP BY

1.1 [1699. Number of Calls Between Two Persons]()

```sql
SELECT 
    person1,person2, 
    count(*) call_count, 
    sum(duration) total_duration 
FROM 
(
    SELECT 
        IF(from_id>to_id, to_id, from_id) person1, 
        IF(from_id>to_id,from_id,to_id) person2, 
        duration  
    FROM 
        calls 
) c 
GROUP BY 
    person1, person2
```

### 1.2 BETWEEN sdate AND edate

1.2 [1251. 平均售价 average_price](https://leetcode.cn/study-plan/sql/?progress=8qjpxl7)

knowleage: **BETWEEN start_date AND end_date**

```sql
SELECT
    product_id,
    Round(SUM(sales) / SUM(units), 2) AS average_price
FROM (
    SELECT
        Prices.product_id AS product_id,
        Prices.price * UnitsSold.units AS sales,
        UnitsSold.units AS units
    FROM 
        Prices JOIN UnitsSold ON Prices.product_id = UnitsSold.product_id
    WHERE UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
) T
GROUP BY product_id
```

### 1.3 SUM / GROUP BY

1.3 [1571. Warehouse Manager](https://leetcode.cn/problems/warehouse-manager/)

知识: SUM / GROUP BY

```sql
SELECT 
    w.name WAREHOUSE_NAME,
    SUM(p.Width * p.Length * p.Height * w.units) VOLUME
FROM 
    warehouse w
LEFT JOIN 
    products p
ON 
    w.product_id = p.product_id
GROUP BY w.name;
```

### 1.4 SUM + CASE WHEN

1.4 [1445. Apples & Oranges](https://leetcode.cn/problems/apples-oranges/)

知识: SUM / CASE WHEN / GROUP BY / ORDER BY

```
SELECT 
    sale_date,
    SUM(CASE WHEN fruit='apples' THEN sold_num ELSE -sold_num END) AS diff
FROM sales
    GROUP BY sale_date
    ORDER BY sale_date;
```

### 1.5 COUNT / SUM / IF

1.5 [1193. Monthly Transactions I](https://leetcode.cn/problems/monthly-transactions-i/)

**理清逻辑, 冷静分析**

> **知识:** 
> 1. count(1)与count(*)得到的结果一致，包含null值。
> 2. count(字段)不计算null值
> 3. count(null)结果恒为0

知识: `DATE_FORMAT / COUNT / SUM / IF / GROUP BY` 

```sql
SELECT 
  DATE_FORMAT(trans_date, '%Y-%m') AS month, 
  country, 
  COUNT(*) AS trans_count, 
  COUNT(
    IF(state = 'approved', 1, NULL)
  ) AS approved_count, 
  SUM(amount) AS trans_total_amount, 
  SUM(
    IF(state = 'approved', amount, 0)
  ) AS approved_total_amount 
FROM 
  Transactions 
GROUP BY 
  month, 
  country
```

### 1.6 round(num, 2)

1.6 [1633. Percentage of Users Attended a Contest](https://leetcode.cn/problems/percentage-of-users-attended-a-contest/)

知识: `round(num, 2) / 子查询在SELECT里 / GROUP BY` [子查询在SELECT里 MYSQL 支持， Hive/Spark 不一定支持] 

```sql
select 
    contest_id,
    round(count(user_id) / (select count(1) from Users) * 100, 2) as percentage
from Register
group by contest_id
order by percentage desc,contest_id
```

1.7 [1173. Immediate Food Delivery I](https://leetcode.cn/problems/immediate-food-delivery-i/) 

```sql
select 
    round (
        sum(order_date = customer_pref_delivery_date) / count(*) * 100,
        2
    ) as immediate_percentage
from Delivery
```

### 1.8 AVG(rating<3) / SUM IF

1.8 [1211. Queries Quality and Percentage](https://leetcode.cn/problems/queries-quality-and-percentage/)

知识：**自从学会了AVG**  AVG(rating < 3) = AVG（条件）相当于sum（if（条件，1，0））/count(全体)

> 使用bool条件将多个样本判断为0和1，多个0和多个1的平均值就是1在整体中的比例，也即满足条件的样本在整体中的比例。

```SQL
SELECT 
    query_name, 
    ROUND(AVG(rating/position), 2) quality,
    ROUND(SUM(IF(rating < 3, 1, 0)) * 100 / COUNT(*), 2) poor_query_percentage
FROM Queries
GROUP BY query_name

==

SELECT query_name
	, round(AVG(rating / position), 2) AS quality
	, round(100 * AVG(rating < 3), 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;
```

### 1.9 DATE_FORMAT / NOT IN

1.9 [1607. Sellers With No Sales](https://leetcode.cn/problems/sellers-with-no-sales/)

```sql
-- DATE_FORMAT / WHERE NOT IN

SELECT 
    seller_name AS SELLER_NAME
FROM 
    Seller
WHERE 
    Seller.seller_id NOT IN (
        SELECT DISTINCT seller_id AS id FROM Orders WHERE DATE_FORMAT(sale_date, "%Y") = 2020
    )
ORDER BY SELLER_NAME;
``` 

### 1.10 Group by + Having

[619. Biggest Single Number](https://leetcode.cn/problems/biggest-single-number/)

having只用于group by分组统计语句

```sql
select 
    max(num) as num
from
    (
        select
            num
        from 
            MyNumbers
        group by num
        having count(num) = 1
    ) t
```

### 1.11 dense_rank() over (part

[1112. Highest Grade For Each Student](https://leetcode.cn/problems/highest-grade-for-each-student/)

```sql
# 窗口
select 
    student_id, 
    course_id, 
    grade 
from 
    (
        select 
            *,
            dense_rank() over (partition by student_id order by grade desc, course_id) rk 
        from enrollments
    ) t
where 
    rk=1
```

### 1.12 Having+SUM(IF / Count(IF)

[1398. Customers Who Bought Products A and B but Not C](https://leetcode.cn/problems/customers-who-bought-products-a-and-b-but-not-c/)

```sql
select 
    o.customer_id customer_id,
    c.customer_name customer_name
 from 
     orders o JOIN customers c ON o.customer_id = c.customer_id
 group by o.customer_id 
 having 
    SUM(IF(o.product_name='A',1,0)) > 0 
    AND SUM(IF(o.product_name='B',1,0)) > 0 
    AND SUM(IF(o.product_name='C',1,0))=0
```

## BigData

<center><embed src="/images/bi/2022最新大数据面试宝典.pdf" width="800" height="600"></center>



## Reference

- [🥕🥕🥕](https://www.zhihu.com/people/hongmianao)
- [从一个sql任务理解spark内存模型](https://zhuanlan.zhihu.com/p/134135758)
- [记录一次spark sql的优化过程](https://zhuanlan.zhihu.com/p/77614511)
- [spark sql多维分析优化——细节是魔鬼](https://zhuanlan.zhihu.com/p/78804934)
- [KuaiShou - Data Warehouse_Interview Questions](https://blog.csdn.net/weixin_43619485/article/details/107164729)
