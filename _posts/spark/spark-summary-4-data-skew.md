---
title: Spark - Data Skew Advanced
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

## 4. data skew - distribution of keys 

No. | View the data distribution of keys that cause data skew
:---: | :---
1. | If the data skew caused by the group by and join statements in Spark SQL, then query the key distribution of the table used in SQL Happening. 
2. | If the data skew is caused by the shuffle operator on Spark RDD, you can view the key distribution in the Spark job, such as `RDD.countByKey()`.  Then, collect/take, see the distribution of the keys.

> For example, Word Count
>
> we can first sample 10% of the sample data for pairs, then use the countByKey operator to count the number of occurrences of each key, and finally traverse and print the number of occurrences of each key in the sample data on the client.

```scala
val sampledPairs = pairs.sample(false, 0.1)
val sampledWordCounts = sampledPairs.countByKey()
sampledWordCounts.foreach(println(_))
```

No. | solutions of the data skew
:---: | :---
1. | Improve the parallelism of shuffle operations <br><br> 在对RDD执行shuffle算子时，给shuffle算子传入一个参数，比如reduceByKey(1000)，该参数就设置了这个shuffle算子执行时shuffle read task的数量<br><br>Spark SQL中的shuffle类语句，比如group by、join等，需要设置一个参数，即spark.sql.shuffle.partitions，该参数代表了shuffle read task的并行度，该值默认是200，对于很多场景来说都有点过小。 <br><br> Experience： cannot completely solve the data skew，such as the amount of data a key is 1 million.
2. | Two-stage aggregation (local aggregation + global aggregation) <br><br> **disadvantages**: only solve aggregate shuffle operations. If it is a shuffle operation of the `join` class, other solutions have to be used.
3. | Convert reduce join to map join <br><br>**advantages**: The effect is very good for data skew caused by the join operation, because shuffle and data skew will not happen at all. <br> **disadvantages**: only suitable for `a large table and a small table`. After all, we need to broadcast the small table, which `consumes more memory resources`. <br>The driver and each Executor will have a full amount of data of a small RDD in the memory. <br> If the RDD data we broadcast is relatively large, such as 10G or more, then memory overflow may occur. Therefore, it is not suitable for the situation where both are large tables.| 

<img src="/images/spark/spark-data-skew-reduce-by-key.png" width="" alt="Data skew only occurs during the shuffle process." />

```python
import sys
import random 
from pyspark import SparkContext, SparkConf
from operator import add
# sc, random.randint(0,2) # 0 or 1 0r 2
```

<details>
<summary>WordCounts reduceByKey More Info...</summary>

```python
# read data from text file and split each line into words
input_file = sc.textFile("/Users/blair/Desktop/input.txt", 2)
words=input_file.flatMap(lambda line: line.split(" "))
# words.collect() # ['China', 'Singapore', 'bbb', 'Singapore', 'hello', 'haha', 'hello', 'world'] 
# words.first()
```


```python
# count the occurrence of each word
wordCounts = words.map(lambda word: (f'{random.randint(0,2)}_{word}', 1)).reduceByKey(add)
wordCounts.take(10)
```

    [('0_Singapore', 3),
     ('2_bbb', 1),
     ('0_hello', 1),
     ('2_haha', 1),
     ('0_world', 1),
     ('1_ShangHai', 1),
     ('0_China', 1),
     ('2_Singapore', 4),
     ('1_Singapore', 1),
     ('2_hello', 1)]


```python
words_recover = wordCounts.map(lambda x: (x[0][x[0].find('_')+1:], x[1]))

word_count_ret = words_recover.reduceByKey(add)
word_count_ret.take(5)
```
</details>

    [('world', 1), ('ShangHai', 1), ('China', 1), ('Singapore', 8), ('bbb', 1)]


## 5. Convert reduce join to map join

<img src="/images/spark/spark-data-skew-5-join.png" width="750" alt="the smaller RDD directly into the Driver memory through the collect operator, and then create a Broadcast variable" />

code:

```python
// 首先将数据量比较小的RDD的数据，collect到Driver中来。
rdd1Data = rdd1.collect()
// 然后使用Spark的广播功能，将小RDD的数据转换成广播变量，这样每个Executor就只有一份RDD的数据。
// 可以尽可能节省内存空间，并且减少网络传输性能开销。
rdd1DataBroadcast = sc.broadcast(rdd1Data)
  
// 对另外一个RDD执行map类操作，而不再是join类操作。
JavaPairRDD<String, Tuple2<String, Row>> joinedRdd = rdd2.mapToPair(
        new PairFunction<Tuple2<Long,String>, String, Tuple2<String, Row>>() {
            private static final long serialVersionUID = 1L;
            @Override
            public Tuple2<String, Tuple2<String, Row>> call(Tuple2<Long, String> tuple)
                    throws Exception {
                // 在算子函数中，通过广播变量，获取到本地Executor中的rdd1数据。
                List<Tuple2<Long, Row>> rdd1Data = rdd1DataBroadcast.value();
                // 可以将rdd1的数据转换为一个Map，便于后面进行join操作。
                Map<Long, Row> rdd1DataMap = new HashMap<Long, Row>();
                for(Tuple2<Long, Row> data : rdd1Data) {
                    rdd1DataMap.put(data._1, data._2);
                }
                // 获取当前RDD数据的key以及value。
                String key = tuple._1;
                String value = tuple._2;
                // 从rdd1数据Map中，根据key获取到可以join到的数据。
                Row rdd1Value = rdd1DataMap.get(key);
                return new Tuple2<String, String>(key, new Tuple2<String, Row>(value, rdd1Value));
            }
        });
  
// 这里得提示一下。
// 上面的做法，仅仅适用于rdd1中的key没有重复，全部是唯一的场景。
// 如果rdd1中有多个相同的key，那么就得用flatMap类的操作，在进行join的时候不能用map，而是得遍历rdd1所有数据进行join。
// rdd2中每条数据都可能会返回多条join后的数据。
```

> 方案实践经验：曾经开发一个数据需求的时候，发现一个join导致了数据倾斜。优化之前，作业的执行时间大约是60分钟左右；使用该方案优化之后，执行时间缩短到10分钟左右，性能提升了6倍。
> 
> Other Solution 1: Use Hive ETL to preprocess data
> Other Solution 2: Filter a few keys that cause skew

## Reference

- [https://github.com/wwcom614/Spark/blob/master/src/main/scala/com/ww/rdd/performance_optimize/BroadcastMapJoins.scala](https://github.com/wwcom614/Spark/blob/master/src/main/scala/com/ww/rdd/performance_optimize/BroadcastMapJoins.scala)
- [每个Spark工程师都应该知道的](https://mp.weixin.qq.com/s/HusOqNA-45lpf5GduLz-pA)
- [Spark的五种JOIN策略解析](https://blog.csdn.net/jmx_bigdata/article/details/109480551?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs)
- [SparkSQL中的三种Join及其具体实现（broadcast join、shuffle hash join和sort merge join](https://blog.csdn.net/wlk_328909605/article/details/82933552?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs)
- [Spark Join——Broadcast Join、Shuffle Hash Join、Sort Merge Join](https://blog.csdn.net/lb812913059/article/details/83313853?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs)
- [spark sql优化：小表大表关联优化 & union替换or & broadcast join](https://blog.csdn.net/zhuiqiuuuu/article/details/79290926)
- [Hive数仓建表该选用ORC还是Parquet，压缩选LZO还是Snappy？](https://zhuanlan.zhihu.com/p/257917645)
- [Spark实践 -- 性能优化基础](https://www.cnblogs.com/stillcoolme/p/10576563.html)
- [尚硅谷2021迎新版大数据Spark从入门到精通](https://www.bilibili.com/video/BV11A411L7CK?p=184)
- [尚硅谷大数据电商数仓V3.0版本教程（数据仓库项目开发实战）](https://www.bilibili.com/video/BV1Hp4y1z7aZ?p=79)
- [Spark Sql 与 MySql 使用 group by 的差别](https://blog.csdn.net/sinat_36231857/article/details/88819553)



