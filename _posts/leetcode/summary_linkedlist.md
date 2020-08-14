---
title: 总结 17 道题 LinkList
toc: true
date: 2020-08-14 18:07:21
categories: [leetcode]
tags: [LinkList]
---

<!--<img src="/images/icpc/BinaryTree-1.png" width="450" alt="" />-->

<img src="/images/leetcode/binary_tree-2.png" width="600" alt="" />

<!-- more -->

**easy：**

> 1. 递归： [求二叉树中的节点个数] ， f(root.lchild)+ f(root.rchild) + 1 ， **✔️**
> 2. 递归： [求二叉树(最大深度)&(最小深度)] ，max(max_depth(root.left), max_depth(root.right))+1

**0. 几个概念**

> 完全二叉树：若二叉树的高度是h，除第h层之外，其他（1h-1）层的节点数都达到了最大个数，并且第h层的节点都连续的集中在最左边。想到点什么没？实际上，完全二叉树和堆联系比较紧密哈

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

## Reference

- [负雪明烛](https://blog.csdn.net/fuxuemingzhu)
- [【LeetCode】代码模板，刷题必会](https://blog.csdn.net/fuxuemingzhu/article/details/101900729)

- [17 道 LinkList](https://weiweiblog.cn/linkedlist_summary/)
