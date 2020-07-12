---
title: Spark Tutorial 2 - 执行过程
toc: true
date: 2020-07-07 10:07:21
categories: [spark]
tags: [spark]
---


<img src="/images/spark/spark-2.1-logo.png" width="450" alt="Spark" />

<!--more-->

## 1. Spark 执行过程

<img src="/images/spark/spark-2.2.png" width="700" alt="Spark Exec" />

## 2. pyspark 小试牛刀

要对这些RDD进行操作，有两种方法 :

1. Transformation
2. Action

Transformation - 这些操作应用于RDD以创建新的RDD。Filter，groupBy和map是转换的示例。

Action - 这些是应用于RDD的操作，它指示Spark执行计算并将结果发送回驱动程序。

### 2.1 count()

```python
from pyspark import SparkContext
sc = SparkContext("local", "count app")
words = sc.parallelize(
    ["scala",
     "java",
     "hadoop",
     "spark",
     "akka",
     "spark vs hadoop",
     "pyspark",
     "pyspark and spark"
     ])
counts = words.count()
print("Number of elements in RDD -> %i" % counts)
```

### 2.2 collect()

```python
from pyspark import SparkContext
sc = SparkContext("local", "collect app")
words = sc.parallelize(
    ["scala",
     "java",
     "hadoop",
     "spark",
     "akka",
     "spark vs hadoop",
     "pyspark",
     "pyspark and spark"
     ])
coll = words.collect()
print("Elements in RDD -> %s" % coll)

```


## 3. Spark 执行图

<img src="/images/spark/spark-2.3.jpg" width="600" alt="Spark Exec" />


## Reference

- [大数据入门与实战-PySpark的使用教程](https://www.jianshu.com/p/5a42fe0eed4d)
- [Python - lru_cache和singledispatch装饰器](https://zhuanlan.zhihu.com/p/27643991)
- [大数据开发系列直播课 ③](https://study.163.com/course/courseMain.htm?courseId=1209979905)