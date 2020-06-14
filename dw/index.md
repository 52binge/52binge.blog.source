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
> 6. [数据分层情况/原因，解决](数据仓分层的意义及如何优雅地设计数据分层)
> 7. 数据抽取和同步的方法

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

> 1. hive整个调优过程做了哪些?
> 2. hive数仓整体架构，实现过程，有哪些问题，是怎样解决的
> 3. 元数据是怎样管理的？元数据中都包括了那些数据
> 4. 怎样保证数据质量
> 5. mapreduce 执行原理
> 6. hive的窗口函数
> 7. hive 分区和分桶具体怎么实现的？
> 8. Hive 支持的底层数据文件类型有哪些
> 9. 数据表的分组和分块？

<!--<details>
<summary>元数据</summary>
元数据包括表的名字，表的列和分区及其属性，表的属性（是否为外部表等），表的数据所在目录等。
</details>-->

- [CSDN-Hive面试题收集](https://blog.csdn.net/WYpersist/article/details/80102757)
- [Hive常见面试题1.0](https://zhuanlan.zhihu.com/p/93932766)

### 3. Hadoop

> 1. hadoop的mr的shuffle过程是怎样的？
> 2. 对于hive的性能优化有哪些经验？
> 3. 简要介绍一下mapreduce执行时的数据流转

### 4. SQL

> 1. sql 分组三类函数的区别
> 2. 手写sql，随意修改要求说出统计思路

### 5. Python

- [2018年最常见的Python面试题&答案（上篇）](https://juejin.im/post/5b6bc1d16fb9a04f9c43edc3)

- [110道Python面试题](https://zhuanlan.zhihu.com/p/54430650)

#### 6. Project

ehxs:
 
> 1). info extract
> 2). Finance
> 3). Sqoop, Hive, Task Scheduling， Airflow
> 4). DMP 


### 7. Leetcode

#### 7.1 Array & LinkedList

<details>
<summary>1. 约瑟夫环</summary>
```python
class Solution:
    def lastRemaining(self, n: int, m: int) -> int:
        if n < 1 or m < 1:
            return None
            
        last = 0
        for i in range(2, n + 1):
            last = (last + m) % i
        return last
```
</details>

<details>
<summary>3. 替换空格</summary>
```python
class Solution:
    def replaceSpace(self, s: str) -> str:
        return s.replace(" ","%20")
```
</details>


## Reference


- [ETL架构师面试题（这篇文章太棒了）](https://www.cnblogs.com/tmeily/p/4593700.html)

