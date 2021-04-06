
## data warehouse

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
 
No. | desc | Flag
:--- | :--- | ---
&nbsp; | dict，list，set和tuple的区别？底层实现是hash/list/数组？  <br><br> 1. list 被实现为长度可变的数组，每次都会分配略大的内存防止频繁的申请分配内存，连续的一块的内存 <br> 2. tuple 本身为一个结构体，结构体里面有一个二级指针，这是常量二级指针，可以形成一个`指针数组` <br>3. **set** : `允许空值的dict`, 对dict有进行优化，在插入和删除元素的复杂度为常数级别，最坏也是O(n) <br> 4. dict 底层使用的哈希表, 哈希表平均查找时间复杂度O(1) <br> &nbsp;&nbsp;  [dict的key是不可变对象，因为要确保经过hash算法之后得到的地址唯一](https://www.codenong.com/cs106215357/) <br> &nbsp;&nbsp; py3.6+ dict是insert ordered，原来是根据hash值,乱序的，pop不一定是最后一个插入的键值对 | ❎
&nbsp; | 函数定义的时候参数前的*和**分别是什么意思，有什么区别？ <br> &nbsp;&nbsp; fun(1,2,3,4), tuple `1, (2,3,4)` / fun(1,a=2,b=3) dict `1, {a:2, b:3}1. ` | ❎
&nbsp; | 给变量a赋值int(1)，内存占4字节，后来又给a赋值str(1)，内存占1字节。请问两次赋值之间发生了什么？ <br> [python按引用赋值和深、浅拷贝 - [-5,256] 小整数优化](https://www.cnblogs.com/f-ck-need-u/p/10123145.html)， python int 占用 24~28 字节, 动态 | ❎
&nbsp; | 编码类型UTF-8，unicode，gbk任选两种说一下区别？ <br><br> &nbsp;&nbsp;Unicode不是一个新的编码规则，而是一套字符集, Unicode 只是一个符号集，它只规定了符号的二进制代码，却没有规定这个二进制代码应该如何存储.<br><br> &nbsp;&nbsp;UTF-8编码: 编码规则就是UTF-8。UTF-8采用1-4个字符进行传输和存储数据，是一种针对Unicode的可变长度字符编码，又称万国码. <br><br> &nbsp;&nbsp; Unicode符号范围（十六进制）, UTF-8编码方式(二进制) | ❎
&nbsp; | is和==的区别 ? Answ: is 用于判断两个变量是否引用,会对比其中两个变量的地址 | ❎
&nbsp; | [选一个module（比如numpy，pandas……）它的整体框架，主要应用场景，底层架构，（优缺点）](https://zhuanlan.zhihu.com/p/23151859?refer=xmucpp) <br><br>pd.DataFrame(`{'A':[434,54],'B':[4,56]}`,index = [1,2]) <br><br> Pandas 主要数据结构是一维数据(Series)、二维数据（DataFrame），这两种数据结构能满足金融、统计、社会等领域中大多典型用例。Pandas 是基于 NumPy 开发，可以与其它第三方计算支持库完美集成. <br><br> Pandas缺点：处理大数据集的速度非常慢。 在默认设置下，Pandas只使用单个CPU内核，在单进程模式下运行函数。 |
3. | **Leetcode** |
&nbsp; | — 输入一个数据流（可以先对数据做预处理，任何预处理都可以，只要得到的数据和原数据是一一映射即可，考官举了一个例子是可以用时间戳），对每一个元素判断是否之前出现过。在尽量减小内存和时间的情况下，如果要求完全精确，如何做？如果允许出现误差，如何做，误差可以控制在多少范围内？
&nbsp; | — 两个有序数组，大小分别是m和n，求整体的中位数，要求时间复杂度O(log(m+n))
&nbsp; | 编程题：大数求和 | ❎

```python
def big_data_add(a, b):
    # 1.先获取两个中最大的长度，然后将短进行补充，使长度一致
    max_len = len(a) if len(a) > len(b) else len(b)
 
    a = a.zfill(max_len) # "abc".zfill(5)  00abc
    b = b.zfill(max_len)

    a = list(a)
    b = list(b)
    result = [0 for i in range(max_len+1)]   # 这里加1主要是考虑到两数加起来可能比之前的数还多一位
 
    for i in range(max_len-1, -1, -1):
        temp = int(a[i]) + int(b[i])
        if temp >= 10:
            # 这里result是i+1  是因为result的长度比max_len长度长
            result[i+1] += temp % 10
            result[i] += temp // 10
        else:
            result[i+1] += temp
 
    return result

```

2个有序数据的中位数： 2分查找

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
            
            ix1, ix2 = 0, 0
            while True:
                # 特殊情况
                if ix1 == m:
                    return nums2[ix2 + k - 1]
                if ix2 == n:
                    return nums1[ix1 + k - 1]
                if k == 1:
                    return min(nums1[ix1], nums2[ix2])

                # 正常情况
                newIndex1 = min(ix1 + k // 2 - 1, m - 1)
                newIndex2 = min(ix2 + k // 2 - 1, n - 1)
                pivot1, pivot2 = nums1[newIndex1], nums2[newIndex2]
                if pivot1 <= pivot2:
                    k = k - (newIndex1 - ix1 + 1)
                    ix1 = newIndex1 + 1
                else:
                    k = k - (newIndex2 - ix2 + 1)
                    ix2 = newIndex2 + 1
        
        m, n = len(nums1), len(nums2)
        totalLength = m + n
        if totalLength % 2 == 1:
            return getKthElement((totalLength + 1) // 2)
        else:
            return (getKthElement(totalLength // 2) + getKthElement(totalLength // 2 + 1)) / 2
```

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
5. | [124. 二叉树最大路径和](https://leetcode-cn.com/problems/binary-tree-maximum-path-sum/), self.maxSum = float("-inf") leftGain = max(maxGain(node.left), 0) <br> [51. N 皇后](https://leetcode-cn.com/problems/n-queens/)， `def backtrack(row: int) if: else: for 回溯` | Hard
6. | [225. 用队列实现栈](https://leetcode-cn.com/problems/implement-stack-using-queues/) , self.queue = collections.deque() , push 后，在 reverse 过来 <br> `self.queue.append(x) for _ in range(n): self.queue.append(self.queue.popleft())` | ❎
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


[大数据工程师（开发）题(附答案)](https://cloud.tencent.com/developer/article/1061680)

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

## Reference


other:

- [Shopee大数据](https://www.shuzhiduo.com/A/6pdDQVbKzw/)
- [0086 shopee题汇总](https://blog.csdn.net/gendlee1991/article/details/105759780)
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
