---
title: Matplotlib Annotation
toc: true
date: 2018-01-23 16:38:21
categories: python
tags: Matplotlib
---

当图线中某些特殊地方需要标注时，我们可以使用 `annotation`.  

matplotlib 中的 `annotation` 有两种方法， 一种是用 plt 里面的 `annotate`，一种是直接用 plt 里面的 `text` 来写标注.

<!-- more -->

## 画出基本图

首先，我们在坐标轴中绘制一条直线.

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-3, 3, 50)
y = 2*x + 1

plt.figure(num=1, figsize=(8, 5),)
plt.plot(x, y,)
plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-6-annotation-output_1_0.png" height="100" width="500" />
</div>

## 移动坐标


```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-3, 3, 50)
y = 2*x + 1

plt.figure(num=1, figsize=(8, 5),)
plt.plot(x, y,)

# 移动坐标
ax = plt.gca()
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')

ax.xaxis.set_ticks_position('bottom')
ax.spines['bottom'].set_position(('data', 0))

ax.yaxis.set_ticks_position('left')
ax.spines['left'].set_position(('data', 0))

plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-6-annotation-output_3_0.png" height="100" width="550" />
</div>

然后标注出点`(x0, y0)`的位置信息. 用 `plt.plot([x0, x0,], [0, y0,], 'k--', linewidth=2.5)` 画出一条垂直于x轴的虚线.

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-3, 3, 50)
y = 2*x + 1

plt.figure(num=1, figsize=(8, 5),)
plt.plot(x, y,)

# 移动坐标
ax = plt.gca()
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')

ax.xaxis.set_ticks_position('bottom')
ax.spines['bottom'].set_position(('data', 0))

ax.yaxis.set_ticks_position('left')
ax.spines['left'].set_position(('data', 0))

x0 = 1
y0 = 2*x0 + 1

###   plt.plot([x0, x0,], [0, y0,], 'k--', linewidth=2.5) 画出一条垂直于x轴的虚线.  ###

plt.plot([x0, x0,], [0, y0,], 'k--', linewidth=2.5)
# set dot styles
plt.scatter([x0, ], [y0, ], s=50, color='b')
plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-6-annotation-output_5_0.png" height="100" width="550" />
</div>

## 加注释 annotate

接下来我们就对`(x0, y0)`这个点进行标注.

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-4, 4, 50)
y = 2*x + 1

plt.figure(num=1, figsize=(10, 6),)
plt.plot(x, y,)

# 移动坐标
ax = plt.gca()
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')

ax.xaxis.set_ticks_position('bottom')
ax.spines['bottom'].set_position(('data', 0))

ax.yaxis.set_ticks_position('left')
ax.spines['left'].set_position(('data', 0))

x0 = 1
y0 = 2*x0 + 1
plt.plot([x0, x0,], [0, y0,], 'k--', linewidth=2.5)
# set dot styles
plt.scatter([x0, ], [y0, ], s=50, color='b')

############## 添加注释 annotate ###############

plt.annotate(r'$2x+1=%s$' % y0, xy=(x0, y0), xycoords='data', xytext=(+30, -30),
             textcoords='offset points', fontsize=16,
             arrowprops=dict(arrowstyle='->', connectionstyle="arc3,rad=.2"))

plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-6-annotation-output_7_0.png" height="100" width="550" />
</div>

其中参数 `xycoords='data'` 是说基于数据的值来选位置, `xytext=(+30, -30)` 和 `textcoords='offset points'` 对于标注位置的描述 和 `xy` 偏差值, `arrowprops`是对图中箭头类型的一些设置.

## 加注释 text


```python
plt.text(-3.7, 3, r'$This\ is\ the\ some\ text. \mu\ \sigma_i\ \alpha_t$',
         fontdict={'size': 16, 'color': 'r'})
```

    Text(-3.7,3,'$This\\ is\\ the\\ some\\ text. \\mu\\ \\sigma_i\\ \\alpha_t$')

其中`-3.7, 3,`是选取text的位置, 空格需要用到转字符`\` ,`fontdict`设置文本字体.

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-4, 4, 50)
y = 2*x + 1

plt.figure(num=1, figsize=(10, 6),)
plt.plot(x, y,)

# 移动坐标
ax = plt.gca()
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')

ax.xaxis.set_ticks_position('bottom')
ax.spines['bottom'].set_position(('data', 0))

ax.yaxis.set_ticks_position('left')
ax.spines['left'].set_position(('data', 0))

x0 = 1
y0 = 2*x0 + 1
plt.plot([x0, x0,], [0, y0,], 'k--', linewidth=2.5)
# set dot styles
plt.scatter([x0, ], [y0, ], s=50, color='b')

############## 添加注释 annotate ###############

plt.annotate(r'$2x+1=%s$' % y0, xy=(x0, y0), xycoords='data', xytext=(+30, -30),
             textcoords='offset points', fontsize=16,
             arrowprops=dict(arrowstyle='->', connectionstyle="arc3,rad=.2"))


############# 添加注释 text #################

plt.text(-3.7, 3, r'$This\ is\ the\ some\ text. \mu\ \sigma_i\ \alpha_t$',
         fontdict={'size': 16, 'color': 'r'})

plt.show()
```

<div class="limg1">
<img src="/images/python/matplotlib-6-annotation-output_11_0.png" height="100" width="500" />
</div>

[img1]: /images/python/matplotlib-6-annotation-output_1_0.png
[img2]: /images/python/matplotlib-6-annotation-output_3_0.png
[img3]: /images/python/matplotlib-6-annotation-output_5_0.png
[img4]: /images/python/matplotlib-6-annotation-output_7_0.png
[img5]: /images/python/matplotlib-6-annotation-output_11_0.png

## Reference

- [matplotlib.org][1]
- [matplotlib docs][2]
- [morvanzhou][3]

[1]: https://matplotlib.org/
[2]: https://matplotlib.org/contents.html
[3]: https://morvanzhou.github.io


