---
title: Matplotlib Basic Use
toc: true
date: 2018-01-01 12:46:21
categories: python
tags: Matplotlib
---

Matplotlib 最基本的使用介绍

<!-- more -->

## 基础应用

使用`import`导入模块`matplotlib.pyplot`，并简写成`plt` 使用`import`导入模块`numpy`，并简写成`np`

```python
import matplotlib.pyplot as plt
import numpy as np
```

```python
np.linspace(-1, 1, 50)
```


		array([-1.        , -0.95918367, -0.91836735, -0.87755102, -0.83673469,
		       -0.79591837, -0.75510204, -0.71428571, -0.67346939, -0.63265306,
		       -0.59183673, -0.55102041, -0.51020408, -0.46938776, -0.42857143,
		       -0.3877551 , -0.34693878, -0.30612245, -0.26530612, -0.2244898 ,
		       -0.18367347, -0.14285714, -0.10204082, -0.06122449, -0.02040816,
		        0.02040816,  0.06122449,  0.10204082,  0.14285714,  0.18367347,
		        0.2244898 ,  0.26530612,  0.30612245,  0.34693878,  0.3877551 ,
		        0.42857143,  0.46938776,  0.51020408,  0.55102041,  0.59183673,
		        0.63265306,  0.67346939,  0.71428571,  0.75510204,  0.79591837,
		        0.83673469,  0.87755102,  0.91836735,  0.95918367,  1.        ])
		        

使用 [np.linspace][4] 定义`x`：范围是(-1,1); 个数是50. 仿真一维数据组(`x` ,`y`)表示曲线1.

```python
x = np.linspace(-1, 1, 50)
y = 2*x + 1
```

使用`plt.figure`定义一个图像窗口. 使用`plt.plot`画(`x` ,`y`)曲线. 使用`plt.show`显示图像.

```python
plt.figure()
plt.plot(x, y)
plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-1-basic-use-1.png" height="100" width="450" />
</div>

[img1]: /images/python/matplotlib-basic-use-1_1.png

## Reference

- [matplotlib.org][1]
- [matplotlib docs][2]
- [morvanzhou][3]

[1]: https://matplotlib.org/
[2]: https://matplotlib.org/contents.html
[3]: https://morvanzhou.github.io
[4]: https://docs.scipy.org/doc/numpy-1.12.0/reference/generated/numpy.linspace.html


