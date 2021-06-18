---
title: Hive Optimization Solution Notes
date: 2021-03-12 09:07:21
categories: [data-warehouse, hive]
tags: [Hive]
---

<img src="/images/hadoop/hadoop-hive-logo-1.png" width="380" alt="Hadoop MapReduce" />

<!-- more -->

## 1. Hive 优化

> [再次分享！Hive调优，数据工程师成神之路](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247493676&idx=1&sn=1658835f7c595cce105022e70640e020&chksm=cf37da21f8405337445ce6d8edbe4640b1a6dbd7903dfd6ac7cd2edbd83394a372bd2e3b9997&scene=21#wechat_redirect)
> [2020 大数据/数仓/数开 Questions](https://mp.weixin.qq.com/s/pwyus1xfX7QAz5MtecveZw)
> [Hive内部表外部表区别及各自使用场景](https://mp.weixin.qq.com/s?__biz=MzI2MDQzOTk3MQ==&mid=2247484702&idx=1&sn=a916d003851335e48b90be23c4519eb0&chksm=ea68efd2dd1f66c4baee87b27f9ae70cf6bde4bd35d5f9c0af66285d795724f8d7345d27a074&scene=21#wechat_redirect)

```sql
// 让可以不走mapreduce任务的，就不走mapreduce任务
hive> set hive.fetch.task.conversion=more;
 
// 开启任务并行执行
 set hive.exec.parallel=true;
// 解释：当一个sql中有多个job时候，且这多个job之间没有依赖，则可以让顺序执行变为并行执行（一般为用到union all的时候）
 
 // 同一个sql允许并行任务的最大线程数 
set hive.exec.parallel.thread.number=8;
 
// 设置jvm重用
// JVM重用对hive的性能具有非常大的 影响，特别是对于很难避免小文件的场景或者task特别多的场景，这类场景大多数执行时间都很短。jvm的启动过程可能会造成相当大的开销，尤其是执行的job包含有成千上万个task任务的情况。
set mapred.job.reuse.jvm.num.tasks=10; 
 
// 合理设置reduce的数目
// 方法1：调整每个reduce所接受的数据量大小
set hive.exec.reducers.bytes.per.reducer=500000000; （500M）
// 方法2：直接设置reduce数量
set mapred.reduce.tasks = 20

// map端聚合，降低传给reduce的数据量
set hive.map.aggr=true  

// 开启hive内置的数倾优化机制
set hive.groupby.skewindata=true
```

[Hadoop高频考点！](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247493886&idx=1&sn=2cee4ece5c7cc87895d9e1a1b2fb440f&chksm=cf37daf3f84053e51cd0323f1ec9114ca0ec159a9451dd53a4afde5a7c6f1cf48f12d7999ef0&scene=21#wechat_redirect)

No. | Hive 优化 | Flag
:---: | --- | :---
1. | explain | explain [extended] query |
2. | Column cropping<br><br>列裁剪 | set hive.optimize.cp = true; # 列裁剪，取数只取查询中需要用的列，默认true
3. | 谓词下推<br><br>Predicate pushdown | set hive.optimize.ppd=true; # 默认是true<br><br>`select a.*, b.* from a join b on a.id = b.id where b.age > 20;`
4. | Partition crop <br> 分区裁剪 | set hive.optimize.pruner=true; # 默认是true
5. | Merge small files<br>合并小文件<br><br><br> Map input merge | 如果一个mapreduce job碰到一对小文件作为输入，一个小文件启动一个Task<br><br>**Map 输入合并:**<br><br># Map端输入、合并文件之后按照block的大小分割（默认）set <br> hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat;<br><br># Map端输入，不合并<br>set hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;<br><br>
5. | 合并小文件 <br><br><br><br> Map/Reduce输出合并 | 大量的小文件会给 HDFS 带来压力，影响处理效率.<br>可以通过合并 Map 和 Reduce 的结果文件来消除影响 <br><br> 是否合并Map输出文件, 默认值为true<br>set hive.merge.mapfiles=true;<br><br> 是否合并Reduce端输出文件,默认值为false<br>set hive.merge.mapredfiles=true;
6. | MapTask并行度 | 1、减少 MapTask 数是通过合并小文件来实现，这一点主要是针对数据源<br>2、增加 MapTask 数可以通过控制上一个 job 的 reduceTask 个数<br><br>重点注意：不推荐把这个值进行随意设置！<br>推荐的方式：使用默认的切块大小即可。如果非要调整，最好是切块的N倍数<br><br> default_mapper_num = total_size / dfs_block_size <br><br> set mapred.map.tasks=10; # 默认值是2, 大于 default_mapper_num 才生效 <br><br>**总结一下控制 mapper 个数的方法**：<br>1. 如果想增加 MapTask 个数，可以设置 mapred.map.tasks 为一个较大的值<br>2. 如果想减少 MapTask 个数，可以设置 maperd.min.split.size 为一个较大的值<br>3. 如input是大量小文件，想减少 mapper 数，可设置 hive.input.format 合并小文件<br><br>hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat;
7. | ReduceTask并行度 | 可以通过改变上述两个参数的值来控制 ReduceTask 的数量. 也可以通过: <br><br> set mapred.map.tasks=10; <br> set mapreduce.job.reduces=10;
8. | **Join优化** | 1. 优先过滤后再进行Join操作，最大限度减少参与join的数据量<br>2. 小表join大表，最好启动mapjoin，hive自启用mapjoin, 小表不能超过25M，可改<br>3. Join on的条件相同的话，最好放入同一个job，并且join表的排列顺序从小到大<br>4. 如果多张表做join, 如果多个链接条件都相同，会转换成一个Job<br><br>**大表Join大表** <br> 1. filter null key <br>2. change null key to rand() <br><br>case when a.user_id is null then `concat('hive',rand())` else a.user_id end = b.user_id;
9. | 启用 MapJoin | 是否根据输入小表的大小，自动将reduce端的common join 转化为map join，将小表刷入内存中 <br> 对应逻辑优化器是MapJoinProcessor <br><br> ```set hive.auto.convert.join = true;```<br><br># 刷入内存表的大小(字节)<br>set hive.mapjoin.smalltable.filesize = 25000000;<br><br> # hive会基于表的size自动的将普通join转换成mapjoin <br> set hive.auto.convert.join.noconditionaltask=true;<br><br> # 多大的表可以自动触发放到内层LocalTask中，默认大小10M<br>set hive.auto.convert.join.noconditionaltask.size=10000000; <br><br> **也可以手动开启mapjoin**： <br> &nbsp;&nbsp; SELECT /*+ MAPJOIN(smallTable) */ smallTable.key, bigTable.value
10. | <br>**`Join_data_skew`** <br><br><br><br>skew /skjuː/ |  # join的key对应的记录条数超过这个值则会进行分拆，值根据具体数据量设置<br>set `hive.skewjoin.key`=100000;<br><br># 如果是join过程出现倾斜应该设置为true<br>set `hive.optimize.skewjoin`=false;<br><br>通过 hive.skewjoin.mapjoin.map.tasks 参数还可以控制第二个 job 的 mapper 数量，默认10000<br>set hive.skewjoin.mapjoin.map.tasks=10000;
13. | Group By优化 | **1. Map端部分聚合** <br><br> # 开启Map端聚合参数设置 set hive.map.aggr=true;<br># 设置map端预聚合的行数阈值，超过该值就会分拆job，默认值100000<br>set hive.groupby.mapaggr.checkinterval=100000 <br><br> **2. 有数据倾斜时进行负载均衡**<br><br>当 HQL 语句使用 group by 时数据出现倾斜时，如果该变量设置为 true，那么 Hive 会自动进行负载均衡。<br>策略就是把 MapReduce 任务拆分成两个： 第1个先做预汇总，第2个再做最终汇总. <br><br> # 自动优化，有数据倾斜的时候进行负载均衡（默认是false） <br> set hive.groupby.skewindata=false;
15. | Count Distinct优化 | 优化后（启动2个job，1个job负责子查询(可有多个reduce)，另1个job负责count(1)): <br> `select count(1) from (select id from tablename group by id) tmp;` 
16. | 怎样写in/exists<br><br>left semi join | -- in / exists 实现 <br>`select a.id, a.name from a where a.id in (select b.id from b);`<br><br>是推荐使用 Hive 的一个高效替代方案：left semi join<br>`select a.id, a.name from a left semi join b on a.id = b.id;` 

Hive0.11版本之后：

```bash
hive.auto.convert.join=True
hive.mapjoin.smalltable.filesize

# 默认值为2500000(25M),通过配置该属性来确定使用该优化的表的大小，如果表的大小小于此值就会被加载进内存中
```

> Notes：使用默认启动该优化的方式如果出现默名奇妙的BUG(比如MAPJOIN并不起作用),就将以下两个属性置为fase手动使用MAPJOIN标记来启动该优化

```bash
hive.auto.convert.join=false(关闭自动MAPJOIN转换操作)
hive.ignore.mapjoin.hint=false(不忽略MAPJOIN标记)
```

**手动开启mapjoin：**

```sql
--SQL方式，在SQL语句中添加MapJoin标记（mapjoin hint）
--将小表放到内存中，省去shffle操作
// 在没有开启mapjoin的情况下，执行的是reduceJoin
SELECT /*+ MAPJOIN(smallTable) */ smallTable.key, bigTable.value FROM
smallTable JOIN bigTable ON smallTable.key = bigTable.key;
/*+mapjoin(smalltable)*/
```

**2.大表Join大表**

把空值的key变成一个字符串加上随机数，把倾斜的数据分到不同的reduce上，由于null值关联不上，处理后并不影响最终结果。如下：

```sql
select * from log a 
left outer join users b 
on 
case when a.user_id is null 
then concat('hive',rand()) 
else a.user_id end = b.user_id;
```

小表不小不大，怎么用 map join 解决倾斜问题

> 在小表和大表进行join时，将小表放在前边，效率会高。hive会将小表进行缓存。

**Reduce 长尾**

`Count Distinct` 的执行原理是将需要去重的字段 以及 Group By 字段 联合作为 key将数据分发到 Reduce端。
因为 Distinct操作，数据无法在 Map 端的 Shuffle 阶段根据 Group By 先做一次聚合操作，以减少传输的数据量，而是将所有的数据都传输到 Reduce 端，当 key 的数据分发不均匀时，就会导致 Reduce 端长尾。

> 1. 对同一个表按照维度对不同的列进行 Count Distinct操作，造成 Map 端数据膨胀，从而使得下游的 Join 和 Reduce 出现链路上的 长尾。
> 2. Map 端直接做聚合时出现 key 值分布不均匀，造成 Reduce 端长尾。 .
> 3. 动态分区数过多时可能造成小文件过多，从而引起 Reduce 端长尾。 .
> 4. 多个 Distinct 同时出现在一段 SQL 代码时，数据会被分发多次， 会造成数据膨胀 N 倍，长尾现象放大 N 倍.


## 2. MapReduce

> (1) Map方法之后Reduce方法之前这段处理过程叫「Shuffle」
>
> (2) Map方法之后，数据首先进入到分区方法，把数据标记好分区，然后把数据发送到环形缓冲区；环形缓冲区默认大小100m，环形缓冲区达到80%时，进行溢写；溢写前对数据进行排序，排序按照对key的索引进行字典顺序排序，排序的手段「快排」；溢写产生大量溢写文件，需要对溢写文件进行「归并排序」；对溢写的文件也可以进行Combiner操作，前提是汇总操作，求平均值不行。最后将文件按照分区存储到磁盘，等待Reduce端拉取。
>
> 3）每个Reduce拉取Map端对应分区的数据。拉取数据后先存储到内存中，内存不够了，再存储到磁盘。拉取完所有数据后，采用归并排序将内存和磁盘中的数据都进行排序。在进入Reduce方法前，可以对数据进行分组操作。


No. | Hive 优化 | Flag
:---: | --- | :---:
1. | join 优化, order & customer - 先过滤在Join |
2. | union优化： （union 去掉重复的记录）而是使用 union all 然后在用group by 去重 |
5. | 消灭子查询内的 group by 、 COUNT(DISTINCT)，MAX，MIN。可以减少job的数量
6. | spark join 优化 - set hive.auto.convert.join=true; 小表自动判断，在内存  <br> &nbsp;&nbsp;Sort -Merge -Bucket Join  对大表连接大表的优化
7. | 数据倾斜 - SQL 导致 <br> 1. group by维度变得更细 2. 值为空的情况单独处理 3. 不同数据类型关联产生数据倾斜（int,string） <br><br> group by维度不能变得更细的时候,就可以在原分组key上添加随机数后分组聚合一次, 然后对结果去掉随机数后再分组聚合,在join时，有大量为null的join key，则可以将null转成随机值，避免聚集|
8. | 数据倾斜 - 业务数据本身导致 - 热点值和非热点值分别进行处理  |
9. | 数据倾斜 - key本身不均 - 可以在key上加随机数，或者增加reduceTask数量 |
10. | 合并小文件 - 小文件的产生有三个地方，map输入，map输出，reduce输出 |

```sql
WITH x AS (
    SELECT
        app,
        user_id,
        count( 1 ) AS rn 
    FROM
        table1 
    GROUP BY
        app,
        user_id 
    ) 

SELECT
    t.app,
    t.user_id 
FROM
    (
    SELECT
        app,
        user_id,
        row_number ( ) over ( PARTITION BY app ORDER BY rn DESC ) AS max_user 
    FROM
        x 
    ) AS t 
WHERE
    t.max_user <= 5
```

## 3. Spark

> (1). Data Skew 的原理很简单：在进行shuffle的时候，必须将各个节点上相同的key拉取到某个节点上的一个task来进行处理，比如按照key进行聚合或join等操作。此时如果某个key对应的数据量特别大的话，就会发生 Data Skew。
> 
> (2). Task 有2个非常慢

1. 不指定语言，写一个WordCount的MapReduce

> 1. lines = sc.textFile(...)
> 2. lines.flatMap(lambda x: x.split(' '))
> 3. wco = words.map(lambda x: (x, 1))
> 4. word_count = wco.reduceByKey(add)
> 5. word_count.collect()

```python
lines = sc.textFile("/Users/blair/ghome/github/spark3.0/pyspark/spark-src/word_count.text", 2)

lines = lines.filter(lambda x: 'New York' in x)
#lines.take(3)

words = lines.flatMap(lambda x: x.split(' '))

wco = words.map(lambda x: (x, 1))

#print(wco.take(5))

word_count = wco.reduceByKey(add)

word_count.collect()
```

2. 你能用SQL语句实现上述的MapReduce吗？

```sql
select id, count(*) from D group by id order by count(*) desc;
```

3. Spark提交你的jar包时所用的命令是什么？

```bash
spark-submit
```

4. 你所理解的Spark的shuffle过程？

> Shuffle是MapReduce框架中的一个特定的phase，介于Map phase和Reduce phase之间，当Map的输出结果要被Reduce使用时，输出结果需要按key哈希，并且分发到每一个Reducer上去，这个过程就是shuffle。由于shuffle涉及到了磁盘的读写和网络的传输，因此shuffle性能的高低直接影响到了整个程序的运行效率。

如果我有两个list，如何用Python语言取出这两个list中相同的元素？


```python
list(set(list1).intersection(set(list2)))
```

Spark有哪些聚合类的算子,我们应该尽量避免什么类型的算子？

> 在我们的开发过程中，能避免则尽可能避免使用reduceByKey、join、distinct、repartition等会进行shuffle的算子，尽量使用map类的非shuffle算子。这样的话，没有shuffle操作或者仅有较少shuffle操作的Spark作业，可以大大减少性能开销。

```bash
./bin/spark-submit \
  --master yarn
  --deploy-mode cluster
  --num-executors 100 \ # 总共申请的executor数目，普通任务十几个或者几十个足够了
  --executor-memory 6G \
  --executor-cores 4 \ # 每个executor内的核数，即每个executor中的任务task数目，此处设置为2
  --driver-memory 1G \ # driver内存大小，一般没有广播变量(broadcast)时，设置1~4g足够
  --conf spark.default.parallelism=1000 \    # 默认每个 satge 的 Task总数
 # Spark作业的默认为500~1000个比较合适,如果不设置，spark会根据底层HDFS的block数量设置task的数量，这样会导致并行度偏少，资源利用不充分。该参数设为num-executors * executor-cores的2~3倍比较合适
  --conf spark.storage.memoryFraction=0.5 \  存储内存
  --conf spark.shuffle.memoryFraction=0.3 \  执行内存 # shuffle过程中一个task拉取到上个stage的task的输出后，进行聚合操作时能够使用的Executor内存的比例，默认是0.2，如果shuffle聚合时使用的内存超出了这个20%的限制，多余数据会被溢写到磁盘文件中去，降低shuffle性能
 # 该参数代表了Executor内存中，分配给shuffle read task进行聚合操作的内存比例，默认是20%。
 #

 # —-spark.yarn.executor.memoryOverhead 1G ： executor执行的时候，用的内存可能会超过executor-memory，
 # 所以会为executor额外预留一部分内存，spark.yarn.executor.memoryOverhead即代表这部分内存
 # 默认的 spark.executor.memoryOverhead=6144（6G） 有点浪费
```

[spark-summary-3-trouble-shooting](http://localhost:5000/2021/01/21/spark/spark-summary-3-trouble-shooting/)

```bash
spark.sql.shuffle.partitions - 配置join或者聚合操作shuffle数据时分区的数量
spark.default.parallelism. - 该参数用于设置每个stage的默认task数量 , 设置该参数为num-executors * executor-cores的2~3倍较为合适
```

**spark sql多维分析优化——提高读取文件的并行度**, File (ROW Group - column chunk)

```bash
spark.sql.files.maxPartitionBytes 默认128MB，单个分区读取的最大文件大小
spark.sql.files.maxPartitionBytes 的值来降低 maxSplitBytes 的值

parquet.block.size
```

> parquet 文件的数据是以row group 存储，一个parquet 文件可能只含有一个row group，也有可能含有多个row group ，row group 的大小 主要由parquet.block.size 决定。
>
> 「Parquet是为了使Hadoop生态系统中的任何项目都可以使用压缩的，高效的列式数据表示形式」
> parquet.block size:默认值为134217728byte,即128MB,表示 Row Group在内存中的块大小。该值设置得大,可以提升 Parquet文件的读取效率,但是相应在写的时候需要耗费更多的内存
>
>「所以在实际生产中，使用Parquet存储，snappy/lzo压缩的方式更为常见，这种情况下可以避免由于读取不可分割大文件引发的数据倾斜。
>
>
> 读取hdfs文件并行了 22个 tasks


```bash
1. Cache 缓存

  1.1 spark.catalog.cacheTable(“t”) 或 df.cache()
             Spark SQL会把需要的列压缩后缓存，避免使用和GC的压力
  1.2 spark.sql.inMemoryColumnarStorage.compressed 默认true
  1.3 spark.sql.inMemoryColumnarStorage.batchSize 默认10000
             控制列缓存时的数量，避免OOM风险。
引申要点： 行式存储 & 列式存储 优缺点

2. 其他配置

  2.1 spark.sql.autoBroadcastJoinThreshold
  2.2 spark.sql.shuffle.partitions 默认200，配置join和agg的时候的分区数
  2.3 spark.sql.broadcastTimeout 默认300秒，广播join时广播等待的时间
  2.4 spark.sql.files.maxPartitionBytes 默认128MB，单个分区读取的最大文件大小
  2.5 spark.sql.files.openCostInBytes
parquet.block.size


3. 广播 hash join - BHJ
   3.1 当系统 spark.sql.autoBroadcastJoinThreshold 判断满足条件，会自动使用BHJ
```

Spark SQL 在 Spark Core 的基础上针对结构化数据处理进行很多优化和改进.

> Spark 只在启动 Executor 是启动一次 JVM，内存的 Task 操作是在线程复用的。每次启动 JVM 的时间可能就需要几秒甚至十几秒，那么当 Task 多了，这个时间 Hadoop 不知道比 Spark 慢了多。
>
> 如果对RDD进行cache操作后，数据在哪里？
>  
> 1. 执行cache算子时数据会被加载到各个Executor进程的内存.
> 2. 第二次使用 会直接从内存中读取而不会区磁盘.

华为云Stack全景图 > 开发者指南 > SQL和DataFrame调优 > Spark SQL join优化

> 1. 逻辑执行计划只是对SQL语句中以什么样的执行顺序做一个整体描述.
> 2. 物理执行计划包含具体什么操作. 例如：是BroadcastJoin、还是SortMergeJoin…
> 
> 聚合后cache
> 
> 默认情况下coalesce不会产生shuffle coalesce, repartition
>
> (1) 谓词下推 Predicate PushDown - SQL中的谓词主要有 like、between、is null、in、=、!=等
> (2) 列裁剪 Column Pruning 和 映射下推 Project PushDown - 列裁剪和映射下推的目的：过滤掉查询不需要使用到的列

## 4. hadoop, hive, spark

- [Hive中order by，sort by，distribute by，cluster by的区别](https://blog.csdn.net/lzm1340458776/article/details/43306115)

> order by会对输入做全局排序，因此只有一个Reducer
> sort by不是全局排序，其在数据进入reducer前完成排序
> 
> distribute by是控制在map端如何拆分数据给reduce端的, sort by为每个reduce产生一个排序文件

1 Hadoop和spark的主要区别
2 Hadoop中一个大文件进行排序，如何保证整体有序？sort只会保证单个节点的数据有序
3 Hive中有哪些udf
4 Hadoop中文件put get的过程详细描述
5 [Java中有哪些GC算法?](https://www.cnblogs.com/Tpf386/p/11210483.html) [1. 标记-清除算法 2. 复制算法 3. 标记-整理算法 4. 分代收集算法]
6 [Java中的弱引用 强引用和软引用分别在哪些场景中使用](https://blog.csdn.net/aitangyong/article/details/39453365)
7 Hadoop和spark的主要区别-这个问题基本都会问到

**(1). Hadoop和spark的主要区别**

> spark消除了冗余的 HDFS 读写: Hadoop 每次 shuffle 操作后，必须写到磁盘，而 Spark 在 shuffle 后不一定落盘，可以 cache 到内存中，以便迭代时使用。如果操作复杂，很多的 shufle 操作，那么 Hadoop 的读写 IO 时间会大大增加，也是 Hive 更慢的主要原因了。
> 
> spark消除了冗余的 MapReduce 阶段: Hadoop 的 shuffle 操作一定连着完整的 MapReduce 操作，冗余繁琐。而 Spark 基于 RDD 提供了丰富的算子操作，且 reduce 操作产生 shuffle 数据，可以缓存在内存中。
>
> JVM 的优化: Hadoop 每次 MapReduce 操作，启动一个 Task 便会启动一次 JVM，基于进程的操作。而 Spark 每次 MapReduce 操作是基于线程的，只在启动 Executor 是启动一次 JVM，内存的 Task 操作是在线程复用的。每次启动 JVM 的时间可能就需要几秒甚至十几秒，那么当 Task 多了，这个时间 Hadoop 不知道比 Spark 慢了多。

**(2). Hadoop中一个大文件进行排序，如何保证整体有序？**

> 一个文件有key值从1到10000的数据，我们用两个分区，将1到5000的key发送到partition1，然后由reduce1处理，5001到10000的key发动到partition2然后由reduce2处理，reduce1的key是按照1到5000的升序排序，reduce2的key是按照5001到10000的升序排序，这就保证了整个MapReduce程序的全局排序。
> 
> Hadoop 中的类 TotalOrderPartitioner

## 5. data warehouse

[知乎：如何建设数据仓库？](https://www.zhihu.com/question/19703294)
[华为：数据仓库、主题域、主题概念与定义](https://www.huaweicloud.com/articles/432adc9ebe5d354c6393a3490a005d10.html)

other:

[美团配送数据治理实践](https://tech.meituan.com/2020/03/12/delivery-data-governance.html)

[数仓大山哥 码龄10年](https://blog.csdn.net/panfelix)
[good 数仓大山哥 - Hive数据倾斜的原因及主要解决方法](https://blog.csdn.net/panfelix/article/details/107326899?spm=1001.2014.3001.5501)
[数仓大山哥 - Hive优化-大表join大表优化](https://blog.csdn.net/panfelix/article/details/107913560?spm=1001.2014.3001.5501)
[缓慢变化维 (Slowly Changing Dimension) 常见的三种类型及原型设计（转）](https://www.cnblogs.com/xqzt/p/4472005.html)

DWH 建模方法: **范式建模法/维度建模法/实体建模法**

这里面就涉及到了数据仓库的架构，简单来说数据仓库分为四个层次：

Layering | Desc
:---: | :--- 
ODS | 存放原始数据，直接加载原始日志、数据，数据保存原貌不做处理。
DWD | 结构与粒度原始表保持一致，对ODS层数据进行清洗
DWS | 以DWD为基础，进行轻度汇总 （少量以ODS为基础）
ADS | 为各种统计报表提供数据

> 注意: 数据仓库的架构当中，各个系统的元数据通过ETL同步到操作性数据仓库ODS中，对ODS数据进行面向主题域建模形成DW（数据仓库），DM是针对某一个业务领域建立模型，具体用户（决策层）查看DM生成的报表

> 最重要的是，要和业务以及产品负责人耐心沟通，认真敲定口径，比如观看人数的统计，就是要确定好哪些观众不算有效观众，观众和主播是同一人的等等细节，耐心是很重要的，需要格外注意的是，开发要学会要抛弃自己的专业知识，用最通俗的方式去解释，并且学会留下记录。
>
> 说了这么多，最最重要的，一定要做好规范维护，无论是用前端还是excel，及时更新是必须的。表的作用，设计理念，表字段的取数逻辑，口径的提供人，表结构都要记录在案，时常维护

数据质量 - 

1. 数据本身质量：数据开发对数据质量负责，保持对数据的敬畏心
2. 数据建设质量：可以从两方面来考量：易用性和丰富性；

Title | Desc
:--- | :--- 
指标体系 |  指标定义规范，目的是统一开发&产品对指标的定义。通过对原子指标的命名规则、派生指标的命名规则和派生词的定义来完成。
粒度  | 
维度 |

 1. 数据主题划分
 2. 数据分层
 3. 表 命名规范 - dwd_数据域_业务过程_(p全量/i增量) / dws_数据域_维度_统计周期
 4. ods dwd dws dim ads

评价体系：

 1. 数据安全
 2. 数据质量
 3. 开发效率
 4. 数据稳定
 5. 数据规范
 6. 数据建设

元数据管理:

 1. Excel 2. DDL 3. Airflow

Risk Dept

 1. 建立工单
 
## Reference

[大数据：元数据（Metadata）](https://www.cnblogs.com/volcao/p/13636557.html)
[数据治理之元数据管理](https://my.oschina.net/u/4631230/blog/4538578)
 
[数据仓库–数据分层（ETL、ODS、DW、APP、DIM）](https://www.codenong.com/cs107025192/)
[数仓--Theory--数仓命名规范](https://www.jianshu.com/p/10de9f7de648)
[有赞数据仓库元数据系统实践](https://tech.youzan.com/youzan-metadata/)
[【数据仓库】——数据仓库概念](https://www.cnblogs.com/jiangbei/p/8483591.html)
[Hive数据倾斜优化总结](https://monkeyip.github.io/2019/04/25/Hive%E6%95%B0%E6%8D%AE%E5%80%BE%E6%96%9C%E4%BC%98%E5%8C%96%E6%80%BB%E7%BB%93/)
[数据仓库–数据分层（ETL、ODS、DW、APP、DIM）](https://www.codenong.com/cs107025192/)
[网易严选数仓规范与评价体系](https://mp.weixin.qq.com/s/D_mqw4UO8H-ckE5ytfnglg)
[DE（开发）题(附答案)](https://cloud.tencent.com/developer/article/1061680)

[Spark系列--SparkSQL(三)执行SparkSQL查询](https://blog.csdn.net/u012834750/article/details/81164990?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_baidulandingword-0&spm=1001.2101.3001.4242)
