---
title: SparkSQL 底层实现原理
date: 2018-10-17 15:28:21
categories: [spark]
tags: [sparkSQL]
---

<img src="/images/spark/SparkSql-logo-2.png" width="500" alt="" />


<!-- more -->

# 1.sparksql概述

## 1.1 sparksql的前世今生

- ==Shark是专门针对于spark的构建大规模数据仓库系统的一个框架==
- Shark与Hive兼容、同时也依赖于Spark版本
- Hivesql底层把sql解析成了mapreduce程序，Shark是把sql语句解析成了Spark任务
- 随着性能优化的上限，以及集成SQL的一些复杂的分析功能，发现Hive的MapReduce思想限制了Shark的发展。
- 最后Databricks公司终止对Shark的开发
  - 决定单独开发一个框架，不在依赖hive，把重点转移到了==sparksql==这个框架上。



## 1.2 什么是sparksql 

![1569468946521](/images/kaikeba/sparkSQL-1/1569468946521.png)

- **Spark SQL** is Apache Spark's module for working with structured data.
- SparkSQL是apache Spark用来处理结构化数据的一个模块



# 2. sparksql的四大特性

- ==1、易整合==

  ![1569469087993](/images/kaikeba/sparkSQL-1/1569469087993.png)



- 将SQL查询与Spark程序无缝混合
- 可以使用不同的语言进行代码开发
  - java
  - scala
  - python
  - R



- ==2、统一的数据源访问==

  ![1569469225309](/images/kaikeba/sparkSQL-1/1569469225309.png)

  - 以相同的方式连接到任何数据源

    - sparksql后期可以采用一种统一的方式去对接任意的外部数据源

    ~~~scala
    val  dataFrame = sparkSession.read.文件格式的方法名("该文件格式的路径")
    ~~~




- ==3、兼容hive==

  ![1569469413038](/images/kaikeba/sparkSQL-2.assets/1569469413038.png)

  - sparksql可以支持hivesql这种语法  sparksql兼容hivesql



- ==4、支持标准的数据库连接==

  ![1569469446641](/images/kaikeba/sparkSQL-2.assets/1569469446641.png)

  - sparksql支持标准的数据库连接JDBC或者ODBC



spark-core----->去操作RDD---->封装了数据

spark-sql------>编程抽象DataFrame

# 3. DataFrame概述

## 3.1 DataFrame发展

- DataFrame前身是schemaRDD,这个schemaRDD是直接继承自RDD，它是RDD的一个实现类
- 在spark1.3.0之后把schemaRDD改名为DataFrame,它不在继承自RDD，而是自己实现RDD上的一些功能
- 也可以把dataFrame转换成一个rdd，调用rdd这个方法
  - 例如 val rdd1=dataFrame.rdd

## 3.2 DataFrame是什么

- 在Spark中，DataFrame是一种==以RDD为基础的分布式数据集==，类似于==传统数据库的二维表格==
- DataFrame带有==Schema元信息==，即DataFrame所表示的二维表数据集的每一列都带有名称和类型，但底层做了更多的优化
- DataFrame可以从很多数据源构建
  - 比如：已经存在的RDD、结构化文件、外部数据库、Hive表。
- RDD可以把它内部元素看成是一个java对象
- DataFrame可以把内部是一个Row对象，它表示一行一行的数据



![1569492382924](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1569492382924.png)

* 可以把DataFrame这样去理解
  * RDD+schema元信息
* dataFrame相比于rdd来说，多了对数据的描述信息（schema元信息）



## 3.3 DataFrame和RDD的优缺点

- ==1、RDD==

  - ==优点==

    - 1、编译时类型安全
      - 开发会进行类型检查，在编译的时候及时发现错误
    - 2、具有面向对象编程的风格

  - ==缺点==

    - 1、构建大量的java对象占用了大量heap堆空间，导致频繁的GC

      ```
      由于数据集RDD它的数据量比较大，后期都需要存储在heap堆中，这里有heap堆中的内存空间有限，出现频繁的垃圾回收（GC），程序在进行垃圾回收的过程中，所有的任务都是暂停。影响程序执行的效率
      ```

    - 2、数据的序列化和反序列性能开销很大

      ```
        在分布式程序中，对象(对象的内容和结构)是先进行序列化，发送到其他服务器，进行大量的网络传输，然后接受到这些序列化的数据之后，再进行反序列化来恢复该对象
      ```



- ==2、DataFrame==
  - ==DataFrame引入了schema元信息和off-heap(堆外)==
  - ==优点==
    - 1、DataFrame引入off-heap，大量的对象构建直接使用操作系统层面上的内存，不在使用heap堆中的内存，这样一来heap堆中的内存空间就比较充足，不会导致频繁GC，程序的运行效率比较高，它是解决了RDD构建大量的java对象占用了大量heap堆空间，导致频繁的GC这个缺点。
    - 2、DataFrame引入了schema元信息---就是数据结构的描述信息，后期spark程序中的大量对象在进行网络传输的时候，只需要把数据的内容本身进行序列化就可以，数据结构信息可以省略掉。这样一来数据网络传输的数据量是有所减少，数据的序列化和反序列性能开销就不是很大了。它是解决了RDD数据的序列化和反序列性能开销很大这个缺点
    - ==缺点==
      - DataFrame引入了schema元信息和off-heap(堆外)它是分别解决了RDD的缺点，同时它也丢失了RDD的优点
        - 1、编译时类型不安全
          - 编译时不会进行类型的检查，这里也就意味着前期是无法在编译的时候发现错误，只有在运行的时候才会发现
        - 2、不在具有面向对象编程的风格



# 4. 读取文件构建DataFrame

## 4.1 读取文本文件创建DataFrame

- 第一种方式
- 将数据person.txt上传到node01的/kkb/install/sparkdatas本地路径下

```scala
node01执行以下命令进入spark-shell

cd /kkb/install/spark-2.3.3-bin-hadoop2.7/
bin/spark-shell  --master local[2] --jars /kkb/install/hadoop-2.6.0-cdh5.14.2/share/hadoop/common/hadoop-lzo-0.4.20.jar


val personDF=spark.read.text("file:///kkb/install/sparkdatas/person.txt")
//org.apache.spark.sql.DataFrame = [value: string]

//打印schema信息
personDF.printSchema

//展示数据
personDF.show
```

- 第二种方式

```scala
//加载数据
val rdd1=sc.textFile("file:///kkb/install/sparkdatas/person.txt").map(x=>x.split(" "))
//定义一个样例类
case class Person(id:String,name:String,age:Int)
//把rdd与样例类进行关联
val personRDD=rdd1.map(x=>Person(x(0),x(1),x(2).toInt))
//把rdd转换成DataFrame
val personDF=personRDD.toDF

//打印schema信息
personDF.printSchema
//展示数据
personDF.show
```



## 4.2 读取json文件创建DataFrame

```scala
val peopleDF=spark.read.json("file:///kkb/install/spark-2.3.3-bin-hadoop2.7/examples/src/main/resources/people.json")
//打印schema信息
peopleDF.printSchema

//展示数据
peopleDF.show
```



## 4.3 读取parquet文件创建DataFrame

```scala
val usersDF=spark.read.parquet("file:////kkb/install/spark-2.3.3-bin-hadoop2.7/examples/src/main/resources/users.parquet")
//打印schema信息
usersDF.printSchema

//展示数据
usersDF.show
```

# 5. DataFrame常用操作

## 5.1 DSL风格语法

创建maven工程，导入jar包

```xml
 <repositories>
        <repository>
            <id>cloudera</id>
            <url>https://repository.cloudera.com/artifactory/cloudera-repos</url>
        </repository>
    </repositories>

    <dependencies>
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-core_2.11</artifactId>
            <version>2.3.3</version>
            <exclusions>
                <exclusion>
                    <groupId>org.apache.avro</groupId>
                    <artifactId>avro-mapred</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>5.1.38</version>
        </dependency>
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.7</version>
        </dependency>

        <dependency>
            <groupId>org.apache.hadoop</groupId>
            <artifactId>hadoop-core</artifactId>
            <version>2.6.0-mr1-cdh5.14.2</version>
            <exclusions>
                <exclusion>
                    <groupId>org.apache.zookeeper</groupId>
                    <artifactId>zookeeper</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
        <dependency>
            <groupId>org.apache.hbase</groupId>
            <artifactId>hbase-server</artifactId>
            <version>1.2.0-cdh5.14.2</version>
        </dependency>
        <dependency>
            <groupId>org.apache.hbase</groupId>
            <artifactId>hbase-common</artifactId>
            <version>1.2.0-cdh5.14.2</version>
        </dependency>
        <dependency>
            <groupId>org.apache.hbase</groupId>
            <artifactId>hbase-client</artifactId>
            <version>1.2.0-cdh5.14.2</version>
        </dependency>
        <dependency>
            <groupId>org.apache.hbase</groupId>
            <artifactId>hbase-spark</artifactId>
            <version>1.2.0-cdh5.14.2</version>
        </dependency>
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-streaming_2.11</artifactId>
            <version>2.3.3</version>
        </dependency>
        <dependency>
            <groupId>org.apache.spark</groupId>
            <artifactId>spark-sql_2.11</artifactId>
            <version>2.3.3</version>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>net.alchim31.maven</groupId>
                <artifactId>scala-maven-plugin</artifactId>
                <version>3.2.2</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>compile</goal>
                            <goal>testCompile</goal>
                        </goals>
                        <configuration>
                            <args>
                                <arg>-dependencyfile</arg>
                                <arg>${project.build.directory}/.scala_dependencies</arg>
                            </args>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>2.4.3</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <filters>
                                <filter>
                                    <artifact>*:*</artifact>
                                    <excludes>
                                        <exclude>META-INF/*.SF</exclude>
                                        <exclude>META-INF/*.DSA</exclude>
                                        <exclude>META-INF/*.RSA</exclude>
                                    </excludes>
                                </filter>
                            </filters>
                            <transformers>
                                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass></mainClass>
                                </transformer>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>

```





- 就是sparksql中的DataFrame自身提供了一套自己的Api，可以去使用这套api来做相应的处理

```scala
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.sql.SparkSession

//定义一个样例类
case class Person(id:String,name:String,age:Int)


object SparkDSL {
  def main(args: Array[String]): Unit = {
    val sparkConf: SparkConf = new SparkConf().setMaster("local[2]").setAppName("sparkDSL")
    val sparkSession: SparkSession = SparkSession.builder().config(sparkConf).getOrCreate()
    val sc: SparkContext = sparkSession.sparkContext
    sc.setLogLevel("WARN")
    //加载数据
    val rdd1=sc.textFile("file:///D:\\开课吧课程资料\\15、scala与spark课程资料\\2、spark课程\\spark_day05\\数据/person.txt").map(x=>x.split(" "))

    //把rdd与样例类进行关联
    val personRDD=rdd1.map(x=>Person(x(0),x(1),x(2).toInt))
    //把rdd转换成DataFrame

    import sparkSession.implicits._  // 隐式转换
    val personDF=personRDD.toDF
    //打印schema信息
    personDF.printSchema
    //展示数据
    personDF.show

    //查询指定的字段
    personDF.select("name").show
    personDF.select($"name").show
      //实现age+1
    personDF.select($"name",$"age",$"age"+1).show()

    //实现age大于30过滤
    personDF.filter($"age" > 30).show

    //按照age分组统计次数
    personDF.groupBy("age").count.show

    //按照age分组统计次数降序
    personDF.groupBy("age").count().sort($"count".desc).show
    sparkSession.stop()
    sc.stop()


  }
} 
```



## 5.2 SQL风格语法

- 可以把DataFrame注册成一张表，然后通过==sparkSession.sql(sql语句)==操作

```scala
//DataFrame注册成表
personDF.createTempView("person")

//使用SparkSession调用sql方法统计查询
spark.sql("select * from person").show
spark.sql("select name from person").show
spark.sql("select name,age from person").show
spark.sql("select * from person where age >30").show
spark.sql("select count(*) from person where age >30").show
spark.sql("select age,count(*) from person group by age").show
spark.sql("select age,count(*) as count from person group by age").show
spark.sql("select * from person order by age desc").show
```



# 6. DataSet概述

## 6.1 DataSet是什么

- DataSet是分布式的数据集合，Dataset提供了==强类型支持==，也是在RDD的每行数据加了类型约束。
- DataSet是在Spark1.6中添加的新的接口。它集中了RDD的优点（强类型和可以用强大lambda函数）以及使用了Spark SQL优化的执行引擎。

## 6.2 DataFrame、DataSet区别

- 假设RDD中的两行数据长这样

![1569492571159](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1569492571159.png)



- 那么DataFrame中的数据长这样

![1569492595941](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1569492595941.png)



- Dataset中的数据长这样

  ![1569492618490](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1569492618490.png)

  - 或者长这样（每行数据是个Object）

  ​	![1569492637053](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1569492637053.png)



```
DataSet包含了DataFrame的功能，Spark2.0中两者统一，DataFrame表示为DataSet[Row]，即DataSet的子集。
（1）DataSet可以在编译时检查类型
（2）并且是面向对象的编程接口
```

## 6.3 DataFrame与DataSet互转

- 1、把一个DataFrame转换成DataSet
  - val dataSet=dataFrame.as[强类型]



- 2、把一个DataSet转换成DataFrame
  - val dataFrame=dataSet.toDF



- **补充说明**
  - 可以从dataFrame和dataSet获取得到rdd
    - val rdd1=dataFrame.rdd
    - val rdd2=dataSet.rdd



## 6.4 构建DataSet

- 1、 通过sparkSession调用createDataset方法

  ```scala
  val ds=spark.createDataset(1 to 10) //scala集合
  val ds=spark.createDataset(sc.textFile("/person.txt"))  //rdd
  ```

- 2、使用scala集合和rdd调用toDS方法

  ```scala
  sc.textFile("/person.txt").toDS
  List(1,2,3,4,5).toDS
  ```

- 3、把一个DataFrame转换成DataSet

  ```
  val dataSet=dataFrame.as[强类型]
  ```

- 4、通过一个DataSet转换生成一个新的DataSet

  ```scala
   List(1,2,3,4,5).toDS.map(x=>x*10)
  ```



## 6.5 RDD以及DataFrame以及DataSet的关系

![sparkSQL](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/sparkSQL.png)



首先，Spark RDD、DataFrame和DataSet是Spark的三类API，下图是他们的发展过程：

DataFrame是spark1.3.0版本提出来的，spark1.6.0版本又引入了DateSet的，但是在spark2.0版本中，DataFrame和DataSet合并为DataSet。

那么你可能会问了：那么，在2.0以后的版本里，RDD是不是不需要了呢？

答案是：NO！首先，DataFrame和DataSet是基于RDD的，而且这三者之间可以通过简单的API调用进行无缝切换。

下面，依次介绍这三类API的特点
一、RDD

RDD的优点：
1.相比于传统的MapReduce框架，Spark在RDD中内置很多函数操作，group，map，filter等，方便处理结构化或非结构化数据。
2.面向对象编程，直接存储的java对象，类型转化也安全

RDD的缺点：
1.由于它基本和hadoop一样万能的，因此没有针对特殊场景的优化，比如对于结构化数据处理相对于sql来比非常麻烦
2.默认采用的是java序列号方式，序列化结果比较大，而且数据存储在java堆内存中，导致gc比较频繁

二、DataFrame
*DataFrame**的优点**：*
1.结构化数据处理非常方便，支持Avro, CSV, elastic search, and Cassandra等kv数据，也支持HIVE tables, MySQL等传统数据表

2.有针对性的优化，如采用Kryo序列化，由于数据结构元信息spark已经保存，序列化时不需要带上元信息，大大的减少了序列化大小，而且数据保存在堆外内存中，减少了gc次数,所以运行更快。

3.hive兼容，支持hql、udf等

DataFrame的缺点：
1.编译时不能类型转化安全检查，运行时才能确定是否有问题
2.对于对象支持不友好，rdd内部数据直接以java对象存储，dataframe内存存储的是row对象而不能是自定义对象

三、DateSet

*DateSet**的优点**：*
1.DateSet整合了RDD和DataFrame的优点，支持结构化和非结构化数据
2.和RDD一样，支持自定义对象存储
3.和DataFrame一样，支持结构化数据的sql查询
4.采用堆外内存存储，gc友好

5.类型转化安全，代码友好



# 7. 	通过IDEA开发程序实现把RDD转换DataFrame

## 7.1 利用反射机制

- 定义一个样例类，后期直接映射成DataFrame的schema信息

  - 应用场景

    ~~~
    在开发代码之前，是可以先确定好DataFrame的schema元信息
    
    case class Person(id:String,name:String,age:Int)
    ~~~

- 代码开发

```scala
import org.apache.spark.SparkContext
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.{Column, DataFrame, Row, SparkSession}

//todo:利用反射机制实现把rdd转成dataFrame
case class Person(id:String,name:String,age:Int)

object CaseClassSchema {
  def main(args: Array[String]): Unit = {

    //1、构建SparkSession对象
    val spark: SparkSession = SparkSession.builder().appName("CaseClassSchema").master("local[2]").getOrCreate()

    //2、获取sparkContext对象
    val sc: SparkContext = spark.sparkContext
    sc.setLogLevel("warn")

    //3、读取文件数据
    val data: RDD[Array[String]] = sc.textFile("file:///D:\\开课吧课程资料\\15、scala与spark课程资料\\2、spark课程\\spark_day05\\数据").map(x=>x.split(" "))

    //4、定义一个样例类

    //5、将rdd与样例类进行关联
    val personRDD: RDD[Person] = data.map(x=>Person(x(0),x(1),x(2).toInt))

    //6、将rdd转换成dataFrame
    //需要手动导入隐式转换
    import spark.implicits._
    val personDF: DataFrame = personRDD.toDF

    //7、对dataFrame进行相应的语法操作
    //todo：----------------- DSL风格语法-----------------start
    //打印schema
    personDF.printSchema()
    //展示数据
    personDF.show()

    //获取第一行数据
    val first: Row = personDF.first()
    println("first:"+first)

    //取出前3位数据
    val top3: Array[Row] = personDF.head(3)
    top3.foreach(println)

    //获取name字段
    personDF.select("name").show()
    personDF.select($"name").show()
    personDF.select(new Column("name")).show()
    personDF.select("name","age").show()

    //实现age +1
    personDF.select($"name",$"age",$"age"+1).show()

    //按照age过滤
    personDF.filter($"age" >30).show()
    val count: Long = personDF.filter($"age" >30).count()
    println("count:"+count)

    //分组
    personDF.groupBy("age").count().show()

    personDF.show()
    personDF.foreach(row => println(row))

    //使用foreach获取每一个row对象中的name字段
    personDF.foreach(row =>println(row.getAs[String]("name")))
    personDF.foreach(row =>println(row.get(1)))
    personDF.foreach(row =>println(row.getString(1)))
    personDF.foreach(row =>println(row.getAs[String](1)))
    //todo：----------------- DSL风格语法--------------------end


    //todo：----------------- SQL风格语法-----------------start
    personDF.createTempView("person")
    //使用SparkSession调用sql方法统计查询
    spark.sql("select * from person").show
    spark.sql("select name from person").show
    spark.sql("select name,age from person").show
    spark.sql("select * from person where age >30").show
    spark.sql("select count(*) from person where age >30").show
    spark.sql("select age,count(*) from person group by age").show
    spark.sql("select age,count(*) as count from person group by age").show
    spark.sql("select * from person order by age desc").show
    //todo：----------------- SQL风格语法----------------------end

    //关闭sparkSession对象
    spark.stop()
  }
}
```



## 7.2 通过StructType动态指定Schema

* 应用场景

  ~~~
  在开发代码之前，是无法确定需要的DataFrame对应的schema元信息。需要在开发代码的过程中动态指定。
  ~~~

- 代码开发

```scala
import org.apache.spark.SparkContext
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.types.{IntegerType, StringType, StructField, StructType}
import org.apache.spark.sql.{DataFrame, Row, SparkSession}

//todo；通过动态指定dataFrame对应的schema信息将rdd转换成dataFrame
object StructTypeSchema {

  def main(args: Array[String]): Unit = {
    //1、构建SparkSession对象
    val spark: SparkSession = SparkSession.builder().appName("StructTypeSchema").master("local[2]").getOrCreate()

    //2、获取sparkContext对象
    val sc: SparkContext = spark.sparkContext
    sc.setLogLevel("warn")

    //3、读取文件数据
    val data: RDD[Array[String]] = sc.textFile("file:///D:\\开课吧课程资料\\15、scala与spark课程资料\\2、spark课程\\spark_day05\\数据").map(x=>x.split(" "))

    //4、将rdd与Row对象进行关联
    val rowRDD: RDD[Row] = data.map(x=>Row(x(0),x(1),x(2).toInt))

    //5、指定dataFrame的schema信息
    //这里指定的字段个数和类型必须要跟Row对象保持一致
    val schema=StructType(
      StructField("id",StringType)::
        StructField("name",StringType)::
        StructField("age",IntegerType)::Nil
    )

    val dataFrame: DataFrame = spark.createDataFrame(rowRDD,schema)
    dataFrame.printSchema()
    dataFrame.show()

    dataFrame.createTempView("user")
    spark.sql("select * from user").show()
    spark.stop()
  }
}
```



# 8、sparkSQL读取sql数据

spark sql可以通过 JDBC 从关系型数据库中读取数据的方式创建DataFrame，通过对DataFrame一系列的计算后，还可以将数据再写回关系型数据库中

- 添加mysql连接驱动jar包

```xml
<dependency>
	<groupId>mysql</groupId>
	<artifactId>mysql-connector-java</artifactId>
	<version>5.1.38</version>
</dependency>
```

- 代码开发

```scala
import java.util.Properties
import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, SparkSession}

//todo:利用sparksql加载mysql表中的数据
object DataFromMysql {

  def main(args: Array[String]): Unit = {
    //1、创建SparkConf对象
    val sparkConf: SparkConf = new SparkConf().setAppName("DataFromMysql").setMaster("local[2]")

    //2、创建SparkSession对象
    val spark: SparkSession = SparkSession.builder().config(sparkConf).getOrCreate()

    //3、读取mysql表的数据
    //3.1 指定mysql连接地址
    val url="jdbc:mysql://localhost:3306/mydb?characterEncoding=UTF-8"
    //3.2 指定要加载的表名
    val tableName="jobdetail"
    // 3.3 配置连接数据库的相关属性
    val properties = new Properties()

    //用户名
    properties.setProperty("user","root")
    //密码
    properties.setProperty("password","123456")

    val mysqlDF: DataFrame = spark.read.jdbc(url,tableName,properties)

    //打印schema信息
    mysqlDF.printSchema()

    //展示数据
    mysqlDF.show()

    //把dataFrame注册成表
    mysqlDF.createTempView("job_detail")

    spark.sql("select * from job_detail where city = '广东' ").show()

    spark.stop()
  }
}
```



# 9、sparkSQL操作CSV文件并将结果写入mysql

使用spark程序读取CSV文件，然后将读取到的数据内容，保存到mysql里面去，注意csv文件的换行问题。

```scala
import java.util.Properties
import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}

object CSVOperate {

  def main(args: Array[String]): Unit = {
    val sparkConf: SparkConf = new SparkConf().setMaster("local[8]").setAppName("sparkCSV")

    val session: SparkSession = SparkSession.builder().config(sparkConf).getOrCreate()
    session.sparkContext.setLogLevel("WARN")
    val frame: DataFrame = session
      .read
      .format("csv")
      .option("timestampFormat", "yyyy/MM/dd HH:mm:ss ZZ")
      .option("header", "true")
      .option("multiLine", true)
      .load("file:///D:\\开课吧课程资料\\15、scala与spark课程资料\\2、spark课程\\spark_day05\\数据\\招聘数据")

    frame.createOrReplaceTempView("job_detail")
    //session.sql("select job_name,job_url,job_location,job_salary,job_company,job_experience,job_class,job_given,job_detail,company_type,company_person,search_key,city from job_detail where job_company = '北京无极慧通科技有限公司'  ").show(80)
    val prop = new Properties()
    prop.put("user", "root")
    prop.put("password", "123456")

    frame.write.mode(SaveMode.Append).jdbc("jdbc:mysql://localhost:3306/mydb?useSSL=false&useUnicode=true&characterEncoding=UTF-8", "mydb.jobdetail_copy", prop)

  }
}
```



# 10、spark  on  hive  与hive on   spark

**Spark on hive 与 Hive on Spark 的区别**

- Spark on hive

Spark通过Spark-SQL使用hive 语句,操作hive,底层运行的还是 spark rdd。

（1）就是通过sparksql，加载hive的配置文件，获取到hive的元数据信息

（2）spark sql获取到hive的元数据信息之后就可以拿到hive的所有表的数据

（3）接下来就可以通过spark sql来操作hive表中的数据

- Hive on Spark

是把hive查询从mapreduce 的mr (Hadoop计算引擎)操作替换为spark rdd（spark 执行引擎） 操作. 相对于spark on hive,这个要实现起来则麻烦很多, 必须重新编译你的spark和导入jar包，不过目前大部分使用的是spark on hive。

 [spark与hive.pptx](/images/kaikeba/sparkSQL-1\spark与hive.pptx) 

## 1、spark_sql与hive进行整合

### 第一步：拷贝hive-site.xml配置文件

将node03服务器安装的hive家目录下的conf文件夹下面的hive-site.xml拷贝到spark安装的各个机器节点，node03执行以下命令进行拷贝

```shell
cd /kkb/install/hive-1.1.0-cdh5.14.2/conf
scp hive-site.xml  node01:/kkb/install/spark-2.3.3-bin-hadoop2.7/conf/
scp hive-site.xml  node02:/kkb/install/spark-2.3.3-bin-hadoop2.7/conf/
scp hive-site.xml  node03:/kkb/install/spark-2.3.3-bin-hadoop2.7/conf/
```

### 第二步：拷贝mysql连接驱动包

将hive当中mysql的连接驱动包拷贝到spark安装家目录下的lib目录下，node03执行下命令拷贝mysql的lib驱动包

```shell
cd /kkb/install/hive-1.1.0-cdh5.14.2/lib/
scp mysql-connector-java-5.1.38.jar  node01:/kkb/install/spark-2.3.3-bin-hadoop2.7/jars/
scp mysql-connector-java-5.1.38.jar  node02:/kkb/install/spark-2.3.3-bin-hadoop2.7/jars/
scp mysql-connector-java-5.1.38.jar  node03:/kkb/install/spark-2.3.3-bin-hadoop2.7/jars/
```



### 第三步：进入spark-sql直接操作hive数据库当中的数据

在spark2.0版本后由于出现了sparkSession，在初始化sqlContext的时候，会设置默认的==spark.sql.warehouse.dir=spark-warehouse==,

此时将hive与sparksql整合完成之后，在通过spark-sql脚本启动的时候，还是会在哪里启动spark-sql脚本，就会在当前目录下创建一个spark.sql.warehouse.dir为spark-warehouse的目录，存放由spark-sql创建数据库和创建表的数据信息，与之前hive的数据息不是放在同一个路径下（可以互相访问）。但是此时spark-sql中表的数据在本地，不利于操作，也不安全。

 

所有在启动的时候需要加上这样一个参数：

--conf  spark.sql.warehouse.dir=hdfs://node01:8020/user/hive/warehouse

保证spark-sql启动时不在产生新的存放数据的目录，sparksql与hive最终使用的是hive同一存放数据的目录。

node01直接执行以下命令，进入spark-sql交互界面，然后操作hive当中的数据，

```shell
cd /kkb/install/spark-2.3.3-bin-hadoop2.7/

bin/spark-sql  --master local[2] \
--executor-memory 512m --total-executor-cores 3 \
--conf  spark.sql.warehouse.dir=hdfs://node01:8020/user/hive/warehouse \
--jars /kkb/install/hadoop-2.6.0-cdh5.14.2/share/hadoop/common/hadoop-lzo-0.4.20.jar
```



使用sparkSQL有hive进行整合之后，就可以通过sparkSQL语句来操作hive表数据了

- 应用场景

```shell
#!/bin/sh
#定义sparksql提交脚本的头信息
SUBMITINFO="spark-sql --master spark://node01:7077 --executor-memory 1g --total-executor-cores 4 --conf spark.sql.warehouse.dir=hdfs://node01:8020/user/hive/warehouse" 
#定义一个sql语句
SQL="select * from default.hive_source;" 
#执行sql语句   类似于 hive -e sql语句
echo "$SUBMITINFO" 
echo "$SQL"
$SUBMITINFO -e "$SQL"
```



## 2、启用spark的thrift  server与hive进行远程交互

除了可以通过spark-shell来与hive进行整合之外，我们也可以通过spark的thrift服务来远程与hive进行交互

### 第一步：修改hive-site.xml的配置

node03执行以下命令修改hive-site.xml的配置属性，添加以下几个配置

```xml
cd /kkb/install/hive-1.1.0-cdh5.14.2/conf
vim hive-site.xml


<property>
   <name>hive.metastore.uris</name>
   <value>thrift://node03:9083</value>
   <description>Thrift URI for the remote metastore</description>
 </property>
 <property>
       <name>hive.server2.thrift.min.worker.threads</name>
       <value>5</value>
  </property>
  <property>
       <name>hive.server2.thrift.max.worker.threads</name>
       <value>500</value>
  </property>
  <property>
       <name>hive.server2.thrift.port</name>
       <value>10000</value>
  </property>
  <property> 
      <name>hive.server2.thrift.bind.host</name>
       <value>node03</value>
  </property>
```

### 第二步：修改完的配置文件分发到其他机器

node03执行以下命令分发hive配置文件

```shell
 cd /kkb/install/hive-1.1.0-cdh5.14.2/conf
 scp hive-site.xml  node01:/kkb/install/spark-2.3.3-bin-hadoop2.7/conf/
 scp hive-site.xml  node02:/kkb/install/spark-2.3.3-bin-hadoop2.7/conf/
 scp hive-site.xml  node03:/kkb/install/spark-2.3.3-bin-hadoop2.7/conf/
```

### 第三步：node03启动metastore服务

node03执行以下命令启动metastore服务

```
cd /kkb/install/hive-1.1.0-cdh5.14.2/
bin/hive --service metastore

```

### 第四步：node03执行以下命令启动spark的thrift  server

==注意：hive安装在哪一台，就在哪一台服务器启动spark的thrift  server==

我的hive安装在node03服务器，所以我在node03服务器上面启动spark的thrift  server服务

node03执行以下命令启动thrift  server服务

```shell
cd /kkb/install/spark-2.3.3-bin-hadoop2.7

sbin/start-thriftserver.sh --master local[2]  --executor-memory 5g --total-executor-cores 5 --jars /kkb/install/hadoop-2.6.0-cdh5.14.2/share/hadoop/common/hadoop-lzo-0.4.20.jar 

```



### 第五步：直接使用beeline来连接

直接在node03服务器上面使用beeline来进行连接spark-sql

```
cd /kkb/install/spark-2.3.3-bin-hadoop2.7
bin/beeline 

beeline> !connect jdbc:hive2://node03:10000
Connecting to jdbc:hive2://node03:10000
Enter username for jdbc:hive2://node03:10000: hadoop
Enter password for jdbc:hive2://node03:10000: ******

```

# 11、sparkSQL自定义函数

用户自定义函数类别分为以下三种：

1).UDF：输入一行，返回一个结果(一对一)，在上篇案例 使用SparkSQL实现根据ip地址计算归属地二 中实现的自定义函数就是UDF，输入一个十进制的ip地址，返回一个省份

2).UDTF：输入一行，返回多行(一对多)，在SparkSQL中没有，因为Spark中使用flatMap即可实现这个功能

3).UDAF：输入多行，返回一行，这里的A是aggregate，聚合的意思，如果业务复杂，需要自己实现聚合函数

## 1、自定义UDF函数

读取深圳二手房成交数据，对房子的年份进行自定义函数处理，如果没有年份，那么就给默认值1990

```scala
import java.util.regex.{Matcher, Pattern}
import org.apache.spark.SparkConf
import org.apache.spark.sql.api.java.UDF1
import org.apache.spark.sql.types.DataTypes
import org.apache.spark.sql.{DataFrame, SparkSession}

object SparkUDF {

  def main(args: Array[String]): Unit = {
    val sparkConf: SparkConf = new SparkConf().setMaster("local[8]").setAppName("sparkCSV")

    val session: SparkSession = SparkSession.builder().config(sparkConf).getOrCreate()
    session.sparkContext.setLogLevel("WARN")
    val frame: DataFrame = session
      .read
      .format("csv")
      .option("timestampFormat", "yyyy/MM/dd HH:mm:ss ZZ")
      .option("header", "true")
      .option("multiLine", true)
      .load("file:///D:\\开课吧课程资料\\15、scala与spark课程资料\\2、spark课程\\spark_day05\\数据\\深圳链家二手房成交明细")

    frame.createOrReplaceTempView("house_sale")


    session.udf.register("house_udf",new UDF1[String,String] {

      val pattern: Pattern = Pattern.compile("^[0-9]*$")
      override def call(input: String): String = {
        val matcher: Matcher = pattern.matcher(input)
        if(matcher.matches()){
          input
        }else{
          "1990"
        }
      }
    },DataTypes.StringType)

    session.sql("select house_udf(house_age) from house_sale  limit 200").show()
    session.stop()
  }

}
```

## 2、自定义UDAF函数

需求：自定义UDAF函数，读取深圳二手房数据，然后按照楼层进行分组，求取每个楼层的平均成交金额

```scala
import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, Row, SparkSession}
import org.apache.spark.sql.expressions.{MutableAggregationBuffer, UserDefinedAggregateFunction}
import org.apache.spark.sql.types._

class MyAverage extends UserDefinedAggregateFunction {
  // 聚合函数输入参数的数据类型
  def inputSchema: StructType = StructType(StructField("floor", DoubleType) :: Nil)

  // 聚合缓冲区中值得数据类型
  def bufferSchema: StructType = {
    StructType(StructField("sum", DoubleType) :: StructField("count", LongType) :: Nil)
  }

  // 返回值的数据类型
  def dataType: DataType = DoubleType

  // 对于相同的输入是否一直返回相同的输出。
  def deterministic: Boolean = true

  // 初始化
  def initialize(buffer: MutableAggregationBuffer): Unit = {
    // 用于存储不同类型的楼房的总成交额
    buffer(0) = 0D
    // 用于存储不同类型的楼房的总个数
    buffer(1) = 0L
  }

  // 相同Execute间的数据合并。
  def update(buffer: MutableAggregationBuffer, input: Row): Unit = {
    if (!input.isNullAt(0)) {
      buffer(0) = buffer.getDouble(0) + input.getDouble(0)
      buffer(1) = buffer.getLong(1) + 1
    }
  }

  // 不同Execute间的数据合并
  def merge(buffer1: MutableAggregationBuffer, buffer2: Row): Unit = {
    buffer1(0) = buffer1.getDouble(0) + buffer2.getDouble(0)
    buffer1(1) = buffer1.getLong(1) + buffer2.getLong(1)
  }

  // 计算最终结果
  def evaluate(buffer: Row): Double = buffer.getDouble(0) / buffer.getLong(1)
}


object MyAverage{
  def main(args: Array[String]): Unit = {
    val sparkConf: SparkConf = new SparkConf().setMaster("local[8]").setAppName("sparkCSV")


    val session: SparkSession = SparkSession.builder().config(sparkConf).getOrCreate()
    session.sparkContext.setLogLevel("WARN")
    val frame: DataFrame = session
      .read
      .format("csv")
      .option("timestampFormat", "yyyy/MM/dd HH:mm:ss ZZ")
      .option("header", "true")
      .option("multiLine", true)
      .load("file:///D:\\开课吧课程资料\\15、scala与spark课程资料\\2、spark课程\\spark_day05\\数据\\深圳链家二手房成交明细")
    frame.createOrReplaceTempView("house_sale")
    session.sql("select floor from house_sale limit 30").show()
    session.udf.register("udaf",new MyAverage)
    session.sql("select floor, udaf(house_sale_money) from house_sale group by floor").show()
    frame.printSchema()
    session.stop()
  }
}
```



# 12、sparkSQL架构设计

sparkSQL是spark技术栈当中又一非常出彩的模块，通过引入SQL的支持，大大降低了开发人员和学习人员的使用成本，让我们开发人员直接使用SQL的方式就能够实现大数据的开发，它同时支持DSL以及SQL的语法风格，目前在spark的整个架构设计当中，所有的spark模块，例如SQL，SparkML，sparkGrahpx以及Structed Streaming等都是基于 Catalyst Optimization & Tungsten Execution模块之上运行，如下图所示就显示了spark的整体架构模块设计

![Untitled Diagram](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/Untitled%20Diagram.png)



## 1、sparkSQL的架构设计实现

sparkSQL 执行先会经过 SQL Parser 解析 SQL，然后经过 Catalyst 优化器处理，最后到 Spark 执行。而 Catalyst 的过程又分为很多个过程，其中包括：

- Analysis：主要利用 Catalog 信息将 Unresolved Logical Plan 解析成 Analyzed logical plan；
- Logical Optimizations：利用一些 Rule （规则）将 Analyzed logical plan 解析成 Optimized Logical Plan；
- Physical Planning：前面的 logical plan 不能被 Spark 执行，而这个过程是把 logical plan 转换成多个 physical plans，然后利用代价模型（cost model）选择最佳的 physical plan；
- Code Generation：这个过程会把 SQL 查询生成 Java 字 节码。

 [sparkSQL架构设计.pptx](/images/kaikeba/sparkSQL-1\sparkSQL架构设计.pptx) 

例如执行以下SQL语句：

```sql
select temp1.class,sum(temp1.degree),avg(temp1.degree)  from (SELECT  students.sno AS ssno,students.sname,students.ssex,students.sbirthday,students.class, scores.sno,scores.degree,scores.cno  FROM students LEFT JOIN scores ON students.sno =  scores.sno ) temp1 group by temp1.class
```



代码实现过程如下：

```scala
package com.kkb.sparksql

import java.util.Properties

import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, SparkSession}

//todo:利用sparksql加载mysql表中的数据
object DataFromMysqlPlan {
  def main(args: Array[String]): Unit = {
    //1、创建SparkConf对象
    val sparkConf: SparkConf = new SparkConf().setAppName("DataFromMysql").setMaster("local[2]")

    //sparkConf.set("spark.sql.codegen.wholeStage","true")
    //2、创建SparkSession对象
    val spark: SparkSession = SparkSession.builder().config(sparkConf).getOrCreate()

    spark.sparkContext.setLogLevel("WARN")

    //3、读取mysql表的数据
    //3.1 指定mysql连接地址
    val url="jdbc:mysql://localhost:3306/mydb?characterEncoding=UTF-8"
    //3.2 指定要加载的表名
    val student="students"
    val score="scores"

    // 3.3 配置连接数据库的相关属性
    val properties = new Properties()

    //用户名
    properties.setProperty("user","root")
    //密码
    properties.setProperty("password","123456")

    val studentFrame: DataFrame = spark.read.jdbc(url,student,properties)
    val scoreFrame: DataFrame = spark.read.jdbc(url,score,properties)
    //把dataFrame注册成表
    studentFrame.createTempView("students")
    scoreFrame.createOrReplaceTempView("scores")
    //spark.sql("SELECT temp1.class,SUM(temp1.degree),AVG(temp1.degree) FROM (SELECT  students.sno AS ssno,students.sname,students.ssex,students.sbirthday,students.class, scores.sno,scores.degree,scores.cno  FROM students LEFT JOIN scores ON students.sno =  scores.sno ) temp1  GROUP BY temp1.class; ").show()
    val resultFrame: DataFrame = spark.sql("SELECT temp1.class,SUM(temp1.degree),AVG(temp1.degree)  FROM (SELECT  students.sno AS ssno,students.sname,students.ssex,students.sbirthday,students.class, scores.sno,scores.degree,scores.cno  FROM students LEFT JOIN scores ON students.sno =  scores.sno  WHERE degree > 60 AND sbirthday > '1973-01-01 00:00:00' ) temp1 GROUP BY temp1.class")
    resultFrame.explain(true)
    resultFrame.show()
    spark.stop()
  }
}

```



通过explain方法来查看sql的执行计划，得到以下信息

```sql
== Parsed Logical Plan ==
'Aggregate ['temp1.class], ['temp1.class, unresolvedalias('SUM('temp1.degree), None), unresolvedalias('AVG('temp1.degree), None)]
+- 'SubqueryAlias temp1
   +- 'Project ['students.sno AS ssno#16, 'students.sname, 'students.ssex, 'students.sbirthday, 'students.class, 'scores.sno, 'scores.degree, 'scores.cno]
      +- 'Filter (('degree > 60) && ('sbirthday > 1973-01-01 00:00:00))
         +- 'Join LeftOuter, ('students.sno = 'scores.sno)
            :- 'UnresolvedRelation `students`
            +- 'UnresolvedRelation `scores`

== Analyzed Logical Plan ==
class: string, sum(degree): decimal(20,1), avg(degree): decimal(14,5)
Aggregate [class#4], [class#4, sum(degree#12) AS sum(degree)#27, avg(degree#12) AS avg(degree)#28]
+- SubqueryAlias temp1
   +- Project [sno#0 AS ssno#16, sname#1, ssex#2, sbirthday#3, class#4, sno#10, degree#12, cno#11]
      +- Filter ((cast(degree#12 as decimal(10,1)) > cast(cast(60 as decimal(2,0)) as decimal(10,1))) && (cast(sbirthday#3 as string) > 1973-01-01 00:00:00))
         +- Join LeftOuter, (sno#0 = sno#10)
            :- SubqueryAlias students
            :  +- Relation[sno#0,sname#1,ssex#2,sbirthday#3,class#4] JDBCRelation(students) [numPartitions=1]
            +- SubqueryAlias scores
               +- Relation[sno#10,cno#11,degree#12] JDBCRelation(scores) [numPartitions=1]

== Optimized Logical Plan ==
Aggregate [class#4], [class#4, sum(degree#12) AS sum(degree)#27, cast((avg(UnscaledValue(degree#12)) / 10.0) as decimal(14,5)) AS avg(degree)#28]
+- Project [class#4, degree#12]
   +- Join Inner, (sno#0 = sno#10)
      :- Project [sno#0, class#4]
      :  +- Filter ((isnotnull(sbirthday#3) && (cast(sbirthday#3 as string) > 1973-01-01 00:00:00)) && isnotnull(sno#0))
      :     +- Relation[sno#0,sname#1,ssex#2,sbirthday#3,class#4] JDBCRelation(students) [numPartitions=1]
      +- Project [sno#10, degree#12]
         +- Filter ((isnotnull(degree#12) && (degree#12 > 60.0)) && isnotnull(sno#10))
            +- Relation[sno#10,cno#11,degree#12] JDBCRelation(scores) [numPartitions=1]

== Physical Plan ==
*(6) HashAggregate(keys=[class#4], functions=[sum(degree#12), avg(UnscaledValue(degree#12))], output=[class#4, sum(degree)#27, avg(degree)#28])
+- Exchange hashpartitioning(class#4, 200)
   +- *(5) HashAggregate(keys=[class#4], functions=[partial_sum(degree#12), partial_avg(UnscaledValue(degree#12))], output=[class#4, sum#32, sum#33, count#34L])
      +- *(5) Project [class#4, degree#12]
         +- *(5) SortMergeJoin [sno#0], [sno#10], Inner
            :- *(2) Sort [sno#0 ASC NULLS FIRST], false, 0
            :  +- Exchange hashpartitioning(sno#0, 200)
            :     +- *(1) Project [sno#0, class#4]
            :        +- *(1) Filter (cast(sbirthday#3 as string) > 1973-01-01 00:00:00)
            :           +- *(1) Scan JDBCRelation(students) [numPartitions=1] [sno#0,class#4,sbirthday#3] PushedFilters: [*IsNotNull(sbirthday), *IsNotNull(sno)], ReadSchema: struct<sno:string,class:string,sbirthday:timestamp>
            +- *(4) Sort [sno#10 ASC NULLS FIRST], false, 0
               +- Exchange hashpartitioning(sno#10, 200)
                  +- *(3) Scan JDBCRelation(scores) [numPartitions=1] [sno#10,degree#12] PushedFilters: [*IsNotNull(degree), *GreaterThan(degree,60.0), *IsNotNull(sno)], ReadSchema: struct<sno:string,degree:decimal(10,1)>
```



## 2、 Catalyst执行过程

从上面的查询计划我们可以看得出来，我们编写的sql语句，经过多次转换，最终进行编译成为字节码文件进行执行，这一整个过程经过了好多个步骤，其中包括以下几个重要步骤

- sql解析阶段 parse
- 生成逻辑计划  Analyzer
- sql语句调优阶段  Optimizer
- 生成物理查询计划  planner

### 1、sql解析阶段 Parser

在spark2.x的版本当中，为了解析sparkSQL的sql语句，引入了==Antlr==。Antlr 是一款强大的语法生成器工具，可用于读取、处理、执行和翻译结构化的文本或二进制文件，是当前 Java 语言中使用最为广泛的语法生成器工具，我们常见的大数据 SQL 解析都用到了这个工具，包括 Hive、Cassandra、Phoenix、Pig 以及 presto 等。目前最新版本的 Spark 使用的是==ANTLR4==，通过这个对 SQL 进行词法分析并构建语法树。

我们可以通过github去查看spark的源码，具体路径如下：

https://github.com/apache/spark/blob/master/sql/catalyst/src/main/antlr4/org/apache/spark/sql/catalyst/parser/SqlBase.g4

查看得到sparkSQL支持的SQL语法，所有sparkSQL支持的语法都定义在了这个文件当中。如果我们需要重构sparkSQL的语法，那么我们只需要重新定义好相关语法，然后使用Antlr4对SqlBase.g4进行语法解析，生成相关的java类，其中就包含重要的词法解析器SqlBaseLexer.java和语法解析器SqlBaseParser.java。在我们运行上面的java的时候，第一步就是通过SqlBaseLexer来解析关键词以及各种标识符，然后使用SqlBaseParser来构建语法树。

![Untitled Diagram](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/Untitled%20Diagram-1591500000169.png)

最终通过Lexer以及parse解析之后，生成语法树，生成语法树之后，使用AstBuilder将语法树转换成为LogicalPlan，这个LogicalPlan也被称为Unresolved  LogicalPlan。解析之后的逻辑计划如下，

```
== Parsed Logical Plan ==
'Aggregate ['temp1.class], ['temp1.class, unresolvedalias('SUM('temp1.degree), None), unresolvedalias('AVG('temp1.degree), None)]
+- 'SubqueryAlias temp1
   +- 'Project ['students.sno AS ssno#16, 'students.sname, 'students.ssex, 'students.sbirthday, 'students.class, 'scores.sno, 'scores.degree, 'scores.cno]
      +- 'Filter (('degree > 60) && ('sbirthday > 1973-01-01 00:00:00))
         +- 'Join LeftOuter, ('students.sno = 'scores.sno)
            :- 'UnresolvedRelation `students`
            +- 'UnresolvedRelation `scores`
```

![unresolved Logical Plan](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/unresolved%20Logical%20Plan.png)



从上图可以看得到，两个表被join之后生成了UnresolvedRelation，选择的列以及聚合的字段都有了，sql解析的第一个阶段就已经完成，接着准备进入到第二个阶段

### 2、绑定逻辑计划Analyzer

在sql解析parse阶段，生成了很多的unresolvedalias ， UnresolvedRelation等很多未解析出来的有些关键字，这些都是属于 Unresolved LogicalPlan解析的部分。 Unresolved LogicalPlan仅仅是一种数据结构，不包含任何数据信息，例如不知道数据源，数据类型，不同的列来自哪张表等等。。Analyzer 阶段会使用事先定义好的 Rule 以及 SessionCatalog 等信息对 Unresolved LogicalPlan 进行 transform。SessionCatalog 主要用于各种==函数资源信息和元数据信息==（数据库、数据表、数据视图、数据分区与函数等）的统一管理。而Rule 是定义在 Analyzer 里面的，具体的类的路径如下：

```scala
org.apache.spark.sql.catalyst.analysis.Analyzer

具体的rule规则定义如下：
 lazy val batches: Seq[Batch] = Seq(
    Batch("Hints", fixedPoint,
      new ResolveHints.ResolveBroadcastHints(conf),
      ResolveHints.RemoveAllHints),
    Batch("Simple Sanity Check", Once,
      LookupFunctions),
    Batch("Substitution", fixedPoint,
      CTESubstitution,
      WindowsSubstitution,
      EliminateUnions,
      new SubstituteUnresolvedOrdinals(conf)),
    Batch("Resolution", fixedPoint,
      ResolveTableValuedFunctions ::
      ResolveRelations ::
      ResolveReferences ::
      ResolveCreateNamedStruct ::
      ResolveDeserializer ::
      ResolveNewInstance ::
      ResolveUpCast ::
      ResolveGroupingAnalytics ::
      ResolvePivot ::
      ResolveOrdinalInOrderByAndGroupBy ::
      ResolveAggAliasInGroupBy ::
      ResolveMissingReferences ::
      ExtractGenerator ::
      ResolveGenerate ::
      ResolveFunctions ::
      ResolveAliases ::
      ResolveSubquery ::
      ResolveSubqueryColumnAliases ::
      ResolveWindowOrder ::
      ResolveWindowFrame ::
      ResolveNaturalAndUsingJoin ::
      ExtractWindowExpressions ::
      GlobalAggregates ::
      ResolveAggregateFunctions ::
      TimeWindowing ::
      ResolveInlineTables(conf) ::
      ResolveTimeZone(conf) ::
      ResolvedUuidExpressions ::
      TypeCoercion.typeCoercionRules(conf) ++
      extendedResolutionRules : _*),
    Batch("Post-Hoc Resolution", Once, postHocResolutionRules: _*),
    Batch("View", Once,
      AliasViewChild(conf)),
    Batch("Nondeterministic", Once,
      PullOutNondeterministic),
    Batch("UDF", Once,
      HandleNullInputsForUDF),
    Batch("FixNullability", Once,
      FixNullability),
    Batch("Subquery", Once,
      UpdateOuterReferences),
    Batch("Cleanup", fixedPoint,
      CleanupAliases)
  )
```

从上面代码可以看出，多个性质类似的 Rule 组成一个 Batch，比如上面名为 Hints 的 Batch就是由很多个 Hints Rule 组成；而多个 Batch 构成一个 batches。这些 batches 会由 RuleExecutor 执行，先按一个一个 Batch 顺序执行，然后对 Batch 里面的每个 Rule 顺序执行。每个 Batch 会执行一次（Once）或多次（FixedPoint，由
`spark.sql.optimizer.maxIterations` 参数决定），执行过程如下：

![spark_batch_ruleexecutor-iteblog](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/spark_batch_ruleexecutor-iteblog.jpg)

所以上面的 SQL 经过这个阶段生成的 Analyzed Logical Plan 如下：

```
== Analyzed Logical Plan ==
class: string, sum(degree): decimal(20,1), avg(degree): decimal(14,5)
Aggregate [class#4], [class#4, sum(degree#12) AS sum(degree)#27, avg(degree#12) AS avg(degree)#28]
+- SubqueryAlias temp1
   +- Project [sno#0 AS ssno#16, sname#1, ssex#2, sbirthday#3, class#4, sno#10, degree#12, cno#11]
      +- Filter ((cast(degree#12 as decimal(10,1)) > cast(cast(60 as decimal(2,0)) as decimal(10,1))) && (cast(sbirthday#3 as string) > 1973-01-01 00:00:00))
         +- Join LeftOuter, (sno#0 = sno#10)
            :- SubqueryAlias students
            :  +- Relation[sno#0,sname#1,ssex#2,sbirthday#3,class#4] JDBCRelation(students) [numPartitions=1]
            +- SubqueryAlias scores
               +- Relation[sno#10,cno#11,degree#12] JDBCRelation(scores) [numPartitions=1]
```

从上面的解析过程来看，students和scores表已经被解析成为了带有sno#0 AS ssno#16, sname#1, ssex#2, sbirthday#3, class#4, sno#10, degree#12, cno#11这么具体的字段，其中还有聚合函数

Aggregate [class#4], [class#4, sum(degree#12) AS sum(degree)#27, avg(degree#12) AS avg(degree)#28]，并且最终返回的四个字段的类型也已经确定了class: string, sum(degree): decimal(20,1), avg(degree): decimal(14,5)，而且也已经知道了数据来源是JDBCRelation(students)表和 JDBCRelation(scores)表。总结来看Analyzed Logical Plan主要就是干了一些这些事情

1、确定最终返回字段名称以及返回类型：

- ​	class: string, sum(degree): decimal(20,1), avg(degree): decimal(14,5)

2、确定聚合函数

- Aggregate [class#4], [class#4, sum(degree#12) AS sum(degree)#27, avg(degree#12) AS avg(degree)#28]

3、确定表当中获取的查询字段

- ​	Project [sno#0 AS ssno#16, sname#1, ssex#2, sbirthday#3, class#4, sno#10, degree#12, cno#11]

4、确定过滤条件

Filter ((cast(degree#12 as decimal(10,1)) > cast(cast(60 as decimal(2,0)) as decimal(10,1))) && (cast(sbirthday#3 as string) > 1973-01-01 00:00:00))

5、确定join方式

Join LeftOuter, (sno#0 = sno#10)

6、确定表当中的数据来源以及分区个数

- JDBCRelation(students) [numPartitions=1]

- JDBCRelation(scores) [numPartitions=1]

至此Analyzed Logical  Plan已经完成。对比Unresolved   Logical Plan到Analyzed Logical Plan 过程如下图

![unresolved Logical Plan](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/unresolved%20Logical%20Plan-1594954815185.png)



![Analyzer Logical Plan](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/Analyzer%20Logical%20Plan.png)





到这里， Analyzed LogicalPlan 就完全生成了

### 3、逻辑优化阶段Optimizer

在前文的绑定逻辑计划阶段对 Unresolved LogicalPlan 进行相关 transform 操作得到了 Analyzed Logical Plan，这个 Analyzed Logical Plan 是可以直接转换成 Physical Plan 然后在 [Spark] 中执行。但是如果直接这么弄的话，得到的 Physical Plan 很可能不是最优的，因为在实际应用中，很多低效的写法会带来执行效率的问题，需要进一步对Analyzed Logical Plan 进行处理，得到更优的逻辑算子树。于是， 针对 SQL 逻辑算子树的优化器 Optimizer 应运而生。

这个阶段的优化器主要是基于规则的（Rule-based Optimizer，简称 ==RBO==），而绝大部分的规则都是启发式规则，也就是基于直观或经验而得出的规则，比如==列裁剪==（过滤掉查询不需要使用到的列）、==谓词下推==（将过滤尽可能地下沉到数据源端）、常量累加（比如 1 + 2 这种事先计算好） 以及常量替换（比如 SELECT * FROM table WHERE i = 5 AND j = i + 3 可以转换成 SELECT * FROM table WHERE i = 5 AND j = 8）等等。

与前文介绍绑定逻辑计划阶段类似，这个阶段所有的规则也是实现 Rule 抽象类，多个规则组成一个 Batch，多个 Batch 组成一个 batches，同样也是在 RuleExecutor 中进行执行

这里按照 Rule 执行顺序一一进行说明。

#### 谓词下推

谓词下推在 SparkQL 是由 `PushDownPredicate` 实现的，这个过程主要将过滤条件尽可能地下推到底层，最好是数据源。所以针对我们上面介绍的 SQL，使用谓词下推优化得到的逻辑计划如下：



![Analyzer Logical Plan](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/Analyzer%20Logical%20Plan-1591504429944.png)



![谓词下推](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/%E8%B0%93%E8%AF%8D%E4%B8%8B%E6%8E%A8-1591504632746.png)





从上图可以看出，谓词下推将 Filter 算子直接下推到 Join 之前了（注意，上图是从下往上看的）

。也就是在扫描 student表的时候使用条件过滤条件过滤出满足条件的数据；同时在扫描 t2 表的时候会先使用 isnotnull(id#8) && (id#8 > 50000) 过滤条件过滤出满足条件的数据。经过这样的操作，可以大大减少 Join 算子处理的数据量，从而加快计算速度。



#### 列裁剪

列裁剪在 Spark SQL 是由 `ColumnPruning` 实现的。因为我们查询的表可能有很多个字段，但是每次查询我们很大可能不需要扫描出所有的字段，这个时候利用列裁剪可以把那些查询不需要的字段过滤掉，使得扫描的数据量减少。所以针对我们上面介绍的 SQL，使用列裁剪优化得到的逻辑计划如下：

![谓词下推](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/%E8%B0%93%E8%AF%8D%E4%B8%8B%E6%8E%A8-1591504632746-1594954838864.png)



![optimized](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/optimized.png)



从上图可以看出，经过列裁剪后，students 表只需要查询 sno和 class 两个字段；scores 表只需要查询 sno,degree 字段。这样减少了数据的传输，而且如果底层的文件格式为列存（比如 Parquet），可以大大提高数据的扫描速度的。

#### 常量替换

常量替换在 Spark SQL 是由 `ConstantPropagation` 实现的。也就是将变量替换成常量，比如 SELECT * FROM table WHERE i = 5 AND j = i + 3 可以转换成 SELECT * FROM table WHERE i = 5 AND j = 8。这个看起来好像没什么的，但是如果扫描的行数非常多可以减少很多的计算时间的开销的。经过这个优化，得到的逻辑计划如下

![spark_constantpropagation-iteblog](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/spark_constantpropagation-iteblog.jpg)



我们的查询中有 `t1.cid = 1 AND t1.did = t1.cid + 1` 查询语句，从里面可以看出 t1.cid 其实已经是确定的值了，所以我们完全可以使用它计算出 t1.did。



#### 常量累加

常量累加在 Spark SQL 是由 `ConstantFolding` 实现的。这个和常量替换类似，也是在这个阶段把一些常量表达式事先计算好。这个看起来改动的不大，但是在数据量非常大的时候可以减少大量的计算，减少 CPU 等资源的使用。经过这个优化，得到的逻辑计划如下：

![spark_constantfolding-iteblog](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/spark_constantfolding-iteblog.jpg)

所以经过上面四个步骤的优化之后，得到的优化之后的逻辑计划为：

```
== Optimized Logical Plan ==
Aggregate [class#4], [class#4, sum(degree#12) AS sum(degree)#27, cast((avg(UnscaledValue(degree#12)) / 10.0) as decimal(14,5)) AS avg(degree)#28]
+- Project [class#4, degree#12]
   +- Join Inner, (sno#0 = sno#10)
      :- Project [sno#0, class#4]
      :  +- Filter ((isnotnull(sbirthday#3) && (cast(sbirthday#3 as string) > 1973-01-01 00:00:00)) && isnotnull(sno#0))
      :     +- Relation[sno#0,sname#1,ssex#2,sbirthday#3,class#4] JDBCRelation(students) [numPartitions=1]
      +- Project [sno#10, degree#12]
         +- Filter ((isnotnull(degree#12) && (degree#12 > 60.0)) && isnotnull(sno#10))
            +- Relation[sno#10,cno#11,degree#12] JDBCRelation(scores) [numPartitions=1]
```

到此为止，优化逻辑阶段基本完成，另外更多的其他优化，参见spark源码：

https://github.com/apache/spark/blob/master/sql/catalyst/src/main/scala/org/apache/spark/sql/catalyst/optimizer/Optimizer.scala#L59



### 4、生成可执行的物理计划阶段Physical Plan

经过前面多个步骤，包括parse，analyzer以及Optimizer等多个阶段，得到经过优化之后的sql语句，但是这个sql语句仍然不能执行，为了能够执行这个sql，最终必须得要翻译成为可以被执行的物理计划，到这个阶段spark就知道该如何执行这个sql了，和前面逻辑计划绑定和优化不一样，这个阶段使用的是策略strategy，而且经过前面介绍的逻辑计划绑定和 Transformations 动作之后，树的类型并没有改变，也就是说：Expression 经过 Transformations 之后得到的还是 Transformations ；Logical Plan 经过 Transformations 之后得到的还是 Logical Plan。而到了这个阶段，经过 Transformations 动作之后，树的类型改变了，由 Logical Plan 转换成 Physical Plan 了。

一个逻辑计划（Logical Plan）经过一系列的策略处理之后，得到多个物理计划（Physical Plans），物理计划在 Spark 是由 SparkPlan 实现的。多个物理计划再经过代价模型（Cost Model）得到选择后的物理计划（Selected Physical Plan），整个过程如下所示：

![1591506889458](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1591506889458.png)

Cost Model 对应的就是基于代价的优化（Cost-based Optimizations，CBO，主要由华为的大佬们实现的，详见 [SPARK-16026](https://issues.apache.org/jira/browse/SPARK-16026) ），核心思想是计算每个物理计划的代价，然后得到最优的物理计划。但是在目前最新版的 Spark 2.4.3，这一部分并没有实现，直接返回多个物理计划列表的第一个作为最优的物理计划，如下

```scala
lazy val sparkPlan: SparkPlan = {
    SparkSession.setActiveSession(sparkSession)
    // TODO: We use next(), i.e. take the first plan returned by the planner, here for now,
    //       but we will implement to choose the best plan.
    planner.plan(ReturnAnswer(optimizedPlan)).next()
}
```

而 [SPARK-16026](https://issues.apache.org/jira/browse/SPARK-16026) 引入的 CBO 优化主要是在前面介绍的**优化逻辑计划阶段 - Optimizer** 阶段进行的，对应的 Rule 为 `CostBasedJoinReorder`，并且默认是关闭的，需要通过 `spark.sql.cbo.enabled` 或 `spark.sql.cbo.joinReorder.enabled` 参数开启。
所以到了这个节点，最后得到的物理计划如下：

```
== Physical Plan ==
*(6) HashAggregate(keys=[class#4], functions=[sum(degree#12), avg(UnscaledValue(degree#12))], output=[class#4, sum(degree)#27, avg(degree)#28])
+- Exchange hashpartitioning(class#4, 200)
   +- *(5) HashAggregate(keys=[class#4], functions=[partial_sum(degree#12), partial_avg(UnscaledValue(degree#12))], output=[class#4, sum#32, sum#33, count#34L])
      +- *(5) Project [class#4, degree#12]
         +- *(5) SortMergeJoin [sno#0], [sno#10], Inner
            :- *(2) Sort [sno#0 ASC NULLS FIRST], false, 0
            :  +- Exchange hashpartitioning(sno#0, 200)
            :     +- *(1) Project [sno#0, class#4]
            :        +- *(1) Filter (cast(sbirthday#3 as string) > 1973-01-01 00:00:00)
            :           +- *(1) Scan JDBCRelation(students) [numPartitions=1] [sno#0,class#4,sbirthday#3] PushedFilters: [*IsNotNull(sbirthday), *IsNotNull(sno)], ReadSchema: struct<sno:string,class:string,sbirthday:timestamp>
            +- *(4) Sort [sno#10 ASC NULLS FIRST], false, 0
               +- Exchange hashpartitioning(sno#10, 200)
                  +- *(3) Scan JDBCRelation(scores) [numPartitions=1] [sno#10,degree#12] PushedFilters: [*IsNotNull(degree), *GreaterThan(degree,60.0), *IsNotNull(sno)], ReadSchema: struct<sno:string,degree:decimal(10,1)>
		
```

从上面的结果可以看出，物理计划阶段已经知道数据源是从 JDBC里面读取了，也知道文件的路径，数据类型等。而且在读取文件的时候，直接将过滤条件（PushedFilters）加进去了

同时，这个 Join 变成了 SortMergeJoin，

![logical Plan](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/logical%20Plan.png)

到这里， Physical Plan 就完全生成了



### 5、代码生成阶段

从以上多个过程执行完成之后，例如parser，analyzer，Optimizer，physicalPlan等，最终我们得到的物理执行计划，这个物理执行计划标明了整个的代码执行过程当中我们代码层面的执行过程，以及最终要得到的数据字段以及字段类型，也包含了我们对应的数据源的位置，虽然得到了物理执行计划，但是这个物理执行计划想要被执行，最终还是得要生成完整的代码，底层还是基于sparkRDD去进行处理的，spark最后也还会有一些Rule对生成的物理执行计划进行处理，这个处理过程就是prepareForExecution，这些rule规则定义在

org.apache.spark.sql.execution.QueryExecution 这个类当中的这个方法里面

```scala
 protected def prepareForExecution(plan: SparkPlan): SparkPlan = {
    preparations.foldLeft(plan) { case (sp, rule) => rule.apply(sp) }
  }

  /** A sequence of rules that will be applied in order to the physical plan before execution. */
  protected def preparations: Seq[Rule[SparkPlan]] = Seq(
    python.ExtractPythonUDFs,  //抽取python的自定义函数
    PlanSubqueries(sparkSession),  //子查询物理计划处理
    EnsureRequirements(sparkSession.sessionState.conf),  //确保执行计划分区排序正确
    CollapseCodegenStages(sparkSession.sessionState.conf), //收集生成代码
    ReuseExchange(sparkSession.sessionState.conf),  //节点重用
    ReuseSubquery(sparkSession.sessionState.conf))  //子查询重用
```

上面的 Rule 中 `CollapseCodegenStages` 是重头戏，这就是大家熟知的全代码阶段生成，Catalyst 全阶段代码生成的入口就是这个规则。当然，如果需要 Spark 进行全阶段代码生成，需要将 `spark.sql.codegen.wholeStage` 设置为 true（默认）。

#### 生成代码与sql解析引擎的区别

在sparkSQL当中，通过生成代码，来实现sql语句的最终生成，说白了最后底层执行的还是代码，那么为什么要这么麻烦，使用代码的方式来执行我们的sql语句，难道没有sql的解析引擎直接执行sql语句嘛？当然是有的，在spark2.0版本之前使用的都是基于Volcano Iterator Model（参见 [《Volcano-An Extensible and Parallel Query Evaluation System》](http://paperhub.s3.amazonaws.com/dace52a42c07f7f8348b08dc2b186061.pdf)） 来实现sql的解析的，这个是由 Goetz Graefe 在 1993 年提出的，当今绝大多数数据库系统处理 SQL 在底层都是基于这个模型的。这个模型的执行可以概括为：首先数据库引擎会将 SQL 翻译成一系列的关系代数算子或表达式，然后依赖这些关系代数算子逐条处理输入数据并产生结果。每个算子在底层都实现同样的接口，比如都实现了 next() 方法，然后最顶层的算子 next() 调用子算子的 next()，子算子的 next() 在调用孙算子的 next()，直到最底层的 next()，具体过程如下图表示：

![原始解析sql方式](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/%E5%8E%9F%E5%A7%8B%E8%A7%A3%E6%9E%90sql%E6%96%B9%E5%BC%8F.png)

Volcano Iterator Model 的优点是抽象起来很简单，很容易实现，而且可以通过任意组合算子来表达复杂的查询。但是缺点也很明显，存在大量的==虚函数调用==，会引起 CPU 的中断，最终影响了执行效率。[databricks的官方博客](https://databricks.com/blog/2016/05/23/apache-spark-as-a-compiler-joining-a-billion-rows-per-second-on-a-laptop.html)对比过使用 Volcano Iterator Model 和手写代码的执行效率，结果发现==手写的代码执行效率要高出十倍==！

所以总结起来就是将sql解析成为代码，比sql引擎直接解析sql语句效率要快，所以spark2.0最终选择使用代码生成的方式来执行sql语句

基于上面的发现，从 Apache Spark 2.0 开始，社区开始引入了 Whole-stage Code Generation，参见 [SPARK-12795](https://issues.apache.org/jira/browse/SPARK-12795)，主要就是想通过这个来模拟手写代码，从而提升 Spark SQL 的执行效率。Whole-stage Code Generation 来自于2011年 Thomas Neumann 发表的 [Efficiently Compiling Efficient Query Plans for Modern Hardware](http://www.vldb.org/pvldb/vol4/p539-neumann.pdf)论文，这个也是 Tungsten 计划的一部分。

Tungsten 代码生成分为三部分：

- 表达式代码生成（expression codegen）
- 全阶段代码生成（Whole-stage Code Generation）
- 加速序列化和反序列化（speed up serialization/deserialization）

#### 表达式代码生成（expression codegen）

这个其实在 Spark 1.x 就有了。表达式代码生成的基类是 org.apache.spark.sql.catalyst.expressions.codegen.CodeGenerator，其下有七个子类：

![1591525895593](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1591525895593.png)

我们前文的 SQL 生成的逻辑计划中的 `(isnotnull(sbirthday#3) && (cast(sbirthday#3 as string) > 1973-01-01 00:00:00)` 就是最基本的表达式。它也是一种 Predicate，所以会调用 org.apache.spark.sql.catalyst.expressions.codegen.GeneratePredicate 来生成表达式的代码。



#### 全阶段代码生成（Whole-stage Code Generation）

![全阶段代码生成](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/%E5%85%A8%E9%98%B6%E6%AE%B5%E4%BB%A3%E7%A0%81%E7%94%9F%E6%88%90.png)

全阶段代码生成（Whole-stage Code Generation），用来将多个处理逻辑整合到单个代码模块中，其中也会用到上面的表达式代码生成。和前面介绍的表达式代码生成不一样，这个是对整个 SQL 过程进行代码生成，前面的表达式代码生成仅对于表达式的。全阶段代码生成都是继承自 org.apache.spark.sql.execution.BufferedRowIterator 的，生成的代码需要实现 processNext() 方法，这个方法会在 org.apache.spark.sql.execution.WholeStageCodegenExec 里面的 doExecute 方法里面被调用。而这个方法里面的 rdd 会将数据传进生成的代码里面 ，比如我们上文 SQL 这个例子的数据源是 JDBC文件，底层使用 org.apache.spark.sql.execution.RowDataSourceScanExec这个类读取文件，然后生成 inputRDD，这个 rdd 在 WholeStageCodegenExec 类中的 doExecute 方法里面调用生成的代码，然后执行我们各种判断得到最后的结果。WholeStageCodegenExec 类中的 doExecute 方法部分代码如下：

```scala


/**
 * WholeStageCodegen compiles a subtree of plans that support codegen together into single Java
 * function.
 *
 * Here is the call graph of to generate Java source (plan A supports codegen, but plan B does not):
 *
 *   WholeStageCodegen       Plan A               FakeInput        Plan B
 * =========================================================================
 *
 * -> execute()
 *     |
 *  doExecute() --------->   inputRDDs() -------> inputRDDs() ------> execute()
 *     |
 *     +----------------->   produce()
 *                             |
 *                          doProduce()  -------> produce()
 *                                                   |
 *                                                doProduce()
 *                                                   |
 *                         doConsume() <--------- consume()
 *                             |
 *  doConsume()  <--------  consume()
 *
 * SparkPlan A should override `doProduce()` and `doConsume()`.
 *
 * `doCodeGen()` will create a `CodeGenContext`, which will hold a list of variables for input,
 * used to generated code for [[BoundReference]].
 */

override def doExecute(): RDD[InternalRow] = {
    val (ctx, cleanedSource) = doCodeGen()
    // try to compile and fallback if it failed
    val (_, maxCodeSize) = try {
      CodeGenerator.compile(cleanedSource)
    } catch {
      case _: Exception if !Utils.isTesting && sqlContext.conf.codegenFallback =>
        // We should already saw the error message
        logWarning(s"Whole-stage codegen disabled for plan (id=$codegenStageId):\n $treeString")
        return child.execute()
    }

    // Check if compiled code has a too large function
    if (maxCodeSize > sqlContext.conf.hugeMethodLimit) {
      logInfo(s"Found too long generated codes and JIT optimization might not work: " +
        s"the bytecode size ($maxCodeSize) is above the limit " +
        s"${sqlContext.conf.hugeMethodLimit}, and the whole-stage codegen was disabled " +
        s"for this plan (id=$codegenStageId). To avoid this, you can raise the limit " +
        s"`${SQLConf.WHOLESTAGE_HUGE_METHOD_LIMIT.key}`:\n$treeString")
      child match {
        // The fallback solution of batch file source scan still uses WholeStageCodegenExec
        case f: FileSourceScanExec if f.supportsBatch => // do nothing
        case _ => return child.execute()
      }
    }

    val references = ctx.references.toArray

    val durationMs = longMetric("pipelineTime")

    val rdds = child.asInstanceOf[CodegenSupport].inputRDDs()
    assert(rdds.size <= 2, "Up to two input RDDs can be supported")
    if (rdds.length == 1) {
      rdds.head.mapPartitionsWithIndex { (index, iter) =>
        val (clazz, _) = CodeGenerator.compile(cleanedSource)
        val buffer = clazz.generate(references).asInstanceOf[BufferedRowIterator]
        buffer.init(index, Array(iter))
        new Iterator[InternalRow] {
          override def hasNext: Boolean = {
            val v = buffer.hasNext
            if (!v) durationMs += buffer.durationMs()
            v
          }
          override def next: InternalRow = buffer.next()
        }
      }
    } else {
      // Right now, we support up to two input RDDs.
      rdds.head.zipPartitions(rdds(1)) { (leftIter, rightIter) =>
        Iterator((leftIter, rightIter))
        // a small hack to obtain the correct partition index
      }.mapPartitionsWithIndex { (index, zippedIter) =>
        val (leftIter, rightIter) = zippedIter.next()
        val (clazz, _) = CodeGenerator.compile(cleanedSource)
        val buffer = clazz.generate(references).asInstanceOf[BufferedRowIterator]
        buffer.init(index, Array(leftIter, rightIter))
        new Iterator[InternalRow] {
          override def hasNext: Boolean = {
            val v = buffer.hasNext
            if (!v) durationMs += buffer.durationMs()
            v
          }
          override def next: InternalRow = buffer.next()
        }
      }
    }
  }
```



在WholeStageCodegenExec 这个类的注释当中也说明了，最终生成的代码过程如下

```scala
/**
 * WholeStageCodegen compiles a subtree of plans that support codegen together into single Java
 * function.
 *
 * Here is the call graph of to generate Java source (plan A supports codegen, but plan B does not):
 *
 *   WholeStageCodegen       Plan A               FakeInput        Plan B
 * =========================================================================
 *
 * -> execute()
 *     |
 *  doExecute() --------->   inputRDDs() -------> inputRDDs() ------> execute()
 *     |
 *     +----------------->   produce()
 *                             |
 *                          doProduce()  -------> produce()
 *                                                   |
 *                                                doProduce()
 *                                                   |
 *                         doConsume() <--------- consume()
 *                             |
 *  doConsume()  <--------  consume()
 *
 * SparkPlan A should override `doProduce()` and `doConsume()`.
 *
 * `doCodeGen()` will create a `CodeGenContext`, which will hold a list of variables for input,
 * used to generated code for [[BoundReference]].
 */
```



相比 Volcano Iterator Model，全阶段代码生成的执行过程如下：

![1591534793978](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1591534793978.png)

通过引入全阶段代码生成，大大减少了虚函数的调用，减少了 CPU 的调用，使得 SQL 的执行速度有很大提升。



#### 代码编译

生成代码之后需要解决的另一个问题是如何将生成的代码进行编译然后加载到同一个 JVM 中去。在早期 Spark 版本是使用 Scala 的 Reflection 和 Quasiquotes 机制来实现代码生成的。Quasiquotes 是一个简洁的符号，可以让我们轻松操作 Scala 语法树，具体参见 [这里](https://docs.scala-lang.org/overviews/quasiquotes/intro.html)。虽然 Quasiquotes 可以很好的为我们解决代码生成等相关的问题，但是带来的新问题是编译代码时间比较长（大约 50ms - 500ms）！所以社区不得不默认关闭表达式代码生成。

为了解决这个问题，Spark 引入了 Janino 项目，参见 [SPARK-7956](https://issues.apache.org/jira/browse/SPARK-7956)。Janino 是一个超级小但又超级快的 Java™ 编译器. 它不仅能像 javac 工具那样将一组源文件编译成字节码文件，还可以对一些 Java 表达式，代码块，类中的文本(class body)或者内存中源文件进行编译，并把编译后的字节码直接加载到同一个 JVM 中运行。Janino 不是一个开发工具, 而是作为运行时的嵌入式编译器，比如作为表达式求值的翻译器或类似于 JSP 的服务端页面引擎，关于 Janino 的更多知识请参见[这里](https://janino-compiler.github.io/janino/)。通过引入了 Janino 来编译生成的代码，结果显示 SQL 表达式的编译时间减少到 5ms。在 Spark 中使用了 `ClassBodyEvaluator` 来编译生成之后的代码，参见 org.apache.spark.sql.catalyst.expressions.codegen.CodeGenerator。

**需要主要的是，代码生成是在 Driver 端进行的，而代码编译是在 Executor 端进行的。**



#### SQL执行

终于到了 SQL 真正执行的地方了。这个时候 Spark 会执行上阶段生成的代码，然后得到最终的结果，DAG 执行图如下：

![1591537781641](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1591537781641.png)



## 3、sparkSQL执行过程深度总结

 [sparkSQL执行过程总结.pptx](/images/kaikeba/sparkSQL-1\sparkSQL执行过程总结.pptx) 

从上面可以看得出来，sparkSQL的执行主要经过了这么几个大的步骤

1、输入sql，dataFrame或者dataSet

2、经过Catalyst过程，生成最终我们得到的最优的物理执行计划

​	1、parser阶段

​		主要是通过Antlr4解析SqlBase.g4 ，所有spark'支持的语法方式都是定义在sqlBase.g4里面了，如果需要扩展sparkSQL的语法，我们只需要扩展sqlBase.g4即可，通过antlr4解析sqlBase.g4文件，生成了我们的语法解析器SqlBaseLexer.java和词法解析器SqlBaseParser.java

​		parse阶段  ==》  	antlr4  ==》解析  ==》 SqlBase.g4  ==》得到  ==》 语法解析器SqlBaseLexer.java + 词法解析器SqlBaseParser.java

​	2、analyzer阶段

​		使用基于Rule的规则解析以及Session Catalog来实现函数资源信息和元数据管理信息

​		Analyzer 阶段   ==》 使用   ==》  Rule  +  Session Catalog  ==》多个rule  ==》 组成一个batch  

​				session CataLog  ==》 保存函数资源信息以及元数据信息等

​	3、optimizer阶段

​			optimizer调优阶段  ==》 基于规则的RBO优化rule-based optimizer  ==>  谓词下推 + 列剪枝  + 常量替换  + 常量累加

​	4、planner阶段

​		通过analyzer生成多个物理计划  ==》 经过Cost  Model进行最优选择  ==》基于代价的CBO优化    ==》 最终选定得到的最优物理执行计划

​	5、选定最终的物理计划，准备执行

​		最终选定的最优物理执行计划  ==》  准备生成代码去开始执行

3、将最终得到的物理执行计划进行代码生成，提交代码去执行我们的最终任务



# 13、sparkSQL调优

## 1、数据缓存

性能调优主要是将数据放入内存中操作，spark缓存注册表的方法

缓存spark表：

spark.catalog.cacheTable("tableName")缓存表

释放缓存表：

spark.catalog.uncacheTable("tableName")解除缓存



## 2、性能优化相关参数

Sparksql仅仅会缓存必要的列，并且自动调整压缩算法来减少内存和GC压力。

| 属性                                         | 默认值 | 描述                                                         |
| -------------------------------------------- | ------ | ------------------------------------------------------------ |
| spark.sql.inMemoryColumnarStorage.compressed | true   | Spark SQL 将会基于统计信息自动地为每一列选择一种压缩编码方式。 |
| spark.sql.inMemoryColumnarStorage.batchSize  | 10000  | 缓存批处理大小。缓存数据时, 较大的批处理大小可以提高内存利用率和压缩率，但同时也会带来 OOM（Out Of Memory）的风险。 |
| spark.sql.files.maxPartitionBytes            | 128 MB | 读取文件时单个分区可容纳的最大字节数（不过不推荐手动修改，可能在后续版本自动的自适应修改） |
| spark.sql.files.openCostInBytes              | 4M     | 打开文件的估算成本, 按照同一时间能够扫描的字节数来测量。当往一个分区写入多个文件的时候会使用。高估更好, 这样的话小文件分区将比大文件分区更快 (先被调度)。 |



## 3、表数据广播

在进行表join的时候，将小表广播可以提高性能，spark2.+中可以调整以下参数、

| 属性                                 | 默认值 | 描述                                                         |
| ------------------------------------ | ------ | ------------------------------------------------------------ |
| spark.sql.broadcastTimeout           | 300    | 广播等待超时时间，单位秒                                     |
| spark.sql.autoBroadcastJoinThreshold | 10M    | 用于配置一个表在执行 join 操作时能够广播给所有 worker 节点的最大字节大小。通过将这个值设置为 -1 可以禁用广播。注意，当前数据统计仅支持已经运行了 ANALYZE TABLE <tableName> COMPUTE STATISTICS noscan 命令的 Hive Metastore 表。 |

## 4、分区数的控制

spark任务并行度的设置中，spark有两个参数可以设置

| 属性                         | 默认值                                                       | 描述                                                   |
| ---------------------------- | ------------------------------------------------------------ | ------------------------------------------------------ |
| spark.sql.shuffle.partitions | 200                                                          | 用于配置 join 或aggregate  shuffle数据时使用的分区数。 |
| spark.default.parallelism    | 对于分布式shuffle操作像reduceByKey和join，父RDD中分区的最大数目。对于无父RDD的并行化等操作，它取决于群集管理器：-本地模式：本地计算机上的核心数-Mesos fine grained mode：8-其他：所有执行节点上的核心总数或2，以较大者为准 | 分布式shuffle操作的分区数                              |

看起来它们的定义似乎也很相似，但在实际测试中，

- spark.default.parallelism只有在处理RDD时才会起作用，对Spark SQL的无效。
- spark.sql.shuffle.partitions则是对sparks SQL专用的设置

## 5. 文件与分区

这个总共有两个参数可以调整：

- 读取文件的时候一个分区接受多少数据；
- 文件打开的开销，通俗理解就是小文件合并的阈值。

文件打开是有开销的，开销的衡量，Spark 采用了一个比较好的方式就是打开文件的开销用，相同时间能扫描的数据的字节数来衡量。

参数介绍如下：

| 属性                              | 默认值             | 描述                                                         |
| --------------------------------- | ------------------ | ------------------------------------------------------------ |
| spark.sql.files.maxPartitionBytes | 134217728 (128 MB) | 打包传入一个分区的最大字节，在读取文件的时候                 |
| spark.sql.files.openCostInBytes   | 4194304 (4 MB)     | 用相同时间内可以扫描的数据的大小来衡量打开一个文件的开销。当将多个文件写入同一个分区的时候该参数有用。该值设置大一点有好处，有小文件的分区会比大文件分区处理速度更快（优先调度） |

spark.sql.files.maxPartitionBytes该值的调整要结合你想要的并发度及内存的大小来进行。

spark.sql.files.openCostInBytes说直白一些这个参数就是合并小文件的阈值，小于这个阈值的文件将会合并



## 6、数据的本地性

分布式计算系统的精粹在于移动计算而非移动数据，但是在实际的计算过程中，总存在着移动数据的情况，除非是在集群的所有节点上都保存数据的副本。移动数据，将数据从一个节点移动到另一个节点进行计算，不但消耗了网络IO，也消耗了磁盘IO，降低了整个计算的效率。为了提高数据的本地性，除了优化算法（也就是修改spark内存，难度有点高），就是合理设置数据的副本。设置数据的副本，这需要通过配置参数并长期观察运行状态才能获取的一个经验值。

先来看看一个 stage 里所有 task 运行的一些性能指标，其中的一些说明：

- `Scheduler Delay` : spark 分配 task 所花费的时间
- `Executor Computing Time` : executor 执行 task 所花费的时间
- `Getting Result Time` : 获取 task 执行结果所花费的时间
- `Result Serialization Time` : task 执行结果序列化时间
- `Task Deserialization Time` : task 反序列化时间
- `Shuffle Write Time` : shuffle 写数据时间
- `Shuffle Read Time` : shuffle 读数据所花费时间

​      下面是spark webUI监控Stage的一个图：

- PROCESS_LOCAL是指读取缓存在本地节点的数据
- NODE_LOCAL是指读取本地节点硬盘数据
- ANY是指读取非本地节点数据
- 通常读取数据PROCESS_LOCAL>NODE_LOCAL>ANY，尽量使数据以PROCESS_LOCAL或NODE_LOCAL方式读取。其中PROCESS_LOCAL还和cache有关。



## 7、sparkSQL参数调优总结

```properties
//1.下列Hive参数对Spark同样起作用。
set hive.exec.dynamic.partition=true; // 是否允许动态生成分区
set hive.exec.dynamic.partition.mode=nonstrict; // 是否容忍指定分区全部动态生成
set hive.exec.max.dynamic.partitions = 100; // 动态生成的最多分区数

//2.运行行为
set spark.sql.autoBroadcastJoinThreshold; // 大表 JOIN 小表，小表做广播的阈值
set spark.dynamicAllocation.enabled; // 开启动态资源分配
set spark.dynamicAllocation.maxExecutors; //开启动态资源分配后，最多可分配的Executor数
set spark.dynamicAllocation.minExecutors; //开启动态资源分配后，最少可分配的Executor数
set spark.sql.shuffle.partitions; // 需要shuffle是mapper端写出的partition个数
set spark.sql.adaptive.enabled; // 是否开启调整partition功能，如果开启，spark.sql.shuffle.partitions设置的partition可能会被合并到一个reducer里运行
set spark.sql.adaptive.shuffle.targetPostShuffleInputSize; //开启spark.sql.adaptive.enabled后，两个partition的和低于该阈值会合并到一个reducer
set spark.sql.adaptive.minNumPostShufflePartitions; // 开启spark.sql.adaptive.enabled后，最小的分区数
set spark.hadoop.mapreduce.input.fileinputformat.split.maxsize; //当几个stripe的大小大于该值时，会合并到一个task中处理

//3.executor能力
set spark.executor.memory; // executor用于缓存数据、代码执行的堆内存以及JVM运行时需要的内存
set spark.yarn.executor.memoryOverhead; //Spark运行还需要一些堆外内存，直接向系统申请，如数据传输时的netty等。
set spark.sql.windowExec.buffer.spill.threshold; //当用户的SQL中包含窗口函数时，并不会把一个窗口中的所有数据全部读进内存，而是维护一个缓存池，当池中的数据条数大于该参数表示的阈值时，spark将数据写到磁盘
set spark.executor.cores; //单个executor上可以同时运行的task数

```

# 14、spark的动态资源划分

动态资源划分，主要是spark当中用于对计算的时候资源如果不够或者资源剩余的情况下进行动态的资源划分，以求资源的利用率达到最大

http://spark.apache.org/docs/2.3.3/configuration.html#dynamic-allocation

Spark中，所谓资源单位一般指的是executors，和Yarn中的Containers一样，在Spark On Yarn模式下，通常使用–num-executors来指定Application使用的executors数量，而–executor-memory和–executor-cores分别用来指定每个executor所使用的内存和虚拟CPU核数

假设有这样的场景，如果使用Hive，多个用户同时使用hive-cli做数据开发和分析，只有当用户提交执行了Hive SQL时候，才会向YARN申请资源，执行任务，如果不提交执行，无非就是停留在Hive-cli命令行，也就是个JVM而已，并不会浪费YARN的资源。现在想用Spark-SQL代替Hive来做数据开发和分析，也是多用户同时使用，如果按照之前的方式，以yarn-client模式运行spark-sql命令行，在启动时候指定–num-executors 10，那么每个用户启动时候都使用了10个YARN的资源（Container），这10个资源就会一直被占用着，只有当用户退出spark-sql命令行时才会释放。例如通过以下这种方式使用spark-sql

```shell
直接通过-e来执行任务，执行完成任务之后，回收资源
cd /kkb/install/spark-2.3.3-bin-hadoop2.7
bin/spark-sql  --master yarn-client  \
--executor-memory 512m –num-executors 10 \
--conf  spark.sql.warehouse.dir=hdfs://node01:8020/user/hive/warehouse \
--jars /kkb/install/hadoop-2.6.0-cdh5.14.2/share/hadoop/common/hadoop-lzo-0.4.20.jar  \
-e  "select count(*) from game_center.ods_task_log;"

进入spark-sql客户端，但是不执行任务，一直持续占有资源
cd /kkb/install/spark-2.3.3-bin-hadoop2.7
bin/spark-sql  --master yarn-client  \
--executor-memory 512m –num-executors 10 \
--conf  spark.sql.warehouse.dir=hdfs://node01:8020/user/hive/warehouse \
--jars /kkb/install/hadoop-2.6.0-cdh5.14.2/share/hadoop/common/hadoop-lzo-0.4.20.jar  

在这种模式下，就算你不提交资源，申请的资源也会一直常驻，这样就明显不合理了

```

spark-sql On Yarn，能不能像Hive一样，执行SQL的时候才去申请资源，不执行的时候就释放掉资源呢，其实从Spark1.2之后，对于On Yarn模式，已经支持动态资源分配（Dynamic Resource Allocation），这样，就可以根据Application的负载（Task情况），动态的增加和减少executors，这种策略非常适合在YARN上使用spark-sql做数据开发和分析，以及将spark-sql作为长服务来使用的场景。

spark当中支持通过动态资源划分的方式来实现动态资源的配置，尽量减少内存的持久占用，但是动态资源划分又会产生进一步的问题例如：

```
executor动态调整的范围？无限减少？无限制增加？
executor动态调整速率？线性增减？指数增减？
何时移除Executor？
何时新增Executor了？只要由新提交的Task就新增Executor吗？
Spark中的executor不仅仅提供计算能力，还可能存储持久化数据，这些数据在宿主executor被kill后，该如何访问？
```



通过spark-shell当中最简单的wordcount为例来查看spark当中的资源划分

```scala
# 以yarn模式执行，并指定executor个数为1
$ spark-shell --master=yarn --num-executors=1

# 提交Job1 wordcount
scala> sc.textFile("file:///etc/hosts").flatMap(line => line.split(" ")).map(word => (word,1)).reduceByKey(_ + _).count();

# 提交Job2 wordcount
scala> sc.textFile("file:///etc/profile").flatMap(line => line.split(" ")).map(word => (word,1)).reduceByKey(_ + _).count();

# Ctrl+C Kill JVM
```



上述的Spark应用中，以yarn模式启动spark-shell，并顺序执行两次wordcount，最后Ctrl+C退出spark-shell。此例中Executor的生命周期如下图：



![1591607427157](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1591607427157.png)

从上图可以看出，Executor在整个应用执行过程中，其状态一直处于Busy（执行Task）或Idle（空等）。处于Idle状态的Executor造成资源浪费这个问题已经在上面提到。下面重点看下开启Spark动态资源分配功能后，Executor如何运作。
![1591607516396](1%E3%80%81sparkSQL%E7%AC%AC%E4%BA%8C%E6%AC%A1%E8%AF%BE.assets/1591607516396.png)

下面分析下上图中各个步骤：

1. spark-shell Start：启动spark-shell应用，并通过--num-executor指定了1个执行器。
2. Executor1 Start：启动执行器Executor1。注意：Executor启动前存在一个AM向ResourceManager申请资源的过程，所以启动时机略微滞后与Driver。
3. Job1 Start：提交第一个wordcount作业，此时，Executor1处于Busy状态。
4. Job1 End：作业1结束，Executor1又处于Idle状态。
5. Executor1 timeout：Executor1空闲一段时间后，超时被Kill。
6. Job2 Submit：提交第二个wordcount，此时，没有Active的Executor可用。Job2处于Pending状态。
7. Executor2 Start：检测到有Pending的任务，此时Spark会启动Executor2。
8. Job2 Start：此时，已经有Active的执行器，Job2会被分配到Executor2上执行。
9. Job2 End：Job2结束。
10. Executor2 End：Ctrl+C 杀死Driver，Executor2也会被RM杀死。

上述流程中需要重点关注的几个问题：

- Executor超时：当Executor不执行任何任务时，会被标记为Idle状态。空闲一段时间后即被认为超时，会被kill。该空闲时间由**spark.dynamicAllocation.executorIdleTimeout**决定，默认值60s。对应上图中：Job1 End到Executor1 timeout之间的时间。
- 资源不足时，何时新增Executor：当有Task处于pending状态，意味着资源不足，此时需要增加Executor。这段时间由**spark.dynamicAllocation.schedulerBacklogTimeout**控制，默认1s。对应上述step6和step7之间的时间。
- 该新增多少Executor：新增Executor的个数主要依据是当前负载情况，即running和pending任务数以及当前Executor个数决定。用maxNumExecutorsNeeded代表当前实际需要的最大Executor个数，maxNumExecutorsNeeded和当前Executor个数的差值即是**潜在的**新增Executor的个数。注意：之所以说**潜在的个数**，是因为最终新增的Executor个数还有别的因素需要考虑，后面会有分析。下面是maxNumExecutorsNeeded计算方法：

```scala
  private def maxNumExecutorsNeeded(): Int = {
    val numRunningOrPendingTasks = listener.totalPendingTasks + listener.totalRunningTasks
    math.ceil(numRunningOrPendingTasks * executorAllocationRatio /
              tasksPerExecutorForFullParallelism)
      .toInt
  }
```

其中numRunningOrPendingTasks为当前running和pending任务数之和。

executorAllocationRatio：最理想的情况下，有多少待执行的任务，那么我们就新增多少个Executor，从而达到最大的任务并发度。但是这也有副作用，如果当前任务都是小任务，那么这一策略就会造成资源浪费。可能最后申请的Executor还没启动，这些小任务已经被执行完了。该值是一个系数值，范围[0~1]。默认1.

tasksPerExecutorForFullParallelism：每个Executor的最大并发数，简单理解为：cpu核心数（spark.executor.cores）/ 每个任务占用的核心数（spark.task.cpus）。



## 问题1：executor动态调整的范围？无限减少？无限制增加？调整速率？

要实现资源的动态调整，那么限定调整范围是最先考虑的事情，Spark通过下面几个参数实现：

- spark.dynamicAllocation.minExecutors：Executor调整下限。（默认值：0）
- spark.dynamicAllocation.maxExecutors：Executor调整上限。（默认值：Integer.MAX_VALUE）
- spark.dynamicAllocation.initialExecutors：Executor初始数量（默认值：minExecutors）。

三者的关系必须满足：minExecutors <= initialExecutors <= maxExecutors

> 注意：如果显示指定了num-executors参数，那么initialExecutors就是num-executor指定的值。

## 问题2：Spark中的Executor既提供计算能力，也提供存储能力。这些因超时被杀死的Executor中持久化的数据如何处理？

如果Executor中缓存了数据，那么该Executor的Idle-timeout时间就不是由**executorIdleTimeout**决定，而是用**spark.dynamicAllocation.cachedExecutorIdleTimeout**控制，默认值：Integer.MAX_VALUE。如果手动设置了该值，当这些缓存数据的Executor被kill后，我们可以通过NodeManannger的External Shuffle Server来访问这些数据。这就要求NodeManager中**spark.shuffle.service.enabled**必须开启。



## 如何配置spark的动态资源划分

### 第一步：修改yarn-site.xml配置文件

```xml
<property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle,spark_shuffle</value>
</property>

<property>
    <name>yarn.nodemanager.aux-services.spark_shuffle.class</name>
    <value>org.apache.spark.network.yarn.YarnShuffleService</value>
</property>
<property>
    <name>spark.shuffle.service.port</name>
    <value>7337</value>
</property>
```



### 第二步：配置spark的配置文件

修改spark-conf的配置选项，开启动态资源划分，或者直接修改spark-defaults.conf，增加以下参数：

```properties
spark.shuffle.service.enabled true   //启用External shuffle Service服务
spark.shuffle.service.port 7337 //Shuffle Service服务端口，必须和yarn-site中的一致
spark.dynamicAllocation.enabled true  //开启动态资源分配
spark.dynamicAllocation.minExecutors 1  //每个Application最小分配的executor数
spark.dynamicAllocation.maxExecutors 30  //每个Application最大并发分配的executor数
spark.dynamicAllocation.schedulerBacklogTimeout 1s 
spark.dynamicAllocation.sustainedSchedulerBacklogTimeout 5s
```

动态资源分配策略：

开启动态分配策略后，application会在task因没有足够资源被挂起的时候去动态申请资源，这种情况意味着该application现有的executor无法满足所有task并行运行。spark一轮一轮的申请资源，当有task挂起或等待spark.dynamicAllocation.schedulerBacklogTimeout(默认1s)时间的时候，会开始动态资源分配；之后会每隔spark.dynamicAllocation.sustainedSchedulerBacklogTimeout(默认1s)时间申请一次，直到申请到足够的资源。每次申请的资源量是指数增长的，即1,2,4,8等。
之所以采用指数增长，出于两方面考虑：其一，开始申请的少是考虑到可能application会马上得到满足；其次要成倍增加，是为了防止application需要很多资源，而该方式可以在很少次数的申请之后得到满足。

动态资源回收策略：

当application的executor空闲时间超过spark.dynamicAllocation.executorIdleTimeout（默认60s）后，就会被回收。









