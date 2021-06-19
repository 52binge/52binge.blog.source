---
title: 2021 Leetcode
date: 2021-03-19 10:54:16
categories: leetcode
tags: leetcode
---

<img src="/images/leetcode/python-leetcode.jpg" width="450" alt="leetCode" />

<!-- more -->

<!--  {% image /images/leetcode/python-leetcode.jpg, width=500px, alt=leetCode %} -->

## 1. binary-search

**1.1 二分查找, while l <= r**

```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        if not nums:
            return -1

        l, r = 0, len(nums) - 1

        while l <= r:
            mid = (r - l)//2 + l

            if nums[mid] < target:
                l = mid + 1
            elif nums[mid] > target:
                r = mid - 1
            else:
                return mid
        
        return -1
```

[34. 在排序数组中查找元素的第一个和最后一个位置](https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array/)

```python
class Solution:
    def searchRange(self, nums: List[int], target: int) -> List[int]:

        if not nums:
            return [-1, -1]

        def binSearch(nums, t, flag):
            l, r = 0, len(nums) - 1
            while l <= r:
                mid = (l + r) // 2
                if nums[mid] > t:
                    r = mid - 1
                elif nums[mid] < t:
                    l = mid + 1
                else:
                    if flag == "L":
                        r = mid - 1
                    else:
                        l = mid + 1

            if flag == 'L' and r + 1 < len(nums) and nums[r + 1] == t:
                return r + 1
            if flag == 'R' and l - 1 >= 0 and nums[l - 1] == t:
                return l - 1
            return -1

        return [binSearch(nums=nums, t=target, flag='L'), binSearch(nums=nums, t=target, flag='R')]
```

[88. 合并两个有序数组](https://leetcode-cn.com/problems/merge-sorted-array/) - 逆向双指针

```python
class Solution:
    def merge(self, A: List[int], m: int, B: List[int], n: int) -> None:
        """
        Do not return anything, modify A in-place instead.
        """
        pa, pb = m-1, n-1
        tail = m+n-1
        
        while not (pa == -1 and pb == -1):
            if pa == -1:
                A[tail] = B[pb]
                pb -= 1
            elif pb == -1:
                A[tail] = A[pa]
                pa -= 1
            elif A[pa] > B[pb]:
                A[tail] = A[pa]
                pa -= 1
            else:
                A[tail] = B[pb]
                pb -= 1
            tail -= 1
        
        return A[:]
```

[15. 3Sum](https://leetcode-cn.com/problems/3sum/) - for for while , second_ix & third_ix 两边夹

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

[11. Container With Most Water](https://leetcode-cn.com/problems/container-with-most-water/) 双指针 - 移动 l 和 r 较小的一方才可能增加 area

```python
class Solution:
    def maxArea(self, height: List[int]) -> int:
        l, r = 0, len(height) - 1
        area = 0
        while l < r:
            area = max(area, min(height[l], height[r]) * (r-l))
            if height[l] < height[r]:
                l += 1
            else:
                r -= 1
        return area
```

## 2. DFS / Stack

[2.1 字符串解码 "3[a2[c]]" == "accacc"](https://leetcode-cn.com/problems/decode-string/), `stack == [(3, ""), (2,"a")]` <img src="/images/leetcode/stack-string-decoding.jpg" width="500" alt="" />

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

[215. 数组中的第K个最大元素](https://leetcode-cn.com/problems/kth-largest-element-in-an-array/) 

```python
from heapq import heapify, heappush, heappop 
# python中的heap是小根堆:  heapify(hp) , heappop(hp), heappush(hp, v) 
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if k == 0 or k > n:
            return []
        
        hp = nums[:k]

        heapify(hp)

        for i in range(k, n):
            v = nums[i]
            if v > hp[0]:
                heappop(hp)
                heappush(hp, v)

        return hp[0]
```

## 3. DP 

No. | dynamic programming | Flag
:---: | --- | ---
no-gd | [31. n个骰子的点数](https://leetcode-cn.com/problems/nge-tou-zi-de-dian-shu-lcof) dp[i][j] ，表示投掷完 i 枚骰子后，点数 j 的出现次数 | ✔️
&nbsp; | [Summary 20 dynamic programming](/2019/08/31/leetcode/summary_dp/) |
(4.1) | **DP表示状态** |
easy | 1. climbing-stairs ， 新建{}or[] ,滚动数组 <br> 2. 连续子数组的最大和 | ❎
addition | [63. 多少种 不同路径 II](https://leetcode-cn.com/problems/unique-paths-ii/), `store = [[0]*n for i in range(m)]` 二维初始化 | ❎
<br> addition | [Edit Distance/编辑距离](https://leetcode-cn.com/problems/edit-distance/)【word1 转换成 word2】<br>&nbsp;&nbsp; 1. dp = [ [0] * (m + 1) for _ in range(n + 1)] <br>&nbsp;&nbsp; 2. dp[i][j] = min(A,B,C) | <br> ✔️❎
addition | [5. Longest Palindromic Substring/最长回文子串](https://leetcode-cn.com/problems/longest-palindromic-substring/) <br>1. 枚举子串的长度 l+1,从小问题到大问题 <br> 2. 枚举子串的起始位置 i, j=i+l 子串结束位置,  dp[i][j] = (dp[i+1][j-1] and s[i]==s[j])  | ✔️❎
good | [把数字翻译成字符串](https://leetcode-cn.com/problems/ba-shu-zi-fan-yi-cheng-zi-fu-chuan-lcof/) | Fib ✔️❎
addition | Leetcode 64. Minimum Path Sum, 最小路径和 `grid[i][j] = min(grid[i - 1][j], grid[i][j - 1]) + grid[i][j]` | ❎
addition | 115. Distinct Subsequences I | Hard
addition | 940. 不同的子序列 II | Hard
addition | Interleaving String/交错字符串 | Hard

## 4. sliding window & hash

No. | Question | Flag
:---: | --- | ---
(6). | sliding Window |
&nbsp; | 65. 最长不含重复字符的子字符串 `滑动窗口` | ✔️❎ 
&nbsp; | 14. 和为s的连续正数序列 &nbsp;&nbsp; [sliding window] <br><br> input：target = 9 <br> output：[[2,3,4],[4,5]] | ✔️❎ 
(7). | 模拟 |
&nbsp; | [21. 圆圈中最后剩下的数字](https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/) <br><br> 1. 当数到最后一个结点不足m个时，需要跳到第一个结点继续数 <br> 2. 每轮都是上一轮被删结点的下一个结点开始数 m 个 <br>3. 寻找 f(n,m) 与 f(n-1,m) 关系 <br> 4. A： f(n,m)=(m+x)%n  <br> 5. Python 深度不够手动设置 sys.setrecursionlimit(100000) <br> [东大 Lucien 题解,讲得最清楚的那个。官方讲解有误](https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/solution/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-by-lee/)  | <br><br><br><br>✔️❎
&nbsp; | 35. 顺时针打印矩阵 `left, right, top, bottom = 0, columns - 1, 0, rows - 1` | ✔️❎
&nbsp; | 56. 把数组排成最小的数, sorted vs sort, `strs.sort(key=cmp_to_key(sort_rule))` | ✔️❎  
&nbsp; | 70. 把字符串转换成整数 <br>&nbsp;&nbsp;&nbsp;&nbsp; int_max, int_min, bndry = 2**31-1, -2**31, 2**31//10 <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bndry=2147483647//10=214748364 ，则以下两种情况越界<br>&nbsp;&nbsp;&nbsp;&nbsp; res > bndry or res == bndry and c >'7' | ✔️❎


## 5. linkedList	

No. | Question | Flag
:---: | --- | ---
(3). | linkedList |
&nbsp; | 7. 从尾到头打印链表： <br>`reversePrint(head.next) + [head.val]` | ❎
&nbsp; | 8. [反转链表](https://leetcode-cn.com/problems/fan-zhuan-lian-biao-lcof/) pre, cur = head, head.next &nbsp; pre.next = None &nbsp; (循环版 双指针) <img src="/images/leetcode/linkedlist-reverseList.gif" width="600" alt="" /> | ❎
&nbsp; | 10. [合并两个排序的链表](https://leetcode-cn.com/problems/he-bing-liang-ge-pai-xu-de-lian-biao-lcof/) &nbsp;&nbsp; [**Recursion**] <br> p.next = self.mergeTwoLists(l1.next, l2) | ❎
addition | 旋转单链表 (F1. 环 F2. 走n-k%n 断开) <br> 举例： 给定 1->2->3->4->5->6->NULL, K=3 <br> 则4->5->6->1->2->3->NULL |  ❎
addition | [92. 翻转部分单链表](https://zhuanlan.zhihu.com/p/141775663) `reverse(head: ListNode, tail: ListNode)` <br> 举例：1->2->3->4->5->null, from = 2, to = 4 结果：1->4->3->2->5->null | ❎
addition | 链表划分, 描述： 给定一个单链表和数值x，划分链表使得小于x的节点排在大于等于x的节点之前 | ❎
addition | [82. 删除排序链表中的重复元素 II](https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list-ii/) 链表1->2->3->3->4->4->5 处理后为 1->2->5. | ❎
addition | 输入：(7 -> 1 -> 6) + (5 -> 9 -> 2)，即617 + 295 <br> 输出：2 -> 1 -> 9，即912 |

## 6. stack

No. | Question | Flag
:---: | --- | ---
(2). | Stack |
&nbsp; | [394. 字符串解码 [a]2[bc]](https://leetcode-cn.com/problems/decode-string/) | ❎
&nbsp; | [28. 包含min函数的栈](https://leetcode-cn.com/problems/bao-han-minhan-shu-de-zhan-lcof/) | ❎
&nbsp; | [29. 最小的k个数【堆排的逆向】](https://leetcode-cn.com/problems/zui-xiao-de-kge-shu-lcof/) `heapq.heappop(hp),heapq.heappush(hp, -arr[i])` | ✔️❎
&nbsp; | 36. 滑动窗口的最大值  (同理于包含 min 函数的栈) deque.popleft(),双端队列+单调 | ✔️❎
&nbsp; | [59 II. 队列的最大值](https://leetcode-cn.com/problems/dui-lie-de-zui-da-zhi-lcof/) , `维护个单调的deque` <br> &nbsp;&nbsp; import queue, queue.deque(), queue.Queue(), deq[0], deq[-1] | ✔️❎
(5). | DFS / BFS |
&nbsp; | [66. 矩阵中的路径](https://leetcode-cn.com/problems/ju-zhen-zhong-de-lu-jing-lcof/) , `经典好题: 深搜+回溯` def dfs(i, j, k): |  ✔️❎ 
&nbsp; | [61. 机器人的运动范围](https://leetcode-cn.com/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof) `bfs` good <br> &nbsp;&nbsp; `from queue import Queue, q.get() q.pup()` | ✔️❎ 


## 7. string

## 8. Tree [剑指](https://leetcode-cn.com/problemset/lcof/)

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
