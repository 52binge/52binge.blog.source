---
title: DataWare Review Summary 1
date: 2020-10-01 09:07:21
categories: [data-warehouse]
tags: [data warehouse]
---

{% image "/images/dataware/sm-data-warehouse-logo-1.jpg", width="500px", alt="" %}

<!-- more -->

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
1. | 数仓建模工具哪一个好? | powerDesigner 勉强推一个吧
2. | DWS 轻度聚合及（汇总 == group by） | 是按照 Topic 划分的
3. | DWD join 成宽表 by ODS |  事实表基本都在 DWD 层.
4. | App 层也是在 Hive 中么? | 尽量不要
5. | 数据仓库的数据质量如何保障? | 需要从源头管控，业务系统进行细致的字段的校验
6. | 如何保证你的计算的指标结果准确性？ | 1. 有测试人员 2. 我们公司有做小样本数据集的抽取开发
7. | 数据存储格式 | orc / Parquet
8. | 数据压缩方式 | snappy / LZO
9. | 数据存储格式 + 压缩 | 服务器的磁盘空间可以变为原来的 1/3
10. | | beeline 客户端支持远程连接
11. | lzo 支持切分么？ | snappy 不支持切分, 给lzo文件建立索引后，则支持切分

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
3. | Clickhouse是一个用于在线分析处理（OLAP）的列式数据库管理系统（DBMS）
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


<details>
<summary>数据湖 vs 数据仓库 vs 数据中台</summary>

No. | Title | desc
:---: | --- | :---:
0. | [https://delta.io/](https://delta.io/) |
1. | [数据湖如何为企业带来9%的高增长？可否取代数据仓库？](https://mp.weixin.qq.com/s/SjQgQD4jstm9lrE0lSCMbA) | ✔️
2. | [数据湖(Data Lake)-剑指下一代数据仓库](https://mp.weixin.qq.com/s/8k5Iimm6ePaT_Dt1WJihkA) | ✔️
3. | [IOTA架构、数据湖、Metric Platform，终于有人讲清楚了！](https://mp.weixin.qq.com/s/nn6bHRmx9Xf3WI9mUyWPhw)
4. | [Delta Lake 数据湖的诞生与案例实践](https://mp.weixin.qq.com/s/CxRMnclnLtE9pDToBV6RDg) |

至此，我们也可以对比一下数据湖、数据仓库、数据中台，简明扼要概括为：

1）数据湖：   无为而治，目标AI

2）数据仓库：分而治之，目标BI

3）数据中台：一统天下，目标组织架构

> Data Lake是一个存储库，可以存储大量结构化，半结构化和非结构化数据。它是以原生格式存储每种类型数据的地方，对帐户大小或文件没有固定限制。它提供高数据量以提高分析性能和本机集成。
> 
> Data Lake就像一个大型容器，与真正的湖泊和河流非常相似。就像在湖中你有多个支流进来一样，数据湖有结构化数据，非结构化数据，机器到机器，实时流动的日志。
> 
> 数据湖相对于以往的关系型数据库、传统式数据仓库，更多体现的是一种数据存储技术上的融合。数据湖的提出，改变了用户使用数据的方式，同时，数据湖也整合了各种类型数据的分析和存储，用户不必为不同的数据构建不同数据存储库。
> 
> 但是，现阶段数据湖更多是作为数据仓库的补充，它的用户一般只限于专业数据科学家或分析师。数据湖概念和技术还在不断演化，不同的解决方案供应商也在添加新的特性和功能，包括架构标准化和互操作性、数据治理要求、数据安全性等。
> 
> 未来，数据湖可能会进一步发展，作为一种云服务随时按需满足对不同数据的分析、处理和存储需求，数据湖的扩展性，可以为用户提供更多的实时分析，基于企业大数据的数据湖正在向支持更多类型的实时智能化服务发展， 将会为企业现有的数据驱动型决策制定模式带来极大改变。
> 
> 即席查询（Ad Hoc）用户据自己的需求，灵活的选择查询条件，系统能够根据用户的选择生成相应的统计报表

</details>


<details>
<summary>dw</summary>


No. | 主题名称 | 主题描述
--- | --- | --- 
1. | **客户 (USER)** | 当事人, 用户信息, 非常多, 人行征信信息， 个人资产信息
2. | 机构 (ORG) | 线下有哪些团队, 浙江区，团队长，客户经理， 有 600+ 个. 只有维度表
<br>3. | <br>产品 (PRD) | 签协议 产生 产品, 业务流程, 只有维度表 <br> 产品维度表： 产品编号(分好几级), 产品名称, dim_code, dim_name， 上架， 下架<br>京东金条， code， 展示给财务
4. | 渠道 (CHL) |
5. | **事件 (EVT)** | 1. 业借<!--(50~200亿)--> / 注册&认证 2. 授信 3. 支用 4. 放款 5. 支付 6. 还款 <!--(支付流水总量有1.5亿) , 所以基本每天全量全量关联-->
6. | **协议 (AGR)** | 合约
7. | 营销 (CAMP) | 营销之后的，商务经理和渠道，谈下来之后， 后端 渠道， 资产， 账务
8. | **财务 (RISK)** |
9. | 风险 (FINANCE) | 风险部


</details>

## Reference

- [HDFS基本架构、原理、与应用场景、实践（附ppt）](https://mp.weixin.qq.com/s/Za1MuzKQBmuJCza400_hdg)
- [Hive存储格式对比](https://blog.csdn.net/xueyao0201/article/details/79103973)
- [very good - igDataGuide/面试-all](https://github.com/Dr11ft/BigDataGuide/tree/master/%E9%9D%A2%E8%AF%95)
- [Apache Druid 简介](https://zhuanlan.zhihu.com/p/82038648)
- [操作系统之堆和栈的区别](https://www.cnblogs.com/George1994/p/6399895.html)
- [漫谈数据仓库之拉链表（原理、设计以及在Hive中的实现）](https://blog.csdn.net/zhaodedong/article/details/54177686)
- [2020大数据/数仓/数开面试题真题总结(附答案)](https://mp.weixin.qq.com/s/pwyus1xfX7QAz5MtecveZw)



