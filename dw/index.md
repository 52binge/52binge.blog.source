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

### 1. Data WareHouse

> 1). 范式建模/维度建模的区别，应用场景的区别，优缺点
<details>
<summary>3NF vs Dimensional modeling </summary>
```
3NF: 
	每个属性值唯一，不具有多义性；
	每个非主属性必须完全依赖于整个主键，而非主键的一部分；    
	每个非主属性不能依赖于其他关系中的属性，因为这样的话，这种属性应该归到其他关系中。    

维度模型:
	是一个规范化的事实表和反规范化的一些维度表组成的
```
</details>


> 2). IBM范式建模的七大主题是什么？其中怎样理解当事人主题

> 4. 缓慢变化维你们是怎么处理的？ 拉链表的实现
> 5. 数据分层情况/原因，解决的什么问题
> 6. 数据抽取和同步的方法
> 7. join的表中筛选和where中筛选有什么区别

[知乎:数据仓库建模](https://zhuanlan.zhihu.com/p/74765529)

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

### 6. Leetcode

#### 5.1 Array & LinkedList

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

