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

[img1]: /images/python/matplotlib-2-figure-1.png
[img2]: /images/python/matplotlib-2-figure-2.png

## Reference

- [matplotlib.org][1]
- [matplotlib docs][2]
- [morvanzhou][3]

[1]: https://matplotlib.org/
[2]: https://matplotlib.org/contents.html
[3]: https://morvanzhou.github.io


