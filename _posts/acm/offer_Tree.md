---
title: Binary Tree
toc: true
date: 2019-06-11 10:06:21
categories: icpc
tags: acm
---

<img src="/images/icpc/BinaryTree-1.png" width="450" />


<!-- more -->

> 1. 重建二叉树 ok Node\* f3(int\* pre, int\* ino, int len)       
> 2. 树的子结构,遍历+判断, bool f5(Node\* root1, Node\* root2), bool son(Node\* p1, Node\* p2) 
> 3. 二叉树的镜像  ok 递归.   
> 4. 从上往下打印二叉树 ok bfs      
> 5. 二叉搜索树的后序遍历序列 bool f6(int\* sec, int len)  
> 6. 二叉树中和为某一值的路径 void f4(Node\* root, int exSum, int curSum, vecotr\< int \>& path)     
> 7. 二叉搜索树与双向链表 void convert(Node\* root, Node\*& pLast)   
> 8. 二叉树的深度 bool isBalance(Node\* root, int\* dep)
> 9. 平衡二叉树 bool isBalance(Node\* root, int\* dep)    
> 10. [二叉树的下一个结点](https://blog.csdn.net/libin1105/article/details/48422299)  ok       
> 11. 对称的二叉树 ok      
> 12. 按之字形顺序打印二叉树      
> 13. 把二叉树打印成多行  ok.   
> 14. 序列化二叉树      
> 15. 二叉搜索树的第k个结点 ok.   
> 16. [二叉查找树节点的删除](https://blog.csdn.net/xiaoxiaoxuanao/article/details/61918125).  重要
> 17. strcpy 手写 char\* my_strcpy(char \*dst, const char\* src)

### 5. 具体算法

#### 5.1 斐波拉契

> 1. 斐波拉契数列 ok.   
> 2. 跳台阶  ok.   
> 3. 变态跳台阶  2 \* Fib(n-1).   
> 4. 矩形覆盖  ok

#### 5.4 回溯

> 1. 矩阵中的路径(BFS).   
> 2. 机器人的运动范围(DFS)

#### 5.5 排序

> 1. 数组中的逆序对(归并排序).  void mergeSort(int a[], int l, int r)
> 2. 最小的K个数(堆排序).   
> 3. 最小的K个数(快速排序) ok

#### 5.6 位运算

> 1. 二进制中1的个数  n & n-1.   
> 2. 数值的整数次方 dp.   
> 3. 数组中只出现一次的数字 ok.  

### 6. Stack & Queue & heap