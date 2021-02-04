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

No. | Author| Link
--- | --- | --- 
1. | Spark学习技巧 | [Spark SQL从入门到精通](https://cloud.tencent.com/developer/article/1423334?from=article.detail.1033005) <br><br> Data Source： json, parquet, jdbc, orc, libsvm, csv, text, Hive 表
2. | Spark学习技巧 | [sparksql调优之第一弹](https://cloud.tencent.com/developer/article/1033005)<br><br> 1. JVM(略) 2. 内存调优 spark.catalog.cacheTable("tableName")  <br>3. 广播 broadcastTimeout/autoBroadcastJoinThreshold  <br> 4. 分区设置 spark.sql.shuffle.partitions，默认是200

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
  .config(sparkConf) .getOrCreate()
//使用hive元数据
val spark = SparkSession.builder()
  .config(sparkConf) .enableHiveSupport().getOrCreate()
spark.sql("select count(*) from student").show()
```

使用 createOrReplaceTempView

```scala
val df =spark.read.json("examples/src/main/resources/people.json") 
df.createOrReplaceTempView("people") 
spark.sql("SELECT * FROM people").show()
```

## Reference

- [W3C School - Spark SQL性能调优](https://www.w3cschool.cn/spark/5ruxnozt.html)
- [弱鸡了吧？背各种SparkSQL调优参数？这个东西才是SparkSQL必须要懂的](https://zhuanlan.zhihu.com/p/336693158)
- [SparkSQL性能调优](https://blog.csdn.net/YQlakers/article/details/68925328?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs)
- [一些常用的Spark SQL调优技巧](https://www.cnblogs.com/lestatzhang/p/10611322.html)
- [SparkSQL调优](http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/)
- [Spark基础：Spark SQL调优](https://zhuanlan.zhihu.com/p/148758337)
- [一些常用的Spark SQL调优技巧](https://blog.csdn.net/abc33880238/article/details/102100573?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs)
- [spark-sql调优技巧](https://blog.csdn.net/weixin_40035337/article/details/108018058?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-0&spm=1001.2101.3001.4242)
- [聊聊spark-submit的几个有用选项](https://cloud.tencent.com/developer/article/1150767?from=article.detail.1423334)





