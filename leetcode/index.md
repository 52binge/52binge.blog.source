# [剑指](https://leetcode-cn.com/problemset/lcof/)

No. | Question | Flag
--- | --- | ---
**easy** |  |  
1 | 左旋转字符串 | ❎
2 | 链表中倒数第k个节点 | ❎
3 | 二叉树的深度 | ❎
4 | 二叉树的镜像 | ✔️
5 | 打印从1到最大的n位数 | ❎
6 | 替换空格 | ❎
7 | 从尾到头打印链表 | ❎
8 | 反转链表 &nbsp;&nbsp; [**Recursion**] | ✔️ 
9 | 二叉搜索树的第k大节点 &nbsp;&nbsp; [中序遍历 倒序] | ✔️ 
10 | 合并两个排序的链表 | ❎
11 | 二进制中1的个数 [n = n & (n-1)] | ❎ 
12 | 用两个栈实现队列 | ❎
13 | 二叉树的最近公共祖先 &nbsp;&nbsp; [**Recursion**] | ✔️ 
14 | 和为s的连续正数序列 &nbsp;&nbsp; [sliding window]| ✔️ 
15 | 二叉搜索树的最近公共祖先 &nbsp;&nbsp; [**Recursion** + 剪枝] | ✔️ 
16 | 从上到下打印二叉树II | ❎
17 | 数组中出现次数超过一半的数字 | ❎
18 | 数组中重复的数字 | ❎
19 | 和为s的两个数字 | ❎
20 | 调整数组顺序使奇数位于偶数前面 | ❎
21 | 圆圈中最后剩下的数字 | ✔️
22 | 两个链表的第一个公共节点 | ❎
23 | 第一个只出现一次的字符 | ❎
24 | 连续子数组的最大和 | ❎
25 | 删除链表的节点 | ❎
26 | 平衡二叉树 <br> abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 and self.isBalanced(root.left) and self.isBalanced(root.right) | ✔️ 
27 | 对称的二叉树 | ✔️
28 | 包含min函数的栈 | ❎
29 | 最小的k个数 【堆排序 的逆向思维】| ✔️
30 | 不用加减乘除做加法  add(a ^ b, (a & b) << 1) | ❎
31 | n个骰子的点数 | ✔️
32 | 在排序数组中查找数字I | ❎
33 | 旋转数组的最小数字 | ❎
34 | 扑克牌中的顺子 ma - mi < 5 | ❎
35 | 顺时针打印矩阵 | ✔️
36 | 滑动窗口的最大值 | ✔️
37 | 0～n-1中缺失的数字 | ❎
38 | 翻转单词顺序 | ❎
39 | 青蛙跳台阶问题 | ❎
40 | 二维数组中的查找 | ❎
41 | 斐波那契数列 | ❎
 | | 
**medium** |  | 
 | | 
42 | 求1+2+…+n | ❎
43 | 数组中数字出现的次数 | so hard
44 | 复杂链表的复制 |  
45 | 数组中数字出现的次数 |  
46 | 重建二叉树 |  
47 | 礼物的最大价值 |  
48 | 从上到下打印二叉树 |  
49 | 丑数 |  
50 | 二叉搜索树与双向链表 |  
51 | 股票的最大利润 |  
52 | 栈的压入、弹出序列 |  
53 | 从上到下打印二叉树 |  
54 | 构建乘积数组 |  
55 | 二叉树中和为某一值的路径 |  
56 | 把数组排成最小的数 |  
57 | 剪绳子 |  
58 | 字符串的排列 |  
59 | 把数字翻译成字符串 |  
60 | 二叉搜索树的后序遍历序列 |  
61 | 机器人的运动范围 |  
62 | 队列的最大值 |  
63 | 树的子结构 |  
64 | 1～n整数中1出现的次数 |  
65 | 最长不含重复字符的子字符串 |  
66 | 矩阵中的路径 |  
67 | 数字序列中某一位的数字 |  
68 | 数值的整数次方 |  
69 | 剪绳子 |  
70 | 把字符串转换成整数 | 
71 | 表示数值的字符串 | 
 | | 
**hard** |  | 
 | | 
72 | 数据流中的中位数 | 
73 | 序列化二叉树 | 
74 | 数组中的逆序对 | 
75 | 正则表达式匹配 | 

## 1. Tree

二叉树的镜像

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

二叉树的最近公共祖先

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

二叉搜索树的最近公共祖先

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

对称的二叉树

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



## 2. LinkedList

7). 从尾到头打印链表

```python
self.reversePrint(head.next) + [head.val]
```

8). 反转链表

```python
# 输入: 1->2->3->4->5->NULL
# 输出: 5->4->3->2->1->NULL

# step1: 1->2->3->4<-5
# step2: 1->2->3<-4<-5
# step3: 1->2<-3<-4<-5
#
# step4: NULL<-1<-2<-3<-4<-5

class Solution(object):
    def reverseList(self, head) -> ListNode:
        if (head == None or head.next == None):
            return head
        
        cur = self.reverseList(head.next)
        # 如果链表是 1->2->3->4->5，那么此时的cur就是5
        # 而head是4，head的下一个是5，下下一个是空
        # 所以head.next.next 就是5->4
        head.head.next = head
        # 防止链表循环，需要将head.next设置为空
        head.next = None
        # 每层**Recursion**函数都返回cur，也就是最后一个节点
        return cur
```

剑指 Offer 35. 复杂链表的复制

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


## 3. Array & Sort

最小的k个数

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

n个骰子的点数

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

剑指 Offer 29. 顺时针打印矩阵

```python
# -*- coding: utf-8 -*-
"""
    @file: e.spiralOrder.py
    @date: 2020-09-07 4:19 PM
    @desc: 剑指 Offer 29. 顺时针打印矩阵
    @url : https://leetcode-cn.com/problems/shun-shi-zhen-da-yin-ju-zhen-lcof/
"""

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

## 4. sliding window

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