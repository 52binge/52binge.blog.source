---
title: Sklearn Common Attributes and Functions
date: 2018-01-05 14:15:21
categories: python
tags: Sklearn
---

今天来看 `Model` 的属性和功能, 这里以 `LinearRegressor` 为例，所以先导入包，数据，还有模型

<!-- more -->

```python
from sklearn import datasets
from sklearn.linear_model import LinearRegression

loaded_data = datasets.load_boston()

data_X = loaded_data.data
data_y = loaded_data.target

model = LinearRegression()
```

## 训练和预测

接下来 `model.fit` 和 `model.predict` 就属于 `Model` 的功能，用来训练模型，用训练好的模型预测


```python
model.fit(data_X, data_y)

print(model.predict(data_X[:4, :]))
```

    [ 30.00821269  25.0298606   30.5702317   28.60814055]


## 参数和分数

`model.coef_` 和 `model.intercept_` 属于 `Model` 的属性， 例如对于 `LinearRegressor` 这个模型，这两个属性分别输出模型的斜率和截距（与y轴的交点）


```python
print(model.coef_)
print(model.intercept_)
```

    [ -1.07170557e-01   4.63952195e-02   2.08602395e-02   2.68856140e+00
      -1.77957587e+01   3.80475246e+00   7.51061703e-04  -1.47575880e+00
       3.05655038e-01  -1.23293463e-02  -9.53463555e-01   9.39251272e-03
      -5.25466633e-01]
    36.4911032804

`model.get_params()` 也是功能，它可以取出之前定义的参数

```python
print(model.get_params())
```

    {'copy_X': True, 'fit_intercept': True, 'n_jobs': 1, 'normalize': False}

`model.score(data_X, data_y)` 它可以对 `Model` 用 `R^2` 的方式进行打分，输出精确度。  
关于 `R^2 coefficient of determination` 可以查看 [Coefficient_of_determination][4]

```python
print(model.score(data_X, data_y)) # R^2 coefficient of determination
```

    0.740607742865


> 按标准的来说, 是要将数据分成训练数据和测试数据, 这里不是一个完整的测试, 只是展示 model 里面的一些属性. 正确率很少能真正100%, 取决于拟合度怎么样. 拟合度好, 正确率高

## Reference

- [scikit-learn.org][1]
- [scikit-learn docs][2]
- [scikit-learn morvanzhou][3]

[1]: http://scikit-learn.org/
[2]: http://scikit-learn.org/stable/tutorial/basic/tutorial.html
[3]: https://morvanzhou.github.io

[4]: https://en.wikipedia.org/wiki/Coefficient_of_determination


