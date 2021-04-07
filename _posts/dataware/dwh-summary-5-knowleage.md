---
top: 8
title: Hive Optimization Solution Notes
toc: true
date: 2021-03-12 09:07:21
categories: [data-warehouse]
tags: [SQL]
---

<img src="/images/hadoop/hadoop-hive-logo-1.png" width="450" alt="Hadoop MapReduce" />

<!-- more -->

## Hive 优化

No. | Hive 优化 | Flag
:---: | --- | :---
1. | explain | explain [extended] query |
2. | Column cropping<br><br>列裁剪 | set hive.optimize.cp = true; # 列裁剪，取数只取查询中需要用的列，默认true
3. | 谓词下推<br><br>Predicate pushdown | set hive.optimize.ppd=true; # 默认是true<br><br>`select a.*, b.* from a join b on a.id = b.id where b.age > 20;`
4. | Partition crop <br> 分区裁剪 | set hive.optimize.pruner=true; # 默认是true
5. | Merge small files<br>合并小文件<br><br><br> Map input merge | 如果一个mapreduce job碰到一对小文件作为输入，一个小文件启动一个Task<br><br>**Map 输入合并:**<br><br># Map端输入、合并文件之后按照block的大小分割（默认）set <br> hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat;<br><br># Map端输入，不合并<br>set hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;<br><br>
5. | 合并小文件 <br><br><br><br> Map/Reduce输出合并 | 大量的小文件会给 HDFS 带来压力，影响处理效率.<br>可以通过合并 Map 和 Reduce 的结果文件来消除影响 <br><br> 是否合并Map输出文件, 默认值为true<br>set hive.merge.mapfiles=true;<br><br> 是否合并Reduce端输出文件,默认值为false<br>set hive.merge.mapredfiles=true;
6. | 设置MapTask并行度 | 1、减少 MapTask 数是通过合并小文件来实现，这一点主要是针对数据源<br>2、增加 MapTask 数可以通过控制上一个 job 的 reduceTask 个数<br><br>重点注意：不推荐把这个值进行随意设置！<br>推荐的方式：使用默认的切块大小即可。如果非要调整，最好是切块的N倍数<br><br> default_mapper_num = total_size / dfs_block_size <br><br> set mapred.map.tasks=10; # 默认值是2, 大于 default_mapper_num 才生效 <br><br>**总结一下控制 mapper 个数的方法**：<br>1. 如果想增加 MapTask 个数，可以设置 mapred.map.tasks 为一个较大的值<br>2. 如果想减少 MapTask 个数，可以设置 maperd.min.split.size 为一个较大的值<br>3. 如果输入是大量小文件，想减少 mapper 个数，可以通过设置 hive.input.format 合并小文件
7. | 设置ReduceTask并行度 | 可以通过改变上述两个参数的值来控制 ReduceTask 的数量. 也可以通过: <br><br> set mapred.map.tasks=10; <br> set mapreduce.job.reduces=10;
8. | Join优化 | 1. 优先过滤后再进行Join操作，最大限度的减少参与join的数据量<br>2. 小表join大表，最好启动mapjoin，hive自动启用mapjoin, 小表不能超过25M，可以更改<br>3. Join on的条件相同的话，最好放入同一个job，并且join表的排列顺序从小到大<br>4. 如果多张表做join, 如果多个链接条件都相同，会转换成一个Job<br><br>**大表Join大表** <br> 1. 空key过滤 <br>2. 空key转换
9. | 启用 MapJoin | 是否根据输入小表的大小，自动将reduce端的common join 转化为map join，将小表刷入内存中 <br> 对应逻辑优化器是MapJoinProcessor <br><br> ```set hive.auto.convert.join = true;```<br><br># 刷入内存表的大小(字节)<br>set hive.mapjoin.smalltable.filesize = 25000000;<br><br> # hive会基于表的size自动的将普通join转换成mapjoin <br> set hive.auto.convert.join.noconditionaltask=true;<br><br> # 多大的表可以自动触发放到内层LocalTask中，默认大小10M<br>set hive.auto.convert.join.noconditionaltask.size=10000000; <br><br> **也可以手动开启mapjoin**：
10. | <br><br>`Join数据倾斜优化` | # join的key对应的记录条数超过这个值则会进行分拆，值根据具体数据量设置<br>set `hive.skewjoin.key`=100000;<br><br># 如果是join过程出现倾斜应该设置为true<br>set `hive.optimize.skewjoin`=false;<br><br>通过 hive.skewjoin.mapjoin.map.tasks 参数还可以控制第二个 job 的 mapper 数量，默认10000<br>set hive.skewjoin.mapjoin.map.tasks=10000;
13. | Group By优化 | **1. Map端部分聚合** <br><br> # 开启Map端聚合参数设置 set hive.map.aggr=true;<br># 设置map端预聚合的行数阈值，超过该值就会分拆job，默认值100000<br>set hive.groupby.mapaggr.checkinterval=100000 <br><br> **2. 有数据倾斜时进行负载均衡**<br><br>当 HQL 语句使用 group by 时数据出现倾斜时，如果该变量设置为 true，那么 Hive 会自动进行负载均衡。<br>策略就是把 MapReduce 任务拆分成两个： 第1个先做预汇总，第2个再做最终汇总. <br><br> # 自动优化，有数据倾斜的时候进行负载均衡（默认是false） <br> set hive.groupby.skewindata=false;
15. | Count Distinct优化 | 优化后（启动2个job，1个job负责子查询(可有多个reduce)，另1个job负责count(1)): <br> `select count(1) from (select id from tablename group by id) tmp;` 
16. | 怎样写in/exists语句 | -- in / exists 实现 <br>`select a.id, a.name from a where a.id in (select b.id from b);`<br><br>是推荐使用 Hive 的一个高效替代方案：left semi join<br>`select a.id, a.name from a left semi join b on a.id = b.id;`

**手动开启mapjoin：**

```sql
--SQL方式，在SQL语句中添加MapJoin标记（mapjoin hint）
--将小表放到内存中，省去shffle操作
// 在没有开启mapjoin的情况下，执行的是reduceJoin
SELECT /*+ MAPJOIN(smallTable) */ smallTable.key, bigTable.value FROM
smallTable JOIN bigTable ON smallTable.key = bigTable.key;
/*+mapjoin(smalltable)*/
```

No. | Hive 优化 | Flag
:---: | --- | :---:
1. | join 优化, order & customer - 先过滤在Join |
2. | union优化： （union 去掉重复的记录）而是使用 union all 然后在用group by 去重 |
3. | count distinct优化, 使用子查询 |
4. | 用in 来代替join |
5. | 消灭子查询内的 group by 、 COUNT(DISTINCT)，MAX，MIN。可以减少job的数量
6. | join 优化 - set hive.auto.convert.join=true; 小表自动判断，在内存  <br> &nbsp;&nbsp;Sort -Merge -Bucket Join  对大表连接大表的优化
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

[再次分享！Hive调优，数据工程师成神之路](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247493676&idx=1&sn=1658835f7c595cce105022e70640e020&chksm=cf37da21f8405337445ce6d8edbe4640b1a6dbd7903dfd6ac7cd2edbd83394a372bd2e3b9997&scene=21#wechat_redirect)

进程 启动慢 vs 线程 级别
MR中间结果只能存磁盘HDFS, Spark 中间结果可以缓存
Map方法之后Reduce方法之前这段处理过程叫「Shuffle」

> (1). Data Skew 的原理很简单：在进行shuffle的时候，必须将各个节点上相同的key拉取到某个节点上的一个task来进行处理，比如按照key进行聚合或join等操作。此时如果某个key对应的数据量特别大的话，就会发生 Data Skew。
> 
> (2). Task 有2个非常慢

Hive

(1). Count Distinct 改为 Group by
(2). 在小表和大表进行join时，将小表放在前边，效率会高。hive会将小表进行缓存。

2、mapjoin

使用mapjoin将小表放入内存，在map端和大表逐一匹配。从而省去reduce。

样例：

```sql
select /*+MAPJOIN(b)*/ a.a1,a.a2,b.b2 from tablea a JOIN tableb b ON a.a1=b.b1
```

缓存多张小表：

```sql
select /*+MAPJOIN(b,c)*/ a.a1,a.a2,b.b2 from tablea a JOIN tableb b ON a.a1=b.b1 JOIN tbalec c on a.a1=c.c1
```

Hive0.11版本之后：
hive.auto.convert.join=True
hive.mapjoin.smalltable.filesize
默认值为2500000(25M),通过配置该属性来确定使用该优化的表的大小，如果表的大小小于此值就会被加载进内存中

注意：使用默认启动该优化的方式如果出现默名奇妙的BUG(比如MAPJOIN并不起作用),就将以下两个属性置为fase手动使用MAPJOIN标记来启动该优化

hive.auto.convert.join=false(关闭自动MAPJOIN转换操作)
hive.ignore.mapjoin.hint=false(不忽略MAPJOIN标记)

原文链接：https://blog.csdn.net/u012036736/article/details/84978689

**2.1 参数调节**

```bash
set hive.map.aggr = true # 在map中会做部分聚集操作，效率更高但需要更多的内存。
set hive.groupby.skewindata = true 
# 数据倾斜的时候进行负载均衡，查询计划生成两个MR job
#
# 第一个job先进行key随机分配处理，随机分布到Reduce中，每个Reduce做部分聚合操作，先缩小数据量。
# 第二个job再进行真正的group by key处理，根据预处理的数据结果按照Group By Key分布到Reduce中（这个过程可以保证相同的Key被分布到同一个Reduce中）
# 完成最终的聚合操作。

set hive.merge.mapfiles=true # 当出现小文件过多，需要合并小文件

set hive.exec.reducers.bytes.per.reducer=1000000000 （单位是字节） 
# 每个reduce能够处理的数据量大小，默认是1G。

hive.exec.reducers.max=999 
# 最大可以开启的reduce个数，默认是999个。在只配了hive.exec.reducers.bytes.per.reducer以及hive.exec.reducers.max的情况下，实际的reduce个数会根据实际的数据总量/每个reduce处理的数据量来决定。

set mapred.reduce.tasks=-1 
# 实际运行的reduce个数，默认是-1，可以认为指定，但是如果认为在此指定了，那么就不会通过实际的总数据量hive.exec.reducers.bytes.per.reducer来决定reduce的个数了。
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

6.小表不小不大，怎么用 map join 解决倾斜问题

> 在小表和大表进行join时，将小表放在前边，效率会高。hive会将小表进行缓存。

**Reduce 长尾**

`Count Distinct` 的执行原理是将需要去重的宇段 以及 GroupBy宇段联合作为 key将数据分发到 Reduce端。
因为 Distinct操作，数据无法在 Map 端的 Shuffle 阶段根据 Group By 先做一次聚合操作，以减少传输的数据量，而是将所有的数据都传输到 Reduce 端，当 key 的数据分发不均匀时，就会导致 Reduce 端长尾。

> 1. 对同一个表按照维度对不同的列进行 Count Distinct操作，造成 Map 端数据膨胀，从而使得下游的 Join 和 Reduce 出现链路上的 长尾。
> 2. Map 端直接做聚合时出现 key 值分布不均匀，造成 Reduce 端长尾。 .
> 3. 动态分区数过多时可能造成小文件过多，从而引起 Reduce 端长尾。 .
> 4. 多个 Distinct 同时出现在一段 SQL 代码时，数据会被分发多次， 会造成数据膨胀 N 倍，长尾现象放大 N 倍.

**MapReduce**

> (1) Map方法之后Reduce方法之前这段处理过程叫「Shuffle」
>
> (2) Map方法之后，数据首先进入到分区方法，把数据标记好分区，然后把数据发送到环形缓冲区；环形缓冲区默认大小100m，环形缓冲区达到80%时，进行溢写；溢写前对数据进行排序，排序按照对key的索引进行字典顺序排序，排序的手段「快排」；溢写产生大量溢写文件，需要对溢写文件进行「归并排序」；对溢写的文件也可以进行Combiner操作，前提是汇总操作，求平均值不行。最后将文件按照分区存储到磁盘，等待Reduce端拉取。
>
> 3）每个Reduce拉取Map端对应分区的数据。拉取数据后先存储到内存中，内存不够了，再存储到磁盘。拉取完所有数据后，采用归并排序将内存和磁盘中的数据都进行排序。在进入Reduce方法前，可以对数据进行分组操作。

---

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