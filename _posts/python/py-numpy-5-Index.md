---
title: Numpy Index
toc: true
date: 2017-12-26 14:28:21
categories: python
tags: Numpy   
mathjax: true
---

在元素列表或者数组中，我们可以用如同 `a[2]` 一样的表示方法，同样的，Numpy中也有相应的表示方法

<!-- more -->

## 一维索引


```python
import numpy as np
A = np.arange(3,15)

# array([3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
         
print(A[3])    # 6
```

    6

让我们将矩阵转换为二维的，此时进行同样的操作：


```python
A = np.arange(3,15).reshape((3,4))
"""
array([[ 3,  4,  5,  6]
       [ 7,  8,  9, 10]
       [11, 12, 13, 14]])
"""
         
print(A[2])         
# [11 12 13 14]
```

    [11 12 13 14]

实际上这时的 `A[2]` 对应的就是 矩阵A 中第三行(从0开始算第一行)的所有元素。

## 二维索引

```python
print(A[1][1])      # 8
print(A[1, 1])      # 8
```

    8
    8

在Python的 list 中，我们可以利用:对一定范围内的元素进行切片操作，在Numpy中我们依然可以给出相应的方法：


```python
print(A[1, 1:3])    # [8 9]
```

    [8 9]

这一表示形式即针对第二行中第2到第4列元素进行切片输出（不包含第4列）。 此时我们适当的利用for函数进行打印：


```python
for row in A:
    print(row)
"""    
[ 3,  4,  5, 6]
[ 7,  8,  9, 10]
[11, 12, 13, 14]
"""
```

此时它会逐行进行打印操作。如果想进行逐列打印，就需要稍稍变化一下：


```python
for column in A.T:
    print(column)
"""  
[ 3,  7,  11]
[ 4,  8,  12]
[ 5,  9,  13]
[ 6, 10,  14]
"""
```

说一些关于迭代输出的问题：

```python
import numpy as np
A = np.arange(3,15).reshape((3,4))
         
print(A.flatten())   
# array([3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])

for item in A.flat:
    print(item)
    
# 3
# 4
# ……
# 14
```

    [ 3  4  5  6  7  8  9 10 11 12 13 14]
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14


这一脚本中的flatten是一个展开性质的函数，将多维的矩阵进行展开成1行的数列。而flat是一个迭代器，本身是一个object属性。

## Reference

- [numpy.org][1]
- [numpy docs][2]
- [morvanzhou][3]

[1]: http://www.numpy.org/
[2]: https://docs.scipy.org/doc/numpy-dev/user/quickstart.html
[3]: https://morvanzhou.github.io