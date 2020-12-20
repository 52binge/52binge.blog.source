## 0. Glassdoor

No. | Question | Flag
:---: | --- | :---:
1. | hashmap questions <br> [哈希冲突解决方法](https://blog.csdn.net/weixin_44560940/article/details/95762569) : 关键字值不同的元素可能会映象到哈希表的同一地址上就会发生哈希冲突<br> [大厂面试必问！HashMap 怎样解决hash冲突？](https://blog.csdn.net/bjmsb/article/details/107919872) <br> [为什么 Map 桶中超过 8 个才转为红黑树？](https://www.jianshu.com/p/fdf3d24fe3e8) |<br> [HashMap指南](https://zhuanlan.zhihu.com/p/76735726) <br> [HashMap面试](https://www.cnblogs.com/zengcongcong/p/11295349.html)

[shop大数据面试](https://blog.csdn.net/gendlee1991/article/details/105759780)

No. | Question | Flag
:---: | --- | :---:
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
0. | 幻读： InnoDB MVCC 的实现，通过保存数据在某个时间点的快照来实现的 | ❎
1. | 事务4个特性ACID 有哪些 并分别解释? <br><br> &nbsp;&nbsp;事务是指是程序中一系列严密的逻辑操作，而且所有操作必须全部成功完成. <br><br> A原子性： 事务是数据库的逻辑工作单位，不可分割<br>C一致性： 数据库从一个一致性状态变到另一个一致性状态 <br>I 隔离性：一个事务的执行不能其它事务干扰 <br> D持久性：  一个事务一旦提交，它对数据库中的数据的改变就应该是永久性的，不能回滚 | <br><br><br><br> ❎
2. | [MySQL隔离级别有哪些?](https://zhuanlan.zhihu.com/p/79382923) <br> 1. Read Uncommitted（读取未提交内容）- &nbsp;&nbsp;也称为 脏读(Dirty Read) - **RollBack** <br>2. Read Committed（读取提交内容）- &nbsp;&nbsp;一个事务只能看见已经提交事务所做的改变 <br>3. Repeatable Read（可重读） - &nbsp;&nbsp;同一事务并发读同样结果. InnoDB MVCC 解决幻读 <br>4. Serializable（可串行化）- &nbsp;&nbsp; 事务排序解决 幻读问题<br><br> 1. 脏读(Drity Read): 某事务已更新了数据，RollBack了操作，则后一个事务所读取的数据就会是不正确.<br>2. 不可重复读: 在一事务的两次查询数据不一致，可能中间插入了一个事务更新原有的数据.<br>3. 幻读(Phantom Read): 在一事务的两次查询中数据笔数不一致. 另一事务却在此插入了新的几列数据. | <br><br><br><br> ❎
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
1. | 股票最大利润 cost, profit = float("+inf"), 0 | ❎
2. | Move Zeroes for i in range(len(nums)): | ❎
3. | 二叉树层序遍历 | ❎
4. | 删除排序链表中的重复元素 II， dummyHead = ListNode(0), dummyHead.next = head | ❎
5. | [如何实现LRU](http://localhost:5000/lc/#review-shop), 双向链表+Dict+Size+Cap <br> class DLinkedNode(4), removeTail, moveToHead, addToHead, removeNode | ✔️❎
6. | [125. 验证回文串](https://leetcode-cn.com/problems/valid-palindrome/), while, while left < right and not s[left].isalnum(): <br><br> 扩展: [5. 最长回文子串 dp](https://leetcode-cn.com/problems/longest-palindromic-substring/), 枚举长度 <br> &nbsp; for l in range(n): for i in n: dp[i][j] = (dp[i + 1][j - 1] and s[i] == s[j]) | <br>❎
7. | 判断二叉树是否对称 <br> &nbsp; class TreeNode: def \_\_init\_\_(self, x): <br> &nbsp; isSymmetricHelper(left.left, right.right) and isSymmetricHelper(left.right, right.left) | <br>❎
8. | [98. 验证二叉搜索树](https://leetcode-cn.com/problems/validate-binary-search-tree/), while stack or root: while root | ❎
9. | 找出数组里三个数相乘最大的那个（有正有负）| ❎
10. | 做题：两个十六进制数的加法 | ❎
11. | [93. 复原IP地址](https://leetcode-cn.com/problems/restore-ip-addresses/), ".".join(['1','2','3','4']) == '1.2.3.4',&nbsp; ord("a") = 97 &nbsp; if 0 < addr <= 0xFF: | ✔️❎
12. | [202. 快乐数](https://leetcode-cn.com/problems/happy-number/), divmod(79, 10) = 7,9;  while n > 0: n, digit = divmod(n, 10) | ❎
13. | 快排归并手撕 | ❎
14. | [1143. 最长公共子序列](https://leetcode-cn.com/problems/longest-common-subsequence/) dp = [[0] * (n + 1) for _ in range(m + 1)] <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if text1[i - 1] == text2[j - 1]: dp[i][j] = dp[i-1][j-1] + 1 <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else: dp[i][j] = max(dp[i-1][j], dp[i][j-1]) | <br>❎
15. | [3. 无重复字符的最长子串](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/), occ=set(); for: while r+1 < n and s[r+1] not in occ: | ❎
16. | 405-数字转换为十六进制数, bin(dec), oct(dec), hex(dec), int('0b10000', 2) | ❎
17. | [67. 二进制求和](https://leetcode-cn.com/problems/add-binary/)， for i, j in zip(a[::-1], b[::-1]):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s = int(i) + int(j) + carry, r = str(s % 2) + r, carry = s // 2 | ❎
18. | [4. 寻找两个正序数组的中位数 - hard](https://leetcode-cn.com/problems/median-of-two-sorted-arrays/) ,二分查找 O(log (m+n))  <br> A: 1 3 4 9 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↑<br>B: `1 2 3` 4 5 6 7 8 9<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↑| <br>✔️<br>❎
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

### 5.1 三次握手

TCP 的三次握手, 四次挥手:  TCP 协议是如何建立和释放连接的？

三次握手建立连接:

第一次握手：A给B打电话说，你可以听到我说话吗？（seq=x）
第二次握手：B收到了A的信息，然后对A说：我可以听得到你说话啊，你能听得到我说话吗？（ACK=x+1，seq=y）
第三次握手：A收到了B的信息，然后说可以的，我要给你发信息啦！（ack=y+1）

### 5.2 四次挥手

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

没看的:

[Shopee-Interview-Backend](https://github.com/Tscharrl/Shopee-Interview-Backend)
[Shopee社招Java岗面试经历](http://www.mianshigee.com/article/47506wik)
[【牛客网面经整理】7.20shopee一面面经，加入我自己整理的相关拓展问题（redis））](https://blog.csdn.net/xintu1314/article/details/108375623?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-3&spm=1001.2101.3001.4242)
