---
title: Pandas Concat、Join、join_axes、append
toc: true
date: 2017-12-31 09:22:21
categories: python
tags: Pandas   
mathjax: true
---


`pandas` 处理多组数据的时候往往会要用到数据的合并处理,使用 `concat` 是一种基本的合并方式.而且 `concat` 中有很多参数可以调整,合并成你想要的数据形式.

<!-- more -->

## axis (合并方向)

`axis=0` 是预设值，因此未设定任何参数时，默认axis=0

```python
import pandas as pd
import numpy as np

#定义资料集
df1 = pd.DataFrame(np.ones((3,4))*0, columns=['a','b','c','d'])
df2 = pd.DataFrame(np.ones((3,4))*1, columns=['a','b','c','d'])
df3 = pd.DataFrame(np.ones((3,4))*2, columns=['a','b','c','d'])

#concat纵向合并
res = pd.concat([df1, df2, df3], axis=0)

#打印结果
print(res)
```

         a    b    c    d
    0  0.0  0.0  0.0  0.0
    1  0.0  0.0  0.0  0.0
    2  0.0  0.0  0.0  0.0
    0  1.0  1.0  1.0  1.0
    1  1.0  1.0  1.0  1.0
    2  1.0  1.0  1.0  1.0
    0  2.0  2.0  2.0  2.0
    1  2.0  2.0  2.0  2.0
    2  2.0  2.0  2.0  2.0


仔细观察会发现结果的`index`是0, 1, 2, 0, 1, 2, 0, 1, 2，若要将`index`重置，请看例子二。

## ignore_index (重置 index)


```python
#承上一个例子，并将index_ignore设定为True
res = pd.concat([df1, df2, df3], axis=0, ignore_index=True)

#打印结果
print(res)
```

         a    b    c    d
    0  0.0  0.0  0.0  0.0
    1  0.0  0.0  0.0  0.0
    2  0.0  0.0  0.0  0.0
    3  1.0  1.0  1.0  1.0
    4  1.0  1.0  1.0  1.0
    5  1.0  1.0  1.0  1.0
    6  2.0  2.0  2.0  2.0
    7  2.0  2.0  2.0  2.0
    8  2.0  2.0  2.0  2.0


结果的`index`变 0, 1, 2, 3, 4, 5, 6, 7, 8

## join (合并方式)

`join='outer'` 为预设值，未设定任何参数时，函数默认 `join='outer'`。此方式是依照`column`来做纵向合并，有相同的`column`上下合并在一起，其他独自的`column`个自成列，原本没有值的位置皆以`NaN`填充。

```python
import pandas as pd
import numpy as np

#定义资料集
df1 = pd.DataFrame(np.ones((3,4))*0, columns=['a','b','c','d'], index=[1,2,3])
df2 = pd.DataFrame(np.ones((3,4))*1, columns=['b','c','d','e'], index=[2,3,4])

#纵向"外"合并df1与df2
res = pd.concat([df1, df2], axis=0, join='outer')

print(res)
```

         a    b    c    d    e
    1  0.0  0.0  0.0  0.0  NaN
    2  0.0  0.0  0.0  0.0  NaN
    3  0.0  0.0  0.0  0.0  NaN
    2  NaN  1.0  1.0  1.0  1.0
    3  NaN  1.0  1.0  1.0  1.0
    4  NaN  1.0  1.0  1.0  1.0

只有相同的`column`合并在一起，其他的会被抛弃


```python
#承上一个例子

#纵向"内"合并df1与df2
res = pd.concat([df1, df2], axis=0, join='inner')

#重置index并打印结果
res = pd.concat([df1, df2], axis=0, join='inner', ignore_index=True)
print(res)
```

         b    c    d
    0  0.0  0.0  0.0
    1  0.0  0.0  0.0
    2  0.0  0.0  0.0
    3  1.0  1.0  1.0
    4  1.0  1.0  1.0
    5  1.0  1.0  1.0

## join_axes (依照 axes 合并)

```python
import pandas as pd
import numpy as np

#定义资料集
df1 = pd.DataFrame(np.ones((3,4))*0, columns=['a','b','c','d'], index=[1,2,3])
df2 = pd.DataFrame(np.ones((3,4))*1, columns=['b','c','d','e'], index=[2,3,4])

#依照`df1.index`进行横向合并
res = pd.concat([df1, df2], axis=1, join_axes=[df1.index])

#打印结果
print(res)
#     a    b    c    d    b    c    d    e
# 1  0.0  0.0  0.0  0.0  NaN  NaN  NaN  NaN
# 2  0.0  0.0  0.0  0.0  1.0  1.0  1.0  1.0
# 3  0.0  0.0  0.0  0.0  1.0  1.0  1.0  1.0

#移除join_axes，并打印结果
res = pd.concat([df1, df2], axis=1)
print(res)
```

         a    b    c    d    b    c    d    e
    1  0.0  0.0  0.0  0.0  NaN  NaN  NaN  NaN
    2  0.0  0.0  0.0  0.0  1.0  1.0  1.0  1.0
    3  0.0  0.0  0.0  0.0  1.0  1.0  1.0  1.0
         a    b    c    d    b    c    d    e
    1  0.0  0.0  0.0  0.0  NaN  NaN  NaN  NaN
    2  0.0  0.0  0.0  0.0  1.0  1.0  1.0  1.0
    3  0.0  0.0  0.0  0.0  1.0  1.0  1.0  1.0
    4  NaN  NaN  NaN  NaN  1.0  1.0  1.0  1.0


## append (添加数据)

`append`只有纵向合并，没有横向合并


```python
import pandas as pd
import numpy as np

#定义资料集
df1 = pd.DataFrame(np.ones((3,4))*0, columns=['a','b','c','d'])
df2 = pd.DataFrame(np.ones((3,4))*1, columns=['a','b','c','d'])
df3 = pd.DataFrame(np.ones((3,4))*1, columns=['a','b','c','d'])
s1 = pd.Series([1,2,3,4], index=['a','b','c','d'])

#将df2合并到df1的下面，以及重置index，并打印出结果
res = df1.append(df2, ignore_index=True)
print(res)
#     a    b    c    d
# 0  0.0  0.0  0.0  0.0
# 1  0.0  0.0  0.0  0.0
# 2  0.0  0.0  0.0  0.0
# 3  1.0  1.0  1.0  1.0
# 4  1.0  1.0  1.0  1.0
# 5  1.0  1.0  1.0  1.0

#合并多个df，将df2与df3合并至df1的下面，以及重置index，并打印出结果
res = df1.append([df2, df3], ignore_index=True)
print(res)
#     a    b    c    d
# 0  0.0  0.0  0.0  0.0
# 1  0.0  0.0  0.0  0.0
# 2  0.0  0.0  0.0  0.0
# 3  1.0  1.0  1.0  1.0
# 4  1.0  1.0  1.0  1.0
# 5  1.0  1.0  1.0  1.0
# 6  1.0  1.0  1.0  1.0
# 7  1.0  1.0  1.0  1.0
# 8  1.0  1.0  1.0  1.0

#合并series，将s1合并至df1，以及重置index，并打印出结果
res = df1.append(s1, ignore_index=True)
print(res)
#     a    b    c    d
# 0  0.0  0.0  0.0  0.0
# 1  0.0  0.0  0.0  0.0
# 2  0.0  0.0  0.0  0.0
# 3  1.0  2.0  3.0  4.0
```

         a    b    c    d
    0  0.0  0.0  0.0  0.0
    1  0.0  0.0  0.0  0.0
    2  0.0  0.0  0.0  0.0
    3  1.0  1.0  1.0  1.0
    4  1.0  1.0  1.0  1.0
    5  1.0  1.0  1.0  1.0
         a    b    c    d
    0  0.0  0.0  0.0  0.0
    1  0.0  0.0  0.0  0.0
    2  0.0  0.0  0.0  0.0
    3  1.0  1.0  1.0  1.0
    4  1.0  1.0  1.0  1.0
    5  1.0  1.0  1.0  1.0
    6  1.0  1.0  1.0  1.0
    7  1.0  1.0  1.0  1.0
    8  1.0  1.0  1.0  1.0
         a    b    c    d
    0  0.0  0.0  0.0  0.0
    1  0.0  0.0  0.0  0.0
    2  0.0  0.0  0.0  0.0
    3  1.0  2.0  3.0  4.0

## Reference

- [pandas.pydata.org][1]
- [pandas docs][2]
- [morvanzhou][3]

[1]: https://pandas.pydata.org/
[2]: http://pandas.pydata.org/pandas-docs/version/0.21/
[3]: https://morvanzhou.github.io