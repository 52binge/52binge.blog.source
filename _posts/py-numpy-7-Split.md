---
title: Numpy Array Split
toc: true
date: 2017-12-27 13:28:21
categories: python
tags: Numpy   
mathjax: true
---

Numpy array 横向分割、纵向分割、等量分割、非等量分割

<!-- more -->

## 创建数据


```python
import numpy as np

A = np.arange(12).reshape((3, 4))

"""
array([[ 0,  1,  2,  3],
    [ 4,  5,  6,  7],
    [ 8,  9, 10, 11]])
"""

print(A)
```

    [[ 0  1  2  3]
     [ 4  5  6  7]
     [ 8  9 10 11]]


## 纵向分割


```python
print(np.split(A, 2, axis=1))
"""
[array([[0, 1],
        [4, 5],
        [8, 9]]), array([[ 2,  3],
        [ 6,  7],
        [10, 11]])]
"""
```

## 横向分割


```python
print(np.split(A, 3, axis=0))

# [array([[0, 1, 2, 3]]), array([[4, 5, 6, 7]]), array([[ 8,  9, 10, 11]])]
```

## 不等量的分割

在机器学习时经常会需要将数据做不等量的分割，因此解决办法为`np.array_split()`


```python
print(np.array_split(A, 3, axis=1))
"""
[array([[0, 1],
        [4, 5],
        [8, 9]]), array([[ 2],
        [ 6],
        [10]]), array([[ 3],
        [ 7],
        [11]])]
"""
```

成功将Array不等量分割!

## 其他的分割方式

在Numpy里还有`np.vsplit()`与横`np.hsplit()`方式可用。


```python
print(np.vsplit(A, 3)) #等于 print(np.split(A, 3, axis=0))

# [array([[0, 1, 2, 3]]), array([[4, 5, 6, 7]]), array([[ 8,  9, 10, 11]])]


print(np.hsplit(A, 2)) #等于 print(np.split(A, 2, axis=1))
"""
[array([[0, 1],
       [4, 5],
       [8, 9]]), array([[ 2,  3],
        [ 6,  7],
        [10, 11]])]
"""
```

## Reference

- [numpy.org][1]
- [numpy docs][2]
- [morvanzhou][3]

[1]: http://www.numpy.org/
[2]: https://docs.scipy.org/doc/numpy-dev/user/quickstart.html
[3]: https://morvanzhou.github.io