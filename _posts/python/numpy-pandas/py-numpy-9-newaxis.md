---
title: numpy.newaxis 转变矩阵的形狀
toc: true
date: 2018-09-11 15:37:21
categories: python
tags: newaxis
---

有一個**一維陣列 x1**，我分別想要把它變成一個 3\*1 的矩陣 **x2**，以及 1\*3 的矩陣 **x3**，作法如下。

<!-- more -->

```python
import numpy as np

x1 = np.array([10, 20, 30], float)

# 有一個一維陣列x1，我分別想要把它變成一個 3*1 的矩陣x2，以及 1*3 的矩陣x3，作法如下。

print("shape of x1 is ", x1.shape)
print(x1)

print("-------------")

x2 = x1[:, np.newaxis]
print("shape of x2 is ", x2.shape)
print(x2)

print("-------------")

x3 = x1[np.newaxis, :]
print("shape of x3 is ", x3.shape)
print(x3)
```

output:

```
shape of x1 is  (3,)
[ 10.  20.  30.]
-------------
shape of x2 is  (3, 1)
[[ 10.]
 [ 20.]
 [ 30.]]
-------------
shape of x3 is  (1, 3)
[[ 10.  20.  30.]]
```

## Reference

- [利用numpy的newaxis轉變矩陣的形狀][6]

[6]: http://www.ben-do.github.io/2016/09/15/change-shape-of-matrix-by-numpy/

