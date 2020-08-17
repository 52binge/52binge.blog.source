---
title: 总结 17 道题 LinkList
toc: true
date: 2020-08-17 18:07:21
categories: [leetcode]
tags: [LinkList]
---

<img src="/images/leetcode/linked-list-logo.png" width="600" alt="" />

<!-- more -->

面18. 删除链表的节点（双指针，清晰图解）

<img src="/images/leetcode/linked-list-1.png" width="550" alt="双指针" />

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def deleteNode(self, head: ListNode, val: int) -> ListNode:
        if head.val == val: return head.next
        pre, cur = head, head.next
        while cur and cur.val != val:
            pre, cur = cur, cur.next
        if cur: pre.next = cur.next
        return head
```

在 O(1) 时间删除链表节点

```python
class Node:
    def __init__(self, x):
        self.val = x
        self.next = None
# 1. head or del is null 2. del=head 3. del=tail 4. del=normal
def del_node(head, p_del):

    if head is None or p_del is None:
        return head

    if p_del == head:
        return head.next

    if p_del.next is None:
        tmp = head
        while tmp.next != p_del:
            tmp = tmp.next
        tmp.next = None

    else:
        p_del.val = p_del.next.val
        p_del.next = p_del.next.next

    return head
```

**easy:**

> 1. 在 O(1) 时间删除链表节点， ✔️ 1. head or del is null 2. del=head 3. del=tail 4. del=normal
> 2. 删除单链表倒数第 n 个节点， ✔️
> 3. 求单链表的中间节点， ✔️
> 4. 判断单链表是否存在环， ✔️
> 5. 从尾到头打印链表, 递归 ok.， ✔️
> 6. 链表中倒数第k个结点 ok.， ✔️
> 7. 判断两个无环单链表是否相交， ✔️
> 8. 两个链表相交扩展：求两个无环单链表的第一个相交点， ✔️
> 9. 两个链表的第一个公共结点  ， ✔️   
> 10. 旋转单链表  (1. 环 2. 走n-k%n 断开)， ✔️  
> 
> 题目描述：给定一个单链表，设计一个算法实现链表向右旋转 K 个位置。
举例： 给定 1->2->3->4->5->6->NULL, K=3
则4->5->6->1->2->3->NULL

环路的入口点

> 在第 4 题两个指针相遇后，让其中一个指针回到链表的头部，另一个指针在原地，同时往前每次走一步，当它们再次相遇时，就是在环路的入口点。

**medium:**

> 2. [反转链表][2.3] next=head->next, head->next=pre, pre=head, head=next; 4步 ok， ✔️
> 3. 翻转部分单链表 举例：1->2->3->4->5->null, from = 2, to = 4 结果：1->4->3->2->5->null
> 4. [复杂链表的复制][2.5] ok， ✔️
> 7. 链表划分 （题目描述： 给定一个单链表和数值x，划分链表使得小于x的节点排在大于等于x的节点之前）
> 9. 单链表排序
> 10. 合并两个或k个有序链表  ok， 递归 (三元运算符).   
> 12. 删除链表重复结点  链表1->2->3->3->4->4->5 处理后为 1->2->5. first->next=head, last, p 三针， ✔️
> 10. 链表中环的入口结点， ✔️   

## 1. 在 O(1) 时间删除链表节点

```python

```

## Reference

- [负雪明烛](https://blog.csdn.net/fuxuemingzhu)
- [【LeetCode】代码模板，刷题必会](https://blog.csdn.net/fuxuemingzhu/article/details/101900729)

- [17 道 LinkList](https://weiweiblog.cn/linkedlist_summary/)
