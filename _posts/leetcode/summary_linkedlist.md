---
title: 总结 17 道题 LinkList
toc: true
date: 2020-08-19 18:07:21
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

## 1. easy 10道

> 1. 在 O(1) 时间删除链表节点， ✔️ 1. head or del is null 2. del=head 3. del=tail 4. del=normal
> 2. 删除单链表倒数第 n 个节点， ✔️
> 3. 求单链表的中间节点， ✔️
> 4. 判断单链表是否存在环， ✔️ while(runner && runner->next)
> 5. 从尾到头打印链表, 递归 ok.， ✔️
> 6. 链表中倒数第k个结点 ok.， ✔️
> 7. 判断两个无环单链表是否相交， ✔️ 判断 tail node is equal ?
> 8. 两个链表相交扩展：求两个无环单链表的第一个相交点， ✔️
>        相遇后，让其中一个指针回到链表的头部，另一个指针在原地，同时往前每次走一步，当它们再次相遇就是在环路的入口点
> 9. 两个链表的第一个公共节点  ， ✔️ p1 = (null == p1) ? headB : p1.next;
> 10. 旋转单链表  (F1. 环 F2. 走n-k%n 断开)， ✔️  
> 
> 题目描述：给定一个单链表，设计一个算法实现链表向右旋转 K 个位置。
举例： 给定 1->2->3->4->5->6->NULL, K=3
则4->5->6->1->2->3->NULL

**解题思路：**

> - 方法一 双指针，快指针先走k步，然后两个指针一起走，当快指针走到末尾时，慢指针的下一个位置是新的顺序的头结点，这样就可以旋转链表了。
> `m = n - k % n; ... ; newhead = cur.next; cur.next = NULL` 
> - 方法二 先遍历整个链表获得链表长度n，然后此时把链表头和尾链接起来，在往后走n – k % n个节点就到达新链表的头结点前一个点，这时断开链表即可。


环路的入口点

> 在第 4 题两个指针相遇后，让其中一个指针回到链表的头部，另一个指针在原地，同时往前每次走一步，当它们再次相遇时，就是在环路的入口点。

## 2. medium 8道

> 1. [反转链表](https://weiweiblog.cn/reverselist/) next=head->next, head->next=pre, pre=head, head=next; 4步 ok， ✔️
> <img src="/images/leetcode/linked-list-2.gif" width="650" alt="3指针" />
> 
> 2. 翻转部分单链表 举例：1->2->3->4->5->null, from = 2, to = 4 结果：1->4->3->2->5->null
> 3. [复杂链表的复制](https://leetcode-cn.com/problems/fu-za-lian-biao-de-fu-zhi-lcof/) ok， ✔️
> 4. 链表划分 （题目描述： 给定一个单链表和数值x，划分链表使得小于x的节点排在大于等于x的节点之前）
> 9. 单链表排序
> 10. 合并两个或k个有序链表  ok， 递归 (三元运算符).   
> 12. 删除链表重复结点  链表1->2->3->3->4->4->5 处理后为 1->2->5. first->next=head, last, p 三针， ✔️
> 10. 链表中环的入口结点， ✔️   

### 2.3 复杂链表的复制

Solution: 迭代. [图解 链表的深拷贝](https://leetcode-cn.com/problems/fu-za-lian-biao-de-fu-zhi-lcof/solution/lian-biao-de-shen-kao-bei-by-z1m/) 

该方法的思路比较直接，对于一个结点，分别拷贝此结点、next 指针指向的结点、random 指针指向的结点， 然后进行下一个结点...如果遇到已经出现的结点，那么我们不用拷贝该结点，只需将 next 或 random 指针指向该结点即可。

<img src="/images/leetcode/linked-list-2.4.jpeg" width="650" alt="" />

```python
class Solution:
    def copyRandomList(self, head: 'Node') -> 'Node':
        visited = {}
        def getClonedNode(node):
            if node:
                if node in visited:
                    return visited[node]
                else:
                    visited[node] = Node(node.val,None,None)
                    return visited[node]
            return None
        
        if not head: return head
        old_node = head
        new_node = Node(old_node.val,None,None)
        visited[old_node] = new_node

        while old_node:
            new_node.random = getClonedNode(old_node.random)
            new_node.next = getClonedNode(old_node.next)
            
            old_node = old_node.next
            new_node = new_node.next
        return visited[head]
```

### 2.4 链表划分

```python
def partition(head: Node, x: int) {
    // write your code here
    if not head return None;
    
    leftDummy = Node(0)
    rightDummy = Node(0)
    
    left = leftDummy, right = rightDummy;

    while (head != null) {
        if (head.val &lt; x) {
            left.next = head;
            left = head;
        } else {
            right.next = head;
            right = head;
        }
        head = head.next;
    }

    right.next = null;
    left.next = rightDummy.next;
    return leftDummy.next;
}
```

## 3. hard 1道

> 链表求和

## Reference

- [负雪明烛](https://blog.csdn.net/fuxuemingzhu)
- [【LeetCode】代码模板，刷题必会](https://blog.csdn.net/fuxuemingzhu/article/details/101900729)

- [17 道 LinkList](https://weiweiblog.cn/linkedlist_summary/)
