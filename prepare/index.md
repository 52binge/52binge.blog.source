## Pre

1. hashmap questions
 
> [HashMap面试指南](https://zhuanlan.zhihu.com/p/76735726)
> [HashMap常见面试题整理](https://www.cnblogs.com/zengcongcong/p/11295349.html)
> [shopee 后端面试题目](https://blog.csdn.net/gendlee1991/article/details/105759780)
 
2. What is the difference between optimistic and pessimistic locks?

> [你了解乐观锁和悲观锁吗？](https://www.cnblogs.com/kismetv/p/10787228.html)
>
> 1、CAS（Compare And Swap）
> 2、版本号机制
> 3、乐观锁加锁吗？
> 4、CAS有哪些缺点？

3. The coding test had 2 questions, were about heaps and double-ended queues.

```python
# from heapq import heappush, nsmallest, nlargest, ...
heap = []
for i in range(3):
    heappush(heap, i)
# heappop(heap)：弹出堆中最小的元素
# heapify(heap)：将列表转换为堆
# heapreplace(heap, x)：弹出堆中最小的元素，然后将新元素插入
# nlargest(n, iter)、nsmallest(n, iter)：用来寻找任何可迭代对象iter中的前n个最大的或前n个最小的元素

queue = collections.deque()
queue.append(5)
queue.appendleft(10)
cur = queue.popleft()
cur = queue.pop()
```
 
4. there was a question on writing an SQL query and command line applications.

> 在复习

5. General DWH concepts, Spark internals, mapreduce. They also had few questions on coding which were focused on data structures & algorithms. The interviewers look at how you're thought process.

6. Explain the map reduce paradigm.

> 在复习

7. several questions about database, sharding, RMDB vs NoSQL DB, Why distributed NoSQL DB cannot always support transaction? 
 
8. leetcode: solve a problem of top k problem in an online white board

```python
# return heapq.nsmallest(k, arr)

import heapq
class Solution:
    def smallestK(self, arr: List[int], k: int) -> List[int]:
        if k>len(arr) or k==0:
            return []
        heap = []
        for i in arr[:k]:
            heapq.heappush(heap, -i)
        for i in arr[k:]:
            if i < -heap[0]:
                heapq.heappop(heap)
                heapq.heappush(heap, -i)
        result = []
        for i in range(k):
            result.append(-heapq.heappop(heap))
        return result[::-1]
```

扩展: 

> 1). 692. 前K个高频单词
> 2). 347. 前 K 个高频元素
> 3). 215. Kth Largest Element in an Array
> 4). 面试题 17.14. 最小K个数 (排序)
 
9. Level traverse a binary tree in an online white board.

## question

- [Hive中order by，sort by，distribute by，cluster by的区别](https://blog.csdn.net/lzm1340458776/article/details/43306115)

> order by会对输入做全局排序，因此只有一个Reducer
> sort by不是全局排序，其在数据进入reducer前完成排序


## info

1. leetcode原题，遍历二叉树，然后股票最大利润，很简单
2. Move Zeroes 讲数组里的0移到末端（不能开辟额外空间） - 优化，达到logn，两个指针从前往后走
3. 网卡上数据如何流转
4. hashmap琏表转红黑树为什么是8
5. 快排归并手撕
6. sort by 和 order by 区别
7. 数据库相关
8. 虚拟内存
9. 手撕代码：topk小元素
10. LRU是什么，复杂度是多少
11. Java基础 + 项目经验
12. 多线程优化
13. MySQL数据库引擎
14. 事物隔离级别，如何处理幻读
15. Redis 数据过期策略
16. 如何实现LRU
17. k8s集群规模以及管理
18. code testing：回文串判断
19. 问了一嘴多线程咋实现的

[经验分享](https://www.aiwaner.cn/singapore-shopee.html)

## MySQL的存储引擎

因为面试前看了一篇关于B+数结构的文章，满脑子都是B+树，没答好，续多Innodb的特性都没答到

InnoDB是MySQL目前默认的存储引擎，底层使用了B+树作为数据结构，与MyiSAM不同的时，InnoDB属于聚集索引，主键和数据一起存储在B+树的叶子节点中，而MyiSAM的主键和数据是分开存储的，叶子节点中存储的是数据所在的地址。InnoDB和MyiSAM的区别：

存储方式：前者索引和数据共存于一个文件中；后者索引和数据分开存储
锁粒度：前者支持行锁（MVCC特性)；而后者仅支持到表锁
事务支持：前者支持事务；后者不支持事务
对于写多的场景，由于MyiSAM需要频繁的锁表，性能开销比InnoDB大得多
对于读多写少的场景，由于InnoDB每次操作都需要在事务中，MyiSAM的性能可能会比前者好

## [Sho技术](https://www.shuzhiduo.com/A/6pdDQVbKzw/)

1 用自己擅长的语言实现非递归单链表反转 现场手写
2 Hadoop和spark的主要区别
3 Hadoop中一个大文件进行排序，如何保证整体有序？sort只会保证单个节点的数据有序
4 Hive中有哪些udf
5 Hadoop中文件put get的过程详细描述
6 Java中有哪些GC算法
7 Java中的弱引用 强引用和软引用分别在哪些场景中使用


2 Hadoop和spark的主要区别-这个问题基本都会问到

记住3点最重要的不同之处：

spark消除了冗余的 HDFS 读写: Hadoop 每次 shuffle 操作后，必须写到磁盘，而 Spark 在 shuffle 后不一定落盘，可以 cache 到内存中，以便迭代时使用。如果操作复杂，很多的 shufle 操作，那么 Hadoop 的读写 IO 时间会大大增加，也是 Hive 更慢的主要原因了。
spark消除了冗余的 MapReduce 阶段: Hadoop 的 shuffle 操作一定连着完整的 MapReduce 操作，冗余繁琐。而 Spark 基于 RDD 提供了丰富的算子操作，且 reduce 操作产生 shuffle 数据，可以缓存在内存中。
JVM 的优化: Hadoop 每次 MapReduce 操作，启动一个 Task 便会启动一次 JVM，基于进程的操作。而 Spark 每次 MapReduce 操作是基于线程的，只在启动 Executor 是启动一次 JVM，内存的 Task 操作是在线程复用的。每次启动 JVM 的时间可能就需要几秒甚至十几秒，那么当 Task 多了，这个时间 Hadoop 不知道比 Spark 慢了多。

## 牛客

1. 手撕代码：两个字符串的最大公共子串
2. 请你找出其中不含有重复字符的最长子串的长度。
3. 405-数字转换为十六进制数
4. 二进制加法
5. 2个有序数组，维护中位数

### important

1. 二叉树层序遍历；
2. 找出数组里三个数相乘最大的那个（有正有负）
3. 进程和线程的区别
4. 虚拟内存是怎么调度的
5. HTTP和HTTPS的区别
6. 做题：两个十六进制数的加法
7. 大数据处理的一些技术细节（看看经验等），比如hive里的一些基本语法和数据倾斜的优化等

## 三次握手

TCP 的三次握手, 四次挥手:  TCP 协议是如何建立和释放连接的？

三次握手建立连接:


第一次握手：A给B打电话说，你可以听到我说话吗？（seq=x）
第二次握手：B收到了A的信息，然后对A说：我可以听得到你说话啊，你能听得到我说话吗？（ACK=x+1，seq=y）
第三次握手：A收到了B的信息，然后说可以的，我要给你发信息啦！（ack=y+1）


四次挥手释放连接:

A:喂，我不说了。(FIN)
B:我知道了。等下，上一句还没说完。Balabala…..（ACK）
B:好了，说完了，我也不说了。（FIN）
A:我知道了。(ACK)
A等待 2MSL,保证B收到了消息,否则重说一次我知道了。

## Reference

- [0086 shopee面试题汇总](https://blog.csdn.net/gendlee1991/article/details/105759780)
- [good - 新加坡Singapore Data infra 经验分享](https://www.aiwaner.cn/singapore-shopee.html)
- [一亩三分地 - Shopee新加坡面经](https://www.1point3acres.com/bbs/interview/shopee-data-engineer-591386.html)
- [2020 年 Shopee 秋招面经](https://leetcode-cn.com/circle/discuss/ej0oh6/view/oDT1B0/)
- [Shopee虾皮技术面](https://www.shuzhiduo.com/A/6pdDQVbKzw/)
- [操作系统虚拟内存调度方式（页式、段式、段页式）](https://blog.csdn.net/Bob__yuan/article/details/102584606)
- [数仓大法好！跨境电商 Shopee 的实时数仓之路](https://blog.csdn.net/qq_31975963/article/details/107662805)

other:

- [各大公司近期 data engineer 面经大全](https://1o24bbs.com/t/topic/4022)
- [求职面试分享 [2019.07.28]](https://www.chasedream.com/show.aspx?id=27223&cid=29)

