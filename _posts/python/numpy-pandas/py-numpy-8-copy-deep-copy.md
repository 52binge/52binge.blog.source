---
title: Numpy copy & deep copy
date: 2017-12-27 14:28:21
categories: python
tags: Numpy   
---

numpy copy & deep copy

<!-- more -->

## = 的赋值方式会带有关联性

```python
import numpy as np

a = np.arange(4)
# array([0, 1, 2, 3])

b = a
c = a
d = b
```

改变`a`的第一个值，`b`、`c`、`d`的第一个值也会同时改变。


```python
a[0] = 11
print(a)
# array([11,  1,  2,  3])
```

    [11  1  2  3]

确认`b`、`c`、`d`是否与`a`相同

```python
b is a  # True
c is a  # True
d is a  # True
```

## copy() 的赋值方式没有关联性

```python
b = a.copy()    # deep copy
print(b)        # array([11, 22, 33,  3])
a[3] = 44
print(a)        # array([11, 22, 33, 44])
print(b)        # array([11, 22, 33,  3])
```

    [11  1  2  3]
    [11  1  2 44]
    [11  1  2  3]

## Reference

- [numpy.org][1]
- [numpy docs][2]
- [morvanzhou][3]

[1]: http://www.numpy.org/
[2]: https://docs.scipy.org/doc/numpy-dev/user/quickstart.html
[3]: https://morvanzhou.github.io