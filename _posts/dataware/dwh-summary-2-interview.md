---
top: 7
title: DataWare Review Summary 2
toc: true
date: 2021-01-09 09:07:21
categories: [data-warehouse]
tags: [data warehouse]
---

<img src="/images/dataware/sm-data-warehouse-logo-1.jpg" width="580" alt="" />

<!-- more -->

No. | [2020年大厂-数据仓库篇](https://my.oschina.net/u/4631230/blog/4688808) | Flag
:---: | --- | :---:
0. | [Hive SQL count（distinct）效率问题及优化](https://article.itxueyuan.com/a93Dg) <br>set mapreduce.map.memory.mb=48192;<br>set mapreduce.reduce.memory.mb=48192;<br>set mapred.reduce.tasks=1000；<br><br>select count（distinct account） from...where...<br><br> 加入distinct，map阶段不能用combine消重，数据输出为（k，v）形式然后在reduce阶段进行消重<br>Hive在处理COUNT这种“全聚合(full aggregates)”计算时，忽略指定的Reduce Task数，而强制使用1 <br><br> insert overwrite table temp select id，account，count(1) as num from tablename group by id，account； <br> <img src="/images/hadoop/map-reduce-combine.png" width="780" alt="" /> <br>[MapReduce流程简单解析](https://blog.csdn.net/yuzhuzhong/article/details/51476353)| ❎
1. | 手写"连续活跃登陆"等类似场景的sql | ❎
<br><br>2. | left semi join和left join区别? <br><br>`left semi join` 是 in(keySet) 的关系，遇到右表重复记录，左表会跳过；当右表不存在的时候，左表数据不会显示; 相当于SQL的in语句. <br>`left join`: 当右表不存在的时候，则会显示NULL |　<br><br>❎
<br><br><br>3. | 维度建模 和 范式建模(3NF模型) 的区别? <br><br> 维度建模是面向分析场景的，主要关注点在于快速、灵活: **星型模型 & 雪花模型 & 星系模型** <br><br> 3NF的最终目的就是为了降低数据冗余，保障数据一致性: <br> (2.1) 原子性 - 数据不可分割 <br> (2.2) 基于第一个条件，实体属性完全依赖于主键 <br> (2.3) 消除传递依赖 - 任何非主属性不依赖于其他非主属性 | <br><br><br>❎
<br><br><br> 4. | 数据漂移如何解决 ? <br><br>通常是指ods表的同一个业务日期数据中包含了前一天或后一天凌晨附近的数据或者丢失当天变更的数据，这种现象就叫做漂移，且在大部分公司中都会遇到的场景<br><br> 1. 多获取后一天的数据，保障数据只多不少 <br>2. 通过多个时间戳字段来限制时间获取相对准确的数据 log_time, modified_time, proc_time <br> &nbsp;&nbsp;&nbsp;&nbsp; modified_time 过滤非当天的数据，这样确保数据不会因为系统问题被遗漏 | <br><br><br>❎
5. | 拉链表如何设计，拉链表出现数据回滚的需求怎么解决 ? <br><br> 拉链表使用的场景：<br>1. 数据量大，且表中部分字段会更新，比如用户地址、产品描述信息、订单状态等等<br>2. 需要查看某一个时间段的历史快照信息<br>3. 变化比例和频率不是很大 |
6. | 以 LEFT JOIN 为例： 谈谈 在使用 LEFT JOIN 时，ON 和 WHERE 过滤条件的区别如下： <br><br> 1. on 条件是在生成临时表时使用的条件，它不管 on 中的条件是否为真，都会返回左边表中的记录 <br> 2. where 条件是在临时表生成好后，再对临时表进行过滤的条件。| ❎
7. | 公共层(CDM:dwd和dws) 和 数据集市层的区别和特点？ <br><br> 分为dwd层和dws层，主要存放`明细事实数据、维表数据 及 公共指标汇总数据`，其中明细事实数据、维表数据一般是根据ods层数据加工生成的，公共指标汇总数据一般是基于维表和明细事实数据加工生成的.<br><br> 采用维度模型方法作为理论基础，更多采用一些`维度退化的手段，将维度退化到事实表中`，减少事实表和维度表之间的关联。同时在汇总层，加强指标的维度退化，采用更多的宽表化手段构建公共指标数据层. <br><br> Data Mart: 就是满足特定部门或者用户的需求，按照多维方式存储。面向决策分析的数据立方体 |
8. | 从原理上说一下mpp和mr的区别 ? <br> 1. MPP跑的是SQL,而Hadoop底层处理是MapReduce程序 <br> 2. 扩展程度：MPP扩展一般是扩展到100左右,因为MPP始终还是DB,一定要考虑到C(Consistency) | ❎
9. | Kimball和Inmon的相同和不同？ Inmon： 不强调事实表和维度表的概念， 类似 3NF | ❎
10. | 缓慢变化维（Slowly Changing Dimension）处理方式 ?  <br>1. 重写覆盖 <br>2. 增加新行(注意事实表关联更新) <br>3. 快照 (每天保留全量的快照数据，通过空间换时间) <br>4. 历史拉链 (拉链表的处理方式，即通过时间标示当前有效记录) | ❎
11. | 数据质量/元数据管理/指标体系建设/数据驱动 | 略
12. | [hive的row_number()、rank()和dense_rank()的区别以及具体使用](https://blog.csdn.net/qq_20641565/article/details/52841345) | ❎
13. | [Hive窗口函数怎么设置窗口大小？](https://blog.csdn.net/qq_41106844/article/details/108415566), between 1 preceding and 1 following | ✔️
14. | Hive 四个by的区别 |
15. | 怎么验证Hive SQL的正确性 ？ <br> 1. 如果只是校验sql的语法正确性，可以通过explain或者执行一下就可以
16. | Hive数据选择的什么压缩格式 ? |
17. | Hive SQL如何转化MR任务 ? <br> HiveSQL ->AST(抽象语法树) -> QB(查询块) ->OperatorTree（操作树）->优化后的操作树->mapreduce任务树->优化后的mapreduce任务树 |
18. | join操作底层 MR 是怎么执行的？ 根据join对应的key进行分区shuffle，然后执行mapreduce那套流程. |
19. | Parquet数据格式内部结构? |
&nbsp; | [2020 BAT大厂数据分析面试经验：“高频面经”之数据分析篇](https://blog.csdn.net/qq_36936730/article/details/104302799) |
1. | Mysql中索引是什么？建立索引的目的？ |
2. | sql语句执行顺序？ from-on-join-where-group by-avg,sum-having |
3. | 数据库与数据仓库的区别? |
4. | OLTP和OLAP的区别？ |
5. | 行存储和列存储的区别? <br><br> 行存储：传统数据库的存储方式，同一张表内的数据放在一起，插入更新很快。缺点是每次查询即使只涉及几列，也要把所有数据读取<br>列存储：OLAP等情况下，将数据按照列存储会更高效，每一列都可以成为索引，投影很高效。缺点是查询是选择完成时，需要对选择的列进行重新组装。<br><br>当你的核心业务是 OLTP 时，一个行式数据库，再加上优化操作，可能是个最好的选择。<br>当你的核心业务是 OLAP 时，一个列式数据库，绝对是更好的选择 |
6. | Hive执行流程？ |
7. | Hive HDFS HBase区别？ <br> Hbase是Hadoop database，即Hadoop数据库.<br>&nbsp;&nbsp; 它是一个适合于非结构化数据存储的数据库，HBase基于列的而不是基于行的模式. |
8. | 数仓中ODS、DW、DM(Data Mart) 概念及区别？ |
9. | 窗口函数是什么？实现原理？ <br><br> 窗口函数又名开窗函数，属于分析函数的一种。用于解决复杂报表统计需求的功能强大的函数。窗口函数用于计算基于组的某种聚合值，它和聚合函数的不同之处是：`对于每个组返回多行`，而聚合函数对于每个组只返回一行.<br><br> 下面列举一些常用窗口函数：<br><br>1. 获取数据排名的：ROW_NUMBER() RAND() DENSE_RANK() PERCENT_RANK()<br>2. 获取分组内的第一名或者最后一名等：FIRST_VALUE() LAST_VALUE() LEAD() LAG()<br>3. 累计分布：vCUME_DIST() NTH_VALUE() NTILE() |




<details>
<summary>漫谈系列</summary>

> [1. 漫谈系列 - 数仓第一篇NO.1 『基础架构』](https://mp.weixin.qq.com/s/J_PA_qhU44DX0PiCDuVaEA)
> 
> [2. 漫谈系列 - 数仓第二篇NO.2 『数据模型』](https://mp.weixin.qq.com/s/oKcCQx2vfnyAYlu7V0uHbg)
> 
> [3. 漫谈系列 - 数仓第三篇NO.3 『数据ETL』](https://mp.weixin.qq.com/s/INerSvksPi8sreSVCA2csA)
> 
> [4. 漫谈系列 - 数仓第四篇NO.4 『数据应用』](https://mp.weixin.qq.com/s/Y1xWwJ2Jr392eRHQeBRYZQ)
> 
> [5. 漫谈系列 - 数仓第五篇NO.5 『调度系统』](https://mp.weixin.qq.com/s/d5g-anyABYAcbYfP-jg4HQ)
> 
> [6. 漫谈系列 - 数仓第六篇NO.6 『数据治理』][0]
> 
> [7. 漫谈系列 - 漫谈数仓第一篇NO.7 『面试真经』](https://mp.weixin.qq.com/s/iZs7zEb-yoiSnlG2q74Fvg)

<center><embed src="/images/dataware/建设企业级数据仓库EDW(内部资料，禁止外传).pdf" width="950" height="600"></center>

[0]: /2020/10/01/dataware/summary-dataware/


- [元数据管理解析以及数据仓库和主数据介绍](https://zhuanlan.zhihu.com/p/36136675)


No. | table_type | details
:---: | :---: | :--- | :---
1. | 事实表 | （1）事务事实表  <br> （2）周期快照事实表 <br> （3）累积快照事实表
2. | 维度表 | （1）退化维度（DegenerateDimension）<br> （2）缓慢变化维（Slowly Changing Dimensions）| 维度的属性并不是始终不变的，它会随着时间的流逝发生缓慢的变化，这种随时间发生变化的维度我们一般称之为缓慢变化维（SCD）

</details>

## Reference

- [SQL 窗口函数的优化和执行](https://mp.weixin.qq.com/s/zdHHg6MmydiUpTopn_sniA)
- [【社招】快手_数据仓库_面试题整理](https://blog.csdn.net/weixin_43619485/article/details/107164729)
- [2020年大厂面试题-数据仓库篇](https://my.oschina.net/u/4631230/blog/4688808) 