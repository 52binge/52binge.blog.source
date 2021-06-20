---
title: Pandas IO
date: 2017-12-30 21:15:21
categories: python
tags: Pandas   
---

`pandas` 可以读取与存取的资料格式有很多种，像 `csv`、`excel`、`json`、`html` 与 `pickle` 等…

详细请看[官方文档][4]

<!-- more -->

## 读取csv

示范档案下载 - student.csv

```python
import pandas as pd #加载模块

#读取csv
data = pd.read_csv('students.csv')

#打印出data
print(data)
```

        Student ID  name   age  gender
    0         1100  Kelly   22  Female
    1         1101    Clo   21  Female
    2         1102  Tilly   22  Female
    3         1103   Tony   24    Male
    4         1104  David   20    Male
    5         1105  Catty   22  Female
    6         1106      M    3  Female
    7         1107      N   43    Male
    8         1108      A   13    Male
    9         1109      S   12    Male
    10        1110  David   33    Male
    11        1111     Dw    3  Female
    12        1112      Q   23    Male
    13        1113      W   21  Female
    
## 将资料存取成pickle

```python
data.to_pickle('student.pickle')
```

## Reference

- [pandas.pydata.org][1]
- [pandas docs][2]
- [morvanzhou][3]
- [pandas IO Tools][4]

[1]: https://pandas.pydata.org/
[2]: http://pandas.pydata.org/pandas-docs/version/0.21/
[3]: https://morvanzhou.github.io
[4]: http://pandas.pydata.org/pandas-docs/stable/io.html