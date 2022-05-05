---
title: data analysis - SQL 50 第2篇 action
date: 2020-08-08 09:07:21
categories: bi
tags: [data warehouse]
---

{% image "/images/sql/sql-50-logo.jpg", width="500px", alt="" %}

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

[bilibili analysis](https://www.bilibili.com/video/BV1q4411G7Lw?p=5)

```sql
SELECT
    s_id, avg(s_score)
FROM
    score
GROUP BY s_id HAVING avg(s_score) > 60
```

**(9). 查询所有课程成绩小于60分的学生的学号、姓名**

1. 得出同学课程成绩小于 60分 的课程数
2. 统计同学总共学了几门课

```sql
SELECT a.s_id, t.s_name
FROM

(
SELECT s_id, count(c_id) as cnt
FROM Score
WHERE s_score < 60
GROUP BY s_id
) a

INNER JOIN

(
SELECT s_id, count(c_id) as cnt FROM Score
GROUP BY s_id
) b
ON a.s_id = b.s_id

INNER JOIN

Student as t ON a.s_id=t.s_id

WHERE a.cnt = b.cnt
```



**(3). 查询所有学生的学号、姓名、选课数、总成绩**

学号 | 姓名 | 课程编号 | 这门课成绩
:----:  | :----: | :----: | :----:
1 | 小张 | 1 | 60
1 | 小张 | 3 | 70

```sql
SELECT
	t1.s_id,
	t1.s_name,
	COUNT( t2.c_id ),
	SUM(case when t2.s_score is NULL then 0 else t2.s_score END) 
FROM
	Student AS t1
	LEFT JOIN Score AS t2 ON t1.s_id = t2.s_id
GROUP BY s_id, t1.s_name
```

**(4). 查询姓“猴”的老师的个数（不重要）**

```sql
SELECT
	count(t_id)
FROM teacher
WHERE t_name LIKE '张%'
```

```sql
SELECT
	count(distinct t_name)
FROM teacher
WHERE t_name LIKE '张%'
```

**(5). 查询没学过“张三”老师课的学生的学号、姓名（重点）**

学号 | 课程号 | 成绩 | 教师号 | 教师姓名
:----:  | :----: | :----: | :----: | :----:
s_1 | c_1 | 90 | t_1 | 张三

```sql
SELECT s_id, s_name from Student
WHERE s_id not in (
	SELECT s_id FROM Score s
	INNER JOIN Course c ON s.c_id = c.c_id
	INNER JOIN Teacher t ON c.t_id = t.t_id
	WHERE t.t_name='张三'
)
```

**(6). 查询学过“张三”老师所教的所有课的同学的学号、姓名（重点)**

```sql
SELECT st.s_id, st.s_name 
FROM 
   Student as st
   INNER JOIN Score s ON s.s_id = st.s_id
   INNER JOIN Course c ON s.c_id = c.c_id
   INNER JOIN Teacher t ON c.t_id = t.t_id
   WHERE t.t_name='张三'
)
```
> 平时做的时候表太大，我们会先过滤用 ’张三‘ 的条件，做成 temp table 在开始做 JOIN.

**(7). 查询学过编号为“01”的课程并且也学过编号为“02”的课程的学生的学号、姓名（重点）**

```sql
SELECT * FROM STUDENT WHERE s_id IN
(
    SELECT a.s_id 
    FROM
        (SELECT s_id, c_id FROM Score WHERE c_id = '01') a
        INNER JOIN
        (SELECT s_id, c_id FROM Score WHERE c_id = '02') b
    ON a.s_id = b.s_id
)
```

**(8). 查询课程编号为“02”的总成绩（不重点）**

```sql
SELECT SUM(s_score)
FROM Score
wWHERE c_id = '02'
```

**(10). 查询没有学全所有课的学生的学号、姓名(重点)**

```sql
SELECT * FROM course
SELECT * FROM Score
```

Error Version: 

```sql
SELECT s_id, s_name FROM Student WHERE s_id IN 
(
  SELECT s_id FROM Score
  GROUP BY s_id HAVING count(distinct c_id) < (SELECT COUNT(distinct c_id) FROM Course)
)

-- 一门课都没有学，上面的 SQL 就漏掉了.
```

Right Version:

```sql
SELECT st.*, sc.*
FROM Student as st
LEFT JOIN Score as sc ON st.s_id=sc.s_id
GROUP BY st.s_id HAVING count(distinct sc.c_id) < (SELECT COUNT(distinct c_id) FROM Course)
)

-- 一门课都没有学，上面的 SQL 就漏掉了.
```

**(11). 查询至少有一门课与学号为“01”的学生所学课程相同的学生的学号和姓名（重点）**

1. and在括号外用
2. distinct 不知道什么时候用？

{% image "/images/sql/sql-50-11.jpg", width="850px", alt="" %}

**(12). 查询和“01”号同学所学课程完全相同的其他同学的学号(重点)**

{% image "/images/sql/sql-50-12.jpg", width="800px", alt="" %}

{% image "/images/sql/sql-50-table-logo.jpg", width="800px", alt="" %}


## Reference

- [常见的SQL面试题：经典50题 - 知乎](https://zhuanlan.zhihu.com/p/38354000)
- [SQL面试必会50题 - 知乎](https://zhuanlan.zhihu.com/p/43289968)
<br>
- [bilibili【数据分析】- SQL面试50题 - 跟我一起打怪升级 一起成为数据科学家](https://www.bilibili.com/video/BV1q4411G7Lw/?spm_id_from=333.788.videocard.1)
- [数据分析师成长之路](https://zhuanlan.zhihu.com/p/103386372)
<br>
- [【SQL】SQL面试50题 分类梳理与解答](https://zhuanlan.zhihu.com/p/113173133)
- [【Python】数据分析前的入门教程 Python For Everybody P1：零基础程序设计](https://zhuanlan.zhihu.com/p/118633494)

