---
title: Sklearn Save Model
date: 2018-01-10 13:17:21
categories: python
tags: Sklearn
---

我们训练好了一个 `Model` 以后总需要保存和再次预测, 所以保存和读取我们的sklearn model也是同样重要的一步。  
这次主要介绍两种保存Model的模块 `pickle` 与 `joblib`

<!-- more -->

## pickle 保存

首先简单建立与训练一个 `SVC` Model


```python
from sklearn import svm
from sklearn import datasets

clf = svm.SVC()
iris = datasets.load_iris()
X, y = iris.data, iris.target
clf.fit(X,y)
```

    SVC(C=1.0, cache_size=200, class_weight=None, coef0=0.0,
      decision_function_shape='ovr', degree=3, gamma='auto', kernel='rbf',
      max_iter=-1, probability=False, random_state=None, shrinking=True,
      tol=0.001, verbose=False)

使用 `pickle` 来保存与读取训练好的 `Model`

```python
import pickle #pickle模块

#保存Model(注:save文件夹要预先建立，否则会报错)
with open('save/clf.pickle', 'wb') as f:
    pickle.dump(clf, f)

#读取Model
with open('save/clf.pickle', 'rb') as f:
    clf2 = pickle.load(f)
    #测试读取后的Model
    print(clf2.predict(X[0:1]))

# [0]
```

    [0]

## joblib 保存

`joblib` 是 sklearn的外部模块


```python
from sklearn.externals import joblib #jbolib模块

#保存Model(注:save文件夹要预先建立，否则会报错)
joblib.dump(clf, 'save/clf.pkl')

#读取Model
clf3 = joblib.load('save/clf.pkl')

#测试读取后的Model
print(clf3.predict(X[0:1]))

# [0]
```

    [0]

`joblib` 在使用上比较容易，读取速度也相对`pickle`快

## Reference

- [scikit-learn.org][1]
- [scikit-learn docs][2]
- [scikit-learn morvanzhou][3]

[1]: http://scikit-learn.org/
[2]: http://scikit-learn.org/stable/tutorial/basic/tutorial.html
[3]: https://morvanzhou.github.io


