
No. | desc | Flag
:---: | --- | :---:
0. | [客户信息表、合同信息表和还款计划表分别是什么？玩不透老板会怀疑我的能力？](https://zhuanlan.zhihu.com/p/130761566) |
0. | [字节跳动-数据仓库高级工程师面试](https://mp.weixin.qq.com/s/7dHu2QcmU2xvFtGUEp13Fg) |
0. | [大数据常见面试题之spark sql](https://blog.csdn.net/sun_0128/article/details/107858345) |
1. | [2020 BAT大厂数据分析面试经验：“高频面经”之数据分析篇](https://blog.csdn.net/qq_36936730/article/details/104302799) |
2. | [2020年大厂面试题-数据仓库篇](https://my.oschina.net/u/4631230/blog/4688808)  <br><br> 1.手写"连续活跃登陆"等类似场景的sql - 好题目 | <br>✔️
3. | [数仓大法好！跨境电商 Shopee 的实时数仓之路](https://developer.aliyun.com/article/765329) | ❎
4. | [【数仓面试题】使用Hive窗口函数替换union all处理分组汇总（小计，总计）](https://zhuanlan.zhihu.com/p/148466975) | 
5. | [字节跳动数仓面试 三道题-JAVA编程+hive窗口](https://blog.csdn.net/qq_41828180/article/details/106213841]) |
6. | [经典sql题目（使用窗口函数解决）](https://blog.csdn.net/zhangshk_/article/details/82756557)

> [Hive 分析函数lead、lag实例应用](https://blog.csdn.net/kent7306/article/details/50441967)

Spark比MapReduce运行速度快的原因主要有以下几点：

> 1. task启动时间比较快，Spark是fork出线程；而MR是启动一个新的进程；
> 2. 更快的shuffles，Spark只有在shuffle的时候才会将数据放在磁盘，而MR却不是。
> 3. 更快的工作流：典型的MR工作流是由很多MR作业组成的，他们之间的数据交互需要把数据持久化到磁盘才可以；而Spark支持DAG以及pipelining，在没有遇到shuffle完全可以不把数据缓存到磁盘。
缓存：虽然目前HDFS也支持缓存，但是一般来说，Spark的缓存功能更加高效，特别是在SparkSQL中，我们可以将数据以列式的形式储存在内存中。
> 4. 所有的这些原因才使得Spark相比Hadoop拥有更好的性能表现；在比较短的作业确实能快上100倍，但是在真实的生产环境下，一般只会快 2.5x ~ 3x！

手写"连续活跃登陆"等类似场景的sql

```sql
select 
  * 
from 
  (
    select 
      user_id, date_id, 
      lead(date_id, 1) over(partition by user_id order by date_id) as last_date_id 
      # lead 参数1为列名，参数2为往下第n行（可选，默认为1)
    from 
      (
        select 
          user_id, date_id 
        from 
          wedw_dw.tmp_log 
        where 
          date_id >= '2020-08-10' and user_id is not null and length(user_id)> 0 
        group by user_id, date_id order by user_id, date_id
      ) t
  ) t1
where datediff(last_date_id,date_id)=1
```

## 2020年大厂面试题-数据仓库篇

No. | [2020年大厂面试题-数据仓库篇](https://my.oschina.net/u/4631230/blog/4688808) | Flag
:---: | --- | :---:
0. | [Hive SQL count（distinct）效率问题及优化](https://article.itxueyuan.com/a93Dg) |
1. | 手写"连续活跃登陆"等类似场景的sql | ❎
<br><br>2. | left semi join和left join区别? <br><br>`left semi join` 是 in(keySet) 的关系，遇到右表重复记录，左表会跳过；当右表不存在的时候，左表数据不会显示; 相当于SQL的in语句. <br>`left join`: 当右表不存在的时候，则会显示NULL |　<br><br>❎
<br><br><br>3. | 维度建模 和 范式建模(3NF模型) 的区别? <br><br> 维度建模是面向分析场景的，主要关注点在于快速、灵活: **星型模型 & 雪花模型 & 星系模型** <br><br> 3NF的最终目的就是为了降低数据冗余，保障数据一致性: <br> (2.1) 原子性 - 数据不可分割 <br> (2.2) 基于第一个条件，实体属性完全依赖于主键 <br> (2.3) 消除传递依赖 - 任何非主属性不依赖于其他非主属性 | <br><br><br>❎
<br><br><br> 4. | 数据漂移如何解决 ? <br><br>通常是指ods表的同一个业务日期数据中包含了前一天或后一天凌晨附近的数据或者丢失当天变更的数据，这种现象就叫做漂移，且在大部分公司中都会遇到的场景<br><br> 1. 多获取后一天的数据，保障数据只多不少 <br>2. 通过多个时间戳字段来限制时间获取相对准确的数据 log_time, modified_time, proc_time <br> &nbsp;&nbsp;&nbsp;&nbsp; modified_time 过滤非当天的数据，这样确保数据不会因为系统问题被遗漏 | <br><br><br>❎
5. | 拉链表如何设计，拉链表出现数据回滚的需求怎么解决 ? <br><br> 拉链表使用的场景：<br>1. 数据量大，且表中部分字段会更新，比如用户地址、产品描述信息、订单状态等等<br>2. 需要查看某一个时间段的历史快照信息<br>3. 变化比例和频率不是很大 |
6. | 以 LEFT JOIN 为例： 谈谈 在使用 LEFT JOIN 时，ON 和 WHERE 过滤条件的区别如下： <br><br> 1. on 条件是在生成临时表时使用的条件，它不管 on 中的条件是否为真，都会返回左边表中的记录 <br> 2. where 条件是在临时表生成好后，再对临时表进行过滤的条件。| ❎
7. | 公共层(CDM:dwd和dws) 和 数据集市层的区别和特点？ <br><br> 分为dwd层和dws层，主要存放`明细事实数据、维表数据 及 公共指标汇总数据`，其中明细事实数据、维表数据一般是根据ods层数据加工生成的，公共指标汇总数据一般是基于维表和明细事实数据加工生成的.<br><br> 采用维度模型方法作为理论基础，更多采用一些`维度退化的手段，将维度退化到事实表中`，减少事实表和维度表之间的关联。同时在汇总层，加强指标的维度退化，采用更多的宽表化手段构建公共指标数据层. <br><br> Data Mart: 就是满足特定部门或者用户的需求，按照多维方式存储。面向决策分析的数据立方体 |
8. | 从原理上说一下mpp和mr的区别 ? <br> 1. MPP跑的是SQL,而Hadoop底层处理是MapReduce程序 <br> 2. 扩展程度：MPP扩展一般是扩展到100左右,因为MPP始终还是DB,一定要考虑到C(Consistency) | ❎
9. | Kimball和Inmon的相同和不同？ Inmon： 不强调事实表和维度表的概念， 类似 3NF | ❎
10. | 缓慢变化维（Slowly Changing Dimension）处理方式 ?  <br>1. 重写覆盖 <br>2. 增加新行(注意事实表关联更新) <br>3. 快照 (每天保留全量的快照数据，通过空间换时间) <br>4. 历史拉链 (拉链表的处理方式，即通过时间标示当前有效记录) | ❎
11. | 数据质量/元数据管理/指标体系建设/数据驱动 | 略
12. | [hive的row_number()、rank()和dense_rank()的区别以及具体使用](https://blog.csdn.net/qq_20641565/article/details/52841345) | ❎
13. | [Hive窗口函数怎么设置窗口大小？](https://blog.csdn.net/qq_41106844/article/details/108415566), between 1 preceding and 1 following | ✔️
14. | Hive 四个by的区别 |
15. | 怎么验证Hive SQL的正确性 ？ <br> 1. 如果只是校验sql的语法正确性，可以通过explain或者执行一下就可以
16. | Hive数据选择的什么压缩格式 ? |
17. | Hive SQL如何转化MR任务 ? <br> HiveSQL ->AST(抽象语法树) -> QB(查询块) ->OperatorTree（操作树）->优化后的操作树->mapreduce任务树->优化后的mapreduce任务树 |
18. | join操作底层 MR 是怎么执行的？ 根据join对应的key进行分区shuffle，然后执行mapreduce那套流程. |
19. | Parquet数据格式内部结构? |
&nbsp; | [2020 BAT大厂数据分析面试经验：“高频面经”之数据分析篇](https://blog.csdn.net/qq_36936730/article/details/104302799) |
1. | Mysql中索引是什么？建立索引的目的？ |
2. | sql语句执行顺序？ from-on-join-where-group by-avg,sum-having |
3. | 数据库与数据仓库的区别? |
4. | OLTP和OLAP的区别？ |
5. | 行存储和列存储的区别? <br><br> 行存储：传统数据库的存储方式，同一张表内的数据放在一起，插入更新很快。缺点是每次查询即使只涉及几列，也要把所有数据读取<br>列存储：OLAP等情况下，将数据按照列存储会更高效，每一列都可以成为索引，投影很高效。缺点是查询是选择完成时，需要对选择的列进行重新组装。<br><br>当你的核心业务是 OLTP 时，一个行式数据库，再加上优化操作，可能是个最好的选择。<br>当你的核心业务是 OLAP 时，一个列式数据库，绝对是更好的选择 |
6. | Hive执行流程？ |
7. | Hive HDFS HBase区别？ <br> Hbase是Hadoop database，即Hadoop数据库.<br>&nbsp;&nbsp; 它是一个适合于非结构化数据存储的数据库，HBase基于列的而不是基于行的模式. |
8. | 数仓中ODS、DW、DM(Data Mart) 概念及区别？ |
9. | 窗口函数是什么？实现原理？ <br><br> 窗口函数又名开窗函数，属于分析函数的一种。用于解决复杂报表统计需求的功能强大的函数。窗口函数用于计算基于组的某种聚合值，它和聚合函数的不同之处是：`对于每个组返回多行`，而聚合函数对于每个组只返回一行.<br><br> 下面列举一些常用窗口函数：<br><br>1. 获取数据排名的：ROW_NUMBER() RAND() DEBSE_RANK() PERCENT_RANK()<br>2. 获取分组内的第一名或者最后一名等：FIRST_VALUE() LAST_VALUE() LEAD() LAG()<br>3. 累计分布：vCUME_DIST() NTH_VALUE() NTILE() |

## 大数据研发工程师

No. | desc | Flag
:---: | --- | :---:
&nbsp; | [大数据研发工程师（两年）字节跳动面经](https://juejin.cn/post/6844904181254340621) | |
1. | 数据不一致有没有遇到过，怎么解决的? &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **回答：** 1. 指标体系,数仓 2. 规则引擎，复用逻辑 | 
2. | 一道sql的题，一张表，用户id和登录日期，查找连续两天登陆的用户 <br> &nbsp;&nbsp; `and (a.pdate = date_sub(b.pdate,1) or a.pdate = date_add(b.pdate,1))` | 
3. | 怎么定位性能问题对应的是哪段sql? <br><br> 1. spark driver log 看 执行慢的stage（99%） <br> 2. spark ui 上看 该stage 的task 执行完成比率 <br> 3. spark ui 上看 该stage 对应的 continer id 和 所属job <br> 4. spark ui 上看 sql 的执行计划 和 执行计划图，最终定位到是哪段sql | <br><br>❎
4. | [遇到spark性能问题怎么解决的？](https://juejin.cn/post/6844903942766198798) &nbsp;&nbsp;&nbsp;&nbsp; 1. 提交参数 2. 开发调优 3. Shuffle调优 4. 小文件 |
5. | [121. 买卖股票的最佳时机 I](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/) <br> &nbsp;&nbsp;&nbsp;&nbsp; maxprofit = max(price - minprice, maxprofit), minprice = min(price, minprice) <br>[122. 买卖股票的最佳时机 II](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/), <br> 贪心: tmp = prices[i] - prices[i - 1], if tmp > 0: profit += tmp <br> DP： dp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i]) <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp[i][1] = max(dp[i-1][1], dp[i-1][0]-prices[i]) | 
6. | linux 求一个文件出现某个单词的行数 linux做完用spark写<br> &nbsp;&nbsp;spark: long numAs = logData.filter(s -> s.contains("a")).count(); |
7. | cache和persisit 的区别? <br><br> cache只有一个默认的缓存级别MEMORY_ONLY，即将数据持久化到内存中. <br> persist可以通过传递一个 StorageLevel 对象来设置缓存的存储级别. | ❎
8. | 有优化过Spark执行性能吗，怎么优化的, [超全spark性能优化总结](https://zhuanlan.zhihu.com/p/108454557) | 
9. | spark on service 用过吗， spark context有退出的问题遇到过吗？ 这个知道没用过，所以没答出来，不过通过这个问题能看出来字节大佬还真挺厉害的，三面面试官对技术都这么了解
10. | spark dataframe比rdd性能好，为啥? <br><br> DataFrame运行效率优于RDD，因为它规定了具体的结构对数据加以约束. 由于DataFrame具有定义好的结构, Spark可以在作业运行时应用许多性能增强的方法. 如果你能够使用RDD完美地编写程序，也可以通过RDD实现相同的性能. <br><br> Spark SQL的核心是Catalyst优化器，它以一种新颖的方式利用高级编程语言功能（例如Scala的模式匹配和quasiquotes）来构建可扩展的查询优化器, 它很容易添加优化规则 |
11. | 堆外内存是干什么用的 netty。结点直接交互数据，spark 最新feature 弃用jvm，直接c++调用内存，都是堆外, Spark 2.x 执行内存和存储内存 相互之间 能 占用 <br> 1. (executor内存) JVM 内部 的 On-heap Memory （对于JVM来说叫做 堆内存）<br> 2. (executor外部) JVM 外部/操作系统 的 Off-heap Memory |
12. | 知道什么是 whole stage codengen吗 <br> 面向接口编程太耗时间，主要是方法递归调用，虚函数调用 可以将一个stage的所有task整理成一个方法，并且生成动态字节码 并结合 |
13. | 加强数仓和业务的学习 加强底层原理的学习
14. | 我机智的回答：想深入业务 和 技术原理. 想优先考虑： data warehouse (高并发和实时流经验欠缺) |
&nbsp; | [字节跳动大数据研发实习超详细面经（已拿offer）](https://blog.csdn.net/m0_48634217/article/details/107057534) |
1. | leetcode: 二叉树层序遍历，按层换行输出 | ❎
2. | 线程的状态及状态之间的装换 |
3. | B+树的特点? <br><br> B+树是一种树数据结构，通常用于`数据库和操作系统`的文件系统中。B+树的特点是能够保持数据稳定有序，其`插入与修改`拥有较稳定的对数时间复杂度。B+树元素自底向上插入，这与二叉树恰好相反。 <br><br> B树是为磁盘或其他直接存取的辅助存储设备而设计的一种平衡搜索树。B树类似于红黑树，但它们在降低磁盘I/O操作数方面要更好一些。|
4. | Redis支持的数据结构? 为什么性能高？ 为什么是单线程? <br> 答： 将数据存储在内存，读取时候不需要进行磁盘的 IO，单线程也保证了系统没有线程的上下文切换。<br><br> String：缓存、计数器、分布式锁等。<br>List：链表、队列、微博关注人时间轴列表等。<br>Hash：用户信息、Hash 表等。<br>Set：去重、赞、踩、共同好友等。<br>Zset：访问量排行榜、点击量排行榜等。Zset 是有序的链表结构，其底层数据结构是跳跃表 skiplist  |
5. | 场景题：如何从百亿条IP信息中得出访问量前10的IP地址 `哈希分治法` <br> 1. ipv4 地址是一个 32 位的整数，可以用 uint 保存。 <br> 2. 我先设计一个哈希函数，把100个G的文件分成10000份，每份大约是 10MB，可以加载进内存了 |
6. | 场景设计题：你自己如何设计一个分布式系统，实现对百亿条数据进行分组并求和 |
7. | Spark shuffle机制? |
8. | 编程题：一个数组有正数有负数，调整数组中的数使得正负交替 <br> 1. 空间 O(1) <br> 2. 保持原来的顺序 - 时间复杂度O(n^2) ， `if (i % 2 == 0 && arr[i] < 0) continue;` <br> 3. 不用保持原来的顺序, O(n) |
9. | [医院排队候诊模型](https://blog.csdn.net/zhongyuchen/article/details/78602167) 假设一个医院，M个医生，N个病人，每个病人看病时长已知。写一个函数，做医生和病人的分配，要求医生负载尽量均衡。 |
10. | [5 分钟理解 https 工作流程](https://www.jianshu.com/p/a68ca86183d7) |
11. | Kafka如何保证生产者不丢失数据，消费端不丢失数据 |
&nbsp; | [字节跳动大数据岗](https://www.nowcoder.com/discuss/204836) , 2019.07 |
1. | 除了使用hive、spark。基本统计框架，自己实现一个word统计算法？ 我说了类似与mapreducer算法
2. | 问了MapReduce执行流程以及问了RDD属性和问了一些transformation和action算子
3. | hive能读取txt文件吗？以及读取哪些类型文件，若不能该怎么让其能读？ <br> load data local inpath '/usr/testFile/result.csv' overwrite into table biao; | ❎
4. | 各个文件分布在不同的分布式系统中，如何快速的实现某个字段前三？
5. | [124. 二叉树中的最大路径和](https://leetcode-cn.com/problems/binary-tree-maximum-path-sum/), [51. N 皇后](https://leetcode-cn.com/problems/n-queens/)， `def backtrack(row: int) if: else: for 回溯` | Hard
6. | [225. 用队列实现栈](https://leetcode-cn.com/problems/implement-stack-using-queues/) , `for _ in range(n): self.queue.append(self.queue.popleft())` |
7. | [小和问题和逆序对问题](https://blog.csdn.net/qq_34761012/article/details/104859991) <br> main: `smallSum(arr,start,mid)+smallSum(arr,mid+1,end)+merge(arr,start,mid,end)` <br>core : `Sum=Sum+arr[l]*(end-r+1)` | ❎
&nbsp; | [字节跳动大数据开发工程师技术中台一二三面+hr面](https://www.nowcoder.com/discuss/451878?channel=-2&source_id=discuss_terminal_discuss_sim)  |


```sql
select distinct a.uid 
  from tb_log a 
  left join tb_log b 
    on a.uid = b.uid 
   and (a.pdate = date_sub(b.pdate,1) or a.pdate = date_add(b.pdate,1))
```

[122. 买卖股票的最佳时机 II](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/)

```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        size = len(prices)
        # dp 数组
        dp = [[0, 0] for _ in range(size)]
        # 初始化
        dp[0][0] = 0
        dp[0][1] = -prices[0]
        for i in range(1, size):
            # 状态转移
            dp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i])
            dp[i][1] = max(dp[i-1][1], dp[i-1][0]-prices[i])
        
        return dp[size-1][0]
```

写sql, 求一个省份下的uv最高的城市 主要考察窗口函数

```sql
select 
  province, 
  city 
from 
  (
    select 
      province, 
      city, 
      row_number() over(
        partition by province 
        order by 
          uv desc
      ) rank 
    from 
      (
        select 
          province, 
          city, 
          count(distinct uid) uv 
        from 
          tb_log 
        where 
          pdate = {date} 
        group by 
          province, 
          city
      ) a
  ) a1 
where 
  a1.rank = 1
```

124. 二叉树中的最大路径和

```python
class Solution:
    def __init__(self):
        self.maxSum = float("-inf")

    def maxPathSum(self, root: TreeNode) -> int:
        def maxGain(node):
            if not node:
                return 0

            # 递归计算左右子节点的最大贡献值
            # 只有在最大贡献值大于 0 时，才会选取对应子节点
            leftGain = max(maxGain(node.left), 0)
            rightGain = max(maxGain(node.right), 0)
            
            # 节点的最大路径和取决于该节点的值与该节点的左右子节点的最大贡献值
            priceNewpath = node.val + leftGain + rightGain
            
            # 更新答案
            self.maxSum = max(self.maxSum, priceNewpath)
        
            # 返回节点的最大贡献值
            return node.val + max(leftGain, rightGain)
   
        maxGain(root)
        return self.maxSum
```

N 皇后

```python
class Solution:
    def solveNQueens(self, n: int) -> List[List[str]]:
        def generateBoard():
            board = list()
            for i in range(n):
                row[queens[i]] = "Q"
                board.append("".join(row))
                row[queens[i]] = "."
            return board

        def backtrack(row: int):
            if row == n:
                board = generateBoard()
                solutions.append(board)
            else:
                for i in range(n):
                    if i in columns or row - i in diagonal1 or row + i in diagonal2:
                        continue
                    queens[row] = i
                    columns.add(i)
                    diagonal1.add(row - i)
                    diagonal2.add(row + i)
                    backtrack(row + 1)
                    columns.remove(i)
                    diagonal1.remove(row - i)
                    diagonal2.remove(row + i)
                    
        solutions = list()
        queens = [-1] * n
        columns = set()
        diagonal1 = set()
        diagonal2 = set()
        row = ["."] * n
        backtrack(0)
        return solutions
```

[Java线程的5种状态及状态之间转换](https://blog.csdn.net/u013129944/article/details/73741161)

<img src="/images/dataware/thread-status.jpg" width="800" alt="Java线程的5种状态及状态之间转换" />


## Hadoop, HDFS, MR, Yarn Job

[七、介绍一下HDFS读写流程](https://mp.weixin.qq.com/s?__biz=Mzg3NjIyNjQwMg==&mid=2247493886&idx=1&sn=2cee4ece5c7cc87895d9e1a1b2fb440f&chksm=cf37daf3f84053e51cd0323f1ec9114ca0ec159a9451dd53a4afde5a7c6f1cf48f12d7999ef0&scene=21#wechat_redirect)

> HDFS block数据块大小为128MB, 默认情况下每个block有三个副本, NameNode主节点， DataNode 从节点.
> 
> HDFS client上传数据到HDFS时，首先，在本地缓存数据，当数据达到一个block大小时。请求NameNode分配一个block。 NameNode会把block所在的DataNode的地址告诉HDFS client。 HDFS client会直接和DataNode通信，把数据写到DataNode节点一个block文件里

No. | Read HDFS (download) - FSDataInputStream() 4步 | Flag
:---: | --- | :---:
1. | FileSystem对象的open == DistributedFileSystem()
2. | get block locations from NameNode （rpc）
3. | Client 与 DataNode 通信, FSDataInputStream对象，该对象会被封装DFSInputStream对象
4. | 假设第一块的数据读完了，就会关闭指向第一块的datanode连接。接着读取下一块.

No. | Writing HDFS (upload) - FSDataOutputStream() 6不步 ACK queue | Flag
:---: | --- | :---:
1. | client通过调用DistributedFileSystem的create方法创建新文件
2. | DFileSystem通过RPC调用namenode去创建一个没有blocks关联的新文件, 创建前， namenode做校验.
3. | 前两步结束后。会返回FSDataOutputStream的对象，与读文件的时候类似， FSDataOutputStream被封装成DFSOutputStream。DFSOutputStream能够协调namenode和datanode。client開始写数据到DFSOutputStream，DFSOutputStream会把数据切成一个个小的packet。然后排成队列data quene
4. | DataStreamer会去处理接受data quene，它先询问namenode这个新的block最适合存储的在哪
5. | DFSOutputStream另一个对列叫ack quene。也是由packet组成，等待datanode的收到响应，当pipeline中的全部datanode都表示已经收到的时候，这时akc quene才会把相应的packet包移除掉。
6. | client完毕写数据后调用close方法关闭写入流 

[MapReduce过程详解](https://juejin.cn/post/6844903607498702856)

**1. Map端整个流程分为4步**
 
1. 来源于HDFS的Block 
2. 在经过Mapper运行后，输出是Key/Value - 默认对Key进行哈希运算后，再以ReduceTask数量取模
3. 内存缓冲区的大小是有限的，默认是100MB, Spill，中文译为溢写
4. 每次溢写都在磁盘上生成一溢写文件，如Map结果很大，就有多次溢写发生，磁盘上就会有多个溢写文件, 后merge

**2. Reduce端整个流程分为3步**

1. Copy过程. 即简单地拉取数据
2. Merge阶段: 复制过来 数据会先放到内存缓冲区中，当达到一定阈值时，就会启动内存到磁盘的Merge.
3. Reducer输出文件。不断Merge后，最后生成一个“最终文件”. 当Reducer输入文件已定，整个Shuffle过程才结束.

No. | MapReduce的Shuffle过程 | Flag
:---: | --- | :---:
1. | Map方法之后Reduce方法之前这段处理过程叫「Shuffle」 | 
2. | Map方法之后，数据首先进入到分区方法，把数据标记好分区，然后把数据发送到环形缓冲区； 环形缓冲区达到80%时，进行溢写； 排序的手段「快排」；溢写产生大量溢写文件，需要对溢写文件进行「归并排序」；对溢写的文件也可以进行Combiner操作，前提是汇总操作，求平均值不行。最后将文件按照分区存储到磁盘，等待Reduce端拉取。 |
3. | 每个Reduce拉取Map端对应分区的数据。拉取数据后先存储到内存中，内存不够了，再存储到磁盘。拉取完所有数据后，采用归并排序将内存和磁盘中的数据都进行排序。在进入Reduce方法前，可以对数据进行分组操作。|

No. | Yarn 的 Job 提交流程 8 步， Client->RM->C->AM--rm-->C nums->NM->C->注销AM+C | Flag
:---: | --- | :---:
1. | client向RM提交应用程序
2. | ResourceManager启动一个Container用于运行ApplicationMaster
3. | 启动中的ApplicationMaster向ResourceManager注册自己，启动成功后与RM保持心跳
4. | AM 向 RM 发送请求,申请相应数目的 Container
5. | 申请成功的Container，由AM进行初始化。Container的启动信息初始化后，AM与对应的NodeManager通信，要求NM启动Container
6. | NM启动container
7. | container运行期间，AM 对 Container进行监控。Container通过RPC协议向对应的AM汇报自己的进度和状态等信息
8. | 应用运行结束后，AM 向 RM 注销自己，并允许属于它的 Container被收回


## 0. Glassdoor

No. | Question | Flag
:---: | --- | :---:
1. | hashmap questions <br> [哈希冲突解决方法](https://blog.csdn.net/weixin_44560940/article/details/95762569) : 关键字值不同的元素可能会映象到哈希表的同一地址上就会发生哈希冲突<br>1. 开放定址法 2. 再哈希法 3. 链地址法 4. 建立公共溢出区<br> [大厂面试必问！HashMap 怎样解决hash冲突？](https://blog.csdn.net/bjmsb/article/details/107919872) <br> [为什么 Map 桶中超过 8 个才转为红黑树？](https://www.jianshu.com/p/fdf3d24fe3e8) |<br> [HashMap指南](https://zhuanlan.zhihu.com/p/76735726) <br> [HashMap面试](https://www.cnblogs.com/zengcongcong/p/11295349.html)

[shop大数据面试](https://blog.csdn.net/gendlee1991/article/details/105759780)

No. | Question | Flag
:---: | --- | :---:
2. | What is the difference between optimistic and pessimistic locks? |

> 数据库锁机制（乐观锁和悲观锁、表锁和行锁）
> [你了解乐观锁和悲观锁吗？](https://www.cnblogs.com/kismetv/p/10787228.html)
>
> 1、CAS（Compare And Swap） - CAS只能保证单个变量操作的原子性
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
0. | 幻读： InnoDB MVCC 的实现，通过保存数据在某个时间点的快照来实现的 | ❎
1. | 事务4个特性ACID 有哪些 并分别解释? <br><br> &nbsp;&nbsp;事务是指是程序中一系列严密的逻辑操作，而且所有操作必须全部成功完成. <br><br> A原子性： 事务是数据库的逻辑工作单位，不可分割<br>C一致性： 数据库从一个一致性状态变到另一个一致性状态 <br>I 隔离性：一个事务的执行不能其它事务干扰 <br> D持久性：  一个事务一旦提交，它对数据库中的数据的改变就应该是永久性的，不能回滚 | <br><br><br><br> ❎
2. | [MySQL隔离级别有哪些?](https://zhuanlan.zhihu.com/p/79382923) <br><br>SQL标准定义了4类隔离级别，包括了一些具体规则，用来限定事务内外的哪些改变是可见的，哪些是不可见的。低级别的隔离级一般支持更高的并发处理，并拥有更低的系统开销。<br><br> 1. Read Uncommitted（读取未提交内容）- &nbsp;&nbsp;也称为 脏读(Dirty Read) - **RollBack** <br>2. Read Committed（读取提交内容）- &nbsp;&nbsp;一个事务只能看见已经提交事务所做的改变 <br>3. Repeatable Read（可重读） - &nbsp;&nbsp;同一事务并发读同样结果. InnoDB MVCC 解决幻读 <br>4. Serializable（可串行化）- &nbsp;&nbsp; 事务排序解决 幻读问题<br><br> 1. 脏读(Drity Read): 某事务已更新了数据，RollBack了操作，则后一个事务所读取的数据就会是不正确.<br>2. 不可重复读: 在一事务的两次查询数据不一致，可能中间插入了一个事务更新原有的数据.<br>3. 幻读(Phantom Read): 在一事务的两次查询中数据笔数不一致. 另一事务却在此插入了新的几列数据. | <br><br><br><br> ❎
3. | SQL的索引采用什么数据结构？（B+树） | ❎
4. | 聚簇索引InnoDB / 非聚簇索引Myisam | ❎
5. | **主键和索引的区别？** <br> 1. 主键是为了标识数据库记录唯一性，不允许记录重复，且键值不能为空，主键也是一个特殊索引. <br>2. 索引可提高查询速度，它相当于字典的目录，可通过它很快查询到想要的结果，而不需要进行全表扫描. <br>3. 主键也可以由多个字段组成，组成复合主键，同时主键肯定也是唯一索引. | ❎
6. | [Redis的过期策略和内存淘汰策略不要搞混淆](https://cloud.tencent.com/developer/article/1643921) <br><br> 1. Redis的过期策略 - 在程序中可以设置Redis中缓存的key的过期时间.  <br>&nbsp;&nbsp;1.1 定时过期 - 会占用大量的CPU <br>&nbsp;&nbsp;1.2 惰性过期 - 占用内存多 <br>&nbsp;&nbsp;1.3 定期过期：每隔一定的时间，会扫描一定数量expires key <br><br>2. Redis的内存淘汰策略是指内存不足时，怎么处理需要新写入且需要申请额外空间的数据. | <br><br><br><br>❎
7. | 如何解决哈希冲突 （拉链法，线性探测法…拓展巴拉巴拉） |

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
&nbsp; | [25. K 个一组翻转链表](https://leetcode-cn.com/problems/reverse-nodes-in-k-group/) 1->2->3->4->5 当 k = 3 时，应当返回: 3->2->1->4->5 <br> &nbsp;  def reverse(self, head: ListNode, tail: ListNode): prev=tail.next p=head <br> &nbsp; def reverseKGroup(head, k): hair = ListNode(0) while head: <br> &nbsp; (1) 查看剩余部分长度是否大于等于 k (2). 把子链表重新接回原链表 | <br>hard
1. | 股票最大利润 cost, profit = float("+inf"), 0 | ❎
2. | [Move Zeroes](https://leetcode-cn.com/problems/move-zeroes/) for i in range(len(nums)): if nums[i]: swap(nums[i], nums[j]) | ❎
3. | ~~二叉树层序遍历~~ | ❎
4. | [83. 删除排序链表中的重复元素](https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/), while cur and cur.next: <br>[82. 删除排序链表中的重复元素 II - 删除所有含有重复数字的节点](https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list-ii/) <br> &nbsp; dHead = ListNode(0), dHead.next = head, pre,cur = dHead,head; <br>&nbsp; `while cur: pre.next = cur.next` 跳过重复部分 | ❎
5. | [如何实现LRU](http://localhost:5000/lc/#review-shop), 双向链表+Dict+Size+Cap <br> class DLinkedNode(4), removeTail, moveToHead, addToHead, removeNode | ✔️❎
6. | [125. 验证回文串](https://leetcode-cn.com/problems/valid-palindrome/), while, while left < right and not s[left].isalnum(): <br><br> 扩展: [5. 最长回文子串 dp](https://leetcode-cn.com/problems/longest-palindromic-substring/), 枚举长度 <br> &nbsp; for l in range(n): for i in n: dp[i][j] = (dp[i + 1][j - 1] and s[i] == s[j]) | <br>❎
7. | 判断二叉树是否对称 <br> &nbsp; class TreeNode: def \_\_init\_\_(self, x): <br> &nbsp; isSymmetricHelper(left.left, right.right) and isSymmetricHelper(left.right, right.left) | <br>❎
8. | [98. 验证二叉搜索树](https://leetcode-cn.com/problems/validate-binary-search-tree/), while stack or root: while root | ❎
9. | 找出数组里三个数相乘最大的那个（有正有负）| ❎
10. | 做题：两个十六进制数的加法 | ❎
11. | [93. 复原IP地址](https://leetcode-cn.com/problems/restore-ip-addresses/), `".".join(['1','2','3','4']) == '1.2.3.4'`,&nbsp; `ord("a") = 97` <br> &nbsp; dfs(seg\_id, seg\_start) for seg\_end in range(seg\_start, len(s)): <br> &nbsp;&nbsp; if 0 < addr <= 0xFF（11111111==255): | ✔️❎
12. | [202. 快乐数](https://leetcode-cn.com/problems/happy-number/), `divmod(79, 10) = 7,9;  while n > 0: n, digit = divmod(n, 10)` | ❎
13. | 快排归并手撕 for i in range(l, r+1): nums[i] = arr[i - l] | ❎
14. | [1143. 最长公共子序列](https://leetcode-cn.com/problems/longest-common-subsequence/) dp = [[0] * (n + 1) for _ in range(m + 1)] <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if text1[i - 1] == text2[j - 1]: dp[i][j] = dp[i-1][j-1] + 1 <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else: dp[i][j] = max(dp[i-1][j], dp[i][j-1]) | <br>❎
15. | [3. 无重复字符的最长子串](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/), occ=set(); <br>&nbsp; for l in range(n): remove(i-1), while r+1 < n and s[r+1] not in occ: add(r+1) | ❎
16. | 405-数字转换为十六进制数, bin(dec), oct(dec), hex(dec), int('0b10000', 2) | ❎
17. | [67. 二进制求和](https://leetcode-cn.com/problems/add-binary/)， for i, j in zip(a[::-1], b[::-1]):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s = int(i) + int(j) + carry, r = str(s % 2) + r, carry = s // 2 <br><br> list(zip([1,2,3], [4,5,6])) == [(1, 4), (2, 5), (3, 6)]| <br>❎
18. | [4. 寻找两个正序数组的中位数 - hard](https://leetcode-cn.com/problems/median-of-two-sorted-arrays/) , 二分查找 O(log (m+n)) , k/2-1=7/2−1=2 <br> def getKthElement(k): <br> A: 1 3 4 9 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↑<br>B: `1 2 3` 4 5 6 7 8 9<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↑<br>k=k-k/2=4, 下一个位置是 k/2-1 = 4/2-1 = 1 | <br>✔️<br>❎
19. | [剑指 Offer 55 - II. 平衡二叉树](https://leetcode-cn.com/problems/ping-heng-er-cha-shu-lcof/) <br> &nbsp; (1). abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 <br> &nbsp; (2). self.isBalanced(root.left) and self.isBalanced(root.right) | <br>❎
20. | [155. 最小栈](https://leetcode-cn.com/problems/min-stack/), self.stack = [], self.min_stack = [float('inf')] | ❎
21. | 非递归单链表反转 现场手写 | ❎
22. | [105. 从前序与中序遍历序列构造二叉树](https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/), i = inorder.index(preorder[0]) | ❎ 
23. | 全排列, def dfs(x): if x == len(c) - 1: res.append(''.join(c)) <br> &nbsp;&nbsp;&nbsp;&nbsp; for i in range(first, n): | ❎
24. | [1262. 可被三整除的最大和](https://leetcode-cn.com/problems/greatest-sum-divisible-by-three/), [题解](https://leetcode-cn.com/problems/greatest-sum-divisible-by-three/solution/ti-jie-5265-ke-bei-san-zheng-chu-de-zui-da-he-by-z/)<br> &nbsp;&nbsp;贪心+逆向思维：<br> &nbsp;&nbsp; a = [x for x in nums if x % 3 == 0] <br> &nbsp;&nbsp; b = sorted([x for x in nums if x % 3 == 1], reverse=True)<br>&nbsp;&nbsp; c = sorted([x for x in nums if x % 3 == 2], reverse=True) | <br><br>❎
27. | 两千万个文件找最小的一千个（答错了，应该用大顶堆，答成了小顶堆）| ❎
28. | 10亿个数中找出最大的10000个数? <br><br> &nbsp;&nbsp;&nbsp;&nbsp; 将1亿个数据分成100份，每份100万个数据，找到每份数据中最大的10000个，最后在剩下的100*10000个数据里面找出最大的10000个 | <br> 分治法
29. | 1000个数据，查找出现次数最多的k个数字 <br><br> 我们首先一样是要把这十亿个数分成很多份。例如 1000份，每份 10万。然后使用 HashMap<int,int> 来统计。在每一次的统计中，我们可以找出最大的100个数？ 这样100\*10000 可以 快排序 解决 | 1. 分治法HashMap <br><br> 2. 位图法Bitmap |
30. | [239. 滑动窗口最大值](https://leetcode-cn.com/problems/sliding-window-maximum/), [题解](https://leetcode-cn.com/problems/sliding-window-maximum/solution/hua-dong-chuang-kou-zui-da-zhi-by-leetcode-3/) 双端队列 <br> &nbsp;(1). # init deque and output: &nbsp;&nbsp;while deq and nums[i] > nums[`deq[-1]`]: deq.pop() <br> &nbsp;(2). # build output: &nbsp;&nbsp;&nbsp;&nbsp;for i in range(k, n): | <br> ✔️❎

### 3.0 LRU

```python
class DLinkedNode:
    def __init__(self, key=0, value=0):
        self.key = key
        self.value = value
        self.prev = None
        self.next = None
        
class LRUCache:
    def __init__(self, capacity: int):
        self.head = DLinkedNode()
        self.tail = DLinkedNode()
        self.head.next = self.tail
        self.tail.prev = self.head
        self.capacity = capacity
        self.size = 0
        self.cache = {}
```


### 3.1 quickSort

```python
def quickSort(nums, left, right):
    if left < right:
        l, r = left, right
        x = nums[l]
        while True:
            while l < r and nums[r] >= x:
                r -= 1
            while l < r and nums[l] <= x:
                l += 1
            if l >= r:
                break
            nums[l], nums[r] = nums[r], nums[l]

        nums[left], nums[l] = nums[l], nums[left]

        quickSort(nums, left, l - 1)
        quickSort(nums, l + 1, right)

    return nums
```

### 3.2 mergeSort

```python
def mergeSort(nums, l, r):
    if l >= r:
        return
    mid = (l + r) // 2
    mergeSort(nums, l, mid)
    mergeSort(nums, mid + 1, r)
    arr = [0] * (r - l + 1)

    k, i, j = 0, l, mid + 1

    while i <= mid and j <= r:
        if nums[i] <= nums[j]:
            arr[k] = nums[i]
            k, i = k + 1, i + 1
        else:
            arr[k] = nums[j]  # ans += (mid+1-i);
            k, j = k + 1, j + 1
    while i <= mid:
        arr[k] = nums[i]
        k, i = k + 1, i + 1
    while j <= r:
        arr[k] = nums[j]
        k, j = k + 1, j + 1

    for i in range(l, r+1):
        nums[i] = arr[i - l]
```

### 3.3 isValidBST

```python
class Solution:
    def isValidBST(self, root):
        stack, pre = [], float('-inf')
        while stack or root:
            while root:
                stack.append(root)
                root = root.left
            root = stack.pop()
            # 如果中序遍历得到的节点的值小于等于前一个 inorder，说明不是二叉搜索树
            if root.val <= pre:
                return False
            pre = root.val
            root = root.right

        return True
```

```python
class Solution:
    def isValidBST(self, root):
        def helper(node, lower = float('-inf'), upper = float('inf')):
            if not node:
                return True
            val = node.val
            if val <= lower or val >= upper:
                return False

            if not helper(node.right, val, upper):
                return False
            if not helper(node.left, lower, val):
                return False
            return True
        return helper(root)
```

### 3.4 isHappy

```python
def isHappy(self, n: int) -> bool:  
    def get_next(number):
        total_sum = 0
        while number > 0:
            number, digit = divmod(number, 10)
            total_sum += digit ** 2
        return total_sum

    slow_runner = n
    fast_runner = get_next(n)
    while fast_runner != 1 and slow_runner != fast_runner:
        slow_runner = get_next(slow_runner)
        fast_runner = get_next(get_next(fast_runner))
    return fast_runner == 1
```

### 93. 复原IP地址

```python
class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        SEG_COUNT = 4
        ans = list()
        segments = [0] * SEG_COUNT
        
        def dfs(segId: int, segStart: int):
            # 如果找到了 4 段 IP 地址并且遍历完了字符串，那么就是一种答案
            if segId == SEG_COUNT:
                if segStart == len(s):
                    ipAddr = ".".join(str(seg) for seg in segments)
                    ans.append(ipAddr)
                return
            
            # 如果还没有找到 4 段 IP 地址就已经遍历完了字符串，那么提前回溯
            if segStart == len(s):
                return

            # 由于不能有前导零，如果当前数字为 0，那么这一段 IP 地址只能为 0
            if s[segStart] == "0":
                segments[segId] = 0
                dfs(segId + 1, segStart + 1)
            
            # 一般情况，枚举每一种可能性并递归
            addr = 0
            for segEnd in range(segStart, len(s)):
                addr = addr * 10 + (ord(s[segEnd]) - ord("0"))
                if 0 < addr <= 0xFF:
                    segments[segId] = addr
                    dfs(segId + 1, segEnd + 1)
                else:
                    break
        

        dfs(0, 0)
        return ans
```

### 46. 全排列

```python
class Solution:
    def permute(self, nums):

        def backtrack(first=0):
            # 所有数都填完了
            if first == n:
                res.append(nums[:])
            for i in range(first, n):
                # 动态维护数组
                nums[first], nums[i] = nums[i], nums[first]
                # 继续递归填下一个数
                backtrack(first + 1)
                # 撤销操作
                nums[first], nums[i] = nums[i], nums[first]

        n = len(nums)
        res = []
        backtrack(first=0)
        return res
```

### 1262. 可被三整除的最大和

```
输入：nums = [3,6,5,1,8]
输出：18
解释：选出数字 3, 6, 1 和 8，它们的和是 18（可被 3 整除的最大和）。
```

方法二：贪心 + 逆向思维

我们把数组中的数分成三部分 a，b 和 c，它们分别包含所有被 3 除余 0，1，2 的数。显然，我们可以选取 a 中所有的数，而对于 b 和 c 中的数，我们需要根据不同的情况选取不同数量的数。

> 我们设 tot 为数组 nums 中所有元素的和，此时 tot 会有三种情况：
>
> tot 是 3 的倍数，那么我们不需要丢弃任何数；
>
> tot 模 3 余 1，此时我们有两种选择：要么丢弃 b 中最小的 1 个数，要么丢弃 c 中最小的 2 个>
> tot 模 3 余 2，此时我们有两种选择：要么丢弃 b 中最小的 2 个数，要么丢弃 c 中最小的 1 个数。

```python
class Solution:
    def maxSumDivThree(self, nums: List[int]) -> int:
        a = [x for x in nums if x % 3 == 0]
        b = sorted([x for x in nums if x % 3 == 1], reverse=True)
        c = sorted([x for x in nums if x % 3 == 2], reverse=True)
        tot = sum(nums)
        ans = 0

        if tot % 3 == 0:
            ans = tot
        if tot % 3 == 1:
            if len(b) >= 1:
                ans = max(ans, tot - b[-1])
            if len(c) >= 2:
                ans = max(ans, tot - sum(c[-2:]))
        elif tot % 3 == 2:
            if len(b) >= 2:
                ans = max(ans, tot - sum(b[-2:]))
            if len(c) >= 1:
                ans = max(ans, tot - c[-1])

        return ans
```

### 4. 寻找两个正序数组的中位数

[题解：二分查找](https://leetcode-cn.com/problems/median-of-two-sorted-arrays/solution/xun-zhao-liang-ge-you-xu-shu-zu-de-zhong-wei-s-114/)

```python
class Solution:
    def findMedianSortedArrays(self, nums1: List[int], nums2: List[int]) -> float:
        def getKthElement(k):
            """
            - 主要思路：要找到第 k (k>1) 小的元素，那么就取 pivot1 = nums1[k/2-1] 和 pivot2 = nums2[k/2-1] 进行比较
            - 这里的 "/" 表示整除
            - nums1 中小于等于 pivot1 的元素有 nums1[0 .. k/2-2] 共计 k/2-1 个
            - nums2 中小于等于 pivot2 的元素有 nums2[0 .. k/2-2] 共计 k/2-1 个
            - 取 pivot = min(pivot1, pivot2)，两个数组中小于等于 pivot 的元素共计不会超过 (k/2-1) + (k/2-1) <= k-2 个
            - 这样 pivot 本身最大也只能是第 k-1 小的元素
            - 如果 pivot = pivot1，那么 nums1[0 .. k/2-1] 都不可能是第 k 小的元素。把这些元素全部 "删除"，剩下的作为新的 nums1 数组
            - 如果 pivot = pivot2，那么 nums2[0 .. k/2-1] 都不可能是第 k 小的元素。把这些元素全部 "删除"，剩下的作为新的 nums2 数组
            - 由于我们 "删除" 了一些元素（这些元素都比第 k 小的元素要小），因此需要修改 k 的值，减去删除的数的个数
            """
            
            index1, index2 = 0, 0
            while True:
                # 特殊情况
                if index1 == m:
                    return nums2[index2 + k - 1]
                if index2 == n:
                    return nums1[index1 + k - 1]
                if k == 1:
                    return min(nums1[index1], nums2[index2])

                # 正常情况
                newIndex1 = min(index1 + k // 2 - 1, m - 1) # k=6, 2
                newIndex2 = min(index2 + k // 2 - 1, n - 1) # k=6, 2
                pivot1, pivot2 = nums1[newIndex1], nums2[newIndex2]
                if pivot1 <= pivot2:
                    k -= newIndex1 - index1 + 1
                    index1 = newIndex1 + 1
                else:
                    k -= newIndex2 - index2 + 1
                    index2 = newIndex2 + 1
        
        m, n = len(nums1), len(nums2)
        totalLength = m + n
        if totalLength % 2 == 1:
            return getKthElement((totalLength + 1) // 2)
        else:
            return (getKthElement(totalLength // 2) + getKthElement(totalLength // 2 + 1)) / 2
```

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

## 5. 网络 TCP

**5.1 三次握手**

TCP 的三次握手, 四次挥手:  TCP 协议是如何建立和释放连接的？

三次握手建立连接:

第一次握手：A给B打电话说，你可以听到我说话吗？（seq=x）
第二次握手：B收到了A的信息，然后对A说：我可以听得到你说话啊，你能听得到我说话吗？（ACK=x+1，seq=y）
第三次握手：A收到了B的信息，然后说可以的，我要给你发信息啦！（ack=y+1）

**5.2 四次挥手**

四次挥手释放连接:

A:喂，我不说了。(FIN)
B:我知道了。等下，上一句还没说完。Balabala…..（ACK）
B:好了，说完了，我也不说了。（FIN）
A:我知道了。(ACK)
A等待 2MSL,保证B收到了消息,否则重说一次我知道了。


TCP四次挥手中的TIME_WAIT状态

## 6. Spark

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


[大数据工程师（开发）面试题(附答案)](https://cloud.tencent.com/developer/article/1061680)

## 7. Hive 优化

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

## Reference

- [Shopee大数据](https://www.shuzhiduo.com/A/6pdDQVbKzw/)
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
- [shop大数据面试](https://blog.csdn.net/gendlee1991/article/details/105759780)



##没看的:

[Shopee-Interview-Backend](https://github.com/Tscharrl/Shopee-Interview-Backend)
[Shopee社招Java岗面试经历](http://www.mianshigee.com/article/47506wik)
[【牛客网面经整理】7.20shopee一面面经，加入我自己整理的相关拓展问题（redis））](https://blog.csdn.net/xintu1314/article/details/108375623?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-3&spm=1001.2101.3001.4242)
