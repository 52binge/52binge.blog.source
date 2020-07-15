---
title: Spark Tutorial 3 - Spark RDD
toc: true
date: 2020-07-07 20:07:21
categories: [spark]
tags: [spark]
---


<img src="/images/spark/spark-3.0-rdd-logo.png" width="550" alt="Spark RDD Feature" />

<!--more-->

## 1. Spark 是什么?

<img src="/images/spark/spark-3.1.png" width="900" alt="Spark" />

> SQL, Oracle, Spark
> 
>  1. Oracle == 汽车
>  2. hadoop == 飞机
>  3. SQL == 驾照
>  4. Spark 让SQL并行运行 == SQL加速器
> 
> Spark 是计算引擎

## 2. Spark 执行过程

<img src="/images/spark/spark-3.2.png" width="830" alt="Spark" />

> HiveOnSpark vs SparkSQL
>
>   1. Store
>   2. MR
> 
> HiveOnSpark, Hive SQL 可以用 Spark 执行引擎, 但是这样调优起来很麻烦
> 
> SparkSQL 比 Hive on Spark 好一点.

## 3. Spark 的起源

<img src="/images/spark/spark-3.3.png" width="900" alt="Spark" />

## 4. Spark 的架构图

> Spark 2.x python & Java 性能 1:1

<img src="/images/spark/spark-3.4.png" width="700" alt="Spark" />

Spark DataFrame 与 pandas Dataframe 没关系，但是可以互相转换

> 1. to_pandas
> 2. to_spark

 1. DataSets : for Java
 2. Dataframe : for Python
 3. SQL : SQL 

 条条大路通罗马
 
 > Spark 适合大规模机器学习，不适合深度学习(tensorflow适合深度学习)，这样理解对么？

## 5. RDD 的五个特性

<img src="/images/spark/spark-3.5.png" width="900" alt="Spark" />

## 6. Spark Api 如何使用

```bash
1. PYSPARK_PYTHON
2. JAVA_HOME
3. SPARK_HOME
4. PYLIB (os.environ["PYLIB"]=os.environ["SPARK_HOME"] + "/python/lib")
```

> PYLIB maybe not setting
>
> export PYSPARK_PYTHON=/Users/blair/.pyenv/versions/anaconda3/envs/spark/bin/python3
> export PYSPARK_DRIVER_PYTHON="jupyter"
> export PYSPARK_DRIVER_PYTHON_OPTS="notebook"

```python
以下是 Mars 的设置 （我们直接用pyspark, 则不用直接这样显示在程序中指定）：
os.environ["PYSPARK_PYTHON"]="C:/Users/netease/Anaconda3/python.exe"
os.environ["JAVA_HOME"]="C:/Program Files/Java/jdk1.8.0_144"
os.environ["SPARK_HOME"]="c:/spark"
os.environ["PYLIB"]=os.environ["SPARK_HOME"] + "/python/lib"
sys.path.insert(0,os.environ["PYLIB"] + "/py4j-0.10.7-src.zip" )
sys.path.insert(0,os.environ["PYLIB"] + "/pyspark.zip" )
```

## 7. 利用 Pyspark 完成 WordCount 

```python
from pyspark import SparkConf , SparkContext

print(sc.version)

lines = sc.textFile("/Users/blair/ghome/github/spark3.0/pyspark/spark-src/word_count.text", 2)

lines.take(3)

words= lines.flatMap(lambda x : x.split(" "))
words.take(3)

wordCounts = words.countByValue()
for word,count in wordCounts.items():
    print("{} : {}".format(word,count))
```

如果有3个节点, 则下列方法可以查看，数据分布在不同的 partition

```python
def indexedFunc(parindex,pariter):
    return ["partition : {} => {}".format(parindex,x) for x in pariter]
    
words.mapPartitionsWithIndex(indexedFunc).collect()
```

> ['partition : 0 => The',
> 'partition : 0 => history',
> 'partition : 0 => of',
> 'partition : 0 => New',
> 'partition : 0 => York',
> 'partition : 0 => begins',
> 'partition : 0 => around',
> 'partition : 0 => 10,000',

查看 spark 运行状态： http://localhost:8080/

<img src="/images/spark/spark-3.7.png" width="900" alt="Spark" />

查看 spark Jobs 状态：http://localhost:4040/jobs/

<img src="/images/spark/spark-3.6.png" width="900" alt="Spark" />

> `知识摘要`:
> 1. 如果用 Hadoop Mapreduce 来完成, 则代码写起来麻烦并繁多.
> 
> 2. Spark 是 内存版的 Mapreduce, Mapreduce 可以说是所有分布式计算的鼻祖.
> 
> 3. Spark 需要做性能调优的时候，还得再看 Mapreduce 的知识来修复.

## 8. Spark 执行图

<img src="/images/spark/spark-2.3.jpg" width="600" alt="Spark Exec" />


## Reference

- [大数据入门与实战-PySpark的使用教程](https://www.jianshu.com/p/5a42fe0eed4d)
- [Python - lru_cache和singledispatch装饰器](https://zhuanlan.zhihu.com/p/27643991)
- [大数据开发系列直播课 ③](https://study.163.com/course/courseMain.htm?courseId=1209979905)
- [PySpark-数据操作-DataFrame](https://www.jianshu.com/p/f79838ddb534)

[株式会社XG JAPAN 日本投资 | 过来人告诉你：日本创业移民的费用和坑](https://www.youtube.com/watch?v=plLTqfBIlqg)