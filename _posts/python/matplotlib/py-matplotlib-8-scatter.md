---
title: Matplotlib Scatter
toc: true
date: 2018-01-24 11:08:21
categories: python
tags: Matplotlib
---

上篇学习了如何 plot 线，今天学习如何 plot `Scatter` 散点图

<!-- more -->

引入模块`numpy`用来产生一些随机数据。生成`1024`个呈标准正态分布的二维数据组 (平均数是`0`，方差为`1`) 作为一个数据集，并图像化这个数据集。每一个点的颜色值用`T`来表示：

```python
import matplotlib.pyplot as plt
import numpy as np

n = 1024    # data size

X = np.random.normal(0, 1, n) # 每一个点的X值
Y = np.random.normal(0, 1, n) # 每一个点的Y值

T = np.arctan2(Y,X) # for color value
```

数据集生成完毕，现在来用 `scatter` `plot` 这个点集

输入`X`和`Y`作为location，`size=75`，颜色为`T`，`color map` 用默认值，透明度`alpha` 为 50%。 x轴显示范围定位(-1.5，1.5)，并用`xtick()` 函数来隐藏`x`坐标轴，`y`轴同理：

```python
plt.scatter(X, Y, s=75, c=T, alpha=.5)

plt.xlim(-1.5, 1.5)
plt.xticks(())  # ignore xticks
plt.ylim(-1.5, 1.5)
plt.yticks(())  # ignore yticks

plt.show()
```

<div class="limg1">
{% image "/images/python/matplotlib-8-scatter-1.png" height="100", width="700px" %}
</div>

[img1]: /images/python/matplotlib-8-scatter-1.png

## Reference

- [matplotlib.org][1]
- [matplotlib docs][2]
- [morvanzhou][3]

[1]: https://matplotlib.org/
[2]: https://matplotlib.org/contents.html
[3]: https://morvanzhou.github.io


