---
title: Pandas Set Value
toc: true
date: 2017-12-30 20:11:21
categories: python
tags: Pandas   
mathjax: true
---

我们可以根据自己的需求, 用 pandas 进行更改数据里面的值, 或者加上一些空的,或者有数值的列.

<!-- more -->

## 创建数据

首先建立了一个 6X4 的矩阵数据


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


## 设置 loc 和 iloc

我们可以利用索引或者标签确定需要修改值的位置

```python
df.iloc[2,2] = 1111
df.loc['20130101','B'] = 2222
print(df)
```

                 A     B     C   D
    2013-01-01   0  2222     2   3
    2013-01-02   4     5     6   7
    2013-01-03   8     0  1111  11
    2013-01-04  12     0    14  15
    2013-01-05  16     0    18  19
    2013-01-06  20     0    22  23


## 根据条件设置

如果现在的判断条件是这样, 我们想要更改B中的数, 而更改的位置是取决于 A 的. 对于A大于4的位置. 更改B在相应位置上的数为0


```python
df.B[df.A>4] = 0
print(df)
```

                 A     B     C   D
    2013-01-01   0  2222     2   3
    2013-01-02   4     5     6   7
    2013-01-03   8     0  1111  11
    2013-01-04  12     0    14  15
    2013-01-05  16     0    18  19
    2013-01-06  20     0    22  23


## 按行或列设置
如果对整列做批处理, 加上一列 ‘F’, 并将 F 列全改为 NaN, 如下:


```python
df['F'] = np.nan
print(df)
```

                 A     B     C   D   F
    2013-01-01   0  2222     2   3 NaN
    2013-01-02   4     5     6   7 NaN
    2013-01-03   8     0  1111  11 NaN
    2013-01-04  12     0    14  15 NaN
    2013-01-05  16     0    18  19 NaN
    2013-01-06  20     0    22  23 NaN


## 添加数据
用上面的方法也可以加上 Series 序列（但是长度必须对齐）


```python
df['E'] = pd.Series([1,2,3,4,5,6], index=pd.date_range('20130101',periods=6)) 
print(df)
```

                 A     B     C   D   F  E
    2013-01-01   0  2222     2   3 NaN  1
    2013-01-02   4     5     6   7 NaN  2
    2013-01-03   8     0  1111  11 NaN  3
    2013-01-04  12     0    14  15 NaN  4
    2013-01-05  16     0    18  19 NaN  5
    2013-01-06  20     0    22  23 NaN  6


这样我们大概学会了如何对 `DataFrame` 中在自己想要的地方赋值或者增加数据。

## Reference

- [pandas.pydata.org][1]
- [pandas docs][2]
- [morvanzhou][3]

[1]: https://pandas.pydata.org/
[2]: http://pandas.pydata.org/pandas-docs/version/0.21/
[3]: https://morvanzhou.github.io