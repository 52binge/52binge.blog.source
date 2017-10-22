---
title: Spark Machine Learning p1 - Spark编程入门
toc: true
date: 2016-04-25 10:07:21
categories: spark
tags: [spark]
mathjax: true
---

Spark 的环境搭建与运行, 接触了 RDD 与 SparkContext, 启动 Spark-Shell 以及如何使用 Scala、Python 编写 Spark 程序. 

<!--more-->

**Apache Spark**

Spark 的设计目标 即: `迭代式+低延迟` 适合 Machine Learning 算法的特性
Spark 分布式计算框架, 将中间数据和结果保存在内存中
Spark 提供函数式API, 并兼容 Hadoop 生态
Spark 框架对 资源调度、任务提交、执行、跟踪， 节点间通信以及数据并行处理的内在底层操作都进行了抽象

> 简化了海量数据的存储(HDFS) 和 计算(MR) 流程。MapReduce 缺点, 如: 启动任务时的高开销、对中间数据 和 计算结果 写入磁盘的依赖。这使得 Hadoop 不适合 迭代式 或 低延迟 的任务。

**Spark 的四种运行模式**

 1.  本地单机模式 -- Spark 进程 all run in one JVM
 2.  集群单机模式 -- 使用 Spark 自己内置的 任务调度框架
 3.  基于 Mesos 一个开源集群计算框架
 4.  基于 YARN 与 Hadoop2 关联形成集群计算和资源调度框架

## 1. Spark运行

运行示例程序来测试是否一切正常：

>./bin/run-example org.apache.spark.examples.SparkPi

该命令将在本地单机模式下执行SparkPi这个示例。在该模式下，所有的Spark进程均运行于同一个JVM中，而并行处理则通过多线程来实现。默认情况下，该示例会启用与本地系统的CPU核心数目相同的线程。

要在本地模式下设置并行的级别，以local[N]的格式来指定一个master变量即可。比如只使用两个线程时，可输入如下命令：

>MASTER=local[2] ./bin/run-example org.apache.spark.examples.SparkPi

## 2. Spark集群

Spark集群由两类程序构成: 

 1. 一个驱动程序
 2. 多个执行程序
 
> 本地模式下所有的处理都运行在同一个JVM内，而在集群模式时它们通常运行在不同的节点上。

一个采用单机模式的Spark集群包括：

 1. 一个运行Spark单机主进程和驱动程序的 Master；
 2. 各自运行一个执行程序进程的多个 Worker。

比如在一个Spark单机集群上运行，只需传入主节点的URL即可：

>MASTER=spark://IP:PORT ./bin/run-example org.apache.spark.examples.SparkPi
其中的IP和PORT分别是主节点IP地址和端口号。这是告诉Spark让示例程序运行在主节点所对应的集群上


## 3. Spark编程模型

### 3.1 SparkContext类

**SparkContext类与SparkConf类**

任何Spark程序的编写都是从SparkContext开始的。SparkContext的初始化需要一个SparkConf对象，后者包含了Spark集群配置的各种参数（比如主节点的URL）。

初始化后，我们便可用SparkContext对象所包含的各种方法来创建和操作RDD。Spark shell（在Scala和Python下可以，但不支持Java）能自动完成上述初始化。若要用Scala代码来实现的话，可参照下面的代码：

```scala
val conf = new SparkConf().setAppName("Test Spark App").setMaster("local[4]")
val sc = new SparkContext(conf)
```

这段代码会创建一个4线程的SparkContext对象，并将其相应的任务命名为Test Spark APP。我们也可通过如下方式调用SparkContext的简单构造函数

```scala
val sc = new SparkContext("local[4]", "Test Spark App")
```

### 3.2 Spark shell

Spark支持 用 Scala or Python REPL（Read-Eval-Print-Loop，即交互式shell）来进行交互式的程序编写。

```
./bin/spark-shell
```

会启动Scala shell 并初始化一个SparkContext对象。我们可以通过 sc这个Scala值来调用这个对象

### 3.3 RDD

一个 RDD 代表一系列的“记录”（严格来说，某种类型的对象）。
这些记录被分配或分区到一个集群的多个节点上（在本地模式下，可以类似地理解为单个进程里的多个线程上）。

Spark中的RDD具备容错性，即当某个节点或任务失败时（因非用户代码原因而引起，如硬件故障、网络不通等），RDD会在余下的节点上自动重建，以便任务能最终完成。

**1. 创建RDD**

RDD可从现有的集合创建 ：

```scala
val collection = List("a", "b", "c", "d", "e")
val rddFromCollection = sc.parallelize(collection)
```

RDD也可以基于Hadoop的输入源创建，比如本地文件系统、HDFS。基于Hadoop的RDD可以使用任何实现了Hadoop InputFormat接口的输入格式，包括文本文件、其他Hadoop标准格式、HBase等。以下举例说明如何用一个本地文件系统里的文件创建RDD：

```
val rddFromTextFile = sc.textFile("LICENSE")
```

上述代码中的textFile函数（方法）会返回一个RDD对象。该对象的每一条记录都是一个表示文本文件中某一行文字的String（字符串）对象。

**2. Spark操作**

在Spark编程模式下，所有的操作被分为 `transformation` 和 `action` 两种。

**transformation** 操作是对一个数据集里的所有记录执行某种函数，从而使记录发生改变；

**action** 通常是运行某些计算或聚合操作，并将结果返回运行 SparkContext 的那个驱动程序。

Spark 的操作通常采用``函数式``风格。

Spark程序中最常用的转换操作便是map操作。该操作对一个RDD里的每一条记录都执行某个函数，从而将输入映射成为新的输出。

比如，下面这段代码便对一个从本地文本文件创建的RDD进行操作。它对该RDD中的每一条记录都执行size函数。
创建一个这样的由若干String构成的RDD对象。通过map函数，我们将每一个字符串都转换为一个整数，从而返回一个由若干Int构成的RDD对象。

```scala
scala> rddFromTextFile.count
res2: Long = 294

scala> val intsFromStringsRDD = rddFromTextFile.map(line => line.size)
intsFromStringsRDD: org.apache.spark.rdd.RDD[Int] = MapPartitionsRDD[3] at map at <console>:23

scala> intsFromStringsRDD.count
res3: Long = 294

scala> val sumOfRecords = intsFromStringsRDD.sum
sumOfRecords: Double = 17062.0

scala> val numRecords = intsFromStringsRDD.count
numRecords: Long = 294

scala> val aveLengthOfRecord = sumOfRecords / numRecords
aveLengthOfRecord: Double = 58.034013605442176

// 等价于

val aveLengthOfRecordChained = rddFromTextFile.map(line => line.size).sum / rddFromTextFile.count

```

> 示例中 **=>** 是Scala下表示匿名函数的语法。语法 **line => line.size** 表示以 **=>** 操作符左边的部分作为输入，对其执行一个函数，并以 **=>** 操作符右边代码的执行结果为输出。在这个例子中，输入为line，输出则是 **line.size** 函数的执行结果。在Scala语言中，这种将一个String对象映射为一个Int的函数被表示为String => Int。

Spark的大多数操作都会返回一个新RDD，但多数的Action操作则是返回计算的结果

> 注 : Spark 中的转换操作是延后的。也就是说，在RDD上调用一个转换操作并不会立即触发相应的计算。 只有必要时才计算结果并将其返回给驱动程序，从而提高了Spark的效率。

```scala
scala> val transformedRDD = rddFromTextFile.map(line => line.size).
     | filter(size => size > 10).map(size => size * 2)
transformedRDD: org.apache.spark.rdd.RDD[Int] = MapPartitionsRDD[7] at map at <console>:24

scala>
```

没有触发任何计算，也没有结果被返回。
如果我们现在在新的RDD上调用一个执行操作，比如sum，该计算将会被触发：

***触发计算***

```scala
scala> val computation = transformedRDD.sum
computation: Double = 34106.0
```

**3. RDD缓存策略**

Spark最为强大的功能之一便是能够把数据缓存在集群的内存里。这通过调用RDD的cache函数来实现：

```scala
scala> rddFromTextFile.cache
res4: rddFromTextFile.type = MapPartitionsRDD[2] at textFile at <console>:21

scala> val aveLengthOfRecordChainedFromCached = rddFromTextFile.map(line => line.size).sum / rddFromTextFile.count
aveLengthOfRecordChainedFromCached: Double = 58.034013605442176
```

在RDD首次调用一个执行操作时，这个操作对应的计算会立即执行，数据会从数据源里读出并保存到内存。因此，首次调用cache函数所需要的时间会部分取决于Spark从输入源读取数据所需要的时间。但是，当下一次访问该数据集的时候，数据可以直接从内存中读出从而减少低效的I/O操作，加快计算。多数情况下，这会取得数倍的速度提升。

> Spark支持更为细化的缓存策略。通过persist函数可以指定Spark的数据缓存策略。关于RDD缓存的更多信息可参见：http://spark.apache.org/docs/latest/programming-guide.html#rdd-persistence。

### 3.4 广播变量和累加器

Spark的另一个核心功能是能创建两种特殊类型的变量：**广播变量** 和 累加器。

广播变量（broadcast variable）为只读变量，它由运行SparkContext的驱动程序创建后发送给会参与计算的节点。对那些需要让各工作节点高效地访问相同数据的应用场景，比如机器学习，这非常有用。

Spark下创建广播变量只需在SparkContext上调用一个方法即可：

```
scala> val broadcastAList = sc.broadcast(List("a", "b", "c", "d", "e"))
broadcastAList: org.apache.spark.broadcast.Broadcast[List[String]] = Broadcast(11)

scala>
```

**广播变量** 也可以被非驱动程序所在的节点（即工作节点）访问，访问的方法是调用该变量的`value`方法：

```scala
scala> val broadcastAList = sc.broadcast(List("a", "b", "c", "d", "e"))
broadcastAList: org.apache.spark.broadcast.Broadcast[List[String]] = Broadcast(11)

scala> sc.parallelize(List("1", "2", "3")).map(x => broadcastAList.value ++ x).collect
res5: Array[List[Any]] = Array(List(a, b, c, d, e, 1), List(a, b, c, d, e, 2), List(a, b, c, d, e, 3))
```

> 注意，collect 函数一般仅在的确需要将整个结果集返回驱动程序并进行后续处理时才有必要调用。如果在一个非常大的数据集上调用该函数，可能耗尽驱动程序的可用内存，进而导致程序崩溃。

高负荷的处理应尽可能地在整个集群上进行，从而避免驱动程序成为系统瓶颈。然而在不少情况下，将结果收集到驱动程序的确是有必要的。很多机器学习算法的迭代过程便属于这类情况。

**累加器**（accumulator）也是一种被广播到工作节点的变量。累加器与广播变量的关键不同，是后者只能读取而前者却可累加。

> 关于累加器的更多信息，可参见《Spark编程指南》：http://spark.apache.org/docs/latest/programming-guide.html#shared-variables。

## 4. Spark Scala 编程入门

[scala-spark-app](https://github.com/blair1/spark/tree/master/Spark-Machine-Learning_8519OSCode/Chapter%2001/scala-spark-app)

```scala
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._

/**
 * A simple Spark app in Scala
 */
object ScalaApp {

  def main(args: Array[String]) {
    val sc = new SparkContext("local[2]", "First Spark App")

    // we take the raw data in CSV format and convert it into a set of records of the form (user, product, price)
    val data = sc.textFile("data/UserPurchaseHistory.csv")
      .map(line => line.split(","))
      .map(purchaseRecord => (purchaseRecord(0), purchaseRecord(1), purchaseRecord(2)))

    // let's count the number of purchases
    val numPurchases = data.count()

    // let's count how many unique users made purchases
    val uniqueUsers = data.map { case (user, product, price) => user }.distinct().count()

    // let's sum up our total revenue
    val totalRevenue = data.map { case (user, product, price) => price.toDouble }.sum()

    // let's find our most popular product
    val productsByPopularity = data
      .map { case (user, product, price) => (product, 1) }
      .reduceByKey(_ + _)
      .collect()
      .sortBy(-_._2)
    val mostPopular = productsByPopularity(0)

    // finally, print everything out
    println("Total purchases: " + numPurchases)
    println("Unique users: " + uniqueUsers)
    println("Total revenue: " + totalRevenue)
    println("Most popular product: %s with %d purchases".format(mostPopular._1, mostPopular._2))

    sc.stop()
  }
}
```

## 5. Spark Java 编程入门

Java API与Scala API本质上很相似。Scala代码可以很方便地调用Java代码，但某些Scala代码却无法在Java里调用，特别是那些使用了隐式类型转换、默认参数和采用了某些Scala反射机制的代码。

SparkContext有了对应的Java版本JavaSparkContext，而RDD则对应JavaRDD。
Spark提供对Java 8匿名函数（lambda）语法的支持。

用Scala编写时，键/值对记录的RDD能支持一些特别的操作（比如reduceByKey和saveAsSequenceFile）。这些操作可以通过隐式类型转换而自动被调用。用Java编写时，则需要特别类型的JavaRDD来支持这些操作。它们包括用于键/值对的JavaPairRDD，以及用于数值记录的JavaDoubleRDD。

Java 8 RDD以及Java 8 lambda表达式更多信息可参见《Spark编程指南》：http://spark.apache.org/docs/latest/programming-guide.html#rdd-operations。

## 6. Spark Python 编程入门

```py
"""用Python编写的一个简单Spark应用"""
from pyspark import SparkContext

sc = SparkContext("local[2]", "First Spark App")
# 将CSV格式的原始数据转化为(user,product,price)格式的记录集
data = sc.textFile("data/UserPurchaseHistory.csv").map(lambda line:
line.split(",")).map(lambda record: (record[0], record[1], record[2]))
# 求总购买次数
numPurchases = data.count()
# 求有多少不同客户购买过商品
uniqueUsers = data.map(lambda record: record[0]).distinct().count()
# 求和得出总收入
totalRevenue = data.map(lambda record: float(record[2])).sum()
# 求最畅销的产品是什么
products = data.map(lambda record: (record[1], 1.0)).
reduceByKey(lambda a, b: a + b).collect()
mostPopular = sorted(products, key=lambda x: x[1], reverse=True)[0]

print "Total purchases: %d" % numPurchases
print "Unique users: %d" % uniqueUsers
print "Total revenue: %2.2f" % totalRevenue
print "Most popular product: %s with %d purchases" % (mostPopular[0], mostPopular[1])
```

匿名函数在Python语言中亦称lambda函数，lambda也是语法表达上的关键字。

用Scala编写时，一个将输入x映射为输出y的匿名函数表示为x => y，而在Python中则是lambda x : y。

```bash
➜  python-spark-app git:(master) ✗ pwd
/Users/hp/ghome/hadoop-spark/spark/Spark-Machine-Learning_8519OSCode/Chapter01/python-spark-app
➜  python-spark-app git:(master) ✗ $SPARK_HOME/bin/spark-submit pythonapp.py
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
16/08/26 15:56:02 INFO SparkContext: Running Spark version 1.5.2
...
Total purchases: 5
Unique users: 4
Total revenue: 39.91
Most popular product: iPhone Cover with 2 purchases
16/08/26 15:56:07 INFO SparkUI: Stopped Spark web UI at http://192.168.143.84:4040
...
```

> Spark的Python API几乎覆盖了所有Scala API所能提供的功能. 但的确有些特性，比如Spark Streaming和个别的API方法，暂不支持。
[具体参见《Spark编程指南》的Python部分](http://spark.apache.org/docs/latest/programming-guide.html)

## 7. 小结

体会了 函数式 编程的威力， scala、python 都可以。java 不适合写 spark 程序
