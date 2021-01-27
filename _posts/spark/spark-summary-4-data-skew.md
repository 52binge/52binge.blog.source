---
top: 8
title: Spark - Data Skew Advanced
toc: true
date: 2021-01-27 07:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-summary-logo-1.jpg" width="500" alt="" />

<!-- more -->


## 1. Spark Data Skew

For example, there are a total of 1,000 tasks, 997 tasks are executed within 1 minute, but the remaining two or three tasks take one or two hours. This situation is very common.

**Most tasks are executed very fast, but some tasks are extremely slow.**

> the progress of the entire Spark job is determined by the task with the longest running time.

## 2. The principle of Data Skew

when performing shuffle, the `same key on each node` must be pulled to `a task on a node` for processing, such as **`aggregation or join`** operations according to the key. 

For example, most keys correspond to 10 pieces of data, but individual keys correspond to 1 million pieces of data, so most tasks may only be assigned to 10 pieces of data, and then run out in 1 second; but individual tasks may be assigned 1 million pieces The data will run for one or two hours. 

<img src="/images/spark/spark-data-skew-1.png" width="700" alt="Data skew only occurs during the shuffle process." />

No. | trigger shuffle operations <br> when data skew, it may be caused by using one of these operators.
:---: | :---
1. | distinct
2. | groupByKey
3. | reduceByKey
4. | aggregateByKey
5. | join, cogroup, repartition, etc. 

## 3. The execution of a task is particularly slow



## Reference

- [Spark实践 -- 性能优化基础](https://www.cnblogs.com/stillcoolme/p/10576563.html)




