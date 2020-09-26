---
title: Spark Tutorials 3 - RDD
toc: true
date: 2020-09-25 16:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/data-flair/Apache-Spark-RDD-01.jpg" width="550" alt="" />

<!-- more -->

## 1. Create RDDs

<img src="/images/spark/data-flair/ways-to-create-RDDs-in-spark-2.jpg" width="700" alt="" />

## 2. RDD Persistence and Caching

What is RDD persistence, Why do we need to call cache or persist on an RDD, What is the Difference between Cache() and Persist() method in Spark

<img src="/images/spark/data-flair/RDD-Persistence-and-Caching-Mechanism-in-Apache-Spark-2.jpg" width="700" alt="" />

**What is RDD Persistence and Caching**

The difference between cache() and persist() is that using cache() the default storage level is `MEMORY_ONLY` while using persist() we can use various storage levels (described below).

> - Time efficient
> - Cost efficient
> - Lessen the execution time.

**Storage levels of Persisted RDDs**

> - MEMORY_ONLY
> - MEMORY_AND_DISK
> - MEMORY_ONLY_SER
> - MEMORY_AND_DISK_SER
> - DISK_ONLY

**How to Unpersist RDD in Spark?**

using RDD.unpersist() method.

## 3. RDD Features

<img src="/images/spark/data-flair/features-of-rdd-1.jpg" width="800" alt="" />

### 3.1 In-memory computation

<img src="/images/spark/data-flair/Spark-In-Memory-Computing.jpg" width="700" alt="" />

### 3.2 Lazy Evaluation

### 3.3 Fault Tolerance

[Fault tolerance in Apache Spark – Reliable Spark Streaming](https://data-flair.training/blogs/fault-tolerance-in-apache-spark/)

### 3.4 Immutability

### 3.5 Persistence

### 3.6 Partitioning

### 3.7 Parallel 

Rdd, process the data parallelly over the cluster.

### 3.8 Location-Stickiness

### 3.9 Coarse-grained Operation

### 3.10 Typed

We can have RDD of various types like: RDD [int], RDD [long], RDD [string].

### 3.11 No limitation

- [RDD Features](https://data-flair.training/blogs/apache-spark-rdd-features/)

- [good Spark基本工作原理和RDD特性](https://www.jianshu.com/p/17b86b677567)
- [Spark RDD 特征及其依赖](https://blog.csdn.net/qq_31573519/article/details/82822296)

## 4. Paired RDD

Here transformation operations are:

1. groupByKey
2. reduceByKey
3. join
4. left outer join
5. right outer Join

Whereas actions like **countByKey**

### 4.1 Objective

<img src="/images/spark/data-flair/Spark-Paired-RDD-01.jpg" width="700" alt="" />

in spark is designed as each dataset in RDD is divided into logical partitions. Further, we can say here each partition may be computed on different nodes of the cluster.

<img src="/images/spark/data-flair/Paired-RDD-01-1.jpg" width="600" alt="" />

### 4.2 Spark Paired RDD

```python
from pyspark import SparkConf , SparkContext
from operator import add
sc.version
lines22 = sc.textFile("/Users/blair/ghome/github/spark3.0/pyspark/spark-src/word_count.text", 2)
pairs22= lines22.map(lambda x: (x, 1))

#pairs22.take(2)

counts22 = pairs22.reduceByKey(add)

counts22
```

### 4.3 Create Spark Paired RDD

a. In Python language

```python
pairs = lines.map(lambda x: (x.split(” “)[0], x))
```

### 4.4 Paired RDD Operations

No. | Operations | desc
--- | :---: | ---
. | **`Transformation Operations`** | 
1. | groupByKey | The groupbykey operation generally groups all the values with the same key. <br> rdd.groupByKey()
2. | reduceByKey(fun) | Here, the reduceByKey operation generally combines values with the same key. <br> add.reduceByKey( (x, y) => x + y)
3. | **combineByKey**(createCombiner, mergeValue, mergeCombiners, partitioner) | CombineByKey uses a different result type, then combine those values with the same key.
4. | mapValues(func) | Even without changing the key, mapValues operation applies a function to each value of a paired RDD of spark. <br><br> rdd.mapValues(x => x+1)
5. | keys() | Keys() operation generally returns a spark RDD of just the keys.
6. | values() | values() operation generally returns an RDD of just the values.
7. | sortByKey() | Similarly, the sortByKey operation generally returns an RDD sorted by the key.
. | **`Action Operations`** | 
8. | countByKey() | countByKey operation, we can count the number of elements for each key.
9. | collectAsMap()** | Here, collectAsMap() operation helps to collect the result as a map to provide easy lookup.
10. | lookup(key) | Moreover, it returns all values associated with the provided key.


## 5. RDD limitations

## Reference

- [data-flair.training/blogs](https://data-flair.training/blogs/)
- [Spark RDD Operations-Transformation & Action with Example](https://data-flair.training/blogs/spark-rdd-operations-transformations-actions/)
- [Spark RDD常用算子学习笔记详解(python版)](https://blog.csdn.net/u014204541/article/details/81130870)
- [Spark常用的Transformation算子的简单例子](https://blog.csdn.net/dwb1015/article/details/52200809)
