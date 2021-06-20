---
title: numpy.random.normal 函数
date: 2018-09-11 16:16:21
categories: python
tags: numpy
---

numpy.random.normal 函数，有三个参数（**loc, scale, size**），代表生成的高斯分布随机数的均值、方差以及输出的 size. 

<!-- more -->

例子：

```python
np.random.normal(0, 0.05, (7,1)).astype(np.float32)
```

Output :

```
array([[-0.05229944],
       [ 0.01754326],
       [ 0.01764081],
       [-0.03058357],
       [-0.05406121],
       [-0.07284269],
       [ 0.00289147]], dtype=float32)
```

**Scipy Help**: **numpy.random.normal**

```python
Parameters:	
loc : float or array_like of floats
Mean (“centre”) of the distribution.

scale : float or array_like of floats
Standard deviation (spread or “width”) of the distribution.

size : int or tuple of ints, optional
Output shape. If the given shape is, e.g., (m, n, k), then m * n * k samples are drawn. If size is None (default), a single value is returned if loc and scale are both scalars. Otherwise, np.broadcast(loc, scale).size samples are drawn.

Returns:	
out : ndarray or scalar
Drawn samples from the parameterized normal distribution.
```

## Reference

- [numpy.random.normal][1]

[1]: https://docs.scipy.org/doc/numpy/reference/generated/numpy.random.normal.html
