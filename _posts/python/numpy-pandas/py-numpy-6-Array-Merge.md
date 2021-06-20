---
title: Numpy Array Merge
date: 2017-12-26 17:28:21
categories: python
tags: Numpy   
---

对于一个`array`的合并，我们可以想到按行、按列等多种方式进行合并

<!-- more -->

## np.vstack()


```python
import numpy as np
A = np.array([1,1,1])
B = np.array([2,2,2])
         
print(np.vstack((A,B)))    # vertical stack

"""
[[1,1,1]
 [2,2,2]]
"""

np.vstack((A,B))
```

    [[1 1 1]
     [2 2 2]]

    array([[1, 1, 1],
           [2, 2, 2]])



vertical stack 本身属于一种上下合并，即对括号中的两个整体进行对应操作。此时我们对组合而成的矩阵进行属性探究：


```python
C = np.vstack((A,B))      
print(A.shape,C.shape)

# (3,) (2,3) # A 是序列, 序列合并后 C 为矩阵
```

    (3,) (2, 3)


利用shape函数可以让我们很容易地知道A和C的属性，从打印出的结果来看，A仅仅是一个拥有3项元素的数组（数列），而合并后得到的C是一个2行3列的矩阵。

## np.hstack() 左右合并：


```python
D = np.hstack((A,B))       # horizontal stack

print(D)
# [1,1,1,2,2,2]

print(A.shape,D.shape)
# (3,) (6,)
```

    [1 1 1 2 2 2]
    (3,) (6,)


不能用 A.T 这样的方法，将一个序列变为矩阵


```python
print(A.T)
print(A.T.shape)
```

    [1 1 1]
    (3,)


通过打印出的结果可以看出：D本身来源于A，B两个数列的左右合并，而且新生成的D本身也是一个含有6项元素的序列。

## np.newaxis()

如果面对如同前文所述的A序列， 转置操作便很有可能无法对其进行转置（因为A并不是矩阵的属性），此时就需要我们借助其他的函数操作进行转置：


```python
print(A[np.newaxis,:])
# [[1 1 1]]

print(A[np.newaxis,:].shape)
# (1,3)

print(A[:,np.newaxis])
"""
[[1]
[1]
[1]]
"""

print(A[:,np.newaxis].shape)
# (3,1)
```

    [[1 1 1]]
    (1, 3)
    [[1]
     [1]
     [1]]
    (3, 1)

此时我们便将具有3个元素的`array`转换为了1行3列以及3行1列的矩阵了。

## 综合总结


```python
import numpy as np
A = np.array([1,1,1])[:,np.newaxis]
B = np.array([2,2,2])[:,np.newaxis]
         
C = np.vstack((A,B))   # vertical stack
D = np.hstack((A,B))   # horizontal stack

print(D)
"""
[[1 2]
[1 2]
[1 2]]
"""

print(A.shape,D.shape)
# (3,1) (3,2)
```

    [[1 2]
     [1 2]
     [1 2]]
    (3, 1) (3, 2)


## np.concatenate()

当你的合并操作需要针对多个矩阵或序列时，借助concatenate函数可能会让你使用起来比前述的函数更加方便：


```python
C = np.concatenate((A,B,B,A),axis=0)

print(C)
"""
array([[1],
       [1],
       [1],
       [2],
       [2],
       [2],
       [2],
       [2],
       [2],
       [1],
       [1],
       [1]])
"""

D = np.concatenate((A,B,B,A),axis=1)

print(D)
"""
array([[1, 2, 2, 1],
       [1, 2, 2, 1],
       [1, 2, 2, 1]])
"""
```

    [[1 2 2 1]
     [1 2 2 1]
     [1 2 2 1]]

`axis` 参数很好的控制了矩阵的纵向或是横向打印，相比较 `vstack` 和 `hstack` 函数显得更加方便。


## Reference

- [numpy.org][1]
- [numpy docs][2]
- [morvanzhou][3]

[1]: http://www.numpy.org/
[2]: https://docs.scipy.org/doc/numpy-dev/user/quickstart.html
[3]: https://morvanzhou.github.io