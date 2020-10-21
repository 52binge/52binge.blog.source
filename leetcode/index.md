---
title: Coding
---

<!--# [Sea](https://leetcode-cn.com/company/shopee/)-->

No. | Question
:---: | ---
(1). | **binary-search** 
&nbsp; | [1.1 二分查找](https://leetcode-cn.com/problems/binary-search/)
&nbsp; | [1.2 在排序数组中查找元素的第一个和最后一个位置](https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array/)
(2). | DFS 
&nbsp; | [2.1 字符串解码 [a]2[bc]](https://leetcode-cn.com/problems/decode-string/)
&nbsp; | s = "3[a]2[bc]"
(3). | Digit 
 &nbsp; | [3.1 回文数](https://leetcode-cn.com/problems/palindrome-number/)
(4). | DP 
&nbsp; | [4.1 栅栏涂色](https://leetcode-cn.com/problems/paint-fence/)
&nbsp; | [4.2 区域和检索](https://leetcode-cn.com/problems/range-sum-query-immutable/)
&nbsp; | [4.3 零钱兑换](https://leetcode-cn.com/problems/coin-change/)
&nbsp; | [4.4 除自身以外数组的乘积](https://leetcode-cn.com/problems/product-of-array-except-self/)
(5). | hash 
&nbsp; | [5.1 两数之和](https://leetcode-cn.com/problems/two-sum/)
(6). | linkedList 
- | [6.1 相交链表](https://leetcode-cn.com/problems/intersection-of-two-linked-lists/)
- | [6.2 环形链表](https://leetcode-cn.com/problems/linked-list-cycle/)
- | [6.3 两数相加](https://leetcode-cn.com/problems/add-two-numbers/)
- | [6.4 复制带随机指针的链表](https://leetcode-cn.com/problems/copy-list-with-random-pointer/)
- | [6.5 LRUCache](https://leetcode-cn.com/company/shopee/)
- | [6.6 删除链表的倒数第N个节点](https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list/)
- | [6.7 排序链表](https://leetcode-cn.com/problems/sort-list/)
(7). | stack 
- | [7.1 有效的括号](https://leetcode-cn.com/problems/valid-parentheses/)
(8). | string 
- | [8.1 字符串相加](https://leetcode-cn.com/problems/add-strings/)
- | [8.2 比较版本号](https://leetcode-cn.com/problems/compare-version-numbers/)
- | [8.3 字符串解码](https://leetcode-cn.com/problems/decode-string/)
- | [8.4 无重复字符的最长子串](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/)
- | [8.5 下一个更大元素 III](https://leetcode-cn.com/problems/next-greater-element-iii/)
- | [8.6 全排列](https://leetcode-cn.com/problems/permutations/)
(9). | tree 
- | [9.1 从前序与中序遍历序列构造二叉树](https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)
- | [9.2 二叉树的中序遍历](https://leetcode-cn.com/problems/binary-tree-inorder-traversal/)
- | [9.3 二叉树的右视图](https://leetcode-cn.com/problems/binary-tree-right-side-view/)


```
# 1 5 8 4 7 6 5 3 1
#
# 1 5 8 5 7 6 4 3 1
#
# 1 5 8 5 1 3 4 6 7
```


# [剑指](https://leetcode-cn.com/problemset/lcof/)


No. | Question | Flag
:---: | --- | ---
**easy** |  |  
4 | 二叉树的镜像： `swap后+递归` | ❎
7 | 从尾到头打印链表： <br>`reversePrint(head.next) + [head.val]` | ❎
8 | 反转链表 &nbsp;&nbsp; [**Recursion**] (需要在写一个循环版) <br>`cur = self.reverseList(head.next)`<br>`head.head.next = head`<br>`head.next = None`<br>`return cur` | ✔️ 
9 | 二叉搜索树的第k大节点 &nbsp;&nbsp; [中序遍历 倒序] <br>`dfs(root.right)`<br> `self.k -= 1` <br> `dfs(root.left)`  | ✔️ 
10 | 合并两个排序的链表 &nbsp;&nbsp; [**Recursion**] <br> p.next = self.mergeTwoLists(l1.next, l2) | ❎
13 | 二叉树的最近公共祖先 &nbsp;&nbsp; [**Recursion**] | ✔️ 
14 | 和为s的连续正数序列 &nbsp;&nbsp; [sliding window] <br><br> input：target = 9 <br> output：[[2,3,4],[4,5]] | ✔️ 
15 | 二叉搜索树的最近公共祖先 &nbsp;&nbsp; [**Recursion** + 剪枝] | ✔️ 
21 | [圆圈中最后剩下的数字](https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/) `需要在review..` | ✔️
26 | 平衡二叉树 <br> abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 and self.isBalanced(root.left) and self.isBalanced(root.right) | ✔️ 
27 | 对称的二叉树 | ✔️
28 | 包含min函数的栈 | ❎
29 | [最小的k个数 【heapq 堆排序 的逆向思维】](http://localhost:5000/leetcode/#32-%E6%9C%80%E5%B0%8F%E7%9A%84k%E4%B8%AA%E6%95%B0) | ✔️
31 | n个骰子的点数 | ✔️
35 | 顺时针打印矩阵 | ✔️
36 | 滑动窗口的最大值 | ✔️
37 | 0～n-1中缺失的数字 | ❎
 | | 
**medium** |  | 
 | | 
42 | 求1+2+…+n | ❎
43 | 数组中数字出现的次数 | so hard
44 | 复杂链表的复制 | ❎ 
45 | 数组中数字出现的次数 | ❎ 
46 | 重建二叉树 | ❎ 
47 | 礼物的最大价值 `f = [len(grid[0]) * [0]] * len(grid)` | ❎ 
48 | 从上到下打印二叉树 III `queue.append([root, 0])` | ❎ 
49 | 丑数 n2, n3, n5 = dp[a] * 2, dp[b] * 3, dp[c] * 5 | ❎ 
50 | 二叉搜索树与双向链表 `self.pre = None, self.head = cur; self.pre = cur` | ✔️  
51 | 股票的最大利润 （买卖一次）  <br>`cost, profit = float("+inf"), 0` <br> for price in prices:<br>&nbsp;&nbsp;&nbsp;&nbsp;`cost, profit = min(cost, price), max(profit, price - cost)` |  
54 | 构建乘积数组 | ❎ 
55 | **二叉树中和为某一值的路径** <br><br> `if sum == 0 and root.left is None and root.right is None` | <br><br> ✔️ 
56 | 把数组排成最小的数 `strs.sort(key=cmp_to_key(sort_rule))` | ✔️ 
57 | 剪绳子 (1) n < 4 (2) n == 4 (3) n > 4, 多个 == 3 段 | ❎ 
58 | 字符串的排列 `c = list(s) res = [] def dfs(x):` | ❎  
59 | 把数字翻译成字符串 `f[i] = f[i-1] + f[i-2]` 同 打家劫舍 | ❎  
60 | 二叉搜索树的后序遍历序列 `def recur(i, j):` | ❎ 
61 | 机器人的运动范围 `bfs` good | ✔️ 
62 | 队列的最大值 |  
65 | 最长不含重复字符的子字符串 `滑动窗口` |  
66 | 矩阵中的路径 |  ✔️
68 | 数值的整数次方  （1）当 n 为偶数 （2）当 n 为奇数 | ❎
70 | 把字符串转换成整数 `int_max, int_min, bndry = 2 ** 31 - 1, -2 ** 31, 2 ** 31 // 10: res > bndry or res == bndry and c > '7'` | ✔️
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


### 1.1 构造二叉树

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

### 1.2 平衡二叉树

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

### 1.5 对称的二叉树

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

### 2.1 从尾到头打印链表

```python
self.reversePrint(head.next) + [head.val]
```

### 2.2 反转链表

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

### 2.3 复杂链表的复制

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

### 4.1 圆圈中最后剩下的数字

```python
# 输入: n = 5, m = 3
# 输出: 3
# 0, 1, 2, 3, 4
# 题目中的要求可以表述为：给定一个长度为 n 的序列，每次向后数 m 个元素并删除，那么最终留下的是第几个元素？
#
# 这个问题很难快速给出答案。但是同时也要看到，这个问题似乎有拆分为较小子问题的潜质：如果我们知道对于一个长度 n - 1 的序列，留下的是第几个元素，那么我们就可以由此计算出长度为 n 的序列的答案。
#
# 算法
#
# 我们将上述问题建模为函数 f(n, m)，该函数的返回值为最终留下的元素的序号。
#
# 首先，长度为 n 的序列会先删除第 m % n 个元素，然后剩下一个长度为 n - 1 的序列。那么，我们可以递归地求解 f(n - 1, m)，就可以知道对于剩下的 n - 1 个元素，最终会留下第几个元素，我们设答案为 x = f(n - 1, m)。
#
# 由于我们删除了第 m % n 个元素，将序列的长度变为 n - 1。当我们知道了 f(n - 1, m) 对应的答案 x 之后，我们也就可以知道，长度为 n 的序列最后一个删除的元素，应当是从 m % n 开始数的第 x 个元素。因此有 f(n, m) = (m % n + x) % n = (m + x) % n。
# Python 默认的递归深度不够，需要手动设置

import sys

# Python解释器默认对递归深度设定为998，但可以用sys.setrecursionlimit(99999999)来打破这个限制。
sys.setrecursionlimit(100000)


def f(n, m):
    if n == 0:
        return 0
    x = f(n - 1, m)
    return (m % n + x) % n

    # return (m + x) % n


class Solution:
    def lastRemaining(self, n: int, m: int) -> int:
        return f(n, m)
```


### 4.2 最小的k个数

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

### 4.3 n个骰子的点数

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

### 4.4 顺时针打印矩阵

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
 
### 4.5 把数组排成最小的数

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
 
### 4.6 把字符串转换成整数 

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


## Reference

- [成长之路 0607offer](https://blog.csdn.net/qq_24243877)
- [知乎： [Leetcode][动态规划]相关题目汇总/分析/总结](https://zhuanlan.zhihu.com/p/35707293)
- [简书： 2019 算法面试相关(leetcode)--动态规划(Dynamic Programming)](https://www.jianshu.com/p/af880bbba792)
- [CSDN leetcode DP](https://blog.csdn.net/EbowTang/article/details/50791500)
- [刷完700多题后的首次总结：LeetCode应该怎么刷？](https://blog.csdn.net/fuxuemingzhu/article/details/105183554)
- [小白一路走来，连续刷题三年，谈谈我的算法学习经验](https://www.cnblogs.com/kubidemanong/p/10996134.html)
[codebunk.com](https://codebunk.com/b/3421100160572/)
[《程序员的算法趣题》-开坑记录](https://www.dattyrabbit.cn/articles/2020/08/16/1597576674555.html?utm_source=ld246.com)
