---
title: Python collections and heapq
date: 2020-12-16 10:07:21
categories: [python]
tags: [interview]
---

{% image "/images/python/language/py-heapq-logo.jpg", width="500px", alt="collections, queue, heapq" %}

<!-- more -->

## 1. queue

### 1.1 collections.deque

```python
import collections

queue = collections.deque()

queue.append(5)
queue.appendleft(10)

queue.append(6)
queue.append(7)

print(queue) # deque([10, 5, 6, 7]) 

cur = queue.popleft()
cur = queue.pop()

print(queue) # deque([5, 6]) 
```

### 1.2 queue.Queue()

```python
from queue import Queue
q = Queue()
q.put(5)
q.put(3)
q.put(9)

print(q.qsize()) # 3
print(q.get()) # 5, 等于是 pop(), Queue 没有 pop() 只有 get(), get==pop
print(q.qsize()) # 2
```


### 1.3 queue.PriorityQueue()

```python
from queue import PriorityQueue

pq = PriorityQueue()

pq.put((1, 2))
pq.put((1, 0))
pq.put((5, 0))
pq.put((2, 3))

while not pq.empty():
    print (pq.get())
    
# output
# (1, 0)                                                                          
# (1, 2)                                                                          
# (2, 3)                                                                          
# (5, 0)  
```

存放自定义类型：

自定义数据类型，需要自定义 `__cmp__` 或者 `__lt__` 比价函数

```python
# -*- coding: utf-8 -*-
from queue import PriorityQueue

class Job(object):
    def __init__(self, priority, description):
        self.priority = priority
        self.description = description

    def __lt__(self, other):
        return self.priority < other.priority

q2 = PriorityQueue()
q2.put(Job(5, 'Mid-level job'))
q2.put(Job(10, 'Low-level job'))
q2.put(Job(1, 'Important job'))  # 数字越小，优先级越高

print(q2.qsize())

while not q2.empty():
    next_job = q2.get()  # 可根据优先级取序列
    print(next_job.description)

# 3
# Important job
# Mid-level job
# Low-level job
```

## 2. heapq



```python
from heapq import nsmallest, nlargest

lst = [5, 8, 0, 4, 6, 7]

print(nsmallest(3, lst))

print(nlargest(3, lst))

# python优先队列和堆的使用
# https://blog.csdn.net/liuweiyuxiang/article/details/97249128
```

## 3. stack is list

```python
a = [1, 5, 22, 2, 7]

a.pop(2)

a.insert(2, 220)

print(a)
```

## 4. 进制转换 bin, oct, hex, int('0b10000', 2)

```python
# -*- coding: UTF-8 -*-
 
# Filename : test.py
# author by : www.runoob.com
 
# 获取用户输入十进制数
dec = int(input("输入数字："))
 
print("十进制数为：", dec)
print("转换为二进制为：", bin(dec))
print("转换为八进制为：", oct(dec))
print("转换为十六进制为：", hex(dec))

int(hex(2*a),16)
```

十进制 与 二进制 的互相转换

```python
In [1]: a = 16

In [9]: bin(a)
Out[9]: '0b10000'

In [10]: int('0b10000', 2)
Out[10]: 16
```

## Reference

