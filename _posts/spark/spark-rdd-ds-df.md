---
title: RDD vs DataFrame vs DataSet
date: 2021-01-03 15:28:21
categories: [spark]
tags: [spark]
---

{% image "/images/spark/spark-aura-9.3.1.png", width="600px", alt="Spark SQL，可对不同格式的数据执行ETL操作（如JSON，Parquet，数据库）然后完成特定的查询操作." %}

<!-- more -->

## 1. RDD和DataFrame

左侧的RDD[Person]虽然以Person为类型参数，Spark框架本身不了解Person类的内部结构。而右侧的DataFrame却提供了详细的结构信息. 使得Spark SQL可以清楚地知道该数据集中包含哪些列，每列的名称和类型各是什么。DataFrame多了数据的结构信息，即schema。

> - RDD是分布式的Java对象的集合。
> - DataFrame是分布式的Row对象的集合。

DataFrame除了提供了比RDD更丰富的算子以外，更重要的特点是提升执行效率、减少数据读取以及执行计划的优化，比如filter下推、裁剪等。

## 2. DF 提升执行效率

RDD API是函数式的，强调不变性，在大部分场景下倾向于`创建新对象而不是修改老对象`。

Spark SQL在框架内部已经在各种可能的情况下 <strong>`尽量重用对象`</strong>，这样做虽然在内部会打破了不变性，但在将数据返回给用户时，还会重新转为不可变数据。

> 利用 DataFrame API进行开发，可以免费地享受到这些优化效果。

## 3. DF 减少数据读取

分析大数据，最快的方法就是 ——忽略它。这里的“忽略”并不是熟视无睹，而是根据查询条件进行恰当的剪枝

上文讨论分区表时提到的 分区剪枝 便是其中一种 -> 当查询的过滤条件中涉及到分区列时，我们可以根据查询条件剪掉肯定不包含目标数据的分区目录，从而减少IO

## 4. RDD和DataSet

> - DataSet以Catalyst逻辑执行计划表示，并且数据以编码的二进制形式被存储，不需要反序列化就可以执行sorting、shuffle等操作。
> 
> - DataSet创立需要一个显式的Encoder，把对象序列化为二进制，可以把对象的scheme映射为Spark SQl类型，然而RDD依赖于运行时反射机制。

## 5. DataFrame和DataSet

> Dataset可以认为是DataFrame的特例，区别是Dataset每一个record存储的是一个强类型值而不是一个Row
> 
> 1. DataSet可以在编译时检查类型
> 2. 是面向对象的编程接口
> 3. DataFrame会继承DataSet，DataFrame是面向Spark SQL的接口

## Reference

- [用Apache Spark进行大数据处理——第二部分：Spark SQL][9]
- [RDD、DataFrame和DataSet的区别](https://www.jianshu.com/p/c0181667daa0)

[9]: http://www.infoq.com/cn/articles/apache-spark-sql
