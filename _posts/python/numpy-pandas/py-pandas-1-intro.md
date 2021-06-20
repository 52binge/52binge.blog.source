---
title: Pandas Basic Intro
date: 2017-12-27 16:28:21
categories: python
tags: Pandas   
---

如果用列表和字典来作比较, 那么可以说 Numpy 是列表形式的，没有数值标签，而 Pandas 就是字典形式

<!-- more -->

Pandas是基于Numpy构建的，让Numpy为中心的应用变得更加简单。

要使用pandas，首先需要了解他主要两个数据结构：Series 和 DataFrame。

## Series


```python
import pandas as pd
import numpy as np

s = pd.Series([1,3,6,np.nan,44,1])

print(s)
```

    0     1.0
    1     3.0
    2     6.0
    3     NaN
    4    44.0
    5     1.0
    dtype: float64

`Series` 的字符串表现形式为：索引在左边，值在右边。
由于我们没有为数据指定索引。于是会自动创建一个0到N-1（N为长度）的整数型索引。

## DataFrame 矩阵创建


```python
dates = pd.date_range('20160101',periods=6)
df = pd.DataFrame(np.random.randn(6,4),index=dates,columns=['a','b','c','d'])

print(df)
```

                       a         b         c         d
    2016-01-01 -0.186992  0.228857  0.572464 -0.842974
    2016-01-02 -0.689623 -1.491299  0.647805  0.819846
    2016-01-03 -1.294425  0.138935  1.729793 -1.270880
    2016-01-04  0.088744  0.745256  0.380425  0.048070
    2016-01-05  0.003135 -2.240388  0.188038 -0.069044
    2016-01-06 -1.358217 -0.820133  1.606467 -1.622589


`DataFrame` 是一个表格型的数据结构，它包含有一组有序的列，每列可以是不同的值类型（数值，字符串，布尔值等）。  
`DataFrame` 既有行索引也有列索引， 它可以被看做由 `Series` 组成的大字典。

我们可以根据每一个不同的索引来挑选数据, 比如挑选 `b` 的元素:

```python
print(df['b'])
```

    2016-01-01    0.228857
    2016-01-02   -1.491299
    2016-01-03    0.138935
    2016-01-04    0.745256
    2016-01-05   -2.240388
    2016-01-06   -0.820133
    Freq: D, Name: b, dtype: float64


我们在创建一组没有给定行标签和列标签的数据 `df1`:


```python
df1 = pd.DataFrame(np.arange(12).reshape((3,4)))
print(df1)
```

       0  1   2   3
    0  0  1   2   3
    1  4  5   6   7
    2  8  9  10  11

这样,他就会采取默认的从0开始 index.

## DataFrame 字典创建

还有一种生成 `df` 的方法, 如下 `df2`:

```python
df2 = pd.DataFrame({'A' : [1, 3, 7, 5],
                    'B' : pd.Timestamp('20130102'),
                    'C' : pd.Series(1,index=list(range(4)),dtype='float32'),
                    'D' : np.array([3] * 4,dtype='int32'),
                    'E' : pd.Categorical(["test","train","test","train"]),
                    'F' : 'foo'})
                    
print(df2)
```

       A          B    C  D      E    F
    0  1 2013-01-02  1.0  3   test  foo
    1  3 2013-01-02  1.0  3  train  foo
    2  7 2013-01-02  1.0  3   test  foo
    3  5 2013-01-02  1.0  3  train  foo


这种方法能对每一列的数据进行特殊对待. 如果想要查看数据中的类型, 我们可以用 `dtype` 这个属性:


```python
print(df2.dtypes)
```

    A             int64
    B    datetime64[ns]
    C           float32
    D             int32
    E          category
    F            object
    dtype: object


如果想看对列的序号:


```python
print(df2.index)
```

    Int64Index([0, 1, 2, 3], dtype='int64')


同样, 每种数据的名称也能看到:


```python
print(df2.columns)
```

    Index(['A', 'B', 'C', 'D', 'E', 'F'], dtype='object')


如果只想看所有 `df2` 的值:


```python
print(df2.values)
```

    [[1 Timestamp('2013-01-02 00:00:00') 1.0 3 'test' 'foo']
     [3 Timestamp('2013-01-02 00:00:00') 1.0 3 'train' 'foo']
     [7 Timestamp('2013-01-02 00:00:00') 1.0 3 'test' 'foo']
     [5 Timestamp('2013-01-02 00:00:00') 1.0 3 'train' 'foo']]


想知道数据的总结, 可以用 `describe()`:


```python
df2.describe()
```

			A	C	D
		count	4.000000	4.0	4.0
		mean	4.000000	1.0	3.0
		std	2.581989	0.0	0.0
		min	1.000000	1.0	3.0
		25%	2.500000	1.0	3.0
		50%	4.000000	1.0	3.0
		75%	5.500000	1.0	3.0
		max	7.000000	1.0	3.0

如果想翻转数据, `transpose`:


```python
print(df2.T)
```

                         0                    1                    2  \
    A                    1                    3                    7   
    B  2013-01-02 00:00:00  2013-01-02 00:00:00  2013-01-02 00:00:00   
    C                    1                    1                    1   
    D                    3                    3                    3   
    E                 test                train                 test   
    F                  foo                  foo                  foo   
    
                         3  
    A                    5  
    B  2013-01-02 00:00:00  
    C                    1  
    D                    3  
    E                train  
    F                  foo  


如果想对数据的 `index` 进行排序并输出:


```python
print(df2.sort_index(axis=1, ascending=False)) # 对列名称进行排序，索引名，倒排序

print(df2.sort_index(axis=0, ascending=False)) # 对列名称进行排序，索引名，倒排序
```

         F      E  D    C          B  A
    0  foo   test  3  1.0 2013-01-02  1
    1  foo  train  3  1.0 2013-01-02  3
    2  foo   test  3  1.0 2013-01-02  7
    3  foo  train  3  1.0 2013-01-02  5
       A          B    C  D      E    F
    3  5 2013-01-02  1.0  3  train  foo
    2  7 2013-01-02  1.0  3   test  foo
    1  3 2013-01-02  1.0  3  train  foo
    0  1 2013-01-02  1.0  3   test  foo


如果是对数据 值 排序输出:


```python
print(df2.sort_values(by='E'))
```

       A          B    C  D      E    F
    0  1 2013-01-02  1.0  3   test  foo
    2  7 2013-01-02  1.0  3   test  foo
    1  3 2013-01-02  1.0  3  train  foo
    3  5 2013-01-02  1.0  3  train  foo

## Reference

- [pandas.pydata.org][1]
- [pandas docs][2]
- [morvanzhou][3]

[1]: https://pandas.pydata.org/
[2]: http://pandas.pydata.org/pandas-docs/version/0.21/
[3]: https://morvanzhou.github.io