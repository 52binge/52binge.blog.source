---
title: Python Pandas - Series、DataFrame
toc: true
date: 2016-11-18 16:43:21
categories: machine-learning
tags: [python]
description: python pandas - series、dataFrame            
mathjax: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$'], ['\[','\]'] ],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

Extension lib | introduction
------- | -------
Numpy | 提供数组支持，以及相应的高效处理函数
Scipy | 提供矩阵支持，以及矩阵相关的数值计算模块
Matplotlib | 数据可视化工具，作图库
Pandas | 数据分析和探索工具
StatsModels | 统计建模和计量经济学，包括描述统计，统计模型估计和推断
Scikit-Learn | 支持回归，分类，聚类 等强大的机器学习库
Keras | 深度学习库，用于建立神经网络以及 deep learning model
Gensim | 用来做 text topic model 的库
Pillow | 旧版的PIL, 图片处理相关
OpenCV | video 处理相关
GMPY2 | 高精度计算相关

## 1. numpy lib

```python
In [1]: import numpy as np
In [2]: a = np.array([2, 0, 1, 5])
In [3]: a
Out[3]: array([2, 0, 1, 5])
In [4]:
```

## 2. pandas lib                                                                                  

> pandas build on **Numpy**
> 
> pandas 基本的数据结构是 : Series 和 DataFrame (它的每一列都是一个Series)。
> 
> 每个 Series 都会有一个对应的 Index，用来标记元。(Index类似于 SQL 主键)

### 2.1 pandas install 

> sudo pip install numpy
> sudo pip install pandas  
> sudo pip install xlrd  
> sudo pip install xlwt

### 2.2 pandas function

> 类SQL，CRUD
> 数据处理函数
> 时间序列分析功能
> 灵活处理缺失数据


## 3. pandas Series

```python
In [4]: from pandas import Series, DataFrame
In [5]: import pandas as pd

In [6]: obj = Series([4, 7, -5, 3])
In [7]: obj
Out[7]:
0    4
1    7
2   -5
3    3
dtype: int64

In [8]: obj.values
Out[8]: array([ 4,  7, -5,  3])

In [9]: obj.index
Out[9]: RangeIndex(start=0, stop=4, step=1)

In [10]: obj2 = Series([4, 7, -5, 3], index=['d', 'b', 'a', 'c'])
```

### 3.1 Series index

```python
In [11]: obj2
Out[11]:
d    4
b    7
a   -5
c    3
dtype: int64

In [12]: obj2.index
Out[12]: Index([u'd', u'b', u'a', u'c'], dtype='object')

In [13]: obj2['a']
Out[13]: -5

In [14]: obj2[['c', 'a']]
Out[14]:
c    3
a   -5
dtype: int64
```

### 3.2 Series like dict

```python
In [16]: 'b' in obj2
Out[16]: True

In [17]: 'e' in obj2
Out[17]: False

In [24]: sdata = {'Ohio': 35, 'Texas': 71, 'Oregon': 16}

In [25]: obj3 = Series(sdata)

In [26]: obj3
Out[26]:
Ohio      35
Texas     71
Oregon    16
dtype: int64

In [30]: states = ['California', 'Ohio', 'Oregon', 'Texas']

In [32]: obj4 = Series(sdata, index=states)

In [33]: obj4
Out[33]: /Library/Python/2.7/site-packages/pandas/formats/format.py:2191: RuntimeWarning: invalid value encountered in greater
  has_large_values = (abs_vals > 1e6).any()
/Library/Python/2.7/site-packages/pandas/formats/format.py:2192: RuntimeWarning: invalid value encountered in less
  has_small_values = ((abs_vals < 10**(-self.digits)) &
/Library/Python/2.7/site-packages/pandas/formats/format.py:2193: RuntimeWarning: invalid value encountered in greater
  (abs_vals > 0)).any()

California     NaN
Ohio          35.0
Oregon        16.0
Texas         71.0
dtype: float64
```

### 3.3 Series isnull

```python
In [48]: obj4.isnull()
Out[48]:
California     True
Ohio          False
Oregon        False
Texas         False
Name: population, dtype: bool

In [39]: obj3
Out[39]:
Ohio      35
Oregon    16
Texas     71
dtype: int64

In [40]: obj4
Out[40]:
California     NaN
Ohio          35.0
Oregon        16.0
Texas         71.0
dtype: float64

In [41]: obj3 + obj4
Out[41]:
California      NaN
Ohio           70.0
Oregon         32.0
Texas         142.0
dtype: float64

In [42]: obj4.name

In [43]: obj4.name = 'population'

In [44]: obj4.name
Out[44]: 'population'

In [45]: obj4
Out[45]:
California     NaN
Ohio          35.0
Oregon        16.0
Texas         71.0
Name: population, dtype: float64
```

## 3. pandas DateFrame

> DateFrame 表格型数据结构
> 
> DataFrame 具有 行索引 和 列索引，由 Series 组成的 dict。