---
title: Summary 17 LinkList
toc: true
date: 2020-08-20 18:07:21
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
> 4. 判断单链表是否存在环， ✔️ while fast and fast->next: if fast==slow return True
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

> - **`方法1`：** 双指针，快指针先走k步，然后两个指针一起走，当快指针走到末尾时，慢指针的下一个位置是新的顺序的头结点，这样就可以旋转链表了。
> `m = n - k % n; ... ; newhead = cur.next; cur.next = NULL` 
> - **`方法2`：** 先遍历整个链表获得链表长度n，然后此时把链表头和尾链接起来，在往后走n – k % n个节点就到达新链表的头结点前一个点，这时断开链表即可。


环路的入口点

> 在第 4 题两个指针相遇后，让其中一个指针回到链表的头部，另一个指针在原地，同时往前每次走一步，当它们再次相遇时，就是在环路的入口点。

## 2. medium 8道

### 2.1 Reverse Linked List I

> 1. [反转链表](https://weiweiblog.cn/reverselist/) next=head->next, head->next=pre, pre=head, head=next; 4步 ok， ✔️
> <img src="/images/leetcode/linked-list-2.gif" width="650" alt="3指针" />
> 
> 2. 翻转部分单链表 举例：1->2->3->4->5->null, from = 2, to = 4 结果：1->4->3->2->5->null
> 3. [复杂链表的复制](https://leetcode-cn.com/problems/fu-za-lian-biao-de-fu-zhi-lcof/) ok， ✔️
> 4. 链表划分 （描述： 给定一个单链表和数值x，划分链表使得小于x的节点排在大于等于x的节点之前）
> 5. 单链表排序， (归并) ✔️
> 6. 合并两个或k个有序链表  ok， (递归 & 迭代循环 都可以实现)， ✔️ 
> 7. 删除链表重复结点  链表1->2->3->3->4->4->5 处理后为 1->2->5. ✔️ 
> ———— 设置 first ，second 指针, first == 确定不重复的, second == work p
> 8. 链表中环的入口结点， ✔️ 

### 2.2 Reverse Linked List II

```
输入: 1->2->3->4->5->NULL, m = 2, n = 4
输出: 1->4->3->2->5->NULL

必要先弄清楚链接反转的原理以及需要哪些指针。
```

举例而言，有一个三个不同节点组成的链表 `A → B → C`，需要反转结点中的链接成为 `A ← B ← C`。

假设有两个指针，一个指向 A，一个指向 B。 记为 prev 和 cur。则用这两个指针实现 A 和 B 之间的链接反转：

```python
cur.next = prev
```

这样做唯一的问题是，没有办法继续下去，换而言之，这样做之后就无法再访问到结点 C。

```python
third = cur.next
cur.next = prev
prev = cur
cur = third
```

<img src="/images/leetcode/linked-list-2.2.png" width="660" alt="双指针" />

```python
class Solution:
    def reverseBetween(self, head, m, n):
        """
        :type head: ListNode
        :type m: int
        :type n: int
        :rtype: ListNode
        """

        # Empty list
        if not head:
            return None

        # Move the two pointers until they reach the proper starting point
        # in the list.
        cur, prev = head, None
        while m > 1:
            prev = cur
            cur = cur.next
            m, n = m - 1, n - 1

        # The two pointers that will fix the final connections.
        tail, con = cur, prev

        # Iteratively reverse the nodes until n becomes 0.
        while n:
            third = cur.next
            cur.next = prev
            prev = cur
            cur = third
            n -= 1

        # Adjust the final connections as explained in the algorithm
        if con:
            con.next = prev
        else:
            head = prev
        tail.next = cur
        return head
```

[反转链表 II](https://leetcode-cn.com/problems/reverse-linked-list-ii/solution/fan-zhuan-lian-biao-ii-by-leetcode/)

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

    while (head != None) {
        if (head.val < x) {
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

### 2.5 单链表排序 (归并)

```java
public ListNode sortList(ListNode head) {
    //采用归并排序
    if (head == null || head.next == null) {
        return head;
    }
    //获取中间结点
    ListNode mid = getMid(head);
    ListNode right = mid.next;
    mid.next = null;
    //合并
    return mergeSort(sortList(head), sortList(right));
}

/**
 * 获取链表的中间结点,偶数时取中间第一个
 *
 * @param head
 * @return
 */
private ListNode getMid(ListNode head) {
    if (head == null || head.next == null) {
        return head;
    }
    //快慢指针
    ListNode slow = head, quick = head;
    //快2步，慢一步
    while (quick.next != null && quick.next.next != null) {
        slow = slow.next;
        quick = quick.next.next;
    }
    return slow;
}

/**
 *
 * 归并两个有序的链表
 *
 * @param head1
 * @param head2
 * @return
 */
private ListNode mergeSort(ListNode head1, ListNode head2) {
    ListNode p1 = head1, p2 = head2, head;
   //得到头节点的指向
    if (head1.val &lt; head2.val) {
        head = head1;
        p1 = p1.next;
    } else {
        head = head2;
        p2 = p2.next;
    }

    ListNode p = head;
    //比较链表中的值
    while (p1 != null && p2 != null) {

        if (p1.val &lt;= p2.val) {
            p.next = p1;
            p1 = p1.next;
            p = p.next;
        } else {
            p.next = p2;
            p2 = p2.next;
            p = p.next;
        }
    }
    //第二条链表空了
    if (p1 != null) {
        p.next = p1;
    }
    //第一条链表空了
    if (p2 != null) {
        p.next = p2;
    }
    return head;
}
```

## 3. medium 链表求和

题目描述：你有两个用链表代表的整数，其中每个节点包含一个数字。数字存储按照在原来整数中相反的顺序，使得第一个数字位于链表的开头。写出一个函数将两个整数相加，用链表形式返回和。

示例：

> 输入：(7 -> 1 -> 6) + (5 -> 9 -> 2)，即617 + 295
> 输出：2 -> 1 -> 9，即912

解题思路：做个大循环，对每一位进行操作：

当前位：(A[i]+B[i])%10

进位：（A[i]+B[i]）/10

---

进阶：假设这些数位是正向存放的，请再做一遍. 思路： 先转数字, 相加, 再转链表

> 输入：(6 -> 1 -> 7) + (2 -> 9 -> 5)，即617 + 295
> 输出：9 -> 1 -> 2，即 912 = 912 % 10 = 9


```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def addTwoNumbers(self, l1: ListNode, l2: ListNode) -> ListNode:
```

```java
public class Solution {
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode c1 = l1;
        ListNode c2 = l2;
        ListNode sentinel = new ListNode(0);
        ListNode d = sentinel;
        int sum = 0;
        while (c1 != null || c2 != null) {
            sum /= 10;
            if (c1 != null) {
                sum += c1.val;
                c1 = c1.next;
            }
            if (c2 != null) {
                sum += c2.val;
                c2 = c2.next;
            }
            d.next = new ListNode(sum % 10);
            d = d.next;
        }
        if (sum / 10 == 1)
            d.next = new ListNode(1);
        return sentinel.next;
    }
}
```

## Reference

- [负雪明烛](https://blog.csdn.net/fuxuemingzhu)
- [【LeetCode】代码模板，刷题必会](https://blog.csdn.net/fuxuemingzhu/article/details/101900729)

- [17 道 LinkList](https://weiweiblog.cn/linkedlist_summary/)
- [力扣刷题总结之链表](https://leetcode-cn.com/circle/article/YGr54o/)
