---
title: Pandas Deal NaN Value
toc: true
date: 2017-12-30 20:56:21
categories: python
tags: Pandas   
mathjax: true
---

处理 `NaN` 数据, 一些 空 或者 `NaN` 数据, 如何删除或者填补这些 `NaN` 数据.

<!-- more -->

## 创建含 NaN 的矩阵

建立了一个6X4的矩阵数据并且把两个位置置为空.


```python
import pandas as pd
import numpy as np

dates = pd.date_range('20130101', periods=6)
df = pd.DataFrame(np.arange(24).reshape((6,4)),index=dates, columns=['A','B','C','D'])
df.iloc[0,1] = np.nan
df.iloc[1,2] = np.nan
print(df)
```

                 A     B     C   D
    2013-01-01   0   NaN   2.0   3
    2013-01-02   4   5.0   NaN   7
    2013-01-03   8   9.0  10.0  11
    2013-01-04  12  13.0  14.0  15
    2013-01-05  16  17.0  18.0  19
    2013-01-06  20  21.0  22.0  23


## pd.dropna()

如果想直接去掉有 `NaN` 的行或列, 可以使用 `dropna`


```python
df1 = df.dropna(
    axis=0,     # 0: 对行进行操作; 1: 对列进行操作
    how='any'   # 'any': 只要存在 NaN 就 drop 掉; 'all': 必须全部是 NaN 才 drop 
    ) 
print(df1)
```

                 A     B     C   D
    2013-01-03   8   9.0  10.0  11
    2013-01-04  12  13.0  14.0  15
    2013-01-05  16  17.0  18.0  19
    2013-01-06  20  21.0  22.0  23


## pd.fillna()

如果是将 `NaN` 的值用其他值代替, 比如代替成 `0`:

```python
df2 = df.fillna(value=0)
print(df2)
```

                 A     B     C   D
    2013-01-01   0   0.0   2.0   3
    2013-01-02   4   5.0   0.0   7
    2013-01-03   8   9.0  10.0  11
    2013-01-04  12  13.0  14.0  15
    2013-01-05  16  17.0  18.0  19
    2013-01-06  20  21.0  22.0  23


## pd.isnull()

判断是否有缺失数据 `NaN`, 为 `True` 表示缺失数据:

```python
print(df.isnull())
```

                    A      B      C      D
    2013-01-01  False   True  False  False
    2013-01-02  False  False   True  False
    2013-01-03  False  False  False  False
    2013-01-04  False  False  False  False
    2013-01-05  False  False  False  False
    2013-01-06  False  False  False  False

检测在数据中是否存在 `NaN`, 如果存在就返回 `True`:

```python
np.any(df.isnull()) == True  
# True
```

    True

## Reference

- [pandas.pydata.org][1]
- [pandas docs][2]
- [morvanzhou][3]

[1]: https://pandas.pydata.org/
[2]: http://pandas.pydata.org/pandas-docs/version/0.21/
[3]: https://morvanzhou.github.io