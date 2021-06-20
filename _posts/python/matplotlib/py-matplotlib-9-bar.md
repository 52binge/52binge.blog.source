---
title: Matplotlib Bar
date: 2018-01-24 13:20:21
categories: python
tags: Matplotlib
---

上篇学习了如何 plot Scatter，今天我们讲述如何 plot `Bar`

<!-- more -->

今日目标 : 柱状图分成上下两部分，每一个柱体上都有相应的数值标注，并且取消坐标轴的显示.

## 生成基本图形

向上向下生成`12个数据`，`X` 为 [0,11] 的整数 ，`Y`是均匀分布的随机数据。 使用的函数是`plt.bar`，参数为`X`和`Y`：


```python
import matplotlib.pyplot as plt
import numpy as np

n = 12

X = np.arange(n)

Y1 = (1 - X / float(n)) * np.random.uniform(0.5, 1.0, n)
Y2 = (1 - X / float(n)) * np.random.uniform(0.5, 1.0, n)

plt.bar(X, +Y1)
plt.bar(X, -Y2)

plt.xlim(-.5, n)
plt.xticks(())

plt.ylim(-1.25, 1.25)
plt.yticks(())

plt.show()
```

<div class="limg1">
{% image "/images/python/matplotlib-9-bar-1-output_1_0.png" height="100", width="550px" %}
</div>

## 加颜色和数据

用`facecolor`设置主体颜色，`edgecolor`设置边框颜色为白色，

```python
plt.bar(X, +Y1, facecolor='#9999ff', edgecolor='white')
plt.bar(X, -Y2, facecolor='#ff9999', edgecolor='white')

plt.show()
```

<div class="limg1">
{% image "/images/python/matplotlib-9-bar-2-output_3_0.png" height="100", width="550px" %}
</div>

接下来我们用函数`plt.text`分别在柱体上方（下方）加上数值，用`%.2f`保留两位小数，横向居中对齐`ha='center'`，纵向底部（顶部）对齐`va='bottom'`：


```python
plt.bar(X, +Y1, facecolor='#9999ff', edgecolor='white')
plt.bar(X, -Y2, facecolor='#ff9999', edgecolor='white')

for x, y in zip(X, Y1):
    # ha: horizontal alignment
    # va: vertical alignment
    plt.text(x + 0.4, y + 0.05, '%.2f' % y, ha='center', va='bottom')

for x, y in zip(X, Y2):
    # ha: horizontal alignment
    # va: vertical alignment
    plt.text(x + 0.4, -y - 0.05, '%.2f' % y, ha='center', va='top')
    
plt.show()
```

<div class="limg1">
{% image "/images/python/matplotlib-9-bar-3-output_5_0.png" height="100", width="550px" %}
</div>

[img1]: /images/python/matplotlib-9-bar-1-output_1_0.png
[img2]: /images/python/matplotlib-9-bar-2-output_3_0.png
[img3]: /images/python/matplotlib-9-bar-3-output_5_0.png

## Reference

- [matplotlib.org][1]
- [matplotlib docs][2]
- [morvanzhou][3]

[1]: https://matplotlib.org/
[2]: https://matplotlib.org/contents.html
[3]: https://morvanzhou.github.io


