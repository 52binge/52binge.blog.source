---
title: 总结 20 道题搞定 leetcode - 二叉树
toc: true
date: 2020-08-03 23:07:21
categories: [leetcode]
tags: [Tree]
---

<!--<img src="/images/icpc/BinaryTree-1.png" width="450" alt="" />-->

<img src="/images/leetcode/binary_tree-1.jpg" width="600" alt="" />

<!-- more -->

## 0. 几个概念

> 完全二叉树：若二叉树的高度是h，除第h层之外，其他（1h-1）层的节点数都达到了最大个数，并且第h层的节点都连续的集中在最左边。想到点什么没？实际上，完全二叉树和堆联系比较紧密哈
>
> 满二叉树：除最后一层外，每一层上的所有节点都有两个子节点，最后一层都是叶子节点。
>
> 哈夫曼树：给定n个权值作为n的叶子结点，构造一棵二叉树，若带权路径长度达到最小，称这样的二叉树为最优二叉树，也称为哈夫曼树(Huffman tree)。
>
> 二叉排序树：又称二叉查找树（Binary Search Tree），亦称二叉搜索树。二叉排序树或者是一棵空树，
>
> 二分查找的时间复杂度是O(log(n))，最坏情况下的时间复杂度是O(n)（相当于顺序查找）
>
> 平衡二叉树：又称 AVL 树。平衡二叉树是二叉搜索树的进化版，所谓平衡二叉树指的是，左右两个子树的高度差的绝对值不超过 1。
>
> 红黑树：红黑树是每个节点都带颜色的树，节点颜色或是红色或是黑色，红黑树是一种查找树。红黑树有一个重要的性质，从根节点到叶子节点的最长的路径不多于最短的路径的长度的两倍。对于红黑树，插入，删除，查找的复杂度都是O（log N）。

## 1. 求二叉树中的节点个数

python

```python
class Node:
    def __init__(self, x):
        self.val = x
        self.lchild = None
        self.rchild = None
        
def getNodeNumRec(root): #递归求叶子节点个数
    if root == None:
        return 0

    return getNodeNumRec(root.lchild)+ getNodeNumRec(root.rchild) + 1
```

java

```java
public static int getNodeNumRec(TreeNode root) {
        if (root == null) {
            return 0;
        }             
        return getNodeNumRec(root.left) + getNodeNumRec(root.right) + 1;
}

```

## 2. 求二叉树的最大层数(最大深度)

递归解法：

>（1）如果二叉树为空，二叉树的深度为0
>（2）如果二叉树不为空，二叉树的深度 = max(左子树深度， 右子树深度) + 1

python

```python
def max_depth(root):
    if root == None:
        return 0
    return max(max_depth(root.left), max_depth(root.right))+1
```

### 2.1 二叉树的最小深度

给定一个二叉树，找出其最小深度。

最小深度是从根节点到最近叶子节点的最短路径上的节点数量。

python

```python
def min_depth(root):
    if root == None:
        return 0
    left = min_depth(root.left)
    right = min_depth(root.right)
    return left + right + 1 if (left == 0 or right == 0) else min(left, right) + 1
```

## 3. 先序遍历/前序遍历

[LeetCode：Binary Tree Preorder Traversal](https://leetcode.cn/problems/binary-tree-preorder-traversal/)

Given a binary tree, return the preorder traversal of its nodes' values.

给定二叉树，返回其节点值的前序遍历。 根 - 左 - 右

```
Input: [1,null,2,3]
   1
    \
     2
    /
   3

Output: [1,2,3]
```

有两种通用的遍历树的策略：

> 1. 深度优先搜索（DFS）
> 2. 宽度优先搜索（BFS）

<img src="/images/leetcode/binary_tree-2.png" width="600" alt="" />

```python
class TreeNode(object):
    """ Definition of a binary tree node."""
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
```

递归 (Recursive)

```python
def pre_order(root, output):
    if root == None:
        return
    
    output.add(root.val)
    
    pre_order(root.left, output)
    pre_order(root.right, output)

def in_order(root, output):
    if root == None:
        return
    
    in_order(root.left, output)
    output.add(root.val)
    in_order(root.right, output)
```

非递归 (non-recursive )

```python
class Solution(object):
    def preorderTraversal(self, root):
        """
        :type root: TreeNode
        :rtype: List[int]
        """
        if root is None:
            return []
        
        stack, output = [root, ], []
        
        while stack:
            root = stack.pop() # python stack == list, pop()
            if root is not None:
                output.append(root.val)
                if root.right is not None: ## first right into, due to stack
                    stack.append(root.right)
                if root.left is not None:
                    stack.append(root.left)
        
        return output
```

## 4. 中序非递归

[LeetCode：Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal/description/)

```python
def inOrder(self, root):
    if root == None:
        return
    myStack = []
    node = root
    while node or myStack:
        while node:
            # 从根节点开始，一直找它的左子树
            myStack.append(node)
            node = node.lchild
        # while结束表示当前节点node为空，即前一个节点没有左子树了
        node = myStack.pop()
        print node.val
        # 开始查看它的右子树
        node = node.rchild
```

## 5. 后序非递归

[LeetCode：Binary Tree Postorder Traversal](https://leetcode.com/problems/binary-tree-postorder-traversal/description/)

```python
def later_stack(self, root):
    if root == None:
        return
    myStack1 = []
    myStack2 = []
    node = root
    myStack1.append(node)
    while myStack1:
    # 这个while循环的功能是找出后序遍历的逆序，存在myStack2里面
        node = myStack1.pop()
        if node.lchild:
            myStack1.append(node.lchild)
        if node.rchild:
            myStack1.append(node.rchild)
        myStack2.append(node)
    while myStack2:
    # 将myStack2中的元素出栈，即为后序遍历次序
        print myStack2.pop().val
```

## 6. 分层遍历

[LeetCode：Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/description/)

本题是让我们把二叉树的每一层节点放入到同一个列表中，最后返回各层的列表组成的总的列表。

可以使用 BFS 和 DFS 解决。

左边是BFS，按照层进行搜索；图右边是DFS，先一路走到底，然后再回头搜索。

<img src="/images/leetcode/binary_tree-3.png" width="700" alt="" />

模板2

```python
from collections import deque 
A=deque([]) #创建一个空的双队列
A.append(n) #从右边像队列中增加元素 ，n表示增加的元素
A.appendleft(n) #从左边像队列中增加元素，n表示增加的元素
A.pop() #从队列的右边删除元素，并且返回删除值
A.popleft() #从队列的左边删除元素，并且返回删除值
```

题目描述：

```
示例：
二叉树：[3,9,20,null,null,15,7],

    3
   / \
  9  20
    /  \
   15   7

返回其层次遍历结果：

[
  [3],
  [9,20],
  [15,7]
]
```

Answer：

```python
from collections import deque

class Solution(object):
    def levelOrder(self, root):
        """
        :type root: TreeNode
        :rtype: List[List[int]]
        """
        queue = collections.deque()
        queue.append(root)
        res = []
        while queue:
            size = len(queue)
            level = []
            for _ in range(size):
                cur = queue.popleft()
                if not cur:
                    continue
                level.append(cur.val)
                queue.append(cur.left)
                queue.append(cur.right)
            if level:
                res.append(level)
        return res
```

### 6.1 自下而上分层遍历

此处撰写解题思路

一个队列用于保存树结构，另一个保存遍历的结果；
利用队列的特性，层序遍历每层的结果；

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def levelOrderBottom(self, root: TreeNode) -> List[List[int]]:
        if root == None:
            return []
        stack = [root]
        result = []
        while len(stack) != 0:
            num = len(stack)
            r_temp = []
            for i in range(num):
                node = stack.pop(0)
                r_temp.append(node.val)
                if node.left:
                    stack.append(node.left)
                if node.right:
                    stack.append(node.right)
            result.insert(0, r_temp)
        return result
```

### 6.2 按之字形顺序打印二叉树 （不错code）

请实现一个函数按照之字形打印二叉树，即第一行按照从左到右的顺序打印，第二层按照从右至左的顺序打印，第三行按照从左到右的顺序打印，其他行以此类推。

> 1). 设两个栈，s2存放奇数层，s1存放偶数层
>
> 2). 遍历s2节点的同时按照左子树、右子树的顺序加入s1，
>
> 3). 遍历s1节点的同时按照右子树、左子树的顺序加入s2

```python
# -*- coding:utf-8 -*-
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None
class Solution:
    def Print(self, pRoot):
        if not pRoot:
            return []
        # write code here
        curLayer = [pRoot]
        res = []
        cnt = 0
        while curLayer:
            nextLayer = []
            tmp = []
            for node in curLayer:
                tmp.append(node.val)
                if node.left:
                    nextLayer.append(node.left)
                if node.right:
                    nextLayer.append(node.right)
            if cnt == 0:
                res.append(tmp)
            else:
                res.append(tmp[::-1])
            curLayer = nextLayer
            cnt = (cnt+1) % 2
        return res
```

## 7. 求二叉树第K层的节点个数

```python
def get_k_level_number(root, k): 
    if root == None or k ==0:
        return 0
    
    if root != None and k == 1:
        return 1
    
    return get_k_level_number(root.left, k-1) + get_k_level_number(root.right, k-1)
```

## 8. 求二叉树第K层的叶子节点个数

```python
def get_k_level_leaf_number(root, k):
    if root == None || k == 0:
        return 0
    
    if root != None and k == 1:
        if root.left == None and root.right == None
            return 1
        else
            return 0
    
    return get_k_level_number(root.left, k-1) + get_k_level_number(root.right, k-1)
```

## 9. 判断两棵二叉树是否结构相同

给定两个二叉树，编写一个函数来检查它们是否相同。

递归解法：

>（1）如果两棵二叉树都为空，返回真
>
>（2）如果两棵二叉树一棵为空，另一棵不为空，返回假
>
>（3）如果两棵二叉树都不为空，如果对应的左子树和右子树都同构返回真，其他返回假

```python
def isSameTree(p: TreeNode, q: TreeNode):
    if p == None and q == None:
        return True
    if p == None or q == None:
        return False

    if p.val == q.val:
        return isSameTree(p.left, q.left) and isSameTree(p.right, q.right)
    return False
```

## 10. 判断二叉树是不是平衡二叉树

```python
def isBalanced(TreeNode root):

    if root == None:
        return True
        
    return abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 and \ 
            isBalanced(root.left) and isBalanced(root.right)
	
    def maxHigh(root):
        if root == None:
            return 0
        return max(maxHigh(root.left), maxHigh(root.right)) + 1
```

## 11. 求二叉树的镜像

LeetCode：[Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree/description/) 翻转一棵二叉树

```
翻转一棵二叉树.
输入：

     4
   /   \
  2     7
 / \   / \
1   3 6   9
输出：

     4
   /   \
  7     2
 / \   / \
9   6 3   1
```

```python
def invertTree(root):
    if root == None:
        return root

    node = root.left
    root.left = invertTree(root.right)
    root.right = invertTree(node)

    return root
```

### 11.1 对称二叉树

LeetCode： [101. Symmetric Tree](https://leetcode-cn.com/problems/symmetric-tree/description/)

```
例如，二叉树 [1,2,2,3,4,4,3] 是对称的。

    1
   / \
  2   2
 / \ / \
3  4 4  3
```

```python
def isSymmetric(root: TreeNode):
    return root == None or isSymmetricHelper(root.left, root.right)
    
    def isSymmetricHelper(left: TreeNode, right: TreeNode):
        if left == None and right == None:
            return True
        if left == None or right == None:
            return False
        if left.val != right.val:
            return False
        return isSymmetricHelper(left.left, right.right) and isSymmetricHelper(left.right, right.left)
```

## 12. 求二叉树中两个节点的最低公共祖先节点

LeetCode：[Lowest Common Ancestor of a Binary Tree](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/description/)

<img src="/images/leetcode/binary-tree-5.png" width="600" alt="" />

给定二叉树，找到树中两个给定节点的最低共同祖先（LCA）。

<img src="/images/leetcode/binary-tree-6.png" width="600" alt="" />

**递归解法**：

（1）如果两个节点分别在根节点的左子树和右子树，则返回根节点

（2）如果两个节点都在左子树，则递归处理左子树；如果两个节点都在右子树，则递归处理右子树

[二叉树的最近公共祖先（后序遍历 DFS ，清晰图解）](https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/solution/236-er-cha-shu-de-zui-jin-gong-gong-zu-xian-hou-xu/)

**根据以上定义，若 root 是 p,q 的 最近公共祖先 ，则只可能为以下情况之一**：

> 1). p 和 q 在 root 的子树中，且分列 root 的 异侧（即分别在左、右子树中）；
> 2). p = root，且 q 在 root 的左或右子树中；
> 3). q = root，且 p 在 root 的左或右子树中；
>
> 考虑通过递归对二叉树进行后序遍历，当遇到节点 p 或 q 时返回。**从底至顶回溯**，当节点 p, q 在节点 root 的异侧时，节点 root 即为最近公共祖先，则向上返回 root.


```python
def lowestCommonAncestor(root: TreeNode, p: TreeNode, q: TreeNode):
    # 当越过叶节点，则直接返回 null
    # 当 rootroot 等于 p, q， 则直接返回 root
    if root == None or root == p or root == q:
        return root
    
    left = lowestCommonAncestor(root.left, p, q)
    right = lowestCommonAncestor(root.right, p, q)
    
    if not left and not right: return None
    
    if not left: return right
    if not right: return left
    
    return root
    #if left != None and right != None:
    #    return root
```

### 12.1 求二叉搜索树的最近公共祖先

LeetCode：[Lowest Common Ancestor of a Binary Search Tree](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/description/)

给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。

百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

## 13. 求二叉树的直径

LeetCode：Diameter of Binary Tree

给定一棵二叉树，你需要计算它的直径长度。一棵二叉树的直径长度是任意两个结点路径长度中的最大值。这条路径可能穿过根结点。



递归解法：对于每个节点，它的最长路径等于左子树的最长路径+右子树的最长路径

## 14. 由前序遍历序列和中序遍历序列重建二叉树

前序遍历 preorder = [3,9,20,15,7]
中序遍历 inorder = [9,3,15,20,7]

```python
def buildTree(self, preorder, inorder):
    if not (preorder and inorder):
        return None
    # 根据前序数组的第一个元素，就可以确定根节点	
    root = TreeNode(preorder[0])
    # 用preorder[0]去中序数组中查找对应的元素
    mid_idx = inorder.index(preorder[0])
    # 递归的处理前序数组的左边部分和中序数组的左边部分
    # 递归处理前序数组右边部分和中序数组右边部分
    root.left = self.buildTree(preorder[1:mid_idx+1],inorder[:mid_idx])
    root.right = self.buildTree(preorder[mid_idx+1:],inorder[mid_idx+1:])
    return root
```


## 15. 判断二叉树是不是完全二叉树

完全二叉树是指最后一层左边是满的，右边可能慢也不能不满，然后其余层都是满的，根据这个特性，利用层遍历。如果我们当前遍历到了NULL结点，如果后续还有非NULL结点，说明是非完全二叉树

## 16. 树的子结构

输入两棵二叉树A，B，判断B是不是A的子结构。

## 17. 二叉树中和为某一值的路径

剑指offer：二叉树中和为某一值的路径

输入一颗二叉树和一个整数，打印出二叉树中结点值的和为输入整数的所有路径。路径定义为从树的根结点开始往下一直到叶结点所经过的结点形成一条路径。

## 18. 二叉树的下一个结点

剑指offer：二叉树的下一个结点

给定一个二叉树和其中的一个结点，请找出中序遍历顺序的下一个结点并且返回。注意，树中的结点不仅包含左右子结点，同时包含指向父结点的指针。

## 19. 序列化二叉树

剑指offer：序列化二叉树

LeetCode：Serialize and Deserialize Binary Tree

请实现两个函数，分别用来序列化和反序列化二叉树

## 20. 二叉搜索树的第k个结点

剑指offer：二叉搜索树的第k个结点

给定一棵二叉搜索树，请找出其中的第k小的结点。例如， （5，3，7，2，4，6，8）中，按结点数值大小顺序第三小结点的值为4。

因为二叉搜索树按照中序遍历的顺序打印出来就是排好序的，所以，我们按照中序遍历找到第k个结点就是题目所求的结点。

## Reference

- [负雪明烛](https://blog.csdn.net/fuxuemingzhu)
- [【LeetCode】代码模板，刷题必会](https://blog.csdn.net/fuxuemingzhu/article/details/101900729)

- [good blog - python_data_structure](https://www.tutorialspoint.com/python_data_structure/python_tree_traversal_algorithms.htm)
- [python_tree_traversal_algorithms](https://www.tutorialspoint.com/python_data_structure/python_tree_traversal_algorithms.htm)
- [[算法总结] 20 道题搞定 BAT 面试——二叉树](https://weiweiblog.cn/20tree/)

