---
title: Summary Data Warehouse
toc: true
date: 2020-10-01 09:07:21
categories: [data-warehouse]
tags: [SQL]
---

<img src="/images/dataware/sm-data-warehouse-logo-1.jpg" width="550" alt="" />

<!-- more -->

https://github.com/blair101/language/blob/master/offer/bishimianshi-20141001.cpp

- [数据仓库（二）](https://www.jianshu.com/p/a145e15dedfc)
- [数据仓库（一）](https://www.jianshu.com/p/9750703dba28)


<br>

---

- [1. 漫画：什么是数据仓库？](https://mp.weixin.qq.com/s/XIJoE3nV7QQwGE0WLIhiRw)
- [2. 深度 | 传统数仓和大数据数仓的区别是什么？ ✔️](https://mp.weixin.qq.com/s/Uo7UzUhCJdzXeLL8nRLefw)
- [3.【gd】 漫谈 | 大牛带你从0到1构建数据仓库实战](https://mp.weixin.qq.com/s/iwC0iKXBFFBVwxCQPhBAxg)
- [4. 数仓那点事：从入门到佛系](https://mp.weixin.qq.com/s/kbSZkggtdaEVnN6wjjv4ag)
- [5. 从8个角度5分钟搞定数据仓库](https://mp.weixin.qq.com/s/3pABsYDHLxS5u1NQV4PGBA)
- [6. 滴滴数据仓库指标体系建设实践](https://mp.weixin.qq.com/s/-pLpLD_HMiasyyRxo5oTRQ)
- [7. 数据仓库 | Hive必知必会（推荐收藏）](https://mp.weixin.qq.com/s/wtY3_c5PArgYrNDUVfqyIA)
- [8. 数仓深度 | 数据模型设计（推荐收藏）](https://mp.weixin.qq.com/s/_WHI-1gjW0iaQeKW0TfMDA)
- [9. 手把手教你如何搭建一个数据仓库](https://mp.weixin.qq.com/s/PwnQl6uji85m7BGALmOVrw)
- [10. 基于spark快速构建数仓项目（文末Q&A）](https://mp.weixin.qq.com/s/oidx8qDndDKr3MN5x5Xl-Q)
- [11. 数据湖VS数据仓库之争？阿里提出大数据架构新概念：湖仓一体！](https://mp.weixin.qq.com/s/V_EWJi5-rtiNNwmnGOdZYw)
- [12. 数据仓库（离线+实时）大厂优秀案例汇总（建议收藏）](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247485223&idx=2&sn=149000071adf5fbdf819fdf6afb1ce7f&chksm=cf34352af843bc3c3f56071447c57f120a3ca7601d4d67c17bb422695d6a4637eec42fad2819&scene=21#wechat_redirect)

> [1. 面试系列 | 大数据、数仓大厂面试（二）][0]
> [2. 面试真经 | 大数据、数仓大厂面试（一）][0]

- [Good - Hive 拉链表实践](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247485525&idx=2&sn=595eab33c9b16f5a20cded2bf3c4f8ed&chksm=cf343a58f843b34e20e2fcd4cbb21f8a27451a3b235050b1c91aec1ac756dc4ad4d74216b879&scene=21#wechat_redirect)


漫谈系列：

1. [仙子紫霞  数据仓库与Python大数据  1/1 叮！致2020的一封情书，请查收！文末2019年文章精选](https://mp.weixin.qq.com/s/tJjkaWsZKbsG8klBSn2JGw)

> [1. 漫谈系列 | 数仓第一篇NO.1 『基础架构』](https://mp.weixin.qq.com/s/J_PA_qhU44DX0PiCDuVaEA)
> [2. 漫谈系列 | 数仓第二篇NO.2 『数据模型』](https://mp.weixin.qq.com/s/oKcCQx2vfnyAYlu7V0uHbg)
> [3. 漫谈系列 | 数仓第三篇NO.3 『数据ETL』](https://mp.weixin.qq.com/s/INerSvksPi8sreSVCA2csA)
> [4. 漫谈系列 | 数仓第四篇NO.4 『数据应用』](https://mp.weixin.qq.com/s/Y1xWwJ2Jr392eRHQeBRYZQ)
> [5. 漫谈系列 | 数仓第五篇NO.5 『调度系统』](https://mp.weixin.qq.com/s/d5g-anyABYAcbYfP-jg4HQ)
> [6. 漫谈系列 | 数仓第六篇NO.6 『数据治理』][0]
> [7. 漫谈系列 | 漫谈数仓第一篇NO.7 『面试真经』](https://mp.weixin.qq.com/s/iZs7zEb-yoiSnlG2q74Fvg)

<center><embed src="/images/dataware/建设企业级数据仓库EDW(内部资料，禁止外传).pdf" width="950" height="600"></center>

[0]: /2020/10/01/dataware/summary-dataware/


- [元数据管理解析以及数据仓库和主数据介绍](https://zhuanlan.zhihu.com/p/36136675)


## 1. Data Warehouse

### 1.1 dw basic 

**data warehouse 逻辑分层架构：**

<img src="/images/dataware/dw-logic-pic.webp" width="850" alt="" />

### 1.2 data modeling

Title_Kimball | [深入浅出数据模型（推荐收藏）](https://mp.weixin.qq.com/s/qAitZe3BPkQNTIDAWgTsFw)
:---: | :---:
**流程** | 架构是自下向上，即从数据集市(主题划分)-->数据仓库--> 数据抽取，是以需求为导向的，一般使用星型模型  
**事实表和维表** | 架构强调模型由事实表和维表组成，注重事实表与维表的设计
**数据集市** | 数据仓库架构中，数据集市是一个逻辑概念，只是多维数据仓库中的主题域划分，并没有自己的物理存储，也可以说是虚拟的数据集市。是数据仓库的一个访问层，是按主题域组织的数据集合，用于支持部门级的决策。

**data modeling 的几种方式:**

No. | 数据建模方式 | type | details
:---: | :---: | :---: | :---:
1. | ER模型 | 三范式 |
<br> 2. | <br> 维度建模 |  **`1. 星型模型`** <br> 2. 雪花模型 <br> **`3. 星座模型`**
.. | .. | ..

#### 事实表

事实表生于业务过程，存储业务活动或事件提炼出来的性能度量。从最低的粒度级别来看，事实表行对应一个度量事件

#### 维度表

No. | table_type | details
:---: | :---: | :--- | :---
1. | 事实表 | （1）事务事实表  <br> （2）周期快照事实表 <br> （3）累积快照事实表
2. | 维度表 | （1）退化维度（DegenerateDimension）<br> （2）缓慢变化维（Slowly Changing Dimensions）| 维度的属性并不是始终不变的，它会随着时间的流逝发生缓慢的变化，这种随时间发生变化的维度我们一般称之为缓慢变化维（SCD）

### 1.3 data ETL

[SQL分析函数，看这一篇就够了](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247483677&idx=1&sn=32ddbe9c8747d9cf9a821162bb9de27f&chksm=cf343310f843ba0626f8623283dd4a23dc480788d818f53713ab038f2fd8f2152f08c985507a&scene=21#wechat_redirect)

### 1.4 data application

No. | Tool | description
:---: | :---: | :---:
1. | Apache_Druid | Druid是一个用于大数据实时查询和分析的高容错、高性能开源分布式系统，用于解决如何在大规模数据集下进行快速的、交互式的查询和分析。 
2. | Apache Kylin™ | 一个开源的分布式分析引擎，提供Hadoop/Spark之上的SQL查询接口及多维分析（OLAP）能力以支持超大规模数据，最初由eBay Inc. 开发并贡献至开源社区。它能在亚秒内查询巨大的Hive表。
3. | Clickhouse | Clickhouse是一个用于在线分析处理（OLAP）的列式数据库管理系统（DBMS）
4. | ADB<br>（AnalyticDB_for_MySQL） | 分析型数据库MySQL版（AnalyticDB for MySQL），是阿里巴巴自主研发的海量数据实时高并发在线分析（Realtime OLAP）云计算服务，使得您可以在毫秒级针对千亿级数据进行即时的多维分析透视和业务探索。

> Ad-hoc 查询或报告（即席查询或报告）是 商业智能的一个次要的话题，它还经常与OLAP、数据仓库、数据挖掘和其他工具相提并论。

## 2. Hive

- [1. 一篇文章让你了解Hive调优（文末赠书）](https://mp.weixin.qq.com/s/K8arR_TCsP-i8BK9tqD6Sg)
- [2. 再次分享！Hive调优，数据工程师成神之路](https://mp.weixin.qq.com/s/OsT2Sgjn47HbhVyRau2vOw)

## 3. Spark

> - **RDD** 
> 
> [1. 基础汇总(二) - RDD专题](https://www.jianshu.com/p/7a8d5ee1bc44)
> [2. Spark中的RDD究竟怎么理解？](https://www.zhihu.com/question/35423604)
> 
> **(1) partitions**
> 
>   每个RDD包括多个分区, 这既是RDD的数据单位, 也是计算粒度, **`每个分区是由一个Task线程处理`**. 在RDD创建的时候可以指定分区的个数, 如果没有指定, 那么默认分区的个数是CPU的核数（standalone）.
> 
> 每一分区对应一个内存block, 由BlockManager分配.
> 
> **(2) partitioner** (分区方法)
> 
> 只存在于（K,V）类型的rdd中，非（K,V）类型的partitioner的值就是None。
> 
> 这个属性指的是RDD的partitioner函数(分片函数), 分区函数就是将数据分配到指定的分区, 这个目前实现了HashPartitioner和RangePartitioner, 只有key-value的RDD才会有分片函数, 否则为none.
> 
> **(3) dependencies** (依赖关系) 
> 
> 窄依赖：父 RDD 的 partition 至多被一个子 RDD partition 依赖（OneToOneDependency）
> 宽依赖：父 RDD 的 partition 被多个子 RDD partitions 依赖（ShuffleDependency）
> 
> **(4) preferedlocations**
> 
> 按照“移动数据不如移动计算”原则，在spark进行任务调度的时候，优先将任务分配到数据块存储的位置
> 
> **(5) compute**
> 
> spark中的计算都是以分区为基本单位的，compute函数只是对迭代器进行复合，并不保存单次计算的结果
> 每个 RDD 中的 compute() 调用 parentRDD.iter() 来将 parent RDDs 中的 records 一个个 拉取过来。
> 
> rdd的算子主要分成2类，action和transformation。这里的算子概念，可以理解成就是对数据集的变换。action会触发真正的作业提交，而transformation算子是不会立即触发作业提交的。每一个 transformation() 方法返回一个 新的RDD。只是某些transformation() 比较复杂，会包含多个子 transformation()，因而会生成多个 RDD。这就是实际 RDD 个数比我们想象的多一些 的原因。通常是，当遇到action算子时会触发一个job的提交，然后反推回去看前面的transformation算子，进而形成一张有向无环图。在DAG中又进行stage的划分，划分的依据是依赖是否是shuffle的，每个stage又可以划分成若干task。接下来的事情就是driver发送task到executor，executor自己的线程池去执行这些task，完成之后将结果返回给driver。action算子是划分不同job的依据。shuffle dependency是stage划分的依据。

[Spark运行流程](https://mp.weixin.qq.com/s/pwyus1xfX7QAz5MtecveZw)

28.如果对RDD进行cache操作后，数据在哪里？

特别大的数据，怎么发送到excutor中？> 数据在第一执行cache算子时会被加载到各个Executor进程的内存中，第二次就会直接从内存中读取而不会区磁盘。

- [Spark面试题(一)](https://zhuanlan.zhihu.com/p/49169166)
- [大数据Spark面试题（一）](https://zhuanlan.zhihu.com/p/107354908)
- [1. 一文详解 Spark Shuffle](https://mp.weixin.qq.com/s/VdwOwmxmOpQC3NIaxqqbmw)
- [2. Spark-submit 参数调优完整攻略](https://mp.weixin.qq.com/s/mo2hYHT13SSMp8iSrsG5xg)
- [3. 每个 Spark 工程师都应该知道的五种 Join 策略](https://mp.weixin.qq.com/s/HusOqNA-45lpf5GduLz-pA)


## 4. hadoop

- [HDFS基本架构、原理、与应用场景、实践（附ppt）](https://mp.weixin.qq.com/s/Za1MuzKQBmuJCza400_hdg)

## 5. classic

- [2020大数据/数仓/数开面试题真题总结(附答案)](https://mp.weixin.qq.com/s/pwyus1xfX7QAz5MtecveZw)

## Reference

- [very good - igDataGuide/面试-all](https://github.com/Dr11ft/BigDataGuide/tree/master/%E9%9D%A2%E8%AF%95)
- [Apache Druid 简介](https://zhuanlan.zhihu.com/p/82038648)




