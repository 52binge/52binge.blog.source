---
title: 例子3 结果可视化
toc: true
date: 2018-09-11 15:40:21
categories: python
tags: tensorflow
---

构建图形，用散点图描述真实数据之间的关系。 （注意：`plt.ion()` 用于连续显示。）

<!-- more -->

## matplotlib 可视化

```python
import tensorflow as tf
import numpy as np

import matplotlib.pyplot as plt
```

```python
x_data = np.linspace(-1,1,300, dtype=np.float32)[:, np.newaxis]
noise = np.random.normal(0, 0.05, x_data.shape).astype(np.float32)
y_data = np.square(x_data) - 0.5 + noise
```

```python
# plot the real data
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
ax.scatter(x_data, y_data)
# plt.ion() # 打开交互模式. 本次运行请注释，全局运行不要注释, 
plt.show()
```

散点图的结果为：

<img src="/images/tensorflow/tf-3.3_1_1.png" width="450" />

每隔 50 次 训练刷新一次图形，用红色、宽度为 5 的线来显示我们的预测数据和输入之间的关系，并暂停 0.1s。

最后，机器学习的结果为：

<img src="/images/tensorflow/tf-3.3_2.png" width="450" />

## Reference

- [tensorflow.org][1]
- [莫烦Python][2]
- [Python入门：matplotlib中ion()和ioff()的使用][3]

[1]: https://www.tensorflow.org/
[2]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/
[3]: https://blog.csdn.net/M_Z_G_Y/article/details/80309446

[img1]: /images/tensorflow/tf-3.3_1_1.png
[img2]: /images/tensorflow/tf-3.3_2.png