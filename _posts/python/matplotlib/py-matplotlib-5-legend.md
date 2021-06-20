---
title: Matplotlib Legend
date: 2018-01-23 15:30:21
categories: python
tags: Matplotlib
---

matplotlib 中的 `legend` 图例就是为了展示出每个数据对应的`图像名称`,可读性更好.

<!-- more -->

## 添加图例 legend


```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-3, 3, 50)
y1 = 2*x + 1
y2 = x**2

plt.figure()
#set x limits
plt.xlim((-1, 2))
plt.ylim((-2, 3))

# set new sticks
new_sticks = np.linspace(-1, 2, 5)
plt.xticks(new_sticks)
# set tick labels
plt.yticks([-2, -1.8, -1, 1.22, 3],
           [r'$really\ bad$', r'$bad$', r'$normal$', r'$good$', r'$really\ good$'])
```

    ([<matplotlib.axis.YTick at 0x1195c3358>,
      <matplotlib.axis.YTick at 0x112681080>,
      <matplotlib.axis.YTick at 0x1195ce710>,
      <matplotlib.axis.YTick at 0x1195f5240>,
      <matplotlib.axis.YTick at 0x1195fc550>],
     <a list of 5 Text yticklabel objects>)

对图中的两条线绘制图例，首先我们设置两条线的类型等信息（蓝色实线与红色虚线).

```python
# set line syles
l1, = plt.plot(x, y1, label='linear line')
l2, = plt.plot(x, y2, color='red', linewidth=1.0, linestyle='--', label='square line')
```

需要注意的是 `l1,` `l2,` 要以`逗号`结尾, 因为 `plt.plot()` 返回的是一个list.

`legend` 将要显示的信息来自于上面代码中的 `label`. 所以我们只需要简单写一下代码, `plt` 就能自动的为我们添加图例.


```python
plt.legend(loc='upper right')
plt.show()
```

<div class="limg1">
{% image "/images/python/matplotlib-5-legend-1.png" height="100", width="650px" %}
</div>

参数 `loc='upper right'` 表示图例将添加在图中的右上角.

## 调整位置和名称

如果我们想单独修改之前的 `label` 信息, 给不同类型的线条设置图例信息. 我们可以在 `plt.legend` 输入更多参数. 如果以下面这种形式添加 `legend`, 我们需要确保, 在上面的代码 `plt.plot(x, y2, label='linear line')` 和 `plt.plot(x, y1, label='square line')` 中有用变量 l1 和 l2 分别存储起来. 


```python
plt.legend(handles=[l1, l2], labels=['up', 'down'],  loc='best')
plt.show()
```

<div class="limg1">
{% image "/images/python/matplotlib-5-legend-2.png" height="100", width="650px" %}
</div>

这样我们就能分别重新设置线条对应的 `label` 了.

其中’loc’参数有多种，’best’表示自动分配最佳位置，其余的如下：

```python
 'best' : 0,          
 'upper right'  : 1,
 'upper left'   : 2,
 'lower left'   : 3,
 'lower right'  : 4,
 'right'        : 5,
 'center left'  : 6,
 'center right' : 7,
 'lower center' : 8,
 'upper center' : 9,
 'center'       : 10,
```


[img1]: /images/python/matplotlib-5-legend-1.png
[img2]: /images/python/matplotlib-5-legend-2.png

## Reference

- [matplotlib.org][1]
- [matplotlib docs][2]
- [morvanzhou][3]

[1]: https://matplotlib.org/
[2]: https://matplotlib.org/contents.html
[3]: https://morvanzhou.github.io


