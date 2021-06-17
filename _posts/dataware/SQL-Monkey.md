---
top: 8
title: 猴子的图解SQL 学习笔记
date: 2021-02-01 09:07:21
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

> RAND() Function 0 <= ret < 1
>
> 1~100 -> SELECT FLOOR(1 + (RAND() * 100)) LIMIT 10;
>
> IF(expr1,expr2,expr3)
>
> SELECT CustomerName, CONCAT("H1", " H2 ", RAND()), 
> CONCAT(Address, " ", PostalCode, " ", City) AS Address FROM Customers;

<details>
<summary>#SQL 如何查询关于【连续几天】的问题</summary>
<p></p>

```sql
SELECT
	id,
	created_at,
	CURDATE( ), -- 2021-03-18
	DATE(created_at), -- 2019-11-21
	DATE(created_at) - 1  -- 20191120
FROM
	users 
	LIMIT 5;

SELECT
    user_id,
    MAX( count_date_on ) 
FROM
    (
        (
        SELECT
            user_id,
            count( date_on ) count_date_on 
        FROM
            (
            SELECT
                user_id,
                date,
                row_number ( ) over ( PARTITION BY USER ORDER BY date DESC ) rnk,
                date - ( MAX( date ) - rnk ) date_on 
            FROM
                TB 
            GROUP BY
                user_id 
            ) A 
        GROUP BY
            user_id,
            date_on 
        ) 
    ) B 
GROUP BY
    user_id
```
</details>

### [1. SQL：查找重复数据？](https://zhuanlan.zhihu.com/p/353564155)

知识: **`group by 列名 having count(列名) > n`**

<img src="/images/sql/monkey-sql-having-count.png" width="590" alt="select 列名 from table group by 列名 having count(列名) > n;" />

举一反三: 查询平均成绩大于60分的学生的学号和平均成绩

```sql
select 学号 ,avg(成绩) from score 
group by 学号  
having avg(成绩 ) >60
```

查询各学生的年龄（精确到月份）

```sql
/*
【知识点】时间格式转化 timestampdiff
*/
select 学号 ,timestampdiff(month ,出生日期 ,now())/12 
from student ;
```

### [2. SQL：如何查找第N高的数据？](https://zhuanlan.zhihu.com/p/101716138)

```sql
select 
    ifNull(
        (select distinct salary from Employee order by Salary Desc limit 1,1),
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

## [10. SQL：经典topN问题](https://zhuanlan.zhihu.com/p/93346220)


```sql
select *
from (
   select *, 
          row_number() over (partition by 姓名
                       order by 成绩 desc) as ranking
   from 成绩表) as a
where ranking <=2
```

## [11. 链家：如何分析留存率？](https://zhuanlan.zhihu.com/p/151357806)

input:

<img src="/images/sql/monkey-sql-lianjia-1-user-retention.png" width="740" alt="如何分析留存率" />

**指标定义：**

1. 某日活跃用户数，某日活跃的去重用户数。
2. N日活跃用户数，某日活跃的用户数在之后的第N日活跃用户数。
3. N日活跃留存率，N日留存用户数/某日活跃用户数

> 例：登陆时间（20180501日）去重用户数10000，这批用户在20180503日仍有7000人活跃，则3日活跃留存率为7000/10000=70%

<img src="/images/sql/monkey-sql-lianjia-2.png" width="740" alt="output" />

**11.1 活跃用户数对应的日期**

```sql
SELECT
    登陆时间,
    count( DISTINCT 用户id ) AS 活跃用户数 
FROM
    用户行为信息表 
WHERE
    应用名称 = '相机' 
GROUP BY
    登陆时间;
```

<img src="/images/sql/monkey-sql-lianjia-5-active-users.png" width="640" alt="" />


**11.2 次日留存用户数** 

次日留存用户数：在今日登录，明天也有登录的用户数。也就是时间间隔=1

一个表如果涉及到时间间隔，就需要用到自联结，也就是将两个相同的表进行联结

```sql
SELECT
    *,
    count(DISTINCT CASE WHEN 时间间隔 = 1 THEN 用户id ELSE NULL END) AS 次日留存数 
    FROM
        (SELECT *, timestampdiff(DAY, a_t, b_t ) AS 时间间隔 FROM c) 
GROUP BY
    a_t;
```

<img src="/images/sql/monkey-sql-lianjia-6-active-users.jpeg" width="740" alt="次日留存用户数" />

<!--
<img src="/images/sql/monkey-sql-lianjia-3.jpeg" width="740" alt="" />
-->

**11.3 三日的留存数/留存率**

```sql
select 
    a_t,
    count(distinct 用户id) as 活跃用户数,
    count(distinct case when 时间间隔=1 then 用户id else null end) as  次日留存数,
    count(distinct case when 时间间隔=1 then 用户id else null end)/ count(distinct 用户id) as 次日留存率,
    count(distinct case when 时间间隔=3 then 用户id else null end) as  三日留存数,
    count(distinct case when 时间间隔=3 then 用户id else null end)/ count(distinct 用户id) as 三日留存率,
    count(distinct case when 时间间隔=7 then 用户id else null end) as  七日留存数,
    count(distinct case when 时间间隔=7 then 用户id else null end)/ count(distinct 用户id) as 七日留存率
from
    (
     SELECT
         c.用户id,
         timestampdiff(day, c.a_t, c.b_t) as 时间间隔
    FROM 
        (
        SELECT 
            a.用户id, 
            a.登陆时间 as a_t,
            b.登陆时间 as b_t 
        FROM 用户行为信息表 as a left join 用户行为信息表 as b on a.用户id = b.用户id where a.应用名称= '相机'
        ) as c
    ) as d
group by a_t;
```

<img src="/images/sql/monkey-sql-lianjia-4.jpeg" width="840" alt="" />

**11.4 本题考点**

1. 常用指标的理解，例如留存用户数、留存率。
2. 灵活使用case来统计when 函数与group by 进行自定义列联表统计。
3. 遇到只有一个表，但是需要计数时间间隔的问题，就要想到用自联结来求时间间隔，类似的有找出连续出现N次的内容、滴滴2020求职真题。

## [12. 如何分析用户满意度？](https://zhuanlan.zhihu.com/p/107150787)

“满意度表”记录了教师和学生对课程的满意程度。“是否满意”列里是老师和学生对课程的评价，其中“是”表示教师和学生都满意。

<img src="/images/sql/monkey-user-satisfaction-1.jpeg" width="700" alt="" />

“ 用户表”记录了学校教师和学生的信息。每个用户有唯一键 “编号”，“是否在系统”表示这个用户是否还在这所学校里，“角色”表示这个人是学生还是教师。

两个表的关系：满意度表的“学生编号” 、 “教师编号” 和用户表的 “编号” 联结。

<img src="/images/sql/monkey-user-satisfaction-2.jpeg" width="700" alt="" />

现在需要分析出学校里人员对课程的满意度。满意度的计算方式如下：

(教师和学生对课程都满意且已存在当前教务系统中的用户) / (在学校里的人数)

```sql
select 
    sum(case when 满意度表.是否满意='是' then 1 else 0 end)/count(满意度表.是否满意) as 满意度
from 满意度表 
left join 
    (select 编号 from 用户表 where 是否在系统='是') as 学生
on (满意度表.学生编号 = 学生.编号)
left join
    (select 编号 from 用户表 where 是否在系统='是') as 教师
on (满意度表.教师编号 = 教师.编号);
```

## [14. 拼多多：如何查找前20%的数据？](https://zhuanlan.zhihu.com/p/138128536)

<img src="/images/sql/monkey-sql-pdd-20-percent-2.jpeg" width="700" alt="" />

把这个复杂的问题拆解为3个子问题：

1）找出访问次数前20%的用户
2）剔除访问次数前20%的用户
3）每类用户的平均访问次数

**1.访问次数前20%的用户**

排名：

```sql
select *,
      row_number() over(order by 访问量 desc) as 排名
from 用户访问次数表;
```

max(排名) * 0.2

```sql
select 
    * 
from 
    (select 
       *,
       row_number() over(order by 访问量 desc) as 排名
    from 用户访问次数表) as a
where 排名 <= (select max(排名) from a) * 0.2;
```

**3. 每类用户的平均访问次数**

```sql
select 用户类型,avg(访问量)
from b
group by 用户类型;
```

## [15. SQL：如何查找工资前三高的员工](https://zhuanlan.zhihu.com/p/103158936)

```sql
select *,
   rank() over (order by 成绩 desc) as ranking,
   dense_rank() over (order by 成绩 desc) as dese_rank,
   row_number() over (order by 成绩 desc) as row_num
from 班级;
```

<img src="/images/sql/monkey-sql-salary-top3-1.png" width="640" alt="" />

```sql
select 课程号,学号,成绩,排名 from
(select *,
     dense_rank() over (partition by 课程号
                  order by 成绩 desc) as 排名
from 成绩表) as aa
where 排名 <=3;
```

## [17. SQL：如何分组比较？](https://zhuanlan.zhihu.com/p/98526392)

```sql
select 
    *
from 
    (select *, avg(成绩) over (partition by 科目) as avg_score from 成绩表) as b
where 成绩 > avg_score;
```

<img src="/images/sql/monkey-sql-group-by-avg-1.jpeg" width="640" alt="" />

## [18. SQL：如何分析游戏？](https://zhuanlan.zhihu.com/p/129326204)

## [37. 字节：你的平均薪水是多少](https://zhuanlan.zhihu.com/p/342793272)

查询出每个部门除去最高、最低薪水后的平均薪水，并保留整数

<img src="/images/sql/monkey-sql-byte-avg-salary-1.jpeg" width="700" alt="" />

> sql的运行顺序，会`先运行from和where子句，最后才运行select子句`。

<img src="/images/sql/monkey-sql-byte-avg-salary-2.png" width="700" alt="" />

> format(N, D) ,  N 是要格式化的数字， D 是要舍入的小数位数


## GB SQL Task

```sql

（2）SQL Task

-- write your code in PostgreSQL 9.4
SELECT (
		SELECT COUNT(*)
		FROM (
			SELECT t2.*
			FROM (
				SELECT t.*, SUM(salary) OVER (ORDER BY salary) AS j_sum_salary
				FROM candidates t
				WHERE position = 'junior'
			) t2
				CROSS JOIN (
					SELECT coalesce(SUM(salary), 0) AS total_salary
					FROM (
						SELECT t1.*
						FROM (
							SELECT t.*, SUM(salary) OVER (ORDER BY salary) AS s_sum_salary
							FROM candidates t
							WHERE position = 'senior'
						) t1
						WHERE s_sum_salary <= 50000
					) seniors_table
				) s
			WHERE j_sum_salary <= 50000 - s.total_salary
		) junior_table
	) AS juniors
	, (
		SELECT COUNT(*)
		FROM (
			SELECT t1.*
			FROM (
				SELECT t.*, SUM(salary) OVER (ORDER BY salary) AS s_sum_salary
				FROM candidates t
				WHERE position = 'senior'
			) t1
			WHERE s_sum_salary <= 50000
		) seniors_table
	) AS seniors
```

## Reference

- [hive大小表join优化性能](https://blog.csdn.net/u012036736/article/details/84978689)
- [分析最近七天内连续三天活跃用户数](https://zhuanlan.zhihu.com/p/92658629)
- [#SQL 如何查询关于【连续几天】的问题](https://zhuanlan.zhihu.com/p/49285570)
- [图解SQL面试题：经典50题](https://zhuanlan.zhihu.com/p/38354000)
- [7张图学会SQL](https://mp.weixin.qq.com/s?__biz=MzAxMTMwNTMxMQ==&mid=2649245863&idx=1&sn=2c3a1e3e8cacf5e4e211758c47619f3e&chksm=835fc097b4284981de23eb6e09259d34963fbd3c1e6bf6c56b7d97bf3f7be816b29572f32d85&scene=21#wechat_redirect)
- [图解面试题](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzAxMTMwNTMxMQ==&action=getalbum&album_id=1398781984763428865&scene=173&from_msgid=2649245863&from_itemidx=1&count=3#wechat_redirect)
- [数据仓库工具箱 维度建模权威指南 第3版.pdf](https://www.cnblogs.com/fly-bird/articles/11332515.html)
