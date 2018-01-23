---
title: Matplotlib Figure
toc: true
date: 2018-01-01 13:08:21
categories: python
tags: Matplotlib
---

matplotlib 的 figure 就是一个 单独的 figure 小窗口, 小窗口里面还可以有更多的小图片

<!-- more -->

```python
import matplotlib.pyplot as plt
import numpy as np
```

使用`np.linspace`定义`x`：范围是(-3,3);个数是50. 仿真一维数据组(`x` ,`y1`)表示曲线1. 仿真一维数据组(`x` ,`y2`)表示曲线2.

```python
x = np.linspace(-3, 3, 50)
y1 = 2*x + 1
y2 = x**2
```

使用`plt.figure`定义一个图像窗口. 使用`plt.plot`画(`x` ,`y1`)曲线.

```python
plt.figure()
plt.plot(x, y1)
plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-2-figure-1.png" height="100" width="450" />
</div>

使用`plt.figure`定义一个图像窗口：编号为3；大小为(8, 5). 

使用`plt.plot`画(`x` ,`y2`)曲线. 
使用`plt.plot`画(`x` ,`y1`)曲线，曲线的颜色属性(`color`)为红色;曲线的宽度(`linewidth`)为1.0；曲线的类型(`linestyle`)为虚线. 使用`plt.show`显示图像.

```python
plt.figure(num=3, figsize=(8, 5),)
plt.plot(x, y2)
plt.plot(x, y1, color='red', linewidth=1.0, linestyle='--')
plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-2-figure-2.png" height="100" width="450" />
</div>

## Set Coordinate axis

使用`plt.xlim`设置x坐标轴范围：(-1, 2)； 使用`plt.ylim`设置y坐标轴范围：(-2, 3)；   
使用`plt.xlabel`设置x坐标轴名称：’I am x’； 使用`plt.ylabel`设置y坐标轴名称：’I am y’；


```python
plt.figure(num=3, figsize=(8, 5),)
plt.plot(x, y2)
plt.plot(x, y1, color='red', linewidth=1.0, linestyle='--')

plt.xlim((-1, 2))
plt.ylim((-2, 3))
plt.xlabel('I am x')
plt.ylabel('I am y')
plt.show()
```

![output_9_0.png][img3]

使用 `np.linspace` 定义范围以及个数：范围是(-1,2);个数是5.   
使用 `print` 打印出新定义的范围.    
使用 `plt.xticks` 设置x轴刻度：范围是(-1,2);个数是5.   


```python
plt.figure(num=3, figsize=(8, 5),)
plt.plot(x, y2)
plt.plot(x, y1, color='red', linewidth=1.0, linestyle='--')

plt.xlim((-1, 2))
plt.ylim((-2, 3))
plt.xlabel('I am x')
plt.ylabel('I am y')

new_ticks = np.linspace(-1, 2, 5)
print(new_ticks)
plt.xticks(new_ticks)
```

    [-1.   -0.25  0.5   1.25  2.  ]

    ([<matplotlib.axis.XTick at 0x11dd68ba8>,
      <matplotlib.axis.XTick at 0x11dd68a58>,
      <matplotlib.axis.XTick at 0x11dd7d5c0>,
      <matplotlib.axis.XTick at 0x11e04af28>,
      <matplotlib.axis.XTick at 0x11e0515c0>],
     <a list of 5 Text xticklabel objects>)

使用`plt.yticks`设置y轴刻度以及名称：刻度为[-2, -1.8, -1, 1.22, 3]；对应刻度的名称为[‘really bad’,’bad’,’normal’,’good’, ‘really good’]. 使用plt.show显示图像.


```python
plt.yticks([-2, -1.8, -1, 1.22, 3],[r'$really\ bad$', r'$bad$', r'$normal$', r'$good$', r'$really\ good$'])
plt.show()
```

![output_13_0.png][img4]

[img1]: /images/python/matplotlib-2-figure-1.png
[img2]: /images/python/matplotlib-2-figure-2.png
[img3]: /images/python/matplotlib-2-figure-3-output_9_0.png
[img4]: /images/python/matplotlib-2-figure-4-output_13_0.png

## Reference

- [matplotlib.org][1]
- [matplotlib docs][2]
- [morvanzhou][3]

[1]: https://matplotlib.org/
[2]: https://matplotlib.org/contents.html
[3]: https://morvanzhou.github.io


