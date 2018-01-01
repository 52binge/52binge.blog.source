---
title: Pandas Select Data
toc: true
date: 2017-12-28 23:28:21
categories: python
tags: Pandas   
mathjax: true
---

pandas 选择数据, 首先我们建立了一个 6X4 的矩阵数据

<!-- more -->

```python
import pandas as pd
import numpy as np

dates = pd.date_range('20130101', periods=6)
df = pd.DataFrame(np.arange(24).reshape((6,4)),index=dates, columns=['A','B','C','D'])
print(df)
```

                 A   B   C   D
    2013-01-01   0   1   2   3
    2013-01-02   4   5   6   7
    2013-01-03   8   9  10  11
    2013-01-04  12  13  14  15
    2013-01-05  16  17  18  19
    2013-01-06  20  21  22  23


## 简单的筛选

如果我们想选取 DataFrame 中的数据，下面描述了两种途径, 他们都能达到同一个目的：


```python
print(df['A'])
print(df.A)
```

    2013-01-01     0
    2013-01-02     4
    2013-01-03     8
    2013-01-04    12
    2013-01-05    16
    2013-01-06    20
    Freq: D, Name: A, dtype: int64
    
    2013-01-01     0
    2013-01-02     4
    2013-01-03     8
    2013-01-04    12
    2013-01-05    16
    2013-01-06    20
    Freq: D, Name: A, dtype: int64

让选择跨越多行或多列:

```python
print(df[0:3])
```

                A  B   C   D
    2013-01-01  0  1   2   3
    2013-01-02  4  5   6   7
    2013-01-03  8  9  10  11

```python
print(df[3:3])
```

    Empty DataFrame
    Columns: [A, B, C, D]
    Index: []

```python
print(df['20130102':'20130104'])
```

                 A   B   C   D
    2013-01-02   4   5   6   7
    2013-01-03   8   9  10  11
    2013-01-04  12  13  14  15


如果 `df[3:3]` 将会是一个空对象。后者选择 `20130102` 到 `20130104` 标签之间的数据，并且包括这两个标签

## 根据标签 loc

可以使用标签来选择数据 `loc`, 本例子主要通过标签名字选择某一行数据， 或者通过选择某行或者所有行（`:`代表所有行）然后选其中某一列或几列数据 :

```python
print(df.loc['20130102'])
```

    A    4
    B    5
    C    6
    D    7
    Name: 2013-01-02 00:00:00, dtype: int64

```python
print(df.loc[:,['A','B']]) 
```

                 A   B
    2013-01-01   0   1
    2013-01-02   4   5
    2013-01-03   8   9
    2013-01-04  12  13
    2013-01-05  16  17
    2013-01-06  20  21

```python
print(df.loc['20130102',['A','B']])
```
    A    4
    B    5
    Name: 2013-01-02 00:00:00, dtype: int64

## 根据序列 iloc

可以采用位置进行选择 `iloc`, 在这里我们可以通过位置选择在不同情况下所需要的数据例如选某一个，连续选或者跨行选等操作。


```python
print(df.iloc[3,1])
```
    13

```python
print(df.iloc[3:5,1:3])
```

                 B   C
    2013-01-04  13  14
    2013-01-05  17  18



```python
print(df.iloc[[1,3,5],1:3])
```

                 B   C
    2013-01-02   5   6
    2013-01-04  13  14
    2013-01-06  21  22


在这里我们可以通过位置选择在不同情况下所需要的数据, 例如选某一个，连续选或者跨行选等操作。

## 根据混合两种 ix

当然我们可以采用混合选择 `ix`, 其中选择’A’和’C’的两列，并选择前三行的数据。


```python
print(df.ix[:3,['A','C']])
```

                A   C
    2013-01-01  0   2
    2013-01-02  4   6
    2013-01-03  8  10


    /Users/blair/.pyenv/versions/anaconda3/lib/python3.6/site-packages/ipykernel_launcher.py:1: DeprecationWarning: 
    .ix is deprecated. Please use
    .loc for label based indexing or
    .iloc for positional indexing
    
    See the documentation here:
    http://pandas.pydata.org/pandas-docs/stable/indexing.html#ix-indexer-is-deprecated
      """Entry point for launching an IPython kernel.


## 通过判断的筛选

最后我们可以采用判断指令 (Boolean indexing) 进行选择. 我们可以约束某项条件然后选择出当前所有数据.


```python
print(df[df.A>8])
df.A>8
```

                 A   B   C   D
    2013-01-04  12  13  14  15
    2013-01-05  16  17  18  19
    2013-01-06  20  21  22  23

    2013-01-01    False
    2013-01-02    False
    2013-01-03    False
    2013-01-04     True
    2013-01-05     True
    2013-01-06     True
    Freq: D, Name: A, dtype: bool

下节我们将会讲到Pandas中如何设置值。


## Reference

- [pandas.pydata.org][1]
- [pandas docs][2]
- [morvanzhou][3]

[1]: https://pandas.pydata.org/
[2]: http://pandas.pydata.org/pandas-docs/version/0.21/
[3]: https://morvanzhou.github.io