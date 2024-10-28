---
title: data-warehouse 2 - interview notes
date: 2021-01-22 09:07:21
categories: bi
tags: [data warehouse]
---

{% image "/images/dataware/sm-data-warehouse-logo-1.jpg", width="500px", alt="" %}

<!-- more -->

No. | [2020年大厂-数据仓库篇](https://my.oschina.net/u/4631230/blog/4688808) | Flag
:---: | --- | :---:
1. | [Hive SQL count（distinct）效率问题及优化](https://article.itxueyuan.com/a93Dg) <br>set mapreduce.map.memory.mb=48192;<br>set mapreduce.reduce.memory.mb=48192;<br>set mapred.reduce.tasks=1000；<br><br>select count（distinct account） from...where...<br><br> 加入distinct，map阶段不能用combine消重，数据输出为（k，v）形式然后在reduce阶段进行消重<br>Hive在处理COUNT这种“全聚合(full aggregates)”计算时，忽略指定的Reduce Task数，而强制使用1 <br><br> insert overwrite table temp select id，account，count(1) as num from tablename group by id，account； <br> {% image "/images/hadoop/map-reduce-combine.png", width="780px", alt="" %} <br>[MapReduce流程简单解析](https://blog.csdn.net/yuzhuzhong/article/details/51476353)| ❎
<br><br>2. | left semi join和left join区别? <br><br>`left semi join` 是 in(keySet) 的关系，遇到右表重复记录，左表会跳过；当右表不存在的时候，左表数据不会显示; 相当于SQL的in语句. <br>`left join`: 当右表不存在的时候，则会显示NULL |　<br><br>❎
<br><br><br>3. | 维度建模 和 范式建模(3NF模型) 的区别? <br><br> 维度建模是面向分析场景的，主要关注点在于快速、灵活: **星型模型 & 雪花模型 & 星系模型** <br><br> 3NF的最终目的就是为了降低数据冗余，保障数据一致性: <br> (2.1) 原子性 - 数据不可分割 <br> (2.2) 基于第一个条件，实体属性完全依赖于主键 <br> (2.3) 消除传递依赖 - 任何非主属性不依赖于其他非主属性 | <br><br><br>❎
4. | 采用维度模型方法作为理论基础，更多采用一些`维度退化的手段，将维度退化到事实表中`，减少事实表和维度表之间的关联。同时在汇总层，加强指标的维度退化，采用更多的宽表化手段构建公共指标数据层.  |
5. | 从原理上说一下mpp和mr的区别 ? <br> 1. MPP跑的是SQL,而Hadoop底层处理是MapReduce程序 <br> 2. 扩展程度：MPP扩展一般是扩展到100左右,因为MPP始终还是DB,一定要考虑到C(Consistency) | ❎
6. | [Hive窗口函数怎么设置窗口大小？](https://blog.csdn.net/qq_41106844/article/details/108415566), between 1 preceding and 1 following | ✔️
7. | Hive SQL如何转化MR任务 ? <br> HiveSQL ->AST(抽象语法树) -> QB(查询块) ->OperatorTree（操作树）->优化后的操作树->mapreduce任务树->优化后的mapreduce任务树 |
8. | join操作底层 MR 是怎么执行的？ 根据join对应的key进行分区shuffle，然后执行mapreduce那套流程. |
&nbsp; | [2020 BAT大厂数据分析面试经验：“高频面经”之数据分析篇](https://blog.csdn.net/qq_36936730/article/details/104302799) |
9. | Mysql中索引是什么？建立索引的目的？ |
10. | 行存储和列存储的区别? <br><br> 行存储：传统数据库的存储方式，同一张表内的数据放在一起，插入更新很快。缺点是每次查询即使只涉及几列，也要把所有数据读取<br>列存储：OLAP等情况下，将数据按照列存储会更高效，每一列都可以成为索引，投影很高效。缺点是查询是选择完成时，需要对选择的列进行重新组装。<br><br>当你的核心业务是 OLTP 时，一个行式数据库，再加上优化操作，可能是个最好的选择。<br>当你的核心业务是 OLAP 时，一个列式数据库，绝对是更好的选择 |
11. | Hive HDFS HBase区别？ <br> Hbase是Hadoop database，即Hadoop数据库.<br>&nbsp;&nbsp; 它是一个适合于非结构化数据存储的数据库，HBase基于列的而不是基于行的模式. |


1. [仙子紫霞  数据仓库与Python大数据  1/1 叮！致2020的一封情书，请查收！文末2019年文章精选](https://mp.weixin.qq.com/s/tJjkaWsZKbsG8klBSn2JGw)

[大数据文章合集-数据仓库与Python大数据](https://mp.weixin.qq.com/s?src=11&timestamp=1720014881&ver=5360&signature=q0R-NquwLDjOZELYXAmLABAzAm-olWaBfdWMM8SSiIW4xboKnjUhtrdAjn3Y-9a84O3XpVGoyushRw40-V2lPFJzuJc8Zf8DbP1WCUAMdkxV3qYGoss2GjtPdknqMGIk&new=1)

> [1. 漫谈系列 - 数仓第一篇NO.1 『基础架构』](https://mp.weixin.qq.com/s/J_PA_qhU44DX0PiCDuVaEA)
> 
> [2. 漫谈系列 - 数仓第二篇NO.2 『数据模型』](https://mp.weixin.qq.com/s/oKcCQx2vfnyAYlu7V0uHbg)
> 
> [3. 漫谈系列 - 数仓第三篇NO.3 『数据ETL』](https://mp.weixin.qq.com/s/INerSvksPi8sreSVCA2csA)
> 
> [4. 漫谈系列 - 数仓第四篇NO.4 『数据应用』](https://mp.weixin.qq.com/s/Y1xWwJ2Jr392eRHQeBRYZQ)
>
> [5. 系列 | 漫谈数仓第五篇NO.5 『OLAP』](https://mp.weixin.qq.com/s?src=11&timestamp=1720014642&ver=5360&signature=3wYrPB00zeUdpVYyETn7y6OCJGW480z3h9nsH2ft46uUQBwQd3xKDQN1ynJICC0ZQ2E5gFzZu4u8TGRfqk6oZMFkNU1A4tBqQBNMg89tz6jd5-Eaq7oNMZtnHoZdVwdX&new=1)
> 
> [7. 漫谈系列 - 漫谈数仓第一篇NO.7 『面试真经』](https://mp.weixin.qq.com/s/iZs7zEb-yoiSnlG2q74Fvg)

<center><embed src="/images/dataware/建设企业级数据仓库EDW(内部资料，禁止外传).pdf" width="950" height="600"></center>

- [元数据管理解析以及数据仓库和主数据介绍](https://zhuanlan.zhihu.com/p/36136675)


<details>
<summary>漫谈系列：</summary>

No. | Question | Flag
:---: | --- | :---:
1. | good - [漫谈大牛带你从0到1构建数据仓库实战](https://mp.weixin.qq.com/s/iwC0iKXBFFBVwxCQPhBAxg) |
2. | good - [数据模型设计（推荐收藏）](https://mp.weixin.qq.com/s/_WHI-1gjW0iaQeKW0TfMDA) |
3. | [数据仓库（二）](https://www.jianshu.com/p/a145e15dedfc), [数据仓库（一）](https://www.jianshu.com/p/9750703dba28) |
4. | [Hadoop的元数据治理--Apache Atlas](https://www.jiqizhixin.com/articles/2019-09-16-12)
5. | [1. 漫画：什么是数据仓库？](https://mp.weixin.qq.com/s/XIJoE3nV7QQwGE0WLIhiRw)
6. | [2. 传统数仓和大数据数仓的区别是什么？ ✔️](https://mp.weixin.qq.com/s/Uo7UzUhCJdzXeLL8nRLefw)
7. | [4. 数仓那点事：从入门到佛系](https://mp.weixin.qq.com/s/kbSZkggtdaEVnN6wjjv4ag)
8. | [5. 从8个角度5分钟搞定数据仓库](https://mp.weixin.qq.com/s/3pABsYDHLxS5u1NQV4PGBA)
9. | [6. 滴滴数据仓库指标体系建设实践](https://mp.weixin.qq.com/s/-pLpLD_HMiasyyRxo5oTRQ)
11. | [9. 手把手教你如何搭建一个数据仓库](https://mp.weixin.qq.com/s/PwnQl6uji85m7BGALmOVrw)
12. | [10. 基于spark快速构建数仓项目（文末Q&A）](https://mp.weixin.qq.com/s/oidx8qDndDKr3MN5x5Xl-Q)
13. | [11. 数据湖VS数据仓库之争？阿里提出大数据架构新概念：湖仓一体！](https://mp.weixin.qq.com/s/V_EWJi5-rtiNNwmnGOdZYw)
14. | [12. 数据仓库（离线+实时）大厂优秀案例汇总（建议收藏）](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247485223&idx=2&sn=149000071adf5fbdf819fdf6afb1ce7f&chksm=cf34352af843bc3c3f56071447c57f120a3ca7601d4d67c17bb422695d6a4637eec42fad2819&scene=21#wechat_redirect)
15. | [Good - Hive 拉链表实践](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247485525&idx=2&sn=595eab33c9b16f5a20cded2bf3c4f8ed&chksm=cf343a58f843b34e20e2fcd4cbb21f8a27451a3b235050b1c91aec1ac756dc4ad4d74216b879&scene=21#wechat_redirect)
</details>

## 1. DWH, Concept

OLTP (on-line transaction processing) | OLAP（On-Line Analytical Processing）
:-------: | :-------:
数据在系统中产生 | 本身不产生数据，基础数据来源于产生系统
基于交易的处理系统 | 基于查询的分析系统
牵扯的数据量很小 | 牵扯的数据量庞大 (复杂查询经常使用全表扫描等)
对响应时间要求非常高 | 响应时间与具体查询有很大关系
用户数量大，为操作用户 | 用户数量少，主要有技术人员与业务人员
各种操作主要基于索引进行 | 业务问题不固定，数据库的各种操作不能完全基于索引进行

DW 4 大特征:  Subject Oriented、Integrate、Non-Volatil、Time Variant .

> **数仓分层**
>
> - STG Stage （不做任何加工, 禁止重复进入）
> - ODS（Operational Data Store）不做处理，存放原始数据 (该层在stage上仅数据格式到标准格式转换)
> - DWD（Data Warehouse Summary 明细数据层）进行简单数据清洗，降维
> - DWS（Data Warehouse Summary 服务数据层）进行轻度汇总（做宽表）
> - ADS（Application Data Summary 数据应用层）为报表提供数据

### 1.1 DWH basic 

**data warehouse 逻辑分层架构：**

{% image "/images/dataware/dw-summary-pic.jpeg", width="550px", alt="" %}

### 1.2 data modeling

Title_Kimball | [深入浅出数据模型（推荐收藏）](https://mp.weixin.qq.com/s/qAitZe3BPkQNTIDAWgTsFw)
:---: | :---:
**流程** | 架构是自下向上，即从数据集市(主题划分)-->数据仓库--> 数据抽取，是以需求为导向的，一般使用星型模型  
**事实表和维表** | 架构强调模型由事实表和维表组成，注重事实表与维表的设计
**数据集市** | 数据仓库架构中，数据集市是一个逻辑概念，只是多维数据仓库中的主题域划分，并没有自己的物理存储，也可以说是虚拟的数据集市。是数据仓库的一个访问层，是按主题域组织的数据集合，用于支持部门级的决策。

**data modeling 的几种方式:**

No. | 数据建模方式 | type
:---: | :--- | :--- 
1. | ER模型 | 三范式 |
<br> 2. | <br> 维度建模 |  1. 星型模型 <br> 2. 雪花模型 <br> 3. 星座模型
 |  | 
1. | 事实表 | 事实表生于业务过程，存储业务活动或事件提炼出来的性能度量。从最低的粒度级别来看，事实表行对应一个度量事件 <br>（1）事务事实表  <br> （2）周期快照事实表 <br> （3）累积快照事实表
2. | 维度表 | （1）退化维度（DegenerateDimension）<br> （2）缓慢变化维（Slowly Changing Dimensions）<br><br> 维度的属性并不是始终不变的，这种随时间发生变化的维度我们一般称之为缓慢变化维（SCD）

### 1.3 data ETL

[SQL分析函数，看这一篇就够了](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247483677&idx=1&sn=32ddbe9c8747d9cf9a821162bb9de27f&chksm=cf343310f843ba0626f8623283dd4a23dc480788d818f53713ab038f2fd8f2152f08c985507a&scene=21#wechat_redirect)

No. | Title | desc
--- | --- | ---
1. | 数据仓库的数据质量如何保障? | 需要从源头管控，业务系统进行细致的字段的校验
2. | 如何保证你的计算的指标结果准确性？ | 1. 有测试人员 2. 做小样本数据集的抽取开发
3. | 数据存储格式 | orc / Parquet
4. | 数据压缩方式 | snappy / LZO
5. | 数据存储格式 + 压缩 | 服务器的磁盘空间可以变为原来的 1/3
6. | lzo 支持切分么？ | snappy 不支持切分, 给lzo文件建立索引后，则支持切分

> create_time, update_time, 使用拉链表解决历史数据变更的问题

```
# 设置输出数据格式压缩成为LZO

SET hive.exec.compress.output=true;
SET mapreduce.output.fileoutputformat.compress=true;
set mapred.output.compression.codec=com.hadoop.compression.lzo.LzopCodec;

#插入数据到目标表里面去
insert overwrite table ods_user_login partition(part_date)
select plat_id,server_id,channel_id,user_id,role_id,role_name,client_ip,event_time,op_type,online_time,operating_system,operating_version,device_brand,device_type,from_unixtime(event_time,'yyyy-MM-dd') as part_date 
from tmp_ods_user_login;

#给lzo文件建立索引：便于以后多个mapTask来对文件进行处理
hadoop jar /kkb/install/hadoop-2.6.0-cdh5.14.2/share/hadoop/common/hadoop-lzo-0.4.20.jar  com.hadoop.compression.lzo.DistributedLzoIndexer /user/hive/warehouse/game_center.db/ods_user_login/
```

### 1.4 Tool-App

No. | Tool
:---: | :---
1. | Apache_Druid <br>&nbsp;&nbsp; Druid是一个用于大数据实时查询和分析的高容错、高性能开源分布式系统，用于解决如何在大规模数据集下进行快速的、交互式的查询和分析。 
2. | Apache Kylin™ <br>&nbsp;&nbsp; 一个开源的分布式分析引擎，提供Hadoop/Spark之上的SQL查询接口及多维分析（OLAP）能力以支持超大规模数据，最初由eBay Inc. 开发并贡献至开源社区。它能在亚秒内查询巨大的Hive表。
3. | Clickhouse 是一个用于在线分析处理（OLAP）的列式数据库管理系统（DBMS）
4. | ADB（AnalyticDB_for_MySQL） <br>&nbsp;&nbsp; 分析型数据库MySQL版（AnalyticDB for MySQL），是阿里巴巴自主研发的海量数据实时高并发在线分析（Realtime OLAP）云计算服务，使得您可以在毫秒级针对千亿级数据进行即时的多维分析透视和业务探索。
5. | [花未全开*月未圆](https://www.cnblogs.com/tesla-turing/p/13276589.html) <br><br>1.1 presto 是Facebook开源的，完全基于内存的并⾏计算(MPP)，分布式SQL交互式查询引擎<br>1.2 数据治理: 在ETL过程中开发人员会对数据清洗这其实就是治理的一部分<br>1.3 元数据是记录数仓中模型的定义、各层级的映射关系、监控数仓的数据状态及 ETL 的任务运行状态 <br><br> 1.4 DW-DM层是采用Kimball的总线式的数据仓库架构，针对部门（比如财务部门）或者某一主题（比如商户、用户），通过维度建模（推荐星型模型），构建一致性维度，原子粒度的数据是DW层，按照实体或者主题经过一定的汇总，建设数据集市模型。数据集市可以为OLAP提供服务。

> Ad-hoc 查询或报告（即席查询或报告）是 商业智能的一个次要的话题，它还经常与OLAP、数据仓库相并论.

## 2. SQL

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

使用多表查询可以获取M x N行记录；

3.4 连接查询:

JOIN查询需要先确定主表，然后把另一个表的数据“附加”到结果集上；
INNER JOIN是最常用的一种JOIN查询，它的语法是SELECT ... FROM <表1> INNER JOIN <表2> ON <条件...>；
JOIN查询仍然可以使用WHERE条件和ORDER BY排序。

```
</details>

## 3. Hive

- [1. 一篇文章让你了解Hive调优（文末赠书）](https://mp.weixin.qq.com/s/K8arR_TCsP-i8BK9tqD6Sg)
- [2. 再次分享！Hive调优，数据工程师成神之路](https://mp.weixin.qq.com/s/OsT2Sgjn47HbhVyRau2vOw)

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

[Hive](/2016/02/15/hadoop/hadoop-hive-brief/)

`Input -> Mappers -> Sort,Shuffle -> Reducers -> Output`

<details>
<summary>Hive 系统架构</summary>
{% image "/images/hadoop/hive-02.png", width="550px", alt="Hive 系统架构" %}

</details>


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
1. 不怕数据多，就怕数据倾斜 (Not Afraid of Large Data, Only Data Skew)
2. Even with tables having hundreds of rows, multiple joins and aggregations can produce numerous jobs, taking over half an hour to complete.
MapReduce job initialization time is relatively long.
3. No Data Skew Issues with SUM and COUNT
  对 SUM、COUNT 来说，不存在数据倾斜问题。 Multiple COUNT(DISTINCT) 效率较低
```
</details>

## Reference

- [HDFS基本架构、原理、与应用场景、实践（附ppt）](https://mp.weixin.qq.com/s/Za1MuzKQBmuJCza400_hdg)
- [Hive存储格式对比](https://blog.csdn.net/xueyao0201/article/details/79103973)
- [very good - igDataGuide/面试-all](https://github.com/Dr11ft/BigDataGuide/tree/master/%E9%9D%A2%E8%AF%95)
- [Apache Druid 简介](https://zhuanlan.zhihu.com/p/82038648)
- [操作系统之堆和栈的区别](https://www.cnblogs.com/George1994/p/6399895.html)
- [漫谈数据仓库之拉链表（原理、设计以及在Hive中的实现）](https://blog.csdn.net/zhaodedong/article/details/54177686)
- [2020大数据/数仓/数开面试题真题总结(附答案)](https://mp.weixin.qq.com/s/pwyus1xfX7QAz5MtecveZw)
- [SQL 窗口函数的优化和执行](https://mp.weixin.qq.com/s/zdHHg6MmydiUpTopn_sniA)
- [【社招】快手_数据仓库_面试题整理](https://blog.csdn.net/weixin_43619485/article/details/107164729)
- [2020年大厂面试题-数据仓库篇](https://my.oschina.net/u/4631230/blog/4688808) 