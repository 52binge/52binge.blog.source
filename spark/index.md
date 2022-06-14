---
title: Business intelligence
date: 2022-04-23 00:20:48
music:
  server: netease   # netease, tencent, kugou, xiami, baidu
  type: song        # song, playlist, album, search, artist
  id: 17423740      # song id / playlist id / album id / search keyword
  autoplay: true
valine:
  placeholder: 有什么想对我说的呢？
---

Diligence is not a race against time, but **continuous**, dripping water wears through the rock. 

Plan | Time | Topic | Level2
:---: | --- | --- | ---
**2022.06** | | | 
1. | 7:00~7:30 | HIMYM EP02 | 
2. | 7:30~8:20 | [2021 leetcode](/2021/03/19/leetcode/2021-leetcode/) |  2.1 binary-search <br> 2.2 dfs + stack <br> 2.3 dynamic programming <br> 2.4 sliding window & hash 
3. | 8:30~9:30 | spark basic | 3.1 mr vs spark (4) <br> 3.2 rdd / dataframe / dataset <br> 3.3 rdd operations - transformation + action <br> 3.4 cache + persist <br> 3.5 spark join 
**2022.07** | | | 
1. | 7:30~8:20 | sql window |  
2. | 8:30~9:30 | project / spark |  
3. | 8:30~9:30 | flink |  

> 1. [Spark面试整理 hdc520 大全好总结](https://www.cnblogs.com/hdc520/p/12588379.html) 2. [2021 Leetcode all](/lc/) / [2021 Leetcode](/2021/03/19/leetcode/2021-leetcode/) 3. [SQL](/categories/sql/)

<p style="font-style:italic;color:cornflowerblue;">小舟從此逝 江海寄餘生🧘 is inputting <img src=/images/tw/main-progress-blue-dot.gif style="box-shadow:none; margin:0;height:16px">
</p>

> `2022.05.27`: review: **spark vs MR**   [Spark面试整理 hdc520 大全好总结](https://www.cnblogs.com/hdc520/p/12588379.html)
>
> 1. DAG计算模型. spark遇到 wide dependency 才会出现shuffer，而hadoop每次MapReduce都会有一次shuffer；
> 2. MapReduce 每次shuffle 操作后，必须写到磁盘, 而spark可以 cache/persist.   RDD在每次transformation后并不立即执行，而且action后才执行，有进一步减少了I/O操作。
> 3. MR它必须等map输出的所有数据都写入本地磁盘文件以后，才能启动reduce操作
> 4. spark 利用多线程来执行具体的任务（Hadoop MapReduce采用的是进程模型），减少任务的启动和切换开销；
>
> **spark的RDD与DataFrame以及Dataset的区别**
> **（1）RDD特点**
> 　　１）弹性：RDD的每个分区在spark节点上存储时默认是放在内存中的，若内存存储不下，则存储在磁盘中。
> 　　２）分布性：每个RDD中的数据可以处在不同的分区中，而分区可以处在不同的节点中． 
> 　　３）容错性：当一个RDD出现故障时，可以根据RDD之间的依赖关系来重新计算出发生故障的RDD.
> 
> **2、spark的算子**
> （1）transform算子：map转换算子，filter筛选算子，flatmap，groupByKey，reduceByKey，sortByKey，join，cogroup，combinerByKey。
> （2）action算子：reduce，collect，count，take，aggregate，countByKey。
> 
> **(2.5) coalesce与repartition的区别**
>　　1）coalesce 与 repartition 都是对RDD进行重新划分，repartition只是coalesce接口中参数shuffle为true的实现。
>　　2）若coalesce中shuffle为false时，传入的参数大于现有的分区数目，RDD的分区数不变，也就是说不经过shuffle，是无法将RDD的分区数变多的。
>　　3）若存在过多的小任务的时候，可以通过coalesce方法，收缩合并分区，减少分区的个数，减小任务调度成本，尽量避免shuffle，这样会比repartition效率高。
>
>**(2.6) reduceByKey与groupByKey的区别：**
>　　pairRdd.reduceByKey(_+_).collect.foreach(println)等价于pairRdd.groupByKey().map(t => (t._1,t._2.sum)).collect.foreach(println)
>　　reduceByKey的结果：（hello,2）(world,3) groupByKey的结果：（hello,(1,1)）（world,(1,1,1)）
>　　使用reduceByKey()的时候，会对同一个Key所对应的value进行本地聚合，然后再传输到不同节点的节点。而使用groupByKey()的时候，并不进行本地的本地聚合，而是将全部数据传输到不同节点再进行合并，groupByKey()传输速度明显慢于reduceByKey()。虽然groupByKey().map(func)也能实现reduceByKey(func)功能，但是，优先使用reduceByKey(func)．
>
>**(2.7) spark的cache和persist的区别：**
>　　1）计算流程DAG特别长,服务器需要将整个DAG计算完成得出结果，若计算流程中突然中间算出的数据丢失了,spark又会根据RDD的依赖关系重新计算，这样会浪费时间，为避免浪费时间可以将中间的计算结果通过cache或者persist放到内存或者磁盘中
>　　2）cache最终调用了persist方法，默认的存储级别仅是存储内存中的；persist是最根本的底层函数，有多个存储级别，executor执行时，60%用来缓存RDD，40%用来存放数据．
>
>**九、spark如何分区：**
>
>　　分区是RDD内部并行计算的一个计算单元，RDD的数据集在逻辑上被划分为多个分片，每一个分片称为分区，分区的个数决定了并行计算的粒度，而每个分区的数值计算都是在一个任务中进行的，因此任务的个数，也是由RDD(准确来说是作业最后一个RDD)的分区数决定。spark默认分区方式是HashPartitioner．只有Key-Value类型的RDD才有分区的，非Key-Value类型的RDD分区的值是None，每个RDD的分区ID范围：0~numPartitions-1，决定这个值是属于那个分区的。

> `2022.05.24`  **DFS / Stack**
>  2.1 字符串解码 “3[a2[c]]” == “accacc”, stack == [(3, ""), (2,"a")]
>
>  [215. 数组中的第K个最大元素](https://leetcode-cn.com/problems/kth-largest-element-in-an-array/)  from heapq import heapify, heappush, heappop 
>  python中的heap是小根堆:  heapify(hp) , heappop(hp), heappush(hp, v) 
>
> `2022.05.22`  **binary-search**
>  1.1 二分查找, while l <= r  1.2 two_sum (easy hash) 1.3 [3sum](https://leetcode.cn/problems/3sum/),(first, second, third)
>  1.4 [34. 在排序数组中查找元素的第一个和最后一个位置](https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/)

> `2022.05.21` full outer join相对来说要复杂一点，full outer join仅采用sort merge join实现，左边和右表既要作为streamIter，又要作为buildIter
> {% image "/images/spark/spark-full-outer-join.png", width="600px", alt="" %}

> `2022.05.20` 
> 1.1 [Spark处理数据比Hive快的原因](https://book.itheima.net/study/1269935677353533441/1270196659166420993/1270200848609222657)
>
> 总结： Spark比Mapreduce运行更快 - Spark在计算模型和调度上比MR做了更多的优化，不需要过多地和磁盘交互。以及对JVM使用的优化。
>   (1) `消除了冗余的HDFS读写` （不需要过多地和磁盘交互）
>   (2) `消除了冗余的MapReduce阶段` 
>   (3) `JVM的优化` [MapReduce操作，启个Task便启次JVM，进程的操作。Spark 线程]
>
> [4点答案在这里 最佳Answer](https://www.cnblogs.com/hdc520/p/12588379.html)
> 
> 1.2 [reduceByKey vs groupByKey](https://blog.csdn.net/zongzhiyuan/article/details/49965021)
> 在spark中，我们知道一切的操作都是基于RDD的。在使用中，RDD有一种非常特殊也是非常实用的format——pair RDD，即RDD的每一行是（key, value）的格式。这种格式很像Python的字典类型，便于针对key进行一些处理。
针对pair RDD这样的特殊形式，spark中定义了许多方便的操作，今天主要介绍一下reduceByKey和groupByKey，
>
> groupByKey 当采用groupByKey时，由于它不接收函数，spark只能先将所有的键值对(key-value pair)都移动，这样的后果是集群节点之间的开销很大，导致传输延时
>
> ```python
> lines = sc.textFile("/Users/blair/ghome/github/spark3.0/pyspark/spark-src/word_count.text", 2)
>
lines = lines.filter(lambda x: 'New York' in x)
#lines.take(3)

words = lines.flatMap(lambda x: x.split(' '))

wco = words.map(lambda x: (x, 1))

#print(wco.take(5))
from operator import add
word_count = wco.reduceByKey(add)

word_count.collect()
```

> `2022.05.19` English My Job 
> {% image "/images/bi/interview-consecutive-login-sql01.jpg", width="650px", alt="" %}
> [2021 blair Notes](/2021/01/09/bi/dwh-summary-2-interview/) / [2020 Interview Questions - Data Warehouse](https://jishuin.proginn.com/p/763bfbd32925)  
> ```sql
-- 1. how to 连续 
select 
  user_id, count(1) cnt
from
  (
    select 
      user_id, 
      login_date, 
      row_number() over(partition by user_id order by login_date) as rn
    from tmp.tmp_last_3_day
  ) t
group by user_id, date_sub(login_date, t.rn)
having count(1) >= 3;
```

> `2022.05.18` shuffle形式有几种？都做哪些优化 & English BBC - <如果在相遇,我会记得你> the good old songs
>
> [spark基础之shuffle机制、原理分析及Shuffle的优化（很好很详细)](https://blog.csdn.net/BigData_Mining/article/details/82622502)
> Shuffle就是对数据进行重组，由于分布式计算的特性和要求，在实现细节上更加繁琐和复杂
> 1. HashShuffle（<=spark1.6,会产生很多小文件, Writer费内存易GC）
> 2. Sort-Based Shuffle (有多重model，不展开)
>  {% image "/images/spark/spark-shuffle-maptask.png", width="650px", alt="" %}
> Transformation 操作如:repartition，join，cogroup，以及任何 *By 或者 *ByKey 的 Transformation 都需要 shuffle 数据9,合理的选用操作将降低 shuffle 操作的成本,提高运算速度


> `2022.05.17` SparkSQL Join & English BBC - 诸事不顺的一天 The English we We Speak 
>
> 1. join 实现有几种呢，源码有研究过吗？ 底层是怎么实现的
>
> [面试必知的Spark SQL几种Join实现 - (streamIter为大表，buildIter为小表)](https://www.51cto.com/article/626552.html)
> sort merge join / broadcast join / hash join


### Spark 精品

[Spark会把数据都载入到内存么？](https://www.jianshu.com/p/b70fe63a77a8)

> Shuffle不过是偷偷的帮你加上了个类似saveAsLocalDiskFile的动作。然而，写磁盘是一个高昂的动作。所以我们尽可能的把数据先放到内存，再批量写到文件里，还有读磁盘文件也是给费内存的动作。
>
> **Cache/Persist意味着什么？**
> 
> 其实就是给某个Stage加上了一个saveAsMemoryBlockFile的动作, Spark允许你把中间结果放内存里.

[Author 知乎](https://www.zhihu.com/people/allwefantasy/posts)

[萝卜姐: Is the ByteDance interview difficult and how should you deal with it?](https://www.zhihu.com/question/339135205/answer/1178925849)

### 1. skill dismantling

> 1.1 底层原理，源码理解。
> 1.2 项目相关，难点，仓库建模
> 1.3 show **sql**

**spark和hive**：

3. 是通过什么管理shuffle中的内存，磁盘 的

4. 讲讲谓词下推？

5. full outer join原理

6. spark为什么比hive快

7. 讲讲sparksql优化

8. 讲讲RDD, DAG, Stage

9. 说说groupByKey, reduceByKey

10. spark是怎么读取文件,分片的？
11. 有没有遇到过spark读取文件，有一些task空跑的现象？
12. 窗口函数中 几个rank函数有啥不同（spark、hive中窗口函数实现原理复盘 Hive sql窗口函数源码分析 sparksql比hivesql优化的点（窗口函数））parquet文件和orc文件有啥不同mr shuffle 是什么样子？具体原理是什么？跟spark有什么不同？讲讲hive sql优化hive 数据倾斜参数原理讲讲spark内存模型？（从一个sql任务理解spark内存模型 ）

**2. Show SQL**

> 就会问还有没有更优化的方式？
> 窗口函数，groupingsets cube这些 都会用到。有好多是计算滑动的那种
> 这个sql 在hive中起几个job，为什么是这么几个job？

3. Be confident and positive

4. Interview tips (overcoming nervousness)

5. last last last last

## 1. Spark Summary

- [1.1 Spark Summary 1 - Basic knowledge](/2020/10/31/spark/spark-summary-1-basic-questions/)

- [1.2 Spark - troubleshooting](/2021/01/21/spark/spark-summary-3-trouble-shooting/)

- [1.3 [转] Spark 多个Stage执行是串行执行的么？](https://www.jianshu.com/p/5fe79b67ea00)

- [1.4 [转] Spark宽依赖和窄依赖深度剖析](https://www.jianshu.com/p/736a4e628f0f)

{% image "/images/spark/spark-summary-1.3-stage-rdd-partition-join.webp", width="600px", alt="Spark Stages" %}

> DataFrame是spark1.3.0版本提出来的
> DataSet是spark1.6.0版本提出来的
> 但在 spark2.0 版本中，DataFrame和DataSet合并为DataSet.

## 2. SparkSQL

- [2.1 SparkSQL 底层实现原理](/2020/10/17/spark/sparkSQL-all-knowleage/)

- [2.2 SparkSQL 从入门到调优](/2021/02/03/spark/spark-summary-5-sql-optimization-indoor/)

- [2.3 Spark SQL几种Join实现](/2020/09/26/spark/spark-sql-join-core/)

- [2.4 SparkSQL Multidimensional Analysis - Group by](/2021/02/10/spark/spark-summary-6-sql-optimization-cube-group-by/)

## 3. Spark Basic

- [3.1 Spark Introduce 1](/2016/06/29/spark/spark-review-1-introduce/)

- [3.2 Spark Intrduce 2 - RDD](/2020/07/07/spark/spark-review-2/)

- [3.3 Spark 核心概念详述 2.2](/2020/07/21/spark/spark-aura-2.2-core-introduce/)

- [3.4 Spark Core 中的 RDD 详解 3.1](/2020/07/23/spark/spark-aura-3.1-RDD-detail/)

- [3.5 spark 基础概念复习 3.2](/2020/07/27/spark/spark-aura-3.2-spark-basic-summary/)

- [3.6 Spark Task-Commit 流程解析 4.2](/2020/07/29/spark/spark-aura-4.2-task-commit/)

- [3.7 SparkCore 中的工作原理 - 任务执行流程 5.1](/2020/07/31/spark/spark-aura-5.1-sparkCore/)

- [3.8 Spark Shuffle Optimize 10 items](/2020/08/12/spark/spark-ma-public-shuffle-optimization/)

- [3.9 SparkSql - 结构化数据处理 (下)](/2020/08/28/spark/spark-aura-9.2-SparkSql/)

- [3.10 Spark Chap 7 内存模型和资源调优](/2020/10/19/spark/spark-aura-7.1-memory/)

- [3.11 Spark Practice](/2021/01/06/spark/python-spark-practice/)

- [3.12 Spark - Data Skew Advanced](/2021/01/27/spark/spark-summary-4-data-skew/)

## 4. Spark Review

- [4.1 Spark Tutorials 1 - Introduce、Ecosysm、Features、Shell Commands](/2020/09/19/spark/Spark-Tutorials-Part1/)

- [4.2 Spark Tutorials 2 - SparkContext、Stage、Executor、RDD](/2020/09/19/spark/Spark-Tutorials-Part2/)

- [4.3 Spark Tutorials 3 - RDD](/2020/09/25/spark/Spark-Tutorials-Part3/)

## 5. Spark Interview

- [5.1 RDD、DataFrame和DataSet的区别](/2021/01/03/spark/spark-rdd-ds-df/)

```python
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    def isBalanced(self, root: TreeNode) -> bool:
        def maxHigh(root):
            if root == None:
                return 0
            return max(maxHigh(root.left), maxHigh(root.right)) + 1

        if root == None:
            return True
        return abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 and self.isBalanced(root.left) and self.isBalanced(root.right)
```
