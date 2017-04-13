---
title: Python numpy.shape 和 numpy.reshape
toc: true
date: 2017-02-21 16:43:21
categories: machine-learning
tags: [python]
description: python numpy.shape and numpy.reshape     
mathjax: true
---

Extension lib | introduction
------- | -------
Numpy | 提供数组支持，以及相应的高效处理函数



```python
from numpy import *  
import numpy as np  
```

## 1. shape

功能：给予数组一个新的形状，而不改变它的数据

```python
# list
L=range(5) # [0, 1, 2, 3, 4]
shape(L)   # [5,]
L=[[1,2,3],[4,5,6]] 
shape(L)
```

(2, 3)

```python
# array

arr=array(range(5)) 
print arr
shape(arr)

print "======  two dimension  ======"

arr=array([[1,2,3], [4,5,6]])
print arr
shape(arr)  
```

======  two dimension  ======
[[1 2 3]
[4 5 6]]

(2, 3)

## 2. reshape

newshape：整数值或整数元组。新的形状应该兼容于原始形状。
如果是一个整数值，表示一个一维数组的长度；
如果是元组，一个元素值可以为-1，此时该元素值表示为指定，此时会从数组的长度和剩余的维度中推断出


```python
a=array([[1,2,3],[4,5,6]])  
reshape(a, 6)  
```

array([1, 2, 3, 4, 5, 6])

```python
reshape(a, (3, -1)) #为指定的值将被推断出为2  
```

array([[1, 2],
       [3, 4],
       [5, 6]])

## Refence article

[numpy.shape][1]

[1]: http://blog.csdn.net/u012005313/article/details/49383551