---
title: Numpy Basic Operation 2
toc: true
date: 2017-12-25 14:43:21
categories: python
tags: Numpy   
mathjax: true
---

numpy 矩阵的基本操作，argmin/argmax、mean/average、cumsum、sort、transpose/A.T、clip

<!-- more -->

## argmin & argmax

矩阵对应元素的索引也是非常重要的

其中的 `argmin()` 和 `argmax()` 两个函数分别对应着求矩阵中最小元素和最大元素的索引。相应的，在矩阵的12个元素中，最小值即2，对应索引0，最大值为13，对应索引为11。


```python
import numpy as np
A = np.arange(2,14).reshape((3,4)) 

# array([[ 2, 3, 4, 5]
#        [ 6, 7, 8, 9]
#        [10,11,12,13]])
         
print(np.argmin(A))    # 0
print(np.argmax(A))    # 11
```

    0
    11


## mean & average

统计中的均值，可以利用下面的方式，将整个矩阵的均值求出来：


```python
print(np.mean(A))        # 7.5
print(np.average(A))     # 7.5
```

    7.5
    7.5


仿照着前一节中dot() 的使用法则，mean()函数还有另外一种写法：


```python
print(A.mean())          # 7.5
```

    7.5


## cumsum

和matlab中的cumsum()累加函数类似，Numpy中也具有cumsum()函数，其用法如下：


```python
print(np.cumsum(A)) 

# [2 5 9 14 20 27 35 44 54 65 77 90]
```

    [ 2  5  9 14 20 27 35 44 54 65 77 90]


在cumsum()函数中：生成的每一项矩阵元素均是从原矩阵首项累加到对应项的元素之和。比如元素9，在cumsum()生成的矩阵中序号为3，即原矩阵中2，3，4三个元素的和。

## diff

相应的有累差运算函数：


```python
print(np.diff(A))    

# [[1 1 1]
#  [1 1 1]
#  [1 1 1]]

```

    [[1 1 1]
     [1 1 1]
     [1 1 1]]


该函数计算的便是每一行中后一项与前一项之差。故一个3行4列矩阵通过函数计算得到的矩阵便是3行3列的矩阵。

> `nonzero()` 函数, 觉得用处不大未学。

## sort


```python
import numpy as np
A = np.arange(14,2, -1).reshape((3,4)) 

# array([[14, 13, 12, 11],
#       [10,  9,  8,  7],
#       [ 6,  5,  4,  3]])

print(np.sort(A))    

# array([[11,12,13,14]
#        [ 7, 8, 9,10]
#        [ 3, 4, 5, 6]])
```

    [[11 12 13 14]
     [ 7  8  9 10]
     [ 3  4  5  6]]


## transpose & A.T

矩阵的转置有两种表示方法：


```python
print(np.transpose(A))    
print(A.T)

# array([[14,10, 6]
#        [13, 9, 5]
#        [12, 8, 4]
#        [11, 7, 3]])
# array([[14,10, 6]
#        [13, 9, 5]
#        [12, 8, 4]
#        [11, 7, 3]])

```

    [[14 10  6]
     [13  9  5]
     [12  8  4]
     [11  7  3]]
    [[14 10  6]
     [13  9  5]
     [12  8  4]
     [11  7  3]]


## clip

特别的，在Numpy中具有clip()函数，例子如下：


```python
print(A)
# array([[14,13,12,11]
#        [10, 9, 8, 7]
#        [ 6, 5, 4, 3]])

print(np.clip(A,5,9))    
# array([[ 9, 9, 9, 9]
#        [ 9, 9, 8, 7]
#        [ 6, 5, 5, 5]])

```

    [[14 13 12 11]
     [10  9  8  7]
     [ 6  5  4  3]]
    [[9 9 9 9]
     [9 9 8 7]
     [6 5 5 5]]


这个函数的格式是clip(Array,Array_min,Array_max)，顾名思义，Array指的是将要被执行用的矩阵，而后面的最小值最大值则用于让函数判断矩阵中元素是否有比最小值小的或者比最大值大的元素，并将这些指定的元素转换为最小值或者最大值。

实际上每一个Numpy中大多数函数均具有很多变量可以操作，你可以指定行、列甚至某一范围中的元素。更多具体的使用细节请记得查阅Numpy官方文档。


## Reference

- [numpy.org][1]
- [numpy docs][2]
- [morvanzhou][3]

[1]: http://www.numpy.org/
[2]: https://docs.scipy.org/doc/numpy-dev/user/quickstart.html
[3]: https://morvanzhou.github.io