---
title: Numpy Attribute
toc: true
date: 2017-12-21 16:43:21
categories: python
tags: [Numpy]    
mathjax: true
---

numpy 的几种属性 维度、行列个数、元素个数

<!-- more -->

- `ndim`：维度
- `shape`：行数和列数
- `size`：元素个数

列表转化为矩阵：

```python
import numpy as np

array1 = np.array(
    [
        [1,2,3],
        [2,3,4]
    ]
)
print(array1)
print('number of dim:', array1.ndim)
print('shape:', array1.shape)
print('size:', array1.size)

"""
    [[1 2 3]
     [2 3 4]]
    number of dim: 2
    shape: (2, 3)
    size: 6
"""
```

## Reference

- [numpy.org][1]
- [numpy docs][2]

[1]: http://www.numpy.org/
[2]: https://docs.scipy.org/doc/numpy-dev/user/quickstart.html