## 0. Glassdoor

No. | Question | Flag
:---: | --- | :---:
1. | hashmap questions <br> hashmap琏表转红黑树为什么是8 | [HashMap面试指南](https://zhuanlan.zhihu.com/p/76735726) <br> [HashMap面试题整理](https://www.cnblogs.com/zengcongcong/p/11295349.html) <br> [shopee 后端面试题目](https://blog.csdn.net/gendlee1991/article/details/105759780)
2. | What is the difference between optimistic and pessimistic locks? |

> 数据库锁机制（乐观锁和悲观锁、表锁和行锁）
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
5. General DWH concepts, Spark internals, mapreduce. They also had few questions on coding which were focused on data structures & algorithms. The interviewers look at how you're thought process.

6. Explain the map reduce paradigm.

> Hadoop 是能对大量数据进行分布式处理的软件框架
> 
> 包括 Hdfs，MapReduce，Yarn

**Spark:** [RDD计算时是把数据全部加载至内存么?](https://blog.csdn.net/zc19921215/article/details/82858585)

[good - 博客园 Spark Shuffle](https://www.cnblogs.com/xiashiwendao/p/12210944.html)

Shuffle的本质: 

> Stage是以shuffle作为分界的! Shuffle不过是偷偷的帮你加上了个类似saveAsLocalDiskFile的动作。
> 
> **如果是M/R的话:**
> 
> 每个Stage其实就是上面说的那样，一套数据被N个嵌套的函数处理(也就是你的transform动作)。遇到了Shuffle,就被切开来。Shuffle本质上是把数据按规则临时都落到磁盘上，相当于完成了一个saveAsTextFile的动作，不过是存本地磁盘。然后被切开的下一个Stage则以本地磁盘的这些数据作为数据源，重走上面的流程。

7. several questions about database, sharding, RMDB vs NoSQL DB, Why distributed NoSQL DB cannot always support transaction? 

> TiDB, 也是可以支持事务的，只是开销非常大
 
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

```python
q = deque()
q.append(), q.popleft()
while q:
    pass
list(res.values())
```

## 1. Operating System

No. | Question | Flag
:---: | --- | :---:
1. | 进程切换说一下 进程切换具体哪些资源？ |
2. | Linux的Kill命令（-9信号的作用）|
3. | 进程切换和线程切换：<br> 进程切换：<br>① 切换页目录以使用新地址空间；<br>② 切换内核栈和硬件上下文； <br> 线程切换不用切地址空间，也就是不用做① <br><br>上下文切换通过OS内核完成，性能损耗主要来源于<br>① 寄存器内容切出切入；<br>② 切换后CPU原本的缓存作废，TLB（页表缓冲）等都被刷新，导致一段时间的内存访问十分低效（线程切换没有这个问题） |

**进程性能 与 系统性能**

> cpu：top, 内存：free, 带宽：netstat, strace
> 内核时间 vs 用户时间， 库时间 vs 应用程序时间， 细分应用程序时间 gprof vs oprofile
> 
> gprof用于分析函数调用耗时，可用之抓出最耗时的函数，以便优化程序
> 
> gprof是GNU profile工具，可以运行于linux、AIX、Sun等操作系统进行C、C++、Pascal、Fortran程序的性能分析

## 2. Database

No. | Question | Flag
:---: | --- | :---:
10. | 事务的特性有哪些 并分别解释 |
11. | MySQL隔离级别有哪些? <br> MySQL默认的隔离级别 -> 可重复读 => 可幻读吗 |
12. | 如何解决哈希冲突 （拉链法，线性探测法…拓展巴拉巴拉） |
13. | SQL的索引采用什么数据结构？（B+树） |
7. | 数据库相关 |
15. | Redis 数据过期策略 |

**MySQL的存储引擎：**

因为面试前看了一篇关于B+数结构的文章，满脑子都是B+树，没答好，续多Innodb的特性都没答到

InnoDB是MySQL目前默认的存储引擎，底层使用了B+树作为数据结构，与MyiSAM不同的时，InnoDB属于聚集索引，主键和数据一起存储在B+树的叶子节点中，而MyiSAM的主键和数据是分开存储的，叶子节点中存储的是数据所在的地址。InnoDB和MyiSAM的区别：

存储方式：前者索引和数据共存于一个文件中；后者索引和数据分开存储
锁粒度：前者支持行锁（MVCC特性)；而后者仅支持到表锁
事务支持：前者支持事务；后者不支持事务
对于写多的场景，由于MyiSAM需要频繁的锁表，性能开销比InnoDB大得多
对于读多写少的场景，由于InnoDB每次操作都需要在事务中，MyiSAM的性能可能会比前者好

## 3. Leetcode

No. | Question | Flag
:---: | --- | :---:
1. | 股票最大利润 cost, profit = float("+inf"), 0 | ❎
2. | Move Zeroes for i in range(len(nums)): | ❎
3. | 二叉树层序遍历； | ❎
4. | 删除排序链表中的重复元素 II， dummyHead = ListNode(0), dummyHead.next = head | ❎
5. | 如何实现LRU |
6. | 回文串判断 |
7. | 判断二叉树是否对称 |
8. | 如何判断一个二叉树是否是二叉搜索树 |
7. | 找出数组里三个数相乘最大的那个（有正有负） |
8. | 做题：两个十六进制数的加法 |
9. | [93. 复原IP地址](https://leetcode-cn.com/problems/restore-ip-addresses/) |
10. | [202. 快乐数](https://leetcode-cn.com/problems/happy-number/) |
11. | 快排归并手撕 |
14. | 手撕代码：两个字符串的最大公共子串
15. | 请你找出其中不含有重复字符的最长子串的长度。
16. | 405-数字转换为十六进制数
17. | 二进制加法
18. | 2个有序数组，维护中位数
19. | 算法：判断是不是平衡二叉树
20. | [155. 最小栈](https://leetcode-cn.com/problems/min-stack/) |
21. | 大文件找出排名前1000的数据 |
22. | 1000个数据，查找出现次数最多的k个数字 |
23. | 非递归单链表反转 现场手写

[经验分享](https://www.aiwaner.cn/singapore-shopee.html)

**Operating System**

1. [进程与线程的区别](https://blog.csdn.net/mxsgoden/article/details/8821936)

> 1. 进程是操作系统分配资源的单位
> 2. 线程(Thread)是进程的一个实体，是CPU调度和分派的基本单位
> 
> 线程和进程的关系是：线程是属于进程的，线程运行在进程空间内，同一进程所产生的线程共享同一内存空间，当进程退出时该进程所产生的线程都会被强制退出并清除。线程可与属于同一进程的其它线程共享进程所拥有的全部资源，但是其本身基本上不拥有系统资源，只拥有一点在运行中必不可少的信息(如程序计数器、一组寄存器和栈)。

2. 虚拟内存是怎么调度的?

> [github OS笔记](https://github.com/blair101/language/blob/master/offer/bishimianshi-20141001.cpp)
> [虚拟内存调度方式（页式、段式、段页式）](https://blog.csdn.net/Bob__yuan/article/details/102584606)
> [怎样通俗的理解操作系统中内存管理分页和分段？](https://www.zhihu.com/question/50796850)
>
> 分页方式的优点是页长固定，因而便于构造页表、易于管理，且不存在外碎片。但分页方式的缺点是页长与程序的逻辑大小不相关。

3. LRU 是什么? 复杂度?

> Cache & 页面置换

4. [HTTP与HTTPS的区别](https://www.cnblogs.com/klb561/p/10289199.html) ?

> 为了数据传输的安全，HTTPS在HTTP的基础上加入了SSL协议，SSL依靠证书来验证服务器的身份，并为浏览器和服务器之间的通信加密。
> 
> HTTPS协议的主要作用可以分为两种：一种是建立一个信息安全通道，来保证数据传输的安全；另一种就是确认网站的真实性。

## 4. hadoop, hive

- [Hive中order by，sort by，distribute by，cluster by的区别](https://blog.csdn.net/lzm1340458776/article/details/43306115)

> order by会对输入做全局排序，因此只有一个Reducer
> sort by不是全局排序，其在数据进入reducer前完成排序
> 
> distribute by是控制在map端如何拆分数据给reduce端的, sort by为每个reduce产生一个排序文件


## 5. [Shopee大数据](https://www.shuzhiduo.com/A/6pdDQVbKzw/)

1 Hadoop和spark的主要区别
2 Hadoop中一个大文件进行排序，如何保证整体有序？sort只会保证单个节点的数据有序
3 Hive中有哪些udf
4 Hadoop中文件put get的过程详细描述
5 Java中有哪些GC算法
6 Java中的弱引用 强引用和软引用分别在哪些场景中使用
7 Hadoop和spark的主要区别-这个问题基本都会问到

记住3点最重要的不同之处：

spark消除了冗余的 HDFS 读写: Hadoop 每次 shuffle 操作后，必须写到磁盘，而 Spark 在 shuffle 后不一定落盘，可以 cache 到内存中，以便迭代时使用。如果操作复杂，很多的 shufle 操作，那么 Hadoop 的读写 IO 时间会大大增加，也是 Hive 更慢的主要原因了。
spark消除了冗余的 MapReduce 阶段: Hadoop 的 shuffle 操作一定连着完整的 MapReduce 操作，冗余繁琐。而 Spark 基于 RDD 提供了丰富的算子操作，且 reduce 操作产生 shuffle 数据，可以缓存在内存中。
JVM 的优化: Hadoop 每次 MapReduce 操作，启动一个 Task 便会启动一次 JVM，基于进程的操作。而 Spark 每次 MapReduce 操作是基于线程的，只在启动 Executor 是启动一次 JVM，内存的 Task 操作是在线程复用的。每次启动 JVM 的时间可能就需要几秒甚至十几秒，那么当 Task 多了，这个时间 Hadoop 不知道比 Spark 慢了多。


## 6. 网络 TCP

### 6.1 三次握手

TCP 的三次握手, 四次挥手:  TCP 协议是如何建立和释放连接的？

三次握手建立连接:

第一次握手：A给B打电话说，你可以听到我说话吗？（seq=x）
第二次握手：B收到了A的信息，然后对A说：我可以听得到你说话啊，你能听得到我说话吗？（ACK=x+1，seq=y）
第三次握手：A收到了B的信息，然后说可以的，我要给你发信息啦！（ack=y+1）

### 6.2 四次挥手

四次挥手释放连接:

A:喂，我不说了。(FIN)
B:我知道了。等下，上一句还没说完。Balabala…..（ACK）
B:好了，说完了，我也不说了。（FIN）
A:我知道了。(ACK)
A等待 2MSL,保证B收到了消息,否则重说一次我知道了。


TCP四次挥手中的TIME_WAIT状态

## 7. Spark

1. 不指定语言，写一个WordCount的MapReduce
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


[大数据工程师（开发）面试题(附答案)](https://cloud.tencent.com/developer/article/1061680)



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
- [面圈网](http://www.mianshigee.com/company/Shopee)

没看的:

[Shopee-Interview-Backend](https://github.com/Tscharrl/Shopee-Interview-Backend)
[Shopee社招Java岗面试经历](http://www.mianshigee.com/article/47506wik)
[【牛客网面经整理】7.20shopee一面面经，加入我自己整理的相关拓展问题（redis））](https://blog.csdn.net/xintu1314/article/details/108375623?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-3&spm=1001.2101.3001.4242)
