---
title: Scikit-Learn 备忘录(not finish)
toc: true
date: 2017-10-28 16:43:21
categories: [python]
tags: [Scikit-Learn]
mathjax: true
---

Scikit-learn 提供了 `数据预处理`、 `交叉验证算法` 与 `可视化算法` 等一系列接口。

<!--more-->

## 1. Basic Example

```py
>>> from sklearn import neighbors, datasets, preprocessing
>>> from sklearn.cross_validation import train_test_split
>>> from sklearn.metrics import accuracy_score
>>> iris = datasets.load_iris()
>>> X, y = iris.data[:, :2], iris.target
>>> X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=33)
>>> scaler = preprocessing.StandardScaler().fit(X_train)
>>> X_train = scaler.transform(X_train)
>>> X_test = scaler.transform(X_test)
>>> knn = neighbors.KNeighborsClassifier(n_neighbors=5)
>>> knn.fit(X_train, y_train)
>>> y_pred = knn.predict(X_test)
>>> accuracy_score(y_test, y_pred)
```

## 2. 数据加载与切分

我们一般使用NumPy中的数组或者Pandas中的DataFrame等数据结构来存放数据：

```python
>>> import numpy as np
>>> X = np.random.random((10,5))
>>> y = np.array(['M','M','F','F','M','F','M','M','F','F','F'])
>>> X[X < 0.7] = 0
```

NumPy还提供了方便的接口帮我们划分训练数据与测试数据：

```python
>>> from sklearn.cross_validation import train_test_split
>>> X_train, X_test, y_train, y_test = train_test_split(X,
 y, random_state=0)
```

## 3. Model:模型

1. 模型创建
2. 模型拟合
3. 模型预测
4. 模型评估

### 3.1 模型创建

#### 3.1.1 监督学习

Linear Regression

```python
>>> from sklearn.linear_model import LinearRegression
>>> lr = LinearRegression(normalize=True)
```

Support Vector Machines

```python
>>> from sklearn.svm import SVC
>>> svc = SVC(kernel='linear')
```

Naive Bayes

```python
>>> from sklearn.naive_bayes import GaussianNB
>>> gnb = GaussianNB()
```

KNN

```python
>>> from sklearn import neighbors
>>> knn = neighbors.KNeighborsClassifier(n_neighbors=5)
```

#### 3.1.2 无监督学习

### 3.2 模型拟合

#### 3.2.2 监督学习

```py
>>> lr.fit(X, y)
>>> knn.fit(X_train, y_train)
>>> svc.fit(X_train, y_train)
```

### 3.3 模型预测

### 3.4 模型评估

## 4. 数据预处理

## 6. Reference

- [知乎-scikit-learn][1]

[1]: https://zhuanlan.zhihu.com/p/24770526