---
title: Spark Tutorials Summary 1
toc: true
date: 2020-09-19 07:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-summary-logo.jpg" width="500" alt="" />

<!-- more -->

## 1. Spark - Introduction

1. Objective – Spark Tutorial
2. Introduction to Spark Programming
3. Spark Tutorial –  History
4. Why Spark?
5. Apache Spark Components

> a. Spark Core
> b. Spark SQL
> c. Spark Streaming

[Spark Tutorial – Learn Spark Programming](https://data-flair.training/blogs/spark-tutorial/)

## 2. Spark - Ecosystem

<img src="/images/spark/apache-spark-ecosystem-components.jpg" width="700" alt="" />

## 3. Spark - Features

<img src="/images/spark/apache-spark-features.jpg" width="700" alt="" />

## 4. Spark - Shell Commands

<img src="/images/spark/apache-SPARK-Shell-Commands-01.jpg" width="600" alt="spark shell" />


### 4.1 Create a new RDD

a) Read File from local filesystem and create an RDD.

```python
from pyspark import SparkConf , SparkContext
lines = sc.textFile("/Users/blair/ghome/github/spark3.0/pyspark/spark-src/word_count.text", 2)

lines.take(3)
```

b) Create an RDD through Parallelized Collection

```python
from pyspark import SparkConf , SparkContext
no = [1, 2, 3, 4, 5, 6, 8, 7]
noData = sc.parallelize(no)

#ParallelCollectionRDD[45] at readRDDFromFile at PythonRDD.scala:262
```

c) From Existing RDDs

```python
words= lines.map(lambda x : x + "haha")

words.take(3)
```

### 4.2 RDD Number of Items

```python
noData.count()
#8
```

### 4.3 Filter Operation

```scala
scala> val DFData = data.filter(line => line.contains("DataFlair"))
```

### 4.4 Transformation and Action

```scala
scala> data.filter(line => line.contains("DataFlair")).count()
```

### 4.5 Read RDD first 5 item

```scala
scala> data.first()
scala> data.take(5)
```

Let’s run some actions

```python
noData.count()

noData.collect()
```

### 4.6 Spark WordCount

Spark WordCount Program in Scala

```scala
scala> var hFile = sc.textFile("hdfs://localhost:9000/inp")

scala> val wc = hFile.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _)
```

### 4.7 Write to HDFS

```scala
scala> wc.saveAsTextFile("hdfs://localhost:9000/out")
```



## Reference


- [Spark RDD Operations-Transformation & Action with Example](https://data-flair.training/blogs/spark-rdd-operations-transformations-actions/)
- [Spark RDD常用算子学习笔记详解(python版)](https://blog.csdn.net/u014204541/article/details/81130870)
- [Spark常用的Transformation算子的简单例子](https://blog.csdn.net/dwb1015/article/details/52200809)
