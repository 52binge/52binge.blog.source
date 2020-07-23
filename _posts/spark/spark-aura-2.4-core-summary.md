---
title: Spark 的 WordCountJava 2.4 总结
toc: true
date: 2020-07-22 08:47:21
categories: [spark]
tags: [spark]
---


Spark 内容回顾

<!--more-->



**避免重复计算**

**可选的 Shuffle 排序**

**灵活的内存管理策略**

三种运行

1. run-example
2. spaek-shell
3. spark-submit

>  spark ----> spark-submit
>  hadoop ---> hadoop jar
>  hive -----> hive -f
  
**WordCount**
 
  (1). 获取编程入口 SparkContext
  (2). 通过编程入口加载数据， 得到数据抽象 RDD
  (3). 针对 RDD 进行各种业务处理
  (4). 针对第3步的结果进行处理
  (5). 关闭 SparkContext

**RDD算子**

SparkContext RDD 算子 (各种函数 map, flatMap, filter)

RDD的算法的分诶的时候：

Transformation： 转换 is lazy
Action： 行动


## Reference

