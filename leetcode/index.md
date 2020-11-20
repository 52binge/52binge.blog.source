---
title: Coding
---

<!--# [Sea](https://leetcode-cn.com/company/shopee/)-->

## [HOT100](https://leetcode-cn.com/problemset/leetcode-hot-100/)

No. | Question | Flag
:---: | --- | :---:
(1). | **binary-search** |
&nbsp; | [15. 3Sum](https://leetcode-cn.com/problems/3sum) == TwoSum | ❎
&nbsp; | [33. Search in Rotated Sorted Array](https://leetcode-cn.com/problems/search-in-rotated-sorted-array/) | ❎
&nbsp; | |
Array | ~~[283. Move Zeroes](https://leetcode-cn.com/problems/move-zeroes)， 冒泡思想~~ | ❎  
&nbsp; | [48. Rotate Image](https://leetcode-cn.com/problems/rotate-image), n\*n matrix, 上三角【`转置+reverse()`】,  matrix[i].reverse() | ✔️❎
(2). | DP |
&nbsp; | [309. Best Time to Buy and Sell Stock with Coo](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-cooldown), [题解：最佳买卖股票时机含冷冻期](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/solution/zui-jia-mai-mai-gu-piao-shi-ji-han-leng-dong-qi-4/)
&nbsp; | [53. Maximum Subarray](https://leetcode-cn.com/problems/maximum-subarray/) | ❎
&nbsp; | [221. Maximal Square](https://leetcode-cn.com/problems/maximal-square/) | ❎
&nbsp; | [64. Minimum Path Sum](https://leetcode-cn.com/problems/minimum-path-sum) ， 格子 DP | ❎
&nbsp; | [198 打家劫舍](https://leetcode-cn.com/problems/house-robber) , max(dp[i - 2] + nums[i], dp[i - 1]) | ❎
背包 | [416 分割等和子集](https://leetcode-cn.com/problems/partition-equal-subset-sum), 0-1背包 变体 | medium
树形DP | [337. House Robber III](https://leetcode-cn.com/problems/house-robber-iii)， 偷不偷 | ✔️
(3). | 模拟 |
&nbsp; | [31. Next Permutation](https://leetcode-cn.com/problems/next-permutation) == [8.5 下一个更大元素 III](https://leetcode-cn.com/problems/next-greater-element-iii/) | ❎
Array | [406. Queue Reconstruction by Height](https://leetcode-cn.com/problems/queue-reconstruction-by-height)， people.sort(key=lambda x:(-x[0], x[1])), 插入法 | ✔️❎
全排列 | [39. Combination Sum](https://leetcode-cn.com/problems/combination-sum) ， [经典好题](https://leetcode-cn.com/problems/combination-sum/solution/hui-su-suan-fa-jian-zhi-python-dai-ma-java-dai-m-2/)| ✔️
(4). | DFS / BFS / Tree / Stack |
&nbsp; | [78. Subsets](https://leetcode-cn.com/problems/subsets), 经典dfs | ❎
&nbsp; | [79. Word Search](https://leetcode-cn.com/problems/word-search) | ❎
&nbsp; | [200. Number of Islands](https://leetcode-cn.com/problems/number-of-islands/) | ❎
&nbsp; | [56. Merge Intervals](https://leetcode-cn.com/problems/merge-intervals/) ， Sort + 遍历, 替换结果 | ❎
&nbsp; | &nbsp; | &nbsp;
&nbsp; | [739. Daily Temperatures](https://leetcode-cn.com/problems/daily-temperatures/)
&nbsp; | [21. Merge Two Sorted Lists](https://leetcode-cn.com/problems/merge-two-sorted-lists) | ❎
&nbsp; | [253. Meeting Rooms II](https://leetcode-cn.com/problems/meeting-rooms-ii) , heapq or 拆数组模拟 | ❎
&nbsp; | [96. Unique Binary Search Trees](https://leetcode-cn.com/problems/unique-binary-search-trees/)  | ❎
&nbsp; | [215. Kth Largest Element in an Array](https://leetcode-cn.com/problems/kth-largest-element-in-an-array/) | ❎
&nbsp; | [287. Find the Duplicate Number](https://leetcode-cn.com/problems/find-the-duplicate-number/)
Tree | [114	二叉树展开为链表](https://leetcode-cn.com/problems/flatten-binary-tree-to-linked-list), prev.right = curr | ❎ 
(6). | LinkedList |
&nbsp; | [142. Linked List Cycle II](https://leetcode-cn.com/problems/linked-list-cycle-ii/) | ✔️
&nbsp; | [148. Sort List](https://leetcode-cn.com/problems/sort-list) | ✔️❎
Page3 | |
&nbsp; | 33 搜索旋转排序数组 |  
&nbsp; | 121 买卖股票的最佳时机 |  
&nbsp; | 300 最长上升子序列  | ❎
&nbsp; | [207. Course Schedule](https://leetcode-cn.com/problems/course-schedule) | 
&nbsp; | [139. Word Break](https://leetcode-cn.com/problems/word-break) ， [好题目，3种解法](https://leetcode-cn.com/problems/word-break/solution/shou-hui-tu-jie-san-chong-fang-fa-dfs-bfs-dong-tai/) |
&nbsp; | [152. Maximum Product Subarray - 乘积最大子数组](https://leetcode-cn.com/problems/maximum-product-subarray) | medium
&nbsp; | [236 二叉树的最近公共祖先](https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree) | medium
&nbsp; | [55	跳跃游戏](https://leetcode-cn.com/problems/jump-game) | medium
&nbsp; | [75 Sort Colors](https://leetcode-cn.com/problems/sort-colors), 2遍 单指针, 1遍双指针 | ❎
&nbsp; | [538 Convert BST to Greater Tree](https://leetcode-cn.com/problems/convert-bst-to-greater-tree) |  
&nbsp; | [621	任务调度器](https://leetcode-cn.com/problems/task-scheduler) |  
前缀和<br>哈希优化 | [560. Subarray Sum Equals K](https://leetcode-cn.com/problems/subarray-sum-equals-k) <br> &nbsp;&nbsp; num_times = collections.defaultdict(int), cur_sum - target in nums_time  | ✔️❎
&nbsp; | [142	环形链表 II](https://leetcode-cn.com/problems/linked-list-cycle-ii) | 
&nbsp; | [240	搜索二维矩阵 II](https://leetcode-cn.com/problems/search-a-2d-matrix-ii) | ❎ 
&nbsp; | [234. Palindrome Linked List](https://leetcode-cn.com/problems/palindrome-linked-list)， 递归(可以反向) or vals == vals[::-1] | ✔️❎
&nbsp; | [543. Diameter of Binary Tree](https://leetcode-cn.com/problems/diameter-of-binary-tree), 好题 self.ans = max(self.ans, L+R) | ✔️❎
&nbsp; | ~~[226 翻转二叉树](https://leetcode-cn.com/problems/invert-binary-tree)~~ | ❎
&nbsp; | ~~[617 合并二叉树](https://leetcode-cn.com/problems/merge-two-binary-trees)~~ | ❎


**56. 合并区间**

```python
class Solution:
    def merge(self, intervals: List[List[int]]) -> List[List[int]]:
        intervals.sort(key=lambda x: x[0])

        merged = []
        for interval in intervals:
            # 如果列表为空，或者当前区间与上一区间不重合，直接添加
            if not merged or merged[-1][1] < interval[0]:
                merged.append(interval)
            else:
                # 否则的话，我们就可以与上一区间进行合并
                merged[-1][1] = max(merged[-1][1], interval[1])

        return merged
```

**337. House Robber III** （偷,不偷）[题解](https://leetcode-cn.com/problems/house-robber-iii/solution/san-chong-fang-fa-jie-jue-shu-xing-dong-tai-gui-hu/)

我们使用一个大小为 2 的数组来表示 int[] res = new int[2] 0 代表不偷，1 代表偷
任何一个节点能偷到的最大钱的状态可以定义为

> - 当前节点选择不偷：当前节点能偷到的最大钱数 = 左孩子能偷到的钱 + 右孩子能偷到的钱
> - 当前节点选择偷：当前节点能偷到的最大钱数 = 左孩子选择自己不偷时能得到的钱 + 右孩子选择不偷时能得到的钱 + 当前节点的钱数

```python
class Solution:
    def rob(self, root: TreeNode) -> int:
        def _rob(root):
            if not root: return 0, 0  # 偷，不偷

            left = _rob(root.left)
            right = _rob(root.right)
            # 偷当前节点, 则左右子树都不能偷
            v1 = root.val + left[1] + right[1]
            # 不偷当前节点, 则取左右子树中最大的值
            v2 = max(left) + max(right)
            return v1, v2

        return max(_rob(root))
```

## Review shop

No. | Question | Flag
:---: | --- | :---:
(1). | **binary-search** |
&nbsp; | [1.1 二分查找](https://leetcode-cn.com/problems/binary-search/), while l <= r | ❎
&nbsp; | [1.2 在排序数组中查找元素的第一个和最后一个位置](https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array/), def binSearch(nums, t, flag), return r+1 or | ❎
addition | [162. 寻找峰值](https://leetcode-cn.com/problems/find-peak-element/) nums[-1] = nums[n] = -∞ , l=mid+1, r=mid| ❎
&nbsp; | [278. First Bad Version](https://leetcode-cn.com/problems/first-bad-version/) , if isBadVersion(mid): right = mid - 1 | ❎
hard | [410. Split Array Largest Sum](https://leetcode-cn.com/problems/split-array-largest-sum/) Input: nums = [7,2,5,10,8], m = 2. Output: 18 <br> 「使……最大值尽可能小」是二分搜索题目常见的问法 | ❎
逆向双指针 | [88. Merge Sorted Array](https://leetcode-cn.com/problems/merge-sorted-array/) nums1 = [1,2,3,0,0,0], nums2 = [2,5,6] | ❎
双指针 | [15. 3Sum](https://leetcode-cn.com/problems/3sum/)， for for while | 
双指针 | [11. 盛最多水的容器](https://leetcode-cn.com/problems/container-with-most-water) | ❎
hard, merge+index | [315. Count of Smaller Numbers After Self](https://leetcode-cn.com/problems/count-of-smaller-numbers-after-self/) | hard
(2). | DFS / Stack |
&nbsp; | [2.1 字符串解码 "3[a2[c]]" == "accacc"](https://leetcode-cn.com/problems/decode-string/), `stack == [(3, ""), (2,"a")]` | ✔️❎
&nbsp; | [215. 数组中的第K个最大元素](https://leetcode-cn.com/problems/kth-largest-element-in-an-array/) from heapq import heapify, heappush, heappop |
(3). | Digit, 模拟 |
 &nbsp; | [3.1 回文数](https://leetcode-cn.com/problems/palindrome-number/) [禁止整数转字符串]， &nbsp;&nbsp;&nbsp;&nbsp;模拟 123321 -> 2332 -> 33 | ❎
 &nbsp; | [470. 用 Rand7() 实现 Rand10()](https://leetcode-cn.com/problems/implement-rand10-using-rand7/) , [题解: 等概率多次调用](https://leetcode-cn.com/problems/implement-rand10-using-rand7/solution/xiang-xi-fen-xi-fei-chang-jing-dian-de-ti-mu-deng-/) | 
(4). | DP |
`good` | [4.1 栅栏涂色](https://leetcode-cn.com/problems/paint-fence/) &nbsp;&nbsp; `dp[i] = dp[i-2]*(k-1) + dp[i-1]*(k-1)` | ✔️❎
&nbsp; | [4.2 区域和检索](https://leetcode-cn.com/problems/range-sum-query-immutable/) | ❎
`good`<br><br><br>`float('inf')`<br><br><br>hard | [4.3 Coin Change [零钱兑换]](https://leetcode-cn.com/problems/coin-change/) &nbsp;&nbsp;`dp[0] = 0`, `dp[x] = min(dp[x], dp[x - coin] + 1)` <br><br> $F(i)= min\_{j=0…n−1} F(i−c\_j)+1$ `dp = [float('inf')] * (amount + 1)` <br><br> 输入：coins = [1, 2, 5], amount = 11<br>输出：3 <br>解释：11 = 5 + 5 + 1 | ✔️❎
&nbsp; | [4.4 除自身以外数组的乘积](https://leetcode-cn.com/problems/product-of-array-except-self/) | ❎
&nbsp; | [279. 完全平方数](https://leetcode-cn.com/problems/perfect-squares/), numSquares(n)=min(numSquares(n-k) + 1)∀k∈square | ✔️❎
&nbsp; | [44. Wildcard Matching](https://leetcode-cn.com/problems/wildcard-matching/) Input: s = "aa", p = "*" Output: true , Input: s = "cb", p = "?a" Output: false |
(5). | hash |
&nbsp; | [5.1 两数之和](https://leetcode-cn.com/problems/two-sum/), enumerate hash[num] = i | ❎
(6). | linkedList |
- | [6.1 相交链表](https://leetcode-cn.com/problems/intersection-of-two-linked-lists/) `romantic` | ❎
- | [6.2 环形链表](https://leetcode-cn.com/problems/linked-list-cycle/) `hash` | ❎
- | [6.3 两数相加 I](https://leetcode-cn.com/problems/add-two-numbers/) `LinkNode 模拟` head = ListNode(0), cur = head, carry = 0 | ❎
- | [445. Add Two Numbers II](https://leetcode-cn.com/problems/add-two-numbers-ii/), 链表求和, stack | ❎
- | [6.4 复制带随机指针的链表](https://leetcode-cn.com/problems/copy-list-with-random-pointer/) ✔️ | ❎
- | [6.5 LRUCache](https://leetcode-cn.com/company/shopee/) class DLinkedNode(4), `removeTail`, `moveToHead`, `addToHead `, `removeNode` | ✔️❎
- | [6.6 删除链表的倒数第N个节点](https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list/) | ❎
- | [6.7 排序链表](https://leetcode-cn.com/problems/sort-list/) | ✔️❎
- | [面试题 02.05. 链表求和 I](https://leetcode-cn.com/problems/sum-lists-lcci/) | ❎
hard | [25. Reverse Nodes in k-Group](https://leetcode-cn.com/problems/reverse-nodes-in-k-group/) |
hard | [23. Merge k Sorted Lists](https://leetcode-cn.com/problems/merge-k-sorted-lists/) |
(7). | stack |
- | [7.1 有效的括号](https://leetcode-cn.com/problems/valid-parentheses/) `if i == ')' and len(stack)> 0 and stack[-1] == '(': stack.pop()` | ❎
- | [402. 移掉K位数字](https://leetcode-cn.com/problems/remove-k-digits/) |
(8). | string |
<br>reversed | [8.1 字符串相加](https://leetcode-cn.com/problems/add-strings/) 给定两个字符串形式的非负整数 num1 和num2 ，计算它们的和 <br> `num1 = "".join(list(reversed(num1)))`,<br> `num1 = num1 + ("0" * diff1) num2 = num2 + ("0" * diff2)` | ✔️️❎ 
- | [8.2 比较版本号](https://leetcode-cn.com/problems/compare-version-numbers/) | ❎
- | ~~[8.3 字符串解码](https://leetcode-cn.com/problems/decode-string/)~~ | ❎
- | [8.4 无重复字符的最长子串](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/) sliding window, `[l, r]` | ✔️❎️
- | [8.5 下一个更大元素 III](https://leetcode-cn.com/problems/next-greater-element-iii/) ， 模拟复杂 [见题解](https://leetcode-cn.com/problems/next-greater-element-iii/solution/xia-yi-ge-geng-da-yuan-su-iii-by-leetcode/) <br> `1,5,8,4,7,6,5,3,1` <br> => decreasing elem found `1,5,8,4(i-1),7,6,5(j),3,1` (found j, just larger a[i-1])<br> => `1,5,8,5,7,6,4,3,1` => `1,5,8,5,1,3,4,6,7` (reverse these elements) | ✔️️❎
- | [8.6 全排列](https://leetcode-cn.com/problems/permutations/) def dfs(ix =0): for i in range(first, n): swap(nums[ix], nums[i])| ❎
(9). | tree |
- | [9.1 从前序与中序遍历序列构造二叉树](https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/) `i = inorder.index(preorder[0])` | ❎
- | [9.2 二叉树的中序遍历 (非递归)](https://leetcode-cn.com/problems/binary-tree-inorder-traversal/) `while while` | ❎
- | [9.3 二叉树的右视图](https://leetcode-cn.com/problems/binary-tree-right-side-view/) | ❎
hard | [124. Binary Tree Maximum Path Sum](https://leetcode-cn.com/problems/binary-tree-maximum-path-sum/) |

### 3sum

```python
class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        n = len(nums)
        nums.sort()
        ans = list()
        
        # 枚举 a
        for first in range(n):
            # 需要和上一次枚举的数不相同
            if first > 0 and nums[first] == nums[first - 1]:
                continue
            # c 对应的指针初始指向数组的最右端
            third = n - 1
            target = -nums[first]
            # 枚举 b
            for second in range(first + 1, n):
                # 需要和上一次枚举的数不相同
                if second > first + 1 and nums[second] == nums[second - 1]:
                    continue
                # 需要保证 b 的指针在 c 的指针的左侧
                while second < third and nums[second] + nums[third] > target:
                    third -= 1
                # 如果指针重合，随着 b 后续的增加
                # 就不会有满足 a+b+c=0 并且 b<c 的 c 了，可以退出循环
                if second == third:
                    break
                if nums[second] + nums[third] == target:
                    ans.append([nums[first], nums[second], nums[third]])
        
        return ans
```

### 402. 移掉K位数字

```python
class Solution:
    def removeKdigits(self, num: str, k: int) -> str:
        numStack = []
        
        # 构建单调递增的数字串
        for digit in num:
            while k and numStack and numStack[-1] > digit:
                numStack.pop()
                k -= 1
        
            numStack.append(digit)
        
        # 如果 K > 0，删除末尾的 K 个字符
        finalStack = numStack[:-k] if k else numStack
        
        # 抹去前导零
        return "".join(finalStack).lstrip('0') or "0"
```

### 241. 为运算表达式设计优先级

解题思路

对于一个形如 x op y（op 为运算符，x 和 y 为数） 的算式而言，**它的结果组合取决于 x 和 y 的结果组合数**，而 x 和 y 又可以写成形如 x op y 的算式。

因此，该问题的子问题就是 x op y 中的 x 和 y：以运算符分隔的左右两侧算式解。

然后我们来进行 **分治算法三步走**：

1. 分解：按运算符分成左右两部分，分别求解
2. 解决：实现一个递归函数，输入算式，返回算式解
3. 合并：根据运算符合并左右两部分的解，得出最终解


```python
class Solution:
    def diffWaysToCompute(self, input: str) -> List[int]:
        # 如果只有数字，直接返回
        if input.isdigit():
            return [int(input)]

        res = []
        for i, char in enumerate(input):
            if char in ['+', '-', '*']:
                # 1.分解：遇到运算符，计算左右两侧的结果集
                # 2.解决：diffWaysToCompute 递归函数求出子问题的解
                left = self.diffWaysToCompute(input[:i])
                right = self.diffWaysToCompute(input[i+1:])
                # 3.合并：根据运算符合并子问题的解
                for l in left:
                    for r in right:
                        if char == '+':
                            res.append(l + r)
                        elif char == '-':
                            res.append(l - r)
                        else:
                            res.append(l * r)

        return res
```


### 279. 完全平方数

Recursion

```python
class Solution(object):
    def numSquares(self, n):
        square_nums = [i**2 for i in range(1, int(math.sqrt(n))+1)]

        def minNumSquares(k):
            """ recursive solution """
            # bottom cases: find a square number
            if k in square_nums:
                return 1
            min_num = float('inf')

            # Find the minimal value among all possible solutions
            for square in square_nums:
                if k < square:
                    break
                new_num = minNumSquares(k-square) + 1
                min_num = min(min_num, new_num)
            return min_num

        return minNumSquares(n)
```

DP

```python
class Solution(object):
    def numSquares(self, n):
        """
        :type n: int
        :rtype: int
        """
        square_nums = [i**2 for i in range(0, int(math.sqrt(n))+1)]
        
        dp = [float('inf')] * (n+1)
        # bottom case
        dp[0] = 0
        
        for i in range(1, n+1):
            for square in square_nums:
                if i < square:
                    break
                dp[i] = min(dp[i], dp[i-square] + 1)
        
        return dp[-1]

```

### 96. 不同的二叉搜索树

```python
class Solution:
    def numTrees(self, n):
        G = [0]*(n+1)
        G[0], G[1] = 1, 1

        for i in range(2, n+1):
            for j in range(1, i+1):
                G[i] += G[j-1] * G[i-j]

        return G[n]
```

<img src="/images/leetcode/stack-string-decoding.jpg" width="600" alt="字符串解码 " />

```python
class Solution:
    def decodeString(self, s: str) -> str:
        stack, res, multi = [], "", 0
        for c in s:
            if c == '[':
                stack.append([multi, res])
                res, multi = "", 0
            elif c == ']':
                cur_multi, last_res = stack.pop()
                res = last_res + cur_multi * res
            elif '0' <= c <= '9':
                multi = multi * 10 + int(c)            
            else:
                res += c
        return res
```

**LRUCache**

<img src="/images/leetcode/lc-146-lru.jpg" width="800" alt="" />

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

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1
        # 如果 key 存在，先通过哈希表定位，再移到头部
        node = self.cache[key]
        self.moveToHead(node)
        return node.value

    def put(self, key: int, value: int) -> None:
        if key not in self.cache:
            # 如果 key 不存在，创建一个新的节点
            node = DLinkedNode(key, value)
            # 添加进哈希表
            self.cache[key] = node
            # 添加至双向链表的头部
            self.addToHead(node)
            self.size += 1
            if self.size > self.capacity:
                # 如果超出容量，删除双向链表的尾部节点
                removed = self.removeTail()
                # 删除哈希表中对应的项
                self.cache.pop(removed.key)
                self.size -= 1
        else:
            # 如果 key 存在，先通过哈希表定位，再修改 value，并移到头部
            node = self.cache[key]
            node.value = value
            self.moveToHead(node)


    def addToHead(self, node):
        node.prev = self.head
        node.next = self.head.next
        self.head.next.prev = node
        self.head.next = node

    def removeNode(self, node):
        node.prev.next = node.next
        node.next.prev = node.prev

    def moveToHead(self, node):
        self.removeNode(node)
        self.addToHead(node)

    def removeTail(self):
        node = self.tail.prev
        self.removeNode(node)
        return node

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache(capacity)
# param_1 = obj.get(key)
# obj.put(key,value)
```

very good sortList:


```python
# -*- coding: utf-8 -*-

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
# 在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序。
#
# 示例 1:
#
# 输入: 4->2->1->3
# 输出: 1->2->3->4
class Solution:
    def sortList(self, head: ListNode) -> ListNode:
        if not head or not head.next: return head # termination.
        # cut the LinkedList at the mid index.
        slow, fast = head, head.next
        while fast and fast.next:
            fast, slow = fast.next.next, slow.next
        mid, slow.next = slow.next, None # save and cut.
        # recursive for cutting.
        left, right = self.sortList(head), self.sortList(mid)
        # merge `left` and `right` linked list and return it.
        h = res = ListNode(0)
        while left and right:
            if left.val < right.val: h.next, left = left, left.next
            else: h.next, right = right, right.next
            h = h.next
        h.next = left if left else right
        return res.next

```

二叉树的中序遍历

```python
class Solution:

    def __init__(self):
        self.res = []

    def inorderTraversal(self, root: TreeNode) -> List[int]:
        if not root:
            return []

        stack = list()

        while stack or root:
            while root:
                stack.append(root)
                root = root.left

            root = stack.pop()

            self.res.append(root.val)

            root = root.right

        return self.res
```

# [剑指,Table](https://leetcode-cn.com/problemset/lcof/)


No. | Question | Flag
:---: | --- | ---
**easy** |  |  
(1). | **Tree** |
&nbsp; | [1.1 平衡二叉树](https://leetcode-cn.com/problems/ping-heng-er-cha-shu-lcof) <br> abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 and self.isBalanced(root.left) and self.isBalanced(root.right) | ❎
&nbsp; | [1.2 对称的二叉树](https://leetcode-cn.com/problems/dui-cheng-de-er-cha-shu-lcof) | ❎
&nbsp; | [1.3 二叉树的镜像](https://leetcode-cn.com/problems/er-cha-shu-de-jing-xiang-lcof)： root.left = self.mirrorTree(root.right) `swap后+递归` | ❎
&nbsp; | [1.4 二叉搜索树的第k大节点](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-di-kda-jie-dian-lcof/) &nbsp;&nbsp; [中序遍历 倒序, 右-中-左]  | ✔️❎ 
good | [1.5 (两个节点)二叉树的最近公共祖先](https://leetcode-cn.com/problems/er-cha-shu-de-zui-jin-gong-gong-zu-xian-lcof/) &nbsp;&nbsp; [**Recursion**] 后序遍历+路径回溯 | ✔️❎ 
good | [1.6 (两个节点)二叉搜索树的最近公共祖先](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-zui-jin-gong-gong-zu-xian-lcof) &nbsp;&nbsp; **Recursion** + 剪枝 | ✔️❎ 
good | [1.7 二叉树中和为某一值的路径](https://leetcode-cn.com/problems/er-cha-shu-zhong-he-wei-mou-yi-zhi-de-lu-jing-lcof) `递归回溯` | ✔❎️
&nbsp; | [1.8 二叉搜索树的后序遍历序列](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-hou-xu-bian-li-xu-lie-lcof) | ❎
&nbsp; | [1.9 二叉搜索树与双向链表](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof/) <img src="/images/leetcode/binary-tree-delinkedlist.png" width="400" alt="" /> |
additional | 求二叉树第K层的节点个数 [**Recursion**] ，root != None and k==1，返回1  <br>  f(root.left, k-1) + f(root.right, k-1) | ❎
additional | 求二叉树第K层的叶子节点个数 [**Recursion**]  <br> if(k==1 and root.left and root.right is null) return 1; | ✔️❎
(2). | Stack |
&nbsp; | [394. 字符串解码 [a]2[bc]](https://leetcode-cn.com/problems/decode-string/) | ❎
&nbsp; | [28. 包含min函数的栈](https://leetcode-cn.com/problems/bao-han-minhan-shu-de-zhan-lcof/) | ❎
&nbsp; | [29. 最小的k个数【堆排的逆向】](http://localhost:5000/leetcode/#32-%E6%9C%80%E5%B0%8F%E7%9A%84k%E4%B8%AA%E6%95%B0) `heapq.heappop(hp),heapq.heappush(hp, -arr[i])` | ✔️❎
&nbsp; | 36. 滑动窗口的最大值  (同理于包含 min 函数的栈) deque.popleft(),双端队列+单调 | ✔️❎
&nbsp; | [59 II. 队列的最大值](https://leetcode-cn.com/problems/dui-lie-de-zui-da-zhi-lcof/) , `维护个单调的deque` <br> &nbsp;&nbsp; import queue, queue.deque(), queue.Queue(), deq[0], deq[-1] | ✔️❎
(3). | linkedList |
&nbsp; | 7. 从尾到头打印链表： <br>`reversePrint(head.next) + [head.val]` | ❎
&nbsp; | 8. [反转链表](https://leetcode-cn.com/problems/fan-zhuan-lian-biao-lcof/) &nbsp;&nbsp; (循环版 双指针) <img src="/images/leetcode/linkedlist-reverseList.gif" width="600" alt="" /> | ❎
&nbsp; | 10. [合并两个排序的链表](https://leetcode-cn.com/problems/he-bing-liang-ge-pai-xu-de-lian-biao-lcof/) &nbsp;&nbsp; [**Recursion**] <br> p.next = self.mergeTwoLists(l1.next, l2) | ❎
addition | 旋转单链表 (F1. 环 F2. 走n-k%n 断开) <br> 举例： 给定 1->2->3->4->5->6->NULL, K=3 <br> 则4->5->6->1->2->3->NULL |  ❎
addition | [92. 翻转部分单链表](https://zhuanlan.zhihu.com/p/141775663) `reverse(head: ListNode, tail: ListNode)` <br> 举例：1->2->3->4->5->null, from = 2, to = 4 结果：1->4->3->2->5->null | ❎
addition | 链表划分 （描述： 给定一个单链表和数值x，划分链表使得小于x的节点排在大于等于x的节点之前）| ❎
addition | 删除链表重复结点 链表1->2->3->3->4->4->5 处理后为 1->2->5. | ❎
addition | 输入：(7 -> 1 -> 6) + (5 -> 9 -> 2)，即617 + 295 <br> 输出：2 -> 1 -> 9，即912 |
(4). | **DP** |
&nbsp; | [31. n个骰子的点数](https://leetcode-cn.com/problems/nge-tou-zi-de-dian-shu-lcof) dp[i][j] ，表示投掷完 i 枚骰子后，点数 j 的出现次数 | ✔️
&nbsp; | [Summary 20 dynamic programming](/2020/08/31/leetcode/summary_dp/) |
(4.1) | **DP表示状态** |
easy | 1. climbing-stairs ， 新建{}or[] ,滚动数组 <br> 2. 连续子数组的最大和 | ❎
addition | [63. 不同路径 II](https://leetcode-cn.com/problems/unique-paths-ii/), `store = [[0]*n for i in range(m)]` 二维初始化 | ❎
<br> addition | Edit Distance/编辑距离【word1 转换成 word2】<br>&nbsp;&nbsp; 1. dp = [ [0] * (m + 1) for _ in range(n + 1)] <br>&nbsp;&nbsp; 2. dp[i][j] = min(A,B,C) | <br> ✔️❎
addition | [5. Longest Palindromic Substring/最长回文子串](https://leetcode-cn.com/problems/longest-palindromic-substring/) <br>&nbsp;&nbsp; dp[i][j] = (dp[i+1][j-1] and s[i]==s[j])  | ✔️❎
good | [把数字翻译成字符串](https://leetcode-cn.com/problems/ba-shu-zi-fan-yi-cheng-zi-fu-chuan-lcof/) | Fib ✔️❎
addition | Leetcode 64. Minimum Path Sum, 最小路径和 `grid[i][j] = min(grid[i - 1][j], grid[i][j - 1]) + grid[i][j]` | ❎
addition | 115. Distinct Subsequences I | Hard
addition | 940. 不同的子序列 II | Hard
addition | Interleaving String/交错字符串 | Hard
(5). | DFS / BFS |
&nbsp; | [66. 矩阵中的路径](https://leetcode-cn.com/problems/ju-zhen-zhong-de-lu-jing-lcof/) , `经典好题` |  ✔️❎ 
&nbsp; | [61. 机器人的运动范围](https://leetcode-cn.com/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof) `bfs` good <br> &nbsp;&nbsp; `from queue import Queue, q.get() q.pup()` | ✔️❎ 
(6). | sliding Window |
&nbsp; | 65. 最长不含重复字符的子字符串 `滑动窗口` | ✔️❎ 
&nbsp; | 14. 和为s的连续正数序列 &nbsp;&nbsp; [sliding window] <br><br> input：target = 9 <br> output：[[2,3,4],[4,5]] | ✔️❎ 
(7). | 模拟 |
&nbsp; | [21. 圆圈中最后剩下的数字](https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/) <br><br> 1. 当数到最后一个结点不足m个时，需要跳到第一个结点继续数 <br> 2. 每轮都是上一轮被删结点的下一个结点开始数 m 个 <br>3. 寻找 f(n,m) 与 f(n-1,m) 关系 <br> 4. A： f(n,m)=(m+x)%n  <br> 5. Python 深度不够手动设置 sys.setrecursionlimit(100000) <br> [东大 Lucien 题解,讲得最清楚的那个。官方讲解有误](https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/solution/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-by-lee/)  | <br><br><br><br>✔️❎
&nbsp; | 35. 顺时针打印矩阵 `left, right, top, bottom = 0, columns - 1, 0, rows - 1` | ✔️❎
&nbsp; | 56. 把数组排成最小的数, sorted vs sort, `strs.sort(key=cmp_to_key(sort_rule))` | ✔️❎  
&nbsp; | 70. 把字符串转换成整数 <br>&nbsp;&nbsp;&nbsp;&nbsp; int_max, int_min, bndry = 2**31-1, -2**31, 2**31//10 <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bndry=2147483647//10=214748364 ，则以下两种情况越界<br>&nbsp;&nbsp;&nbsp;&nbsp; res > bndry or res == bndry and c >'7' | ✔️❎
 | | 
**medium** |  | 
 | | 
37 | 0～n-1中缺失的数字 | ❎
42 | 求1+2+…+n | ❎
43 | 数组中数字出现的次数 | so hard
44 | 复杂链表的复制 | ❎ 
45 | 数组中数字出现的次数 | ❎ 
46 | 重建二叉树 | ❎ 
47 | 礼物的最大价值 `f = [len(grid[0]) * [0]] * len(grid)` | ❎ 
48 | 从上到下打印二叉树 III `queue.append([root, 0])` | ❎ 
49 | 丑数 n2, n3, n5 = dp[a] * 2, dp[b] * 3, dp[c] * 5 | ❎ 
50 | 二叉搜索树与双向链表 | ✔️❎  
51 | 股票的最大利润 （买卖一次）  <br>`cost, profit = float("+inf"), 0` <br> for price in prices:<br>&nbsp;&nbsp;&nbsp;&nbsp;`cost, profit = min(cost, price), max(profit, price - cost)` |  
54 | 构建乘积数组 | ❎ 
55 | **二叉树中和为某一值的路径** | <br> ✔️❎ 
57 | 剪绳子 (1) n < 4 (2) n == 4 (3) n > 4, 多个 == 3 段 | ❎ 
58 | 字符串的排列 `c = list(s) res = [] def dfs(x):` | ❎  
59 | 把数字翻译成字符串 `f[i] = f[i-1] + f[i-2]` 同 打家劫舍 | ❎  
60 | 二叉搜索树的后序遍历序列 `def recur(i, j):` | ❎ 
68 | 数值的整数次方  （1）当 n 为偶数 （2）当 n 为奇数 | ❎
71 | 表示数值的字符串： [确定有限状态自动机](https://leetcode-cn.com/problems/biao-shi-shu-zhi-de-zi-fu-chuan-lcof/solution/biao-shi-shu-zhi-de-zi-fu-chuan-by-leetcode-soluti/) <br> [面试题20. 表示数值的字符串（有限状态自动机，清晰图解）](https://leetcode-cn.com/problems/biao-shi-shu-zhi-de-zi-fu-chuan-lcof/solution/mian-shi-ti-20-biao-shi-shu-zhi-de-zi-fu-chuan-y-2/) | 
 | | 
**hard** |  | 
 | | 
72 | 数据流中的中位数 | 
73 | 序列化二叉树 | 
64 | 1～n整数中1出现的次数 |  
74 | 数组中的逆序对 | 
75 | 正则表达式匹配 | 

No. | Pass Question | Flag
:---: | --- | ---
**pass_easy** |  | 
1 | 左旋转字符串 | ❎
2 | 链表中倒数第k个节点 | ❎
3 | 二叉树的深度 | ❎
5 | 打印从1到最大的n位数： `sum = 10 ** n` | ❎
6 | 替换空格 | ❎
11 | 二进制中1的个数 [n = n & (n-1)] | ❎ 
12 | 用两个栈实现队列 | ❎
16 | 从上到下打印二叉树II &nbsp;&nbsp;  `queue.append([root, 0])` 或 `for _ in range(queue_size)` | ❎
17 | 数组中出现次数超过一半的数字 | ❎
18 | 数组中重复的数字 set() | ❎
19 | 和为s的两个数字  [sliding window] | ❎
20 | 调整数组顺序使奇数位于偶数前面 | ❎
22 | 两个链表的第一个公共节点 | ❎
23 | 第一个只出现一次的字符:&nbsp;&nbsp; Python 3.6 后，默认字典就是有序的，无需用 OrderedDict() | ❎
24 | 连续子数组的最大和 `dp[i] = dp[i-1] + nums[i]` | ❎
25 | 删除链表的节点 pre, p | ❎
30 | 不用加减乘除做加法  add(a ^ b, (a & b) << 1) | ❎
32 | 在排序数组中查找数字I | ❎
33 | 旋转数组的最小数字 `numbers[high]` | ❎
34 | 扑克牌中的顺子 ma - mi < 5 | ❎
38 | 翻转单词顺序 | ❎
39 | 青蛙跳台阶问题 | ❎
40 | 二维数组中的查找 | ❎
41 | 斐波那契数列 | ❎
**pass_medium** |  | 
52 | 栈的压入、弹出序列 (+stack 辅助) | ❎  
53 | 剑指 Offer 32 - III. 从上到下打印二叉树 III | ❎ 
63 | 树的子结构 | ❎  
67 | 数字序列中某一位的数字 `找规律, pass`  | **NG**
69 | 剪绳子II | **Not Good**, so pass.

## 1. Tree

```python
class Solution:
    def treeToDoublyList(self, root: 'Node') -> 'Node':
        def dfs(cur):
            if not cur: return
            dfs(cur.left) # 递归左子树
            if self.pre: # 修改节点引用
                self.pre.right, cur.left = cur, self.pre
            else: # 记录头节点
                self.head = cur
            self.pre = cur # 保存 cur
            dfs(cur.right) # 递归右子树
        
        if not root: return
        self.pre = None
        dfs(root)
        self.head.left, self.pre.right = self.pre, self.head
        return self.head
```

[题解链接](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof/solution/mian-shi-ti-36-er-cha-sou-suo-shu-yu-shuang-xian-5/)

**1.0 构造二叉树**

```python
class Node:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None


def creatTree(vals):
    nodes = []
    for i in range(len(vals)):
        cur_val = vals[i]
        if cur_val is not None:
            cur_node = Node(cur_val)
        else:
            cur_node = None
        nodes.append(cur_node)
        if i > 0:
            # 0, 1-1/2, 2-1/2
            par_id = (i - 1) // 2
            if (i - 1) % 2 == 0:
                nodes[par_id].left = cur_node
            else:
                nodes[par_id].right = cur_node
    return nodes[0]

def pre_out(root):
    if not root:
        return None

    print(root.val)
    pre_out(root.left)
    pre_out(root.right)

if __name__ == '__main__':
    vals = [3,5,1,6,2,0,8,None,None,7,4]
    root = creatTree(vals)
    pre_out(root)
```

### 1.1 平衡二叉树

```python
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

### 1.2 对称的二叉树

```python
def isSymmetricHelper(left: TreeNode, right: TreeNode):
    if left == None and right == None:
        return True
    if left == None or right == None:
        return False
    if left.val != right.val:
        return False
    return isSymmetricHelper(left.left, right.right) and isSymmetricHelper(left.right, right.left)

class Solution:
    def isSymmetric(self, root: TreeNode) -> bool:
        return root == None or isSymmetricHelper(root.left, root.right)
```

### 1.3 二叉树的镜像

```python
class Solution:
    def mirrorTree(self, root: TreeNode) -> TreeNode:
        if root == None:
            return root

        node = root.left
        root.left = self.mirrorTree(root.right)
        root.right = self.mirrorTree(node)

        return root
```

### 1.4 二叉树的最近公共祖先

```python
class Solution:
    def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode) -> TreeNode:
        # 当越过叶节点，则直接返回 null
        # 当 rootroot 等于 p, q， 则直接返回 root
        if root == None or root == p or root == q:
            return root
        
        left = self.lowestCommonAncestor(root.left, p, q)
        right = self.lowestCommonAncestor(root.right, p, q)
        
        if not left and not right: return None
        
        if not left: return right
        if not right: return left
        
        return root
```

**二叉搜索树的最近公共祖先**

```python
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

# 算法:
# 1. 从根节点开始遍历树
# 2. 如果节点 p 和节点 q 都在右子树上，那么以右孩子为根节点继续 1 的操作
# 3. 如果节点 p 和节点 q 都在左子树上，那么以左孩子为根节点继续 1 的操作
# 4. 如果条件 2 和条件 3 都不成立，这就意味着我们已经找到节 p 和节点 q 的 LCA 了

class Solution:
    def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode) -> TreeNode:
        # Value of current node or parent node.
        parent_val = root.val
        # Value of p
        p_val = p.val
        # Value of q
        q_val = q.val

        # If both p and q are greater than parent
        if p_val > parent_val and q_val > parent_val:
            return self.lowestCommonAncestor(root.right, p, q)
        # If both p and q are lesser than parent
        elif p_val < parent_val and q_val < parent_val:
            return self.lowestCommonAncestor(root.left, p, q)
        # We have found the split point, i.e. the LCA node.
        else:
            return root
```

### 1.6 从上到下打印二叉树 II / III

从上到下打印二叉树 II

```python
from collections import deque

class Solution:
    def levelOrder(self, root: TreeNode) -> List[int]:
        if not root:
            return []
        queue = collections.deque()
        queue.append(root)
        res = []
        while queue:
            size = len(queue)
            for _ in range(size):
                cur = queue.popleft()
                if not cur:
                    continue
                res.append(cur.val)
                queue.append(cur.left)
                queue.append(cur.right)
        return res
```

**从上到下打印二叉树 III**

```python
class Solution:
    def levelOrder(self, root: TreeNode) -> List[List[int]]:
        if not root:
            return []

        queue = deque()
        queue.append([root, 0])
        res = []
        tmp_dict = dict()
        while queue:
            cur, level = queue.popleft()
            if tmp_dict.get(level) is not None:
                tmp_dict[level].append(cur.val)
            else:
                tmp_dict[level] = [cur.val]

            if cur.left:
                queue.append([cur.left, level + 1])
            if cur.right:
                queue.append([cur.right, level + 1])

        for ix in range(len(tmp_dict)):
            if ix % 2 == 1:
                res.append(tmp_dict[ix][::-1])
            else:
                res.append(tmp_dict[ix])

        return res
```

### 1.7 二叉树中和为某一值的路径

```python
def pathSum(self, root: TreeNode, sum: int) -> List[List[int]]:

    if not root:
        return []

    self.path.append(root.val)
    sum = sum - root.val
    
    if sum == 0 and root.left is None and root.right is None:
        self.res.append(list(self.path))
    
    if root.left:
        self.pathSum(root.left, sum)
    if root.right:
        self.pathSum(root.right, sum)
    
    self.path.pop()
    return self.res
```

### 1.8 二叉搜索树的后序遍历序列

```python
class Solution:
    def verifyPostorder(self, postorder: [int]) -> bool:
        def recur(i, j):
            if i >= j:
                return True

            p = i

            while postorder[p] < postorder[j]:
                p += 1

            m = p

            while postorder[p] > postorder[j]:
                p += 1

            return p == j and recur(i, m - 1) and recur(m, j - 1)

        return recur(0, len(postorder) - 1)
```

### 1.9 二叉搜索树与双向链表

```python
class Solution:
    def treeToDoublyList(self, root: 'Node') -> 'Node':
        def dfs(cur):
            if not cur: return
            dfs(cur.left) # 递归左子树
            
            if self.pre: # 修改节点引用
                self.pre.right = cur
                cur.left = self.pre
            else: # 记录头节点
                self.head = cur
            self.pre = cur # 保存 cur
            
            dfs(cur.right) # 递归右子树
        
        if not root: return
        self.pre = None
        dfs(root)
        self.head.left = self.pre
        self.pre.right = self.head
        return self.head
```

## 2. LinkedList

### 2.1 复杂链表的复制

```
"""
# Definition for a Node.
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = int(x)
        self.next = next
        self.random = random
"""
class Solution:
    def copyRandomList(self, head: 'Node') -> 'Node':
```

## 3. String

字符串全排列 permutation

```python
# 输入：s = "abc"
# 输出：["abc","acb","bac","bca","cab","cba"]

from typing import List


class Solution:

    def permutation(self, s: str) -> List[str]:
        c = list(s)
        res = []

        def dfs(x):
            if x == len(c) - 1:
                res.append(''.join(c))  # 添加排列方案
                return
            dic = set()
            for i in range(x, len(c)):
                # if c[i] in dic: continue  # 重复，因此剪枝
                # dic.add(c[i])
                c[i], c[x] = c[x], c[i]  # 交换，将 c[i] 固定在第 x 位
                dfs(x + 1)               # 开启固定第 x + 1 位字符
                c[i], c[x] = c[x], c[i]  # 恢复交换

        dfs(0)
        return res
```


## 4. Array & Sort

### 4.1 最小的k个数

```python
import heapq
from typing import List

class Solution:
    def getLeastNumbers(self, arr: List[int], k: int) -> List[int]:

        if k == 0:
            return list()

        hp = [-x for x in arr[:k]]

        heapq.heapify(hp)

        for i in range(k, len(arr)):
            if -hp[0] > arr[i]:
                heapq.heappop(hp)
                heapq.heappush(hp, -arr[i])

        ans = [-x for x in hp]

        return ans
```

### 4.2 n个骰子的点数

```
# 把n个骰子扔在地上，所有骰子朝上一面的点数之和为s。输入n，打印出s的所有可能的值出现的概率。
#
# 你需要用一个浮点数数组返回答案，其中第 i 个元素代表这 n 个骰子所能掷出的点数集合中第 i 小的那个的概率。
#
# 输入: 1
# 输出: [0.16667,0.16667,0.16667,0.16667,0.16667,0.16667]
#
# 输入: 2
# 输出: [0.02778,0.05556,0.08333,0.11111,0.13889,0.16667,0.13889,0.11111,0.08333,0.05556,0.02778]


# 通过题目我们知道一共投掷 n 枚骰子，那最后一个阶段很显然就是：当投掷完 n 枚骰子后，各个点数出现的次数。
#
# 注意，这里的点数指的是前 n 枚骰子的点数和，而不是第 n 枚骰子的点数，下文同理。
#
# 找出了最后一个阶段，那状态表示就简单了。
#
# 首先用数组的第一维来表示阶段，也就是投掷完了几枚骰子。
# 然后用第二维来表示投掷完这些骰子后，可能出现的点数。
# 数组的值就表示，该阶段各个点数出现的次数。
# 所以状态表示就是这样的：dp[i][j] ，表示投掷完 i 枚骰子后，点数 j 的出现次数。

# dp[i][j] += dp[i-1][j-cur];
```

```python
from typing import List


class Solution:

    def twoSum(self, n: int) -> List[float]:

        dp = [[0] * (6 * n + 1) for _ in range(11 + 1)]  # 索引0不取，后面取到最大索引6*n

        for i in range(1, 7):  # init
            dp[1][i] = 1

        for i in range(2, n + 1):  # 从第二轮抛掷开始算
            for j in range(2, 6 * i + 1):  # 第二轮抛掷最小和为2，从大到小更新对应的抛掷次数
                # dp[j] = 0  # 每次投掷要从0更新dp[j]大小，点数和出现的次数要重新计算
                for cur in range(1, 7):  # 每次抛掷的点数
                    if j - cur <= 0:
                        break

                    if j - cur > (i - 1) * 6:
                        continue

                    dp[i][j] += dp[i - 1][j - cur]  # 根据上一轮来更新当前轮数据
                    print(f'{i}, {j}, ==== {i-1} {j-cur}')

        sum_ = 6 ** n
        res = []

        for i in range(n, 6 * n + 1):
            res.append(dp[n][i] * 1.0 / sum_)

        return res
```

### 4.3 顺时针打印矩阵

```python
# 输入：matrix = [
#     [1,2,3,4],
#     [5,6,7,8],
#     [9,10,11,12]
# ]
# 输出：[
#     1,2,3,4,
#     8,12,11,10,
#     9,5,6,7
# ]
from typing import List


class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        if not matrix or not matrix[0]:
            return list()

        rows, columns = len(matrix), len(matrix[0])
        order = list()
        left, right, top, bottom = 0, columns - 1, 0, rows - 1

        while left <= right and top <= bottom:
            for column in range(left, right + 1):
                order.append(matrix[top][column])

            for row in range(top + 1, bottom + 1):
                order.append(matrix[row][right])

            if left < right and top < bottom:
                for column in range(right - 1, left, -1):
                    order.append(matrix[bottom][column])
                for row in range(bottom, top, -1):
                    order.append(matrix[row][left])

            left, right, top, bottom = left + 1, right - 1, top + 1, bottom - 1

        return order
```
 
### 4.4 把数组排成最小的数

```python
from functools import cmp_to_key
from typing import List


class Solution:
    def minNumber(self, nums: List[int]) -> str:
        def sort_rule(x, y):
            a, b = x + y, y + x
            if a > b:
                return 1
            elif a < b:
                return -1
            else:
                return 0

        strs = [str(num) for num in nums]
        strs.sort(key=cmp_to_key(sort_rule))
        return ''.join(strs) 
 ```
 
### 4.5 把字符串转换成整数 

```python
class Solution:
    def strToInt(self, str: str) -> int:
        str = str.strip()                      # 删除首尾空格
        if not str: return 0                   # 字符串为空则直接返回
        res, i, sign = 0, 1, 1
        int_max, int_min, bndry = 2 ** 31 - 1, -2 ** 31, 2 ** 31 // 10
        if str[0] == '-': sign = -1            # 保存负号
        elif str[0] != '+': i = 0              # 若无符号位，则需从 i = 0 开始数字拼接
        for c in str[i:]:
            if not '0' <= c <= '9' : break     # 遇到非数字的字符则跳出
            if res > bndry or res == bndry and c > '7': return int_max if sign == 1 else int_min # 数字越界处理
            res = 10 * res + int(c) # 数字拼接
        return sign * res

```

### 4.7 数值的整数次方 (递归+2分)

```python
class Solution:
    def myPow(self, x: float, n: int) -> float:
        if x == 0: return 0
        res = 1
        if n < 0: x, n = 1 / x, -n
        while n:
            if n & 1: res *= x
            x *= x
            n >>= 1
        return res
```

## 5. sliding window

剑指 Offer 59 - I. 滑动窗口的最大值 - (同理于包含 min 函数的栈)

- [answ](https://leetcode-cn.com/problems/hua-dong-chuang-kou-de-zui-da-zhi-lcof/solution/mian-shi-ti-59-i-hua-dong-chuang-kou-de-zui-da-1-6/) 

```python
# -*- coding: utf-8 -*-
import collections
from typing import List

# 输入: nums = [1,3,-1,-3,5,3,6,7], 和 k = 3
# 输出: [3,3,5,5,6,7]
# 解释:
#
#   滑动窗口的位置                最大值
# ---------------               -----
# [1  3  -1] -3  5  3  6  7       3
#  1 [3  -1  -3] 5  3  6  7       3
#  1  3 [-1  -3  5] 3  6  7       5
#  1  3  -1 [-3  5  3] 6  7       5
#  1  3  -1  -3 [5  3  6] 7       6
#  1  3  -1  -3  5 [3  6  7]      7

class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        if not nums or k == 0: return []
        deque = collections.deque()
        for i in range(k): # 未形成窗口
            while deque and deque[-1] < nums[i]:
                deque.pop()
            deque.append(nums[i])
        res = [deque[0]]

        for i in range(k, len(nums)): # 形成窗口后
            #[0~k-1], [1~k], [2~k+1]
            if deque[0] == nums[i - k]:
                deque.popleft()
            while deque and deque[-1] < nums[i]:
                deque.pop()
            deque.append(nums[i])
            res.append(deque[0])
        return res

```
     
quickSort
 
```cpp
void quickSort(int a[], int left, int right) {
    if(left < right) { // exit. good idea!
        int l = left, r = right, x = a[l];
        while(1) {
            while(l < r && a[r] >= x) r--;
            while(l < r && a[l] <= x) l++;
            if(l >= r) break;
            swap(a[r], a[l]);
        }
        swap(a[left], a[l]);
        quickSort(a, left, l-1);
        quickSort(a, l+1, right);
    }
}

void mergeSort(int a[], int l, int r) { //  8, 5, 4, 9, 2, 3, 6
    if(l >= r) return;   // exit.
    int mid = (l+r) / 2; // overflow  <->  l + (r-l)/2
    mergeSort(a, l, mid);
    mergeSort(a, mid+1, r);  
    int *arr = new int[r-l+1];  
    int k = 0;
    int i = l, j = mid + 1;
    while(i <= mid && j <= r) {  
        if(a[i] <= a[j]) {
            arr[k++] = a[i++]; 
        }
        else {
            arr[k++] = a[j++]; // ans += (mid-i+1);  
        }
    }
    while(i <= mid) arr[k++] = a[i++];
    while(j <= r) arr[k++] = a[j++];
    for(int i = l; i <= r; i++) {
        a[i] = arr[i-l];
    }
    delete []arr;
}
```


## Reference

- [成长之路 0607offer](https://blog.csdn.net/qq_24243877)
- [知乎： [Leetcode][动态规划]相关题目汇总/分析/总结](https://zhuanlan.zhihu.com/p/35707293)
- [简书： 2019 算法面试相关(leetcode)--动态规划(Dynamic Programming)](https://www.jianshu.com/p/af880bbba792)
- [CSDN leetcode DP](https://blog.csdn.net/EbowTang/article/details/50791500)
- [刷完700多题后的首次总结：LeetCode应该怎么刷？](https://blog.csdn.net/fuxuemingzhu/article/details/105183554)
- [小白一路走来，连续刷题三年，谈谈我的算法学习经验](https://www.cnblogs.com/kubidemanong/p/10996134.html)
[codebunk.com](https://codebunk.com/b/3421100160572/)
[《程序员的算法趣题》-开坑记录](https://www.dattyrabbit.cn/articles/2020/08/16/1597576674555.html?utm_source=ld246.com)
