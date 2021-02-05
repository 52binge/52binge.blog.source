---
top: 8
title: SparkSQL 从入门到调优
date: 2021-02-03 15:28:21
categories: [spark]
tags: [sparkSQL]
---

<img src="/images/spark/spark-sql-core-structure.jpeg" width="650" alt="" />


<!-- more -->

## sparksql

No. | Title Author | Link
--- | --- | --- 
1. | Spark学习技巧 | [Spark SQL从入门到精通](https://cloud.tencent.com/developer/article/1423334?from=article.detail.1033005) <br><br> Data Source： json, parquet, jdbc, orc, libsvm, csv, text, Hive 表
2. | Spark学习技巧 | [sparksql调优之第一弹](https://cloud.tencent.com/developer/article/1033005)<br><br> 1. JVM(略) 2. 内存调优 spark.catalog.cacheTable("tableName")  <br>3. 广播 broadcastTimeout=300 / autoBroadcastJoinThreshold  <br> 4. 分区设置 spark.sql.shuffle.partitions，默认是200
<br><br>3. | <br><br>[SparkSQL要懂的](https://zhuanlan.zhihu.com/p/336693158) | Spark SQL在Spark集群中是如何执行的？<br><br> 1. Spark SQL 转换为逻辑执行计划 <br> 2. Catalyst Optimizer组件，将逻辑执行计划转换为Optimized逻辑执行计划 <br> 3. 将Optimized逻辑执行计划转换为物理执行计划 <br> 4. Code Generation对物理执行计划进一步优化，将一些(非shuffle)操作串联在一起 <br> 5. 生成Job（DAG）由scheduler调度到spark executors中执行 <br><br> 逻辑执行计划和物理执行计划的区别？ <br><br> 1. 逻辑执行计划只是对SQL语句中以什么样的执行顺序做一个整体描述.<br>2. 物理执行计划包含具体什么操作. 例如：是BroadcastJoin、还是SortMergeJoin..
4. | [SparkSQL优化]((https://blog.csdn.net/YQlakers/article/details/68925328?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs)) | 1. spark.sql.codegen=false/true 每条查询的语句在运行时编译为java的二进制代码 <br> 2. spark.sql.inMemoryColumnStorage.compressed 默认false 内存列式存储压缩<br>3. spark.sql.inMemoryColumnStorage.batchSize = 1000 <br>4. spark.sql.parquet.compressed.codec 默认snappy, (uncompressed/gzip/lzo) <br><br>5. spark.catalog.cacheTable("tableName") 或 dataFrame.cache()<br> 6. --conf "spark.sql.autoBroadcastJoinThreshold = 50485760" 10 MB -> 50M <br> 7. --conf "spark.sql.shuffle.partitions=200" -> 2000
5. | [SparkSQL调优](http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/) | http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/

### 1.1 基本操作

```python
val df = spark.read.json(“file:///opt/meitu/bigdata/src/main/data/people.json”)
df.show()
import spark.implicits._
df.printSchema()
df.select("name").show()
df.select($"name", $"age" + 1).show()
df.filter($"age" > 21).show()
df.groupBy("age").count().show()
spark.stop()
```

编码

```scala
// spark2+, SparkSession
val spark = SparkSession.builder()
  .config(sparkConf).getOrCreate()
//使用hive元数据
val spark = SparkSession.builder()
  .config(sparkConf).enableHiveSupport().getOrCreate()
spark.sql("select count(*) from student").show()
```

使用 createOrReplaceTempView

```scala
val df =spark.read.json("examples/src/main/resources/people.json") 
df.createOrReplaceTempView("people") 
spark.sql("SELECT * FROM people").show()
```

## Reference

No. | Link
--- | --- 
1. | [W3C School - Spark RDD 操作](https://www.w3cschool.cn/spark/toxq9ozt.html)
2. |  [W3C School - Spark RDD持久化](https://www.w3cschool.cn/spark/4ied1ozt.html)
3. |  [W3C School - Spark SQL性能调优](https://www.w3cschool.cn/spark/5ruxnozt.html)

- [背各种SparkSQL调优参数？这个东西才是SparkSQL必须要懂的](https://zhuanlan.zhihu.com/p/336693158)
- [SparkSQL性能调优](https://blog.csdn.net/YQlakers/article/details/68925328?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs)
- [一些常用的Spark SQL调优技巧](https://www.cnblogs.com/lestatzhang/p/10611322.html)

<br>

- [SparkSQL调优](http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/)
- [Spark基础：Spark SQL调优](https://zhuanlan.zhihu.com/p/148758337)
- [spark-sql调优技巧 - sparkSQL的前世今生](https://blog.csdn.net/weixin_40035337/article/details/108018058?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-0&spm=1001.2101.3001.4242)
- [聊聊spark-submit的几个有用选项](https://cloud.tencent.com/developer/article/1150767?from=article.detail.1423334)





