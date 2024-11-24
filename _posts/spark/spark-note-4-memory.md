---
---
title: Spark Notes 4 - Spark Memory Questions and Answers 
date: 2024-11-22 01:00:21
categories: [spark]
tags: [spark]
---

{% image "/images/spark/spark-rdd-logo.png", width="500px", alt="" %}


<!-- more -->


## 1. Spark memory model

{% image "https://pic4.zhimg.com/v2-7f9edb32ca5ecff916b9bdd52807a817_r.jpg", width="1000px", alt="" %}

| Memory Type          | Description                                                                                   |
|----------------------|-----------------------------------------------------------------------------------------------|
| **Execution Memory** | Used for storing intermediate results during task execution, such as Shuffle and Join.         |
| **Storage Memory**   | Used for caching data (e.g., `RDD.cache()` or `Dataset.persist()`) and broadcasting variables. |
| **Dynamic Allocation** | Execution and Storage Memory share the same region. Unused memory can be reallocated between them. |
| **Key Parameters**   | - `spark.memory.fraction`: Fraction of JVM heap allocated to Execution and Storage (default 0.6). <br> - `spark.memory.storageFraction`: Fraction allocated to Storage (default 0.5, i.e., 30% of JVM heap). |


---

## 2. Optimize Spark memory 

| Optimization Method      | Description                                                                                                              |
|--------------------------|--------------------------------------------------------------------------------------------------------------------------|
| **Adjust Parallelism**   | Increase parallelism to reduce the size of each partition. Configure with `spark.default.parallelism` or `RDD.repartition()`. |
| **Optimize Memory Config** | Increase `spark.executor.memory` and `spark.driver.memory`. Enable off-heap memory with `spark.memory.offHeap.enabled=true` and configure `spark.memory.offHeap.size`. |
| **Serialization Optimization** | Use Kryo serializer: `spark.serializer=org.apache.spark.serializer.KryoSerializer`. Register custom classes for better performance. |
| **Efficient Caching**    | Cache only necessary data and release it in time using `RDD.unpersist()`.                                                  |
| **Shuffle Optimization** | Enable shuffle compression (`spark.shuffle.compress=true`) and avoid wide dependencies (e.g., use `ReduceByKey` instead of `GroupByKey`). |

---

## 3. Troubleshoot OutOfMemory

| Steps to Troubleshoot     | Description                                                                                          |
|---------------------------|------------------------------------------------------------------------------------------------------|
| **Check Logs**            | Identify if the issue is due to Executor or Driver memory. Look for errors like `GC overhead limit exceeded` or `Java heap space`. |
| **Analyze Partition Count** | Check if there are too few partitions, leading to large data per partition.                        |
| **Inspect Wide Dependencies and Cache** | Investigate whether wide dependencies (e.g., `GroupByKey`) or excessive caching caused the issue. |


---

| Resolution Methods        | Description                                                                                          |
|---------------------------|------------------------------------------------------------------------------------------------------|
| **Adjust Memory Settings** | Increase `spark.executor.memory` and `spark.driver.memory`. Enable off-heap memory (`spark.memory.offHeap.enabled=true`). |
| **Increase Partition Count** | Use `RDD.repartition()` or `RDD.coalesce()` to increase partitions and reduce data size per partition. |
| **Optimize DAG**           | Avoid wide dependencies (e.g., `GroupByKey`), use narrow dependencies (e.g., `ReduceByKey`).         |
| **Release Cache**          | Use `RDD.unpersist()` to release unnecessary cached data.                                           |

---

## 4. Off-Heap Memory (堆外内存)

| Aspect                  | Description                                                                                          |
|-------------------------|------------------------------------------------------------------------------------------------------|
| **Definition**          | Off-heap memory refers to memory outside the JVM heap, typically used for serialized data storage to reduce GC pressure. |
| **Enable Off-Heap Memory** | Configure `spark.memory.offHeap.enabled=true` and set `spark.memory.offHeap.size` (e.g., 4g).                     |
| **Use Cases**           | Useful for large datasets with high GC overhead or for storing serialized data streams.              |

---

## 5. Memory overflow (内存溢出)

### 原因描述

| **原因**                  | **描述**                                                                                   |
|---------------------------|------------------------------------------------------------------------------------------|
| **分区不足（Insufficient Partitions）** | 分区数量过少，导致单个分区的数据量过大。                                                       |
| **内存配置不足（Insufficient Memory Config）** | Shuffle 或 Join 操作耗尽了 Executor 或 Driver 的内存。                                      |
| **缓存未释放（Unreleased Cache）**      | 缓存的数据未及时释放，导致内存占用过高。                                                         |
| **序列化对象过大（Large Serialized Objects）** | 序列化的对象过大，超出了内存限制。                                                             |

---

### 避免方法

| **避免方法**               | **描述**                                                                                   |
|---------------------------|------------------------------------------------------------------------------------------|
| **增加分区数量（Increase Partition Count）** | 使用 `spark.default.parallelism` 或 `RDD.repartition()` 增加分区数量。                              |
| **优化内存配置（Optimize Memory Config）**    | 增加 `spark.executor.memory` 和 `spark.driver.memory`，必要时启用堆外内存（off-heap memory）。          |
| **使用 Kryo 序列化（Use Kryo Serialization）** | 替换默认的 JavaSerializer，以减少内存消耗和序列化开销。                                               |
| **及时释放缓存（Release Cache Timely）**      | 使用 `RDD.unpersist()` 释放不再使用的缓存数据，从而释放内存。                                           |


## 6. How to monitor and debug Spark memory issues?

| Monitoring Method        | Description                                                                                          |
|--------------------------|------------------------------------------------------------------------------------------------------|
| **Spark UI**             | Use the Storage tab to monitor cached data usage and the Executors tab to check memory usage.        |
| **Log Analysis**         | Look into `stderr` logs for GC information and memory overflow errors like `GC overhead limit exceeded`. |
| **Metrics System**       | Enable Spark Metrics to send memory usage details to external tools like Prometheus or Grafana.      |
| **Memory Parameter Tuning** | Configure Driver memory (`--driver-memory`) and Executor memory (`--executor-memory`) settings. For example, `--driver-memory 4g` and `--executor-memory 8g`. |
 

---

## 1. 什么是宽依赖和窄依赖？两者的区别是什么？
- **考察点**: 对 Spark 的依赖模型的理解。
- **回答**:
  - **窄依赖（Narrow Dependency）**:
    - 每个分区的数据只依赖父 RDD 中的某些分区。
    - 示例：`map`、`filter`。
  - **宽依赖（Wide Dependency）**:
    - 一个分区依赖于父 RDD 中多个分区，通常会触发 Shuffle。
    - 示例：`groupByKey`、`join`。
  - **区别**:
    - 窄依赖更高效，无需 Shuffle。
    - 宽依赖通常需要 Shuffle，伴随较高的网络和磁盘开销。

---

## 2. Spark 中 Shuffle 的工作原理是什么？

- 对 Shuffle 的理解及其在 Spark 中的实现。
- 能否分析 Shuffle 的性能瓶颈，并提出优化方案。

Shuffle 分为两个阶段：**Shuffle 写** 和 **Shuffle 读**。

- **Shuffle 写**：
  1. 在 Map 阶段（Task），根据分区规则（例如 `HashPartitioner`）对数据进行分组。
  2. 将分组后的数据写入磁盘的临时文件中，按目标分区保存。
  3. 每个 Map Task 生成若干临时文件，分别对应目标分区。
  4. **特点**：涉及磁盘 I/O，可能产生大量中间文件。

- **Shuffle 读**：
  1. 在 Reduce 阶段（Task），Reduce Task 从其他节点读取属于自身分区的数据。
  2. 将读取到的数据加载到内存中进行处理。
  3. **特点**：涉及网络传输和内存分配，数据量大时可能导致内存溢出。

- **Data Skew**：
  - **定义**：Shuffle 是 Spark 中用于分区重新分配的操作。数据倾斜指的是某些分区的数据量过大（如特定 Key 数据量过多），会导致性能不均衡，甚至任务失败。
  - **触发场景**：主要出现在宽依赖操作中。
  - **瓶颈**：网络传输、磁盘 I/O 和内存消耗。
  - **优化策略**：包括减少 Shuffle 的触发、调整分区数量、启用 AQE 和处理数据倾斜。
  - `Spark 3.x 的 AQE 可以自动优化分区和 Join 策略，减少 Shuffle 的影响`

**处理数据倾斜**

- 在 Join 或 Aggregation 操作中，如果 AQE 发现某些分区的数据量远超其他分区（即数据倾斜），会对这些分区进行处理。
- 拆分倾斜分区：将数据量大的分区拆分为更小的子分区。
- 单独处理热点数据：对倾斜的 Key 单独处理，避免拖累整体任务。


```bash
spark.conf.set("spark.sql.adaptive.enabled", "true")  # 启用 AQE
spark.conf.set("spark.sql.adaptive.shuffle.targetPostShuffleInputSize", "64MB")

spark.conf.set("spark.sql.adaptive.skewJoin.enabled", "true")  # 启用数据倾斜优化
```

## 3. Hash Shuffle 和 Sort Shuffle 的区别？为什么 Spark 默认使用 Sort Shuffle？

- **考察点**: 对 Shuffle 策略的理解。
- **回答**:
  - **Hash Shuffle**:
    - 无需排序，生成文件数较多。
    - 适合小分区的任务。
  - **Sort Shuffle**:
    - 对数据进行排序，生成的文件数较少。
    - 适合分区多或需要排序的场景。
  - **默认使用 Sort Shuffle 的原因**:
    - 文件数少，磁盘 I/O 更高效。
    - 支持需要排序的操作（如 `sortByKey`）。

**如何优化 Shuffle Hash Join？**

1. **调整分区数量**：通过 `spark.sql.shuffle.partitions` 设置分区数量，避免单个分区过大。
2. **减少数据倾斜**：通过对 Join 键进行散列或预分区操作，均匀分布数据。
3. **启用 AQE（自适应查询执行）**：Spark 3.x 引入 AQE，能够动态调整分区大小，优化数据倾斜；

---

## 4. 如何优化 Spark 作业中的 Shuffle？
- **考察点**: 对 Shuffle 优化策略的理解。
- **回答**:
  - **减少 Shuffle 的触发**:
    - 缓解宽依赖操作，例如用 `reduceByKey` 替代 `groupByKey`。
  - **优化分区**:
    - 调整分区数，使用 `spark.sql.shuffle.partitions` 或 `RDD.repartition()`。
  - **启用压缩**:
    - 使用 `spark.shuffle.compress=true` 减少网络传输数据量。
  - **数据倾斜优化**:
    - 通过自定义分区器、数据预处理解决热点分区问题。

---

## 5. 什么场景会触发 Shuffle？

- **考察点**: 了解 Shuffle 的触发条件。
- **回答**:
  - 需要重新分区的操作：`repartition`、`coalesce`
  - 键值聚合操作：`reduceByKey` (Global) 、`groupByKey`
  - Join 操作：`join`
  - 去重操作：`distinct`

**reduceByKey 的两阶段依赖**

1. **Local Aggregation**: Each partition performs a local reduce first, which is a **narrow dependency**.
2. **Global Aggregation**: Data with the same key across partitions is shuffled and aggregated, which is a **wide dependency**.


| **Phase**          | **Type**               | **Dependency Relationship**      | **Triggers Shuffle** |
|---------------------|------------------------|-----------------------------------|-----------------------|
| Local Aggregation   | Narrow Dependency      | One partition depends on one parent partition | No                    |
| Global Aggregation  | Wide Dependency        | One partition depends on multiple parent partitions | Yes                   |
---

## 6. 如何解决数据倾斜问题？

- **考察点**: 数据倾斜问题的处理方法。

1. **分析问题**：
数据倾斜通常由 Join 键或 Group By 键的分布不均引起。常见原因包括热点 Key、分区数过少或小表过大等。
2. **解决方案**：
根据具体场景选择：
    - 调整分区数：增加 `spark.sql.shuffle.partitions`。
    - 使用 Salting：为热点 Key 添加随机前缀打散数据。
    - 广播小表：对小表使用 Broadcast Join 避免 Shuffle。
    - 过滤倾斜数据：将倾斜 Key 单独处理。
    - 启用 AQE：让 Spark 自动优化分区和 Join 策略。
3. **实际经验**：
    - 举例说明如何通过 Salting 或 Broadcast Join 解决过某次倾斜问题。
    - 强调启用 AQE 后能动态优化数据倾斜，非常适合现代大规模数据处理场景。






## Reference

- [Spark Transformations](http://spark.apache.org/docs/latest/rdd-programming-guide.html#transformations)
- [关于累加器的更多信息，可参见《Spark编程指南》](http://spark.apache.org/docs/latest/programming-guide.html#shared-variables)
- [Spark广播变量和累加器详解](https://blog.csdn.net/BigData_Mining/article/details/82148085)
- [马老师-Spark的WordCount到底产生了多少个RDD](https://blog.csdn.net/zhongqi2513/article/details/81513587)
- [大数据技术之_19_Spark学习_02_Spark Core 应用解析+ RDD 概念 + RDD 编程 + 键值对 RDD + 数据读取与保存主要方式 + RDD 编程进阶 + Spark Core 实例练习](https://www.cnblogs.com/chenmingjun/p/10777091.html)
- [Offer帮 英语学习包](https://offerbang.io/giftdl/language?wpm=2.3.137.2)
- [spark combinebykey？](https://www.zhihu.com/question/33798481/answer/90849144)
- [pyspark中combineByKey的两种理解方法](https://blog.csdn.net/mrlevo520/article/details/75579728)
- [Spark原理篇之RDD特征分析讲解](https://blog.csdn.net/huahuaxiaoshao/article/details/90744552)
- [PySpark 3.0.1 documentation »](http://spark.apache.org/docs/latest/api/python/pyspark.html?highlight=mapvalues)
- [data-flair.training/blogs](https://data-flair.training/blogs/)
- [Spark RDD Operations-Transformation & Action with Example](https://data-flair.training/blogs/spark-rdd-operations-transformations-actions/)
- [Spark RDD常用算子学习笔记详解(python版)](https://blog.csdn.net/u014204541/article/details/81130870)
- [Spark常用的Transformation算子的简单例子](https://blog.csdn.net/dwb1015/article/details/52200809)
