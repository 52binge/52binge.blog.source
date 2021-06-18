---
title: Data Analysis - SQL 50 第1篇
date: 2020-08-07 09:07:21
categories: [data-warehouse]
tags: [data warehouse]
---

<img src="/images/dataware/sql-50-logo.jpeg" width="550" alt="" />

<!-- more -->

本文汇总了不同版本的SQL面试50题的题目，删去了重复内容，并根据涉及知识点进行分类，按照由易到难、相似题放在一起的思路进行排序并重新编

<img src="/images/dataware/sql-50-table-logo.jpg" width="950" alt="" />

Table 关系图：

<img src="/images/dataware/sql-50-2.jpeg" width="750" alt="" />

- [SQL面试必会50题 - 知乎](https://zhuanlan.zhihu.com/p/43289968)

**建表 & 准备数据：**

```sql
-- 建表
-- 学生表
CREATE TABLE `Student`(
`s_id` VARCHAR(20),
`s_name` VARCHAR(20) NOT NULL DEFAULT '',
`s_birth` VARCHAR(20) NOT NULL DEFAULT '',
`s_sex` VARCHAR(10) NOT NULL DEFAULT '',
PRIMARY KEY(`s_id`)
);
-- 课程表
CREATE TABLE `Course`(
`c_id` VARCHAR(20),
`c_name` VARCHAR(20) NOT NULL DEFAULT '',
`t_id` VARCHAR(20) NOT NULL,
PRIMARY KEY(`c_id`)
);
-- 教师表
CREATE TABLE `Teacher`(
`t_id` VARCHAR(20),
`t_name` VARCHAR(20) NOT NULL DEFAULT '',
PRIMARY KEY(`t_id`)
);
-- 成绩表
CREATE TABLE `Score`(
`s_id` VARCHAR(20),
`c_id` VARCHAR(20),
`s_score` INT(3),
PRIMARY KEY(`s_id`,`c_id`)
);
```

```sql
-- 插入学生表测试数据
insert into Student values('01' , '赵雷' , '1990-01-01' , '男');
insert into Student values('02' , '钱电' , '1990-12-21' , '男');
insert into Student values('03' , '孙风' , '1990-05-20' , '男');
insert into Student values('04' , '李云' , '1990-08-06' , '男');
insert into Student values('05' , '周梅' , '1991-12-01' , '女');
insert into Student values('06' , '吴兰' , '1992-03-01' , '女');
insert into Student values('07' , '郑竹' , '1989-07-01' , '女');
insert into Student values('08' , '王菊' , '1990-01-20' , '女');
-- 课程表测试数据
insert into Course values('01' , '语文' , '02');
insert into Course values('02' , '数学' , '01');
insert into Course values('03' , '英语' , '03');

-- 教师表测试数据
insert into Teacher values('01' , '张三');
insert into Teacher values('02' , '李四');
insert into Teacher values('03' , '王五');

-- 成绩表测试数据
insert into Score values('01' , '01' , 80);
insert into Score values('01' , '02' , 90);
insert into Score values('01' , '03' , 99);
insert into Score values('02' , '01' , 70);
insert into Score values('02' , '02' , 60);
insert into Score values('02' , '03' , 80);
insert into Score values('03' , '01' , 80);
insert into Score values('03' , '02' , 80);
insert into Score values('03' , '03' , 80);
insert into Score values('04' , '01' , 50);
insert into Score values('04' , '02' , 30);
insert into Score values('04' , '03' , 20);
insert into Score values('05' , '01' , 76);
insert into Score values('05' , '02' , 87);
insert into Score values('06' , '01' , 31);
insert into Score values('06' , '03' , 34);
insert into Score values('07' , '02' , 89);
insert into Score values('07' , '03' , 98);
```

## Reference

- [常见的SQL面试题：经典50题 - 知乎](https://zhuanlan.zhihu.com/p/38354000)
- [SQL面试必会50题 - 知乎](https://zhuanlan.zhihu.com/p/43289968)
<br>
- [bilibili【数据分析】- SQL面试50题 - 跟我一起打怪升级 一起成为数据科学家](https://www.bilibili.com/video/BV1q4411G7Lw/?spm_id_from=333.788.videocard.1)
- [数据分析师成长之路](https://zhuanlan.zhihu.com/p/103386372)
<br>
- [【SQL】SQL面试50题 分类梳理与解答](https://zhuanlan.zhihu.com/p/113173133)
- [【Python】数据分析前的入门教程 Python For Everybody P1：零基础程序设计](https://zhuanlan.zhihu.com/p/118633494)
