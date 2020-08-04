---
title: 总结 20 道题搞定 leetcode - 二叉树
toc: true
date: 2020-08-03 23:07:21
categories: [icpc]
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

### 6.1 自下而上分层遍历

### 6.2 按之字形顺序打印二叉树

## 7. 求二叉树第K层的节点个数

## 8. 求二叉树第K层的叶子节点个数

## 9. 判断两棵二叉树是否结构相同

## 10. 判断二叉树是不是平衡二叉树

## 11. 求二叉树的镜像

### 11.1 对称二叉树

## 12. 求二叉树中两个节点的最低公共祖先节点

## 13. 求二叉树的直径

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

## 16. 树的子结构

## 17. 二叉树中和为某一值的路径

## 18. 二叉树的下一个结点

## 19. 序列化二叉树

## 20. 二叉搜索树的第k个结点

## Reference

- [good blog - python_data_structure](https://www.tutorialspoint.com/python_data_structure/python_tree_traversal_algorithms.htm)
- [python_tree_traversal_algorithms](https://www.tutorialspoint.com/python_data_structure/python_tree_traversal_algorithms.htm)
- [[算法总结] 20 道题搞定 BAT 面试——二叉树](https://weiweiblog.cn/20tree/)

