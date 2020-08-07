---
title: Data Analysis - SQL 50
toc: true
date: 2020-08-07 09:07:21
categories: [data-warehouse]
tags: [data warehouse]
---

<img src="/images/dataware/sql-50-logo.jpeg" width="550" alt="" />

<!-- more -->

本文汇总了不同版本的SQL面试50题的题目，删去了重复内容，并根据涉及知识点进行分类，按照由易到难、相似题放在一起的思路进行排序并重新编

<img src="/images/dataware/sql-50-table-logo.jpg" width="950" alt="" />

## Like

```sql
-- 1. 查询「李」姓老师的数量 
select count(*) from teacher
where tname like '李%';

-- 2. 查询名字中含有「风」字的学生信息
select * from student
where sname like '%风%';
```

## 聚合函数、group by和where的相爱相杀

1.聚合函数sum/avg/count/max/min经常与好基友group by搭配使用

2.在使用group by时，select后面只能放

常数（如数字/字符/时间）
聚合函数
聚合键（也就是group by后面的列名）；
因此，在使用group by时，千万不要在select后面放聚合键以外的列名！

3.where函数后面不能直接使用聚合函数！（考虑放在having后面/变成子查询放在where后面）

3). 查询男生、女生人数【聚合函数】

```sql
-- 3. 查询男生、女生人数
select ssex, count(*) from student
group by ssex;
```

4). 查询课程编号为02的总成绩【聚合函数】

```sql
-- 4. 查询课程编号为02的总成绩
select cno, sum(score) from sc 
group by cno having cno='02';
```

5). 查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列【聚合函数】

```sql
-- 5. 查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select cno, avg(score) as avg_score from sc
group by cno
order by avg_score desc, cno;
```

6). 求每门课程的学生人数 【聚合函数】

```sql
-- 6. 求每门课程的学生人数 
select cno, count(sno) as student_number
from sc group by cno;
```

7). 统计每门课程的学生选修人数（超过 5 人的课程才统计）【聚合函数】

```sql
-- 7. 统计每门课程的学生选修人数（超过 5 人的课程才统计）
select cno, count(*) as student_number 
from sc group by cno having count(*)>5
order by student_number desc, cno;
```

## Reference

- [bilibili【数据分析】- SQL面试50题 - 跟我一起打怪升级 一起成为数据科学家](https://www.bilibili.com/video/BV1q4411G7Lw/?spm_id_from=333.788.videocard.1)
- [【SQL】SQL面试50题 分类梳理与解答](https://zhuanlan.zhihu.com/p/113173133)
- [【Python】数据分析前的入门教程 Python For Everybody P1：零基础程序设计](https://zhuanlan.zhihu.com/p/118633494)
