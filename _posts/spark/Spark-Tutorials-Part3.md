---
title: Spark Tutorials 3 - RDD
toc: true
date: 2019-09-25 16:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/data-flair/Apache-Spark-RDD-01.jpg" width="550" alt="" />

<!-- more -->

- [very good Spark原理篇之RDD特征分析讲解](https://blog.csdn.net/huahuaxiaoshao/article/details/90744552)
- [spark 基础知识整理（一）](https://www.jianshu.com/p/fb8f3b34bc30)
- [spark 基础知识整理（二）- RDD专题](https://www.jianshu.com/p/7a8d5ee1bc44)
- [Spark 分区(Partition)的认识、理解和应用](https://blog.csdn.net/zhangzeyuan56/article/details/80935034)

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
. | map / flatMap / mapPartitions | ...
1. | groupByKey | The groupbykey operation generally groups all the values with the same key. <br> rdd.groupByKey()
2. | reduceByKey(fun) | Here, the reduceByKey operation generally combines values with the same key. <br> add.reduceByKey( (x, y) => x + y)
3. | **combineByKey**(createCombiner, mergeValue, mergeCombiners, partitioner) | CombineByKey uses a different result type, then combine those values with the same key.
4. | mapValues(func) | Pass each value in the key-value pair RDD through a map function without changing the keys; this also retains the original RDD’s partitioning.
5. | keys() | Keys() Return an RDD with the keys of each tuple.
6. | values() | Return an RDD with the values of each tuple.
7. | **`sortByKey`**(ascending=True, numPartitions=None, keyfunc=<function RDD.<lambda>>) | Similarly, the sortByKey operation generally returns an RDD sorted by the key.
. | **`Action Operations`** | 
8. | countByKey() | countByKey operation, we can count the number of elements for each key.
9. | collectAsMap() | Here, collectAsMap() operation helps to collect the result as a map to provide easy lookup.
10. | lookup(key) | Moreover, it returns all values associated with the provided key.

[PySpark 3.0.1 documentation »](http://spark.apache.org/docs/latest/api/python/pyspark.html?highlight=mapvalues)

**(1). reduceByKey(fun) & groupByKey**

```python
lines = sc.textFile("/Users/blair/ghome/github/spark3.0/pyspark/spark-src/word_count.text", 2)

lines.take(3)
words = lines.flatMap(lambda x: x.split(' '))
print(words.take(5))

wco = words.map(lambda x: (x, 1))
print(wco.take(5))
# word_count = wco.reduceByKey(add)
# print("\nword_count:")
# print(word_count.take(5))
print("\ngroupByKey:")
test = wco.groupByKey()
print(test.take(2))
# gp = test.map(lambda x: (x[0], [i for i in x[1]]))
# gp.take(2)
```

**(2). mapValues(fun)**

```python
rdd = sc.parallelize([("a", 1), ("b", 1), ("a", 1)])

sorted(rdd.groupByKey().mapValues(len).collect())
# [('a', 2), ('b', 1)]
sorted(rdd.groupByKey().mapValues(list).collect())
# [('a', [1, 1]), ('b', [1])]
```

**(3). keys(), values()**

```python
m = sc.parallelize([(1, 2), (3, 4)]).keys()
m.collect()
[1, 3]

m = sc.parallelize([(1, 2), (3, 4)]).values()
m.collect()
[2, 4]
```

**(4). sortBykey**

- [spark combinebykey？](https://www.zhihu.com/question/33798481/answer/90849144)
- [pyspark中combineByKey的两种理解方法](https://blog.csdn.net/mrlevo520/article/details/75579728)

## 5. RDD limitations

## Reference

- [Spark原理篇之RDD特征分析讲解](https://blog.csdn.net/huahuaxiaoshao/article/details/90744552)
- [PySpark 3.0.1 documentation »](http://spark.apache.org/docs/latest/api/python/pyspark.html?highlight=mapvalues)
- [data-flair.training/blogs](https://data-flair.training/blogs/)
- [Spark RDD Operations-Transformation & Action with Example](https://data-flair.training/blogs/spark-rdd-operations-transformations-actions/)
- [Spark RDD常用算子学习笔记详解(python版)](https://blog.csdn.net/u014204541/article/details/81130870)
- [Spark常用的Transformation算子的简单例子](https://blog.csdn.net/dwb1015/article/details/52200809)
