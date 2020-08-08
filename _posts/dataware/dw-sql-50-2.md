---
title: Data Analysis - SQL 50 第2篇 Action
toc: true
date: 2020-08-08 09:07:21
categories: [data-warehouse]
tags: [data warehouse]
---

<img src="/images/dataware/sql-50-logo.jpg" width="550" alt="" />

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

**(2). 查询平均成绩大于60分的学生的学号和平均成绩（简单，第二道重点）**

<img src="/images/dataware/sql-50-table-logo.jpg" width="850" alt="" />


## Reference

- [常见的SQL面试题：经典50题 - 知乎](https://zhuanlan.zhihu.com/p/38354000)
- [SQL面试必会50题 - 知乎](https://zhuanlan.zhihu.com/p/43289968)
<br>
- [bilibili【数据分析】- SQL面试50题 - 跟我一起打怪升级 一起成为数据科学家](https://www.bilibili.com/video/BV1q4411G7Lw/?spm_id_from=333.788.videocard.1)
- [数据分析师成长之路](https://zhuanlan.zhihu.com/p/103386372)
<br>
- [【SQL】SQL面试50题 分类梳理与解答](https://zhuanlan.zhihu.com/p/113173133)
- [【Python】数据分析前的入门教程 Python For Everybody P1：零基础程序设计](https://zhuanlan.zhihu.com/p/118633494)

