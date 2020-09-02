---
title: Spark Summary
toc: true
date: 2020-08-31 07:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-summary-logo.jpg" width="500" alt="" />

<!-- more -->

## 1. Spark 基础 (3)

1. spark的有几种部署模式，每种模式特点？ 
> 1). local  2). standalone 3). Spark on yarn [(yarn-cluster和yarn-client)][1.1]
2. Spark技术栈有哪些组件，每个组件都有什么功能，适合什么应用场景？
3. spark有哪些组件

> - master：管理集群和节点，不参与计算。
> - worker：计算节点，进程本身不参与计算，和master汇报。
> - Driver：运行程序的main方法，创建spark context对象。
> - sparkContext：控制整个application的生命周期，包括dagsheduler和task scheduler等组件。
> - client：用户提交程序的入口。

<img src="/images/spark/spark-aura-4.1.2.jpg" width="700" alt="" />

[1.1]: Spark:Yarn-cluster和Yarn-client区别与联系

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

### 2.1 spark工作机制

> - 用户在client端提交作业后，会由Driver运行main方法并创建 sparkContext
> - 执行add算子，形成dag图输入**dagscheduler** ， (创建job,划分Stage,提交Stage)
> - 按照add之间的依赖关系划分stage输入task scheduler
> - task scheduler会将stage划分为taskset分发到各个节点的executor中执行

### 2.2 Spark应用程序的执行过程

> - 构建Spark Application的运行环境（启动SparkContext）
> - SparkContext向资源管理器（可以是Standalone、Mesos或YARN）注册并申请运行Executor资源；
> - 资源管理器分配Executor资源，Executor运行情况将随着心跳发送到资源管理器上；
> - SparkContext构建成DAG图，将DAG图分解成Stage，并把Taskset发送给Task Scheduler
> - Executor向SparkContext申请Task，Task Scheduler将Task发放给Executor运行，SparkContext将应用程序代码发放给Executor。
> - Task在Executor上运行，运行完毕释放所有资源

### 2.3 driver的功能是什么？

Spark作业运行时包括一个Driver进程，也是作业主进程，有main函数，且有SparkContext的实例，是程序入口点；

**功能：**

> 1. 向集群申请资源
> 2. 负责了作业的调度和解析
> 3. 生成Stage并调度Task到Executor上（包括DAGScheduler，TaskScheduler）

### 2.4 Spark中Worker工作是什么？

> 1. 管理当前节点内存，CPU使用状况,接收master分配过来的资源指令,通过ExecutorRunner启动程序分配任务
> 2. worker就类似于包工头，管理分配新进程，做计算的服务，相当于process服务
> 3. worker不会运行代码，具体运行的是Executor是可以运行具体appliaction写的业务逻辑代码

### 2.5 task有几种类型？2种

- resultTask类型，最后一个task
- shuffleMapTask类型，除了最后一个task都是

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
- [Spark:Yarn-cluster和Yarn-client区别与联系](https://blog.csdn.net/sdujava2011/article/details/46825637)