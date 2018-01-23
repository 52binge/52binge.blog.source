---
title: Matplotlib Coordinate axis
toc: true
date: 2018-01-23 14:08:21
categories: python
tags: Matplotlib
---

如何移动 matplotlib 中 axis 坐标轴的位置.

<!-- more -->

## 设置名字和位置

```python
import matplotlib.pyplot as plt
import numpy as np
```

使用 `np.linspace` 定义 `x` ：范围是(-3,3);个数是50.     
仿真一维数据组(`x` ,`y1`)表示曲线1.  仿真一维数据组(`x` ,`y2`)表示曲线2.  

```python
x = np.linspace(-3, 3, 50)
y1 = 2*x + 1
y2 = x**2
```

使用`plt.figure`定义一个图像窗口. 

使用`plt.plot`画(`x` ,`y2`)曲线. 使用`plt.plot`画(`x` ,`y1`)曲线，曲线的颜色属性(`color`)为红色; 曲线的宽度(`linewidth`) 为 1.0; 曲线的类型(`linestyle`)为虚线.   

使用`plt.xlim`设置`x`坐标轴范围: (-1, 2); 使用`plt.ylim`设置`y`坐标轴范围: (-2, 3);   


```python
plt.figure()
plt.plot(x, y2)
plt.plot(x, y1, color='red', linewidth=1.0, linestyle='--')
plt.xlim((-1, 2))
plt.ylim((-2, 3))
```

    (-2, 3)

使用`np.linspace`定义范围以及个数：范围是(-1,2);个数是5. 

使用`plt.xticks`设置`x`轴刻度：范围是(-1,2);个数是5.   
使用`plt.yticks`设置`y`轴刻度以及名称: 刻度为[-2, -1.8, -1, 1.22, 3]; 对应刻度的名称为[‘really bad’,’bad’,’normal’,’good’, ‘really good’].

```python
new_ticks = np.linspace(-1, 2, 5)
plt.xticks(new_ticks)
plt.yticks([-2, -1.8, -1, 1.22, 3],['$really\ bad$', '$bad$', '$normal$', '$good$', '$really\ good$'])
```

function | desc | 设置效果
--------|-------|-------
`plt.gca` | 获取当前坐标轴信息 | -
`.spines` | 设置边框 | 右侧边框 & 上边框
`.set_color` | 设置边框颜色 | 默认白色


```python
ax = plt.gca()
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')
plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-4-ax-4_1.png" height="100" width="700" />
</div>

## 调整坐标轴

使用 `.xaxis.set_ticks_position`设置`x`坐标刻度数字或名称的位置：`bottom`.（所有位置：`top`，`bottom`，`both`，`default`，`none`）   
使用 `.spines` 设置边框：`x`轴；     
使用 `.set_position` 设置边框位置：`y=0` 的位置；（位置所有属性：`outward`，`axes`，`data`）  


```python
ax.xaxis.set_ticks_position('bottom')

ax.spines['bottom'].set_position(('data', 0))

plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-4-ax-4_2.png" height="100" width="700" />
</div>

使用`.yaxis.set_ticks_position`设置`y`坐标刻度数字或名称的位置：`left`.（所有位置：`left`，`right`，`both`，`default`，`none`）


```python
ax.yaxis.set_ticks_position('left')
```

使用`.spines`设置边框：`y`轴;  
使用`.set_position`设置边框位置：`x=0`的位置；（位置所有属性：`outward`，`axes`，`data`）   
使用`plt.show`显示图像.


```python
ax.spines['left'].set_position(('data',0))
plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-4-ax-4_3.png" height="100" width="700" />
</div>

[img1]: /images/python/matplotlib-4-ax-4_1.png
[img2]: /images/python/matplotlib-4-ax-4_2.png
[img3]: /images/python/matplotlib-4-ax-4_3.png

## Reference

- [matplotlib.org][1]
- [matplotlib docs][2]
- [morvanzhou][3]

[1]: https://matplotlib.org/
[2]: https://matplotlib.org/contents.html
[3]: https://morvanzhou.github.io


