---
top: 8
title: SparkSQL 从入门到调优
date: 2021-02-03 15:28:21
categories: [spark]
tags: [sparkSQL]
---

<img src="/images/spark/spark-sql-core-structure.jpeg" width="650" alt="" />


<!-- more -->


## 1. SparkSQL 发展

## 2. SparkSQL 使用

## 3. SparkSQL 调优

No. | Title Author | Link
--- | --- | --- 
0. | 华为开发者<br>SparkCore<br><br>知乎大数据<br>SparkSQL | [开发者指南 > 组件成功案例 > Spark > 案例10：Spark Core调优 > 经验总结](https://support-it.huawei.com/docs/zh-cn/fusioninsight-all/developer_guide/zh-cn_topic_0171822910.html) <br><br>[Spark基础：Spark SQL调优](https://zhuanlan.zhihu.com/p/148758337) <br><br> **1. Cache 缓存** <br>&nbsp;&nbsp;1.1 spark.catalog.cacheTable("t") 或 df.cache() <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Spark SQL会把需要的列压缩后缓存，避免使用和GC的压力<br>&nbsp;&nbsp;1.2 spark.sql.inMemoryColumnarStorage.compressed 默认true <br> &nbsp;&nbsp;1.3 spark.sql.inMemoryColumnarStorage.batchSize 默认10000 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 控制列缓存时的数量，避免OOM风险。<br> 引申要点： 行式存储 & 列式存储 优缺点 <br> **2. 其他配置** <br>&nbsp;&nbsp;2.1 spark.sql.autoBroadcastJoinThreshold <br>&nbsp;&nbsp;2.2 spark.sql.shuffle.partitions 默认200，配置join和agg的时候的分区数 <br>&nbsp;&nbsp;2.3 spark.sql.broadcastTimeout 默认300秒，广播join时广播等待的时间 <br>&nbsp;&nbsp;2.4 spark.sql.files.maxPartitionBytes 默认128MB，单个分区读取的最大文件大小<br>&nbsp;&nbsp;2.5 spark.sql.files.openCostInBytes <br>**3. 广播 hash join - BHJ** <br>&nbsp;&nbsp; 3.1 当系统 spark.sql.autoBroadcastJoinThreshold 判断满足条件，会自动使用BHJ <br><br>[华为云Stack全景图 > 开发者指南 > SQL和DataFrame调优 > Spark SQL join优化](https://support-it.huawei.com/docs/zh-cn/fusioninsight-all/developer_guide/zh-cn_topic_0171822912.html) <br><br> <details><summary>spark不会</summary> 注意spark不会确保每次选择广播表都是正确的，因为有的场景比如 full outer join 是不支持BHJ的。手动指定广播: broadcast(spark.table("src")).join(spark.table("records"), "key").show() </details>
1. | Spark学习技巧 | [Spark SQL从入门到精通](https://cloud.tencent.com/developer/article/1423334?from=article.detail.1033005) <br><br> Data Source： json, parquet, jdbc, orc, libsvm, csv, text, Hive 表
<br><br>3. | <br><br>[SparkSQL要懂的](https://zhuanlan.zhihu.com/p/336693158) | Spark SQL在Spark集群中是如何执行的？<br><br> 1. Spark SQL 转换为逻辑执行计划 <br> 2. Catalyst Optimizer组件，将逻辑执行计划转换为Optimized逻辑执行计划 <br> 3. 将Optimized逻辑执行计划转换为物理执行计划 <br> 4. Code Generation对物理执行计划进一步优化，将一些(非shuffle)操作串联在一起 <br> 5. 生成Job（DAG）由scheduler调度到spark executors中执行 <br><br> 逻辑执行计划和物理执行计划的区别？ <br><br> 1. 逻辑执行计划只是对SQL语句中以什么样的执行顺序做一个整体描述.<br>2. 物理执行计划包含具体什么操作. 例如：是BroadcastJoin、还是SortMergeJoin..
4. | [SparkSQL优化]((https://blog.csdn.net/YQlakers/article/details/68925328?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs)) | 1. spark.sql.codegen=false/true 每条查询的语句在运行时编译为java的二进制代码 <br> 2. spark.sql.inMemoryColumnStorage.compressed 默认false 内存列式存储压缩<br>3. spark.sql.inMemoryColumnStorage.batchSize = 1000 <br>4. spark.sql.parquet.compressed.codec 默认snappy, (uncompressed/gzip/lzo) <br><br>5. spark.catalog.cacheTable("tableName") 或 dataFrame.cache()<br> 6. --conf "spark.sql.autoBroadcastJoinThreshold = 50485760" 10 MB -> 50M <br> 7. --conf "spark.sql.shuffle.partitions=200" -> 2000
5. | [SparkSQL调优](http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/) | http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/ <br> 1. 对于数据倾斜，采用加入部分中间步骤，如聚合后cache，具体情况具体分析；<br>2. 适当的使用序化方案以及压缩方案； <br>3. 善于解决重点矛盾，多观察Stage中的Task，查看最耗时的Task，查找原因并改善； <br>4. 对于join操作，优先缓存较小的表；<br>5. 要多注意Stage的监控，多思考如何才能更多的Task使用PROCESS_LOCAL； <br> 6. 要多注意Storage的监控，多思考如何才能Fraction cached的比例更多

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

## 4. SparkSQL 运行过程

## 5. Catalyst


No. | Link
--- | --- 
0. | [【大数据】SparkSql连接查询中的谓词下推处理(一)](https://juejin.cn/post/6844903849405186055)
0. | [使用explain分析Spark SQL中的谓词下推，列裁剪，映射下推](https://www.jianshu.com/p/5ff225a70510)
1. | [SparkSQL – 从0到1认识Catalyst（转载）](https://www.cnblogs.com/shishanyuan/p/8456250.html) <br> [深入研究Spark SQL的Catalyst优化器（原创翻译）](https://www.cnblogs.com/shishanyuan/p/8455786.html)
2. | [Spark SQL Catalyst优化器](https://www.jianshu.com/p/410c23efb565)
3. | [【数据库内核】基于规则优化之谓词下推](https://blog.csdn.net/Night_ZW/article/details/108338826)

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





