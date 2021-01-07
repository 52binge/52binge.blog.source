---
title: Spark Practice
toc: true
date: 2021-01-06 07:07:21
categories: [spark]
tags: [spark]
---

<!--<img src="/images/spark/spark-summary-logo.jpg" width="500" alt="" />
-->

hello count world

<!-- more -->

[good - Spark会把数据都载入到内存么？](https://www.jianshu.com/p/b70fe63a77a8)

## 1. Spark Functions

### 1.1 count, first

```python
lines.= sc.textFile("file:///home/blair/../input.txt")


lines.count()
lines.first()
lines.take(3)
```

### 1.2 filter

```python
pythonLines = lines.filter(lambda line: "Python" in line)

# 另一种写法

def hasPython(line):
    return "Python" in line
pythonLines = lines.filter(hasPython)
```

### 1.3 sc init

```python
from pyspark import SparkConf, SparkContext
#conf = SparkConf().setMaster("local").setAppName("My App")
#sc = SparkContext(conf = conf)

# sc 默认就有了

sc.stop()
```

## Reference

- [spark python 练习（一）](https://blog.csdn.net/Anne999/article/details/70157538)
