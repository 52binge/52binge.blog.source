---
title: Numpy Array 
toc: true
date: 2017-12-22 16:43:21
categories: python
tags: [Numpy]   
mathjax: true
---

创建 array 有很多 形式

<!-- more -->

## 关键字

- `array`：创建数组
- `dtype`：指定数据类型
- `zeros`：数据全为0
- `ones`：数据全为1
- `arrange`：按指定范围创建数据
- `linspace`：创建线段

> 与 List 区别之一 : 没有逗号分隔


```python
a = np.array([2,23,4])
print(a)
# [ 2 23  4]
```

    [ 2 23  4]
    int64


## 指定数据


```python
a = np.array([2,23,4], dtype=np.int) # 默认 int 为 int64
print(a.dtype) 
#int64

a = np.array([2,23,4],dtype=np.int32)
print(a.dtype)
# int32

a = np.array([2,23.1,4.0], dtype=np.float) # 默认 float 为 float64
print(a)
print(a.dtype)
# float64

a = np.array([2,23,4],dtype=np.float32)
print(a.dtype)
# float32
```

    int64
    int32
    [  2.   23.1   4. ]
    float64
    float32


## 创建特定数据


```python
a = np.array(
    [
        [2,23,4],
        [2,23,4]
    ]
)  # 2d 矩阵 2行3列
print(a)

"""
[[ 2 23  4]
 [ 2 32  4]]
"""
```

### 全零数组


```python
# 创建全零数组
a = np.zeros((3,4))  # 数据全为0，3行4列
"""
array([[ 0.,  0.,  0.,  0.],
       [ 0.,  0.,  0.,  0.],
       [ 0.,  0.,  0.,  0.]])
"""
print(a)
```

### 全一数组

> 同时也能指定这些特定数据的 `dtype`:


```python
a = np.ones((3,4),dtype = np.int)   # 数据为1，3行4列
"""
array([[1, 1, 1, 1],
       [1, 1, 1, 1],
       [1, 1, 1, 1]])
"""
print(a)
```

### 全空数组


```python
np.empty( (2,3) ) # 这个方法最大的好处就是速度快，因为少了初始化空间的操作
```

    array([[  9.88131292e-324,   1.13635099e-322,   1.97626258e-323],
           [  9.88131292e-324,   1.13635099e-322,   1.97626258e-323]])

### 连续数组`arange`


```python
a = np.arange(10,20,2) # 10-19 的数据，2步长
"""
array([10, 12, 14, 16, 18])
"""
print(a)

b = np.arange(12)
b
```

    [10 12 14 16 18]
    array([ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11])

### 改变数据的形状`reshape`


```python
a = np.arange(12).reshape((3,4))    # 3行4列，0到11
"""
array([[ 0,  1,  2,  3],
       [ 4,  5,  6,  7],
       [ 8,  9, 10, 11]])
"""
a
```

### 线段型数据`linspace`


```python
a = np.linspace(1,10,20)    # 开始端1，结束端10，且分割成20个数据，生成线段
"""
array([  1.        ,   1.47368421,   1.94736842,   2.42105263,
         2.89473684,   3.36842105,   3.84210526,   4.31578947,
         4.78947368,   5.26315789,   5.73684211,   6.21052632,
         6.68421053,   7.15789474,   7.63157895,   8.10526316,
         8.57894737,   9.05263158,   9.52631579,  10.        ])
"""
a
```

也能进行 `reshape` 工作:


```python
a = np.linspace(1,10,20).reshape((5,4)) # 更改shape
"""
array([[  1.        ,   1.47368421,   1.94736842,   2.42105263],
       [  2.89473684,   3.36842105,   3.84210526,   4.31578947],
       [  4.78947368,   5.26315789,   5.73684211,   6.21052632],
       [  6.68421053,   7.15789474,   7.63157895,   8.10526316],
       [  8.57894737,   9.05263158,   9.52631579,  10.        ]])
"""
```

## Reference

- [numpy.org][1]
- [numpy docs][2]
- [morvanzhou][3]

[1]: http://www.numpy.org/
[2]: https://docs.scipy.org/doc/numpy-dev/user/quickstart.html
[3]: https://morvanzhou.github.io/tutorials/data-manipulation/np-pd/2-2-np-array/