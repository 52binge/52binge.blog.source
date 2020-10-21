---
title: Data WareHouse
date: 2020-06-12 08:59:48
---

OLTP (on-line transaction processing) | OLAP（On-Line Analytical Processing）
:-------: | :-------:
数据在系统中产生 | 本身不产生数据，基础数据来源于产生系统
基于交易的处理系统 | 基于查询的分析系统
牵扯的数据量很小 | 牵扯的数据量庞大 (复杂查询经常使用全表扫描等)
对响应时间要求非常高 | 响应时间与具体查询有很大关系
用户数量大，为操作用户 | 用户数量少，主要有技术人员与业务人员
各种操作主要基于索引进行 | 业务问题不固定，数据库的各种操作不能完全基于索引进行

DW 4 大特征:  Subject Oriented、Integrate、Non-Volatil、Time Variant .

### 1. Data WareHouse

> 1. 3NF vs Dim modeling 
> 2. 事实表 vs 维度表
> 3. 维度建模的三种模式
> 4. IBM DW 7大主题？其中怎样理解当事人主题
> 5. [缓慢变化维](https://zh.twgreatdaily.com/mrqjjnABjYh_GJGV_3je.html) 、 [拉链表 (生效时间/失效时间)](https://blog.csdn.net/qq_42696788/article/details/104989949)
> 6. [数据分层情况/原因，解决](https://blog.csdn.net/QQ1131221088/article/details/89927920)
> 7. 数据抽取和同步的方法

![](/images/dataware/data-layer.png)

![](https://img-blog.csdnimg.cn/20190910140014944.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dhbmdwaW5nNjIz,size_16,color_FFFFFF,t_70)

![](https://ask.qcloudimg.com/http-save/yehe-6343589/5u2krenpem.png?imageView2/2/w/1620)

> **数仓分层**
>
> - STG Stage （不做任何加工, 禁止重复进入）
> - ODS（Operational Data Store）不做处理，存放原始数据 (该层在stage上仅数据格式到标准格式转换)
> - DWD（Data Warehouse Summary 明细数据层）进行简单数据清洗，降维
> - DWS（Data Warehouse Summary 服务数据层）进行轻度汇总（做宽表）
> - ADS（Application Data Summary 数据应用层）为报表提供数据

- [数据仓库&面试总结](https://zhuanlan.zhihu.com/p/145087259)
- [知乎:数据仓库建模](https://zhuanlan.zhihu.com/p/74765529)
- [BI中事实表和维度表的定义](https://blog.csdn.net/u011402596/article/details/44083987)

---

<details>
<summary>1.1 3NF vs Dim modeling </summary>
```
3NF: 
	每个属性值唯一，不具有多义性；
	每个非主属性必须完全依赖于整个主键，而非主键的一部分；    
	每个非主属性不能依赖于其他关系中的属性，因为这样的话，这种属性应该归到其他关系中。    

维度模型:   是一个规范化的 事实表 和 反规范化的一些 维度表 组成的
	
       (1) 一种非规范化的关系模型
       (2) 表跟表之间的关系通过 keyword 和 foreign-key 来定义
```
</details>

<details>
<summary>1.2 事实表 vs 维度表</summary>
```
维度表:
  1. 维表的范围很宽（具有多个属性）
  2. 跟事实表相比，行数相对较小，通常小于 10 万条
  3. 内容相对固定，几乎就是一类查找表，或编码表
事实表:
  1. 数据量大
  2. 列数较少
  3. 经常发生变化
```
</details>

<details>
<summary>1.3 维度建模的三种模式</summary>
```
星型模式（Star Schema）
雪花模型（Snowflake Schema）
星座模型（Fact Constellations Schema）
```
</details>


<details>
<summary>1.4 IBM 7大主题</summary>
```
设计数据仓库按主题划分现在有2种方案:

1. 当事人、地域、协议、事件、产品、资产、营销、渠道等主题划分；
2. 客户、公共、交易、存款、贷款、银行卡、总账、中间业务、渠道等主题划分

数据仓库面向在数据模型中典型的主题领域包括 顾客、产品、订单 和 财务 或是其他某项事务或活动。
```
</details>

<details>
<summary>1.5 缓慢变化维</summary>
```
1. 重写维度值
2. 插入新的维度行
3. 添加维度列
4. 快照方式，每天导一份 dt，定期清理历史数据
```
</details>

### 2. [Hive](/2016/02/15/hadoop/hadoop-hive-brief/)

`Input -> Mappers -> Sort,Shuffle -> Reducers -> Output`

<details>
<summary>Hive 系统架构</summary>
<img src="/images/hadoop/hive-02.png" width="550" alt="Hive 系统架构" />

</details>

> 1. [hive整个调优过程做了哪些?](https://blog.csdn.net/WYpersist/article/details/80030921)
> 2. [Hive性能调优的最佳实践](https://blog.csdn.net/jmx_bigdata/article/details/88035201)
> 3. [Hive 图文并茂-数据仓库 ](https://www.cnblogs.com/moveofgod/p/12383384.html)
> 4. [电商数仓项目系列一：数据仓库简介](https://blog.csdn.net/wangping623/article/details/100697280)
> 2. hive数仓整体架构，实现过程，有哪些问题，是怎样解决的
> 3. 元数据是怎样管理的？元数据中都包括了那些数据
> 4. 怎样保证数据质量
> 5. mapreduce 执行原理
> 6. hive的窗口函数
> 7. hive 分区和分桶具体怎么实现的？
> 8. Hive 支持的底层数据文件类型有哪些
> 9. 数据表的分组和分块？


<details>
<summary>1. Hive 原理</summary>
```
1. 用户提交查询等任务给Driver。
2. 编译器获得该用户的任务Plan。
3. 编译器Compiler根据用户任务去MetaStore中获取需要的Hive的元数据信息。
4. 编译器Compiler得到元数据信息，对任务进行编译，先将HiveQL转换为抽象语法树，然后将抽象语法树转换成查询块，将查询块转化为逻辑的查询计划，重写逻辑查询计划，将逻辑计划转化为物理的计划（MapReduce）, 最后选择最佳的策略。
5. 将最终的计划提交给Driver。
6. Driver将计划Plan转交给ExecutionEngine去执行，获取元数据信息，提交给JobTracker或者SourceManager执行该任务，任务会直接读取HDFS中文件进行相应的操作。
7. 获取执行的结果。
8. 取得并返回执行结果。
```
</details>

<details>
<summary>2. hadoop处理数据的过程，有几个显著的特征</summary>
```
1.不怕数据多，就怕数据倾斜。
2．对jobs数比较多的作业运行效率相对比较低，比如即使有几百行的表，如果多次关联多次汇总，产生十几个jobs，没半小时是跑不完的。map reduce作业初始化的时间是比较长的。
3.对sum，count来说，不存在数据倾斜问题。
4.对count(distinct ),效率较低，数据量一多，准出问题，如果是多count(distinct )效率更低
```
</details>

<details>
<summary>4. Sqoop 问题</summary>
```bash
function import_data_hdfs() {
  sqoop import \
    -Dorg.apache.sqoop.splitter.allow_text_splitter=true --connect ${jdbc_url} --username ${jdbc_username} --password  ${jdbc_passwd} \
    --query "${exec_sql}" \
    --split-by ${id} -m 20 \
    --target-dir ${target_dir} \
    --fields-terminated-by "\001" --lines-terminated-by "\n" \
    --hive-drop-import-delims \
    --null-string '\\N' --null-non-string '\\N'
  check_success
  echo_ex "end successful import ${target_dir}. field.delim : \001"
}
(1) 导入导出Null存储一致性问题
        导出数据时采用–input-null-string和–input-null-non-string
        导入数据时采用–null-string和–null-non-string
(2). jdbc_url
         jdbc_url="jdbc:mysql://xxxx:3306/reportpublic?autoReconnect=true"
(3). Map 阶段, 只有
          原理是重写了 MR： inputformat 和 outputformat
```
</details>

- [CSDN-Hive面试题收集](https://blog.csdn.net/WYpersist/article/details/80102757)
- [Hive常见面试题1.0](https://zhuanlan.zhihu.com/p/93932766)

### 3. Hadoop

> 1. [Hadoop（六）MapReduce的入门与运行原理](https://www.cnblogs.com/frankdeng/p/9311438.html)
> 2. hadoop的mr的shuffle过程是怎样的？
> 3. 对于hive的性能优化有哪些经验？
> 4. 简要介绍一下mapreduce执行时的数据流转

### 4. Spark

迭代式+低延迟

- [Spark 2000题](https://www.jianshu.com/p/7a8fca3838a4)
- [PySpark-DataFrame各种常用操作举例](https://blog.csdn.net/anshuai_aw1/article/details/87881079)
- [Spark 马中华](https://blog.csdn.net/zhongqi2513/category_6081152.html)

### 5. SQL

> 1. [廖雪峰:关系数据库概述](https://www.liaoxuefeng.com/wiki/1177760294764384/1179613436834240)

<details>
<summary>(1). 主键 / FOREIGN KEY</summary>
```
身份证号、手机 这些看上去可以唯一的字段，均不可用作主键。
作为主键最好是完全业务无关的字段，我们一般把这个字段命名为id。
自增整数类型

没有必要的情况下，我们尽量不使用联合主键，因为它给关系表带来了复杂度的上升。

由于外键约束会降低数据库的性能，大部分互联网应用程序为了追求速度，并不设置外键约束，而是仅靠应用程序自身来保证逻辑的正确性。
```
</details>

<details>
<summary>(2). INDEX</summary>
```
可以对一张表创建多个索引。索引的优点是提高了查询效率

缺点是在插入、更新和删除记录时，需要同时修改索引，因此，索引越多，插入、更新和删除记录的速度就越慢。

对于主键，关系数据库会自动对其创建主键索引。使用主键索引的效率是最高的，因为主键会保证绝对唯一。
```
</details>

<details>
<summary>(3). SQL查询</summary>
```sql
3.1 基础查询

SELECT * FROM students WHERE score >= 80;
SELECT id, name, gender, score FROM students ORDER BY score;
SELECT id, name, gender, score FROM students ORDER BY score DESC LIMIT 3 OFFSET 6; 第3页
SELECT COUNT(*) boys FROM students WHERE gender = 'M';

3.2 分组查询:

SELECT COUNT(*) num FROM students GROUP BY class_id;
SELECT class_id, gender, COUNT(*) num FROM students GROUP BY class_id, gender;

3.3 多表查询:

SELECT
    s.id sid,
    s.name,
    s.gender,
    s.score,
    c.id cid,
    c.name cname
FROM students s, classes c
WHERE s.gender = 'M' AND c.id = 1;

使用多表查询可以获取M x N行记录；
多表查询的结果集可能非常巨大，要小心使用。

3.4 连接查询:

JOIN查询需要先确定主表，然后把另一个表的数据“附加”到结果集上；
INNER JOIN是最常用的一种JOIN查询，它的语法是SELECT ... FROM <表1> INNER JOIN <表2> ON <条件...>；
JOIN查询仍然可以使用WHERE条件和ORDER BY排序。

```
</details>

<details>
<summary>(4). 事务</summary>
</details>

> 1. sql 分组三类函数的区别
> 2. 手写sql，随意修改要求说出统计思路

### 6. Python

- [2018年最常见的Python面试题&答案（上篇）](https://juejin.im/post/5b6bc1d16fb9a04f9c43edc3)

- [110道Python面试题](https://zhuanlan.zhihu.com/p/54430650)


## Reference

- [ETL架构师面试题（这篇文章太棒了）](https://www.cnblogs.com/tmeily/p/4593700.html)
- [Python Interview 真题](https://zhuanlan.zhihu.com/p/54430650)
