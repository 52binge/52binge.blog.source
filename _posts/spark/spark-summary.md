---
title: Spark Summary
toc: true
date: 2020-08-31 07:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-summary-logo.jpg" width="500" alt="" />

<!-- more -->

## 1. Spark section-0 基础 (3)

1. spark的有几种部署模式，每种模式特点？
2. Spark技术栈有哪些组件，每个组件都有什么功能，适合什么应用场景？
3. spark有哪些组件

> - master：管理集群和节点，不参与计算。
> - worker：计算节点，进程本身不参与计算，和master汇报。
> - Driver：运行程序的main方法，创建spark context对象。
> - spark context：控制整个application的生命周期，包括dagsheduler和task scheduler等组件。
> - client：用户提交程序的入口。

## 2. Spark运行细节 (13)

1. spark工作机制
2. Spark应用程序的执行过程
3. driver的功能是什么？
4. Spark中Work的主要工作是什么？
5. task有几种类型？2种
6. 什么是shuffle，以及为什么需要shuffle？
7. Spark master HA 主从切换过程不会影响集群已有的作业运行，为什么？
8. Spark并行度怎么设置比较合适
9. Spaek程序执行，有时候默认为什么会产生很多task，怎么修改默认task执行个数？
10. Spark中数据的位置是被谁管理的？
11. 为什么要进行序列化
12. Spark如何处理不能被序列化的对象？

## 3. Spark 与 Hadoop 比较(7)

1. Mapreduce和Spark的相同和区别
2. 简答说一下hadoop的mapreduce编程模型
3. 简单说一下hadoop和spark的shuffle相同和差异？
4. 简单说一下hadoop和spark的shuffle过程
5. partition和block的关联
6. Spark为什么比mapreduce快？
7. Mapreduce操作的mapper和reducer阶段相当于spark中的哪几个算子？

> 相当于spark中的map算子和reduceByKey算子，区别：MR会自动进行排序的，spark要看具体partitioner

## 4. Spark RDD(4)

## 5. Spark 大数据问题(7)

## Reference

- [Spark知识点汇总](https://www.jianshu.com/p/7a8fca3838a4)
- [Spark总结(一) 知乎](https://zhuanlan.zhihu.com/p/49169166)
