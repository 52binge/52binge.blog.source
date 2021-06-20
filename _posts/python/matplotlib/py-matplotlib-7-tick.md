---
title: Matplotlib Tick bbox
date: 2018-01-23 17:08:21
categories: python
tags: Matplotlib
---

图中的内容较多，可通过设置相关内容的`透明度`来使图片更易于观察，也即是本节中的`bbox`参数设置来调节图像信息.

<!-- more -->

## 生成图形

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-3, 3, 50)
y = 0.1*x

plt.figure()
# 在 plt 2.0.2 或更高的版本中, 设置 zorder 给 plot 在 z 轴方向排序
plt.plot(x, y, linewidth=10, zorder=1)
plt.ylim(-2, 2)

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
{% image "/images/python/matplotlib-7-tick-output_1_0.png" height="100", width="700px" %}
</div>

## 调整坐标 bbox

然后对被遮挡的图像调节相关透明度，本例中设置 x轴 和 y轴 的刻度数字进行透明度设置

其中`label.set_fontsize(12)`重新调节字体大小，`bbox`设置目的内容的透明度相关参数，`facecolor`调节 `box` 前景色，`edgecolor` 设置边框， 本处设置边框为无，`alpha`设置透明度. 

```python
for label in ax.get_xticklabels() + ax.get_yticklabels():
    label.set_fontsize(12)
    # 在 plt 2.0.2 或更高的版本中, 设置 zorder 给 plot 在 z 轴方向排序
    label.set_bbox(dict(facecolor='white', edgecolor='None', alpha=0.7, zorder=2))
plt.show()
```

<div class="limg1">
{% image "/images/python/matplotlib-7-tick-output_3_0.png" height="100", width="700px" %}
</div>

[img1]: /images/python/matplotlib-7-tick-output_1_0.png
[img2]: /images/python/matplotlib-7-tick-output_3_0.png

## Reference

- [matplotlib.org][1]
- [matplotlib docs][2]
- [morvanzhou][3]

[1]: https://matplotlib.org/
[2]: https://matplotlib.org/contents.html
[3]: https://morvanzhou.github.io


