---
title: Sklearn Cross-validation 2
toc: true
date: 2018-01-09 10:17:21
categories: python
tags: Sklearn
---

Sklearn 中的 `learning curve` 可以很直观的看出我们的 `model` 学习的进度, 对比发现有没有 `overfitting` 的问题. 然后我们可以对我们的 `model` 进行调整, 克服 `overfitting` 的问题.

<!-- more -->

## Learning curve 检视过拟合

加载对应模块:

```python
from sklearn.learning_curve import learning_curve #学习曲线模块
from sklearn.datasets import load_digits #digits数据集
from sklearn.svm import SVC #Support Vector Classifier
import matplotlib.pyplot as plt #可视化模块
import numpy as np
```

加载digits数据集，其包含的是手写体的数字，从0到9。  
数据集总共有1797个样本，每个样本由64个特征组成， 分别为其手写体对应的8×8像素表示，每个特征取值0~16。

```python
digits = load_digits()
X = digits.data
y = digits.target

#print(len(X[0]))
```

观察样本由小到大的学习曲线变化, 采用K折交叉验证 `cv=10`, 选择平均方差检视模型效能 `scoring='mean_squared_error'`, 样本由小到大分成5轮检视学习曲线(`10%`, `25%`, `50%`, `75%`, `100%`):

```python
train_sizes, train_loss, test_loss = learning_curve(
    SVC(gamma=0.001), X, y, cv=10, scoring='mean_squared_error',
    train_sizes=[0.1, 0.25, 0.5, 0.75, 1])

#平均每一轮所得到的平均方差(共5轮，分别为样本10%、25%、50%、75%、100%)
train_loss_mean = -np.mean(train_loss, axis=1)
test_loss_mean = -np.mean(test_loss, axis=1)
```

可视化图形:

```python
plt.plot(train_sizes, train_loss_mean, 'o-', color="r",
         label="Training")
plt.plot(train_sizes, test_loss_mean, 'o-', color="g",
        label="Cross-validation")

plt.xlabel("Training examples")
plt.ylabel("Loss")
plt.legend(loc="best")
plt.show()
```

<div class="limg1">
{% image "/images/python/sklearn-6-cross-validation-2-output_7_0.png", width="400px" %}
</div>

## Reference

- [scikit-learn.org][1]
- [scikit-learn docs][2]
- [scikit-learn morvanzhou][3]

[1]: http://scikit-learn.org/
[2]: http://scikit-learn.org/stable/tutorial/basic/tutorial.html
[3]: https://morvanzhou.github.io

[img1]: /images/python/sklearn-6-cross-validation-2-output_7_0.png
