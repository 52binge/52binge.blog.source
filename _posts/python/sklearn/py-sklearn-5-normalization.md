---
title: Sklearn Normalization
toc: true
date: 2018-01-06 19:52:21
categories: python
tags: Sklearn
---

Data Normalization 可以提升机器学习的成效

<!-- more -->

## Normalization

```python
from sklearn import preprocessing #标准化数据模块
import numpy as np

# 建立Array
a = np.array([[10, 2.7, 3.6],
              [-100, 5, -2],
              [120, 20, 40]], dtype=np.float64)

# 将normalized后的a打印出
print(preprocessing.scale(a))
```

    [[ 0.         -0.85170713 -0.55138018]
     [-1.22474487 -0.55187146 -0.852133  ]
     [ 1.22474487  1.40357859  1.40351318]]

## Normalization 对结果的影响

```python
# 标准化数据模块
from sklearn import preprocessing 
import numpy as np

# 将资料分割成train与test的模块
from sklearn.model_selection import train_test_split

# 生成适合做classification资料的模块
from sklearn.datasets.samples_generator import make_classification 

# Support Vector Machine中的Support Vector Classifier
from sklearn.svm import SVC 

# 可视化数据的模块
import matplotlib.pyplot as plt 
```

### 生成适合做 Classification 数据

```python
# 生成具有2种属性的300笔数据
X, y = make_classification(
    n_samples=300, n_features=2,
    n_redundant=0, n_informative=2, 
    random_state=22, n_clusters_per_class=1, 
    scale=100)

# n_features 特征个数 = n_informative（） + n_redundant + n_repeated
# n_informative 多信息特征的个数
# n_redundant 冗余信息，informative 特征的随机线性组合
# n_classes 分类类别
# n_clusters_per_class 某一个类别是由几个 cluster 构成的

#可视化数据
plt.scatter(X[:, 0], X[:, 1], c=y)
plt.show()
```

<div class="limg1">
{% image "/images/python/sklearn-5-normalization-output_5_0.png", width="400px" %}
</div>

### data normalization before

```python
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)
clf = SVC()
clf.fit(X_train, y_train)
print(clf.score(X_test, y_test))
```

    0.477777777778

### data normalization after

数据的单位发生了变化, `X` 数据也被压缩到差不多大小范围.

```python
X = preprocessing.scale(X)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)
clf = SVC()
clf.fit(X_train, y_train)
print(clf.score(X_test, y_test))
# 0.9
```

    0.933333333333

## Reference

- [scikit-learn.org][1]
- [scikit-learn docs][2]
- [scikit-learn morvanzhou][3]

[1]: http://scikit-learn.org/
[2]: http://scikit-learn.org/stable/tutorial/basic/tutorial.html
[3]: https://morvanzhou.github.io

[img1]: /images/python/sklearn-5-normalization-output_5_0.png
