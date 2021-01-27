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

## 3. The execution of a task slow

The first thing to look at is **which stage of data skew occurs** in.

1. yarn-client submit, you can see the log locally, find which stage is currently running in the log;
2. yarn-cluster submit, Spark Web UI Run to the first few stages.

> Whether using the yarn-client mode or the yarn-cluster mode, we can take a deep look at the amount of data allocated by **each task of this stage** on the Spark Web UI, so as to further determine whether the uneven data allocated by the task causes data skew.

<img src="/images/spark/spark-data-skew-2.png" width="880" alt="Data skew only occurs during the shuffle process." />

After knowing which stage the data skew occurs, then we need to calculate which part of the code corresponds to the stage where the skew occurs based on the principle of stage division. 

**solution**: as long as you see a shuffle operator or Spark SQL SQL in the Spark code If there is a statement that will cause shuffle in the statement (such as a group by statement), then it can be determined that the front and the back stage are divided by that place.

**Word Count**

```scala
val conf = new SparkConf()
val sc = new SparkContext(conf)
 
val lines = sc.textFile("hdfs://...")
val words = lines.flatMap(_.split(" "))
val pairs = words.map((_, 1))
val wordCounts = pairs.reduceByKey(_ + _)
 
wordCounts.collect().foreach(println(_))
```

### 3.1 stages divided

the entire code, only one reduceByKey operator will shuffle, the front and back stages will be divided. 
\* stage0, mainly to perform operations from textFile to map, and perform **shuffle write operations**. 

### 3.2 shuffle write

The shuffle write operation can be simply understood as **partitioning the data in the pairs RDD**. In the data processed by each task, the same key will be written to the same disk file.
\* Stage1 is mainly to perform operations from reduceByKey to collect. 

### 3.3 shuffle read

When **each task of stage1** starts to run, it will first perform shuffle read operation. The task that performs the shuffle read operation will pull those keys that `belong to the node where each task of stage 0 is located`, and then perform operations such as global aggregation or join on the same key. Here, the value of the key is accumulated. 

After `stage1 executes the reduceByKey operator, it calculates the final wordCounts RDD`, and then executes the collect operator to pull all the data to the Driver for us to traverse and print out.



## Reference

- [Spark实践 -- 性能优化基础](https://www.cnblogs.com/stillcoolme/p/10576563.html)




