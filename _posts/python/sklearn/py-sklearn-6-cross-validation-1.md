---
title: Sklearn Cross-validation 1
toc: true
date: 2018-01-08 18:17:21
categories: python
tags: Sklearn
---

Sklearn 中的 `Cross-validation` 对于我们选择正确的 `Model` 和 `Model 的参数`是非常有用， 有了它我们能直观的看出不同 Model 或者参数对结构准确度的影响。

<!-- more -->

## Model 基础验证法

```python
from sklearn.datasets import load_iris # iris数据集
from sklearn.model_selection import train_test_split # 分割数据模块
from sklearn.neighbors import KNeighborsClassifier # K最近邻(kNN，k-NearestNeighbor)分类算法

#加载iris数据集
iris = load_iris()
X = iris.data
y = iris.target

#分割数据并
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=4)

#建立模型
knn = KNeighborsClassifier()

#训练模型
knn.fit(X_train, y_train)

#将准确率打印出
print(knn.score(X_test, y_test))
```

    0.973684210526

可以看到基础验证的准确率为 `0.973684210526`

## Model Cross Validation


```python
from sklearn.cross_validation import cross_val_score # K折交叉验证模块

#使用K折交叉验证模块
scores = cross_val_score(knn, X, y, cv=5, scoring='accuracy')

#将5次的预测准确率打印出
print(scores)

#将5次的预测准确平均率打印出
print(scores.mean())
```

    [ 0.96666667  1.          0.93333333  0.96666667  1.        ]
    0.973333333333

可以看到交叉验证的准确平均率为 `0.973333333333`

## Aaccuracy 准确率判断

一般来说 `准确率(accuracy)` 会用于判断分类(Classification)模型的好坏


```python
import matplotlib.pyplot as plt #可视化模块

#建立测试参数集
k_range = range(1, 31)

k_scores = []

#藉由迭代的方式来计算不同参数对模型的影响，并返回交叉验证后的平均准确率
for k in k_range:
    knn = KNeighborsClassifier(n_neighbors=k)
    scores = cross_val_score(knn, X, y, cv=10, scoring='accuracy')
    k_scores.append(scores.mean())

#可视化数据
plt.plot(k_range, k_scores)
plt.xlabel('Value of K for KNN')
plt.ylabel('Cross-Validated Accuracy')
plt.show()
```

<div class="limg1">
{% image "/images/python/sklearn-6-cross-validation-1-output_6_0.png", width="400px" %}
</div>

从图中得知，选择 `12~18` 的 `k` 值最好。高过 `18` 之后，准确率开始下降则是因为过拟合(`Over fitting`)的问题。

## Mean squared error

一般来说平均方差(`Mean squared error`)会用于判断回归(`Regression`)模型的好坏


```python
import matplotlib.pyplot as plt
k_range = range(1, 31)
k_scores = []
for k in k_range:
    knn = KNeighborsClassifier(n_neighbors=k)
    loss = -cross_val_score(knn, X, y, cv=10, scoring='mean_squared_error')
    k_scores.append(loss.mean())

plt.plot(k_range, k_scores)
plt.xlabel('Value of K for KNN')
plt.ylabel('Cross-Validated MSE')
plt.show()
```

<div class="limg1">
{% image "/images/python/sklearn-6-cross-validation-1-output_8_1.png", width="400px" %}
</div>

由图可以得知，平均方差越低越好，因此选择`13~18`左右的`K`值会最好

## Reference

- [scikit-learn.org][1]
- [scikit-learn docs][2]
- [scikit-learn morvanzhou][3]

[1]: http://scikit-learn.org/
[2]: http://scikit-learn.org/stable/tutorial/basic/tutorial.html
[3]: https://morvanzhou.github.io

[img1]: /images/python/sklearn-6-cross-validation-1-output_6_0.png
[img2]: /images/python/sklearn-6-cross-validation-1-output_8_1.png

