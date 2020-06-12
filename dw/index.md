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


### 2. Hive


### 3. Hadoop

### 4. Python

- [2018年最常见的Python面试题&答案（上篇）](https://juejin.im/post/5b6bc1d16fb9a04f9c43edc3)

- [110道Python面试题](https://zhuanlan.zhihu.com/p/54430650)

### 5. Leetcode

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

### 6. SQL

### 7. AI

## Reference

- [ETL架构师面试题（这篇文章太棒了）](https://www.cnblogs.com/tmeily/p/4593700.html)

