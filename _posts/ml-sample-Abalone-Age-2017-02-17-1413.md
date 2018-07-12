---
title: Abalone's Age
toc: true
date: 2017-02-17 17:28:21
categories: machine-learning
tags: Neural Networks
description: neural networks example - abalone's age
mathjax: true
---

## [Abalone's Age](http://www.pkbigdata.com/common/cmpt/成电大数据培训实践_竞赛信息.html)

『Abalone's Age』

鲍鱼，在现代汉语中有多种含义。最常用的是指一种原始的海洋贝类，属于单壳软体动物，其只有半面外壳，壳坚厚、扁而宽，鲍鱼是中国传统的名贵食材，位居四大海味之首。
鲍鱼的优劣与年龄相关。一般来说，我们可以数鲍鱼的生长纹来确定鲍鱼的年龄，但数生长纹也是一件挺麻烦的事情。在这里，我们采用与鲍鱼年龄有关的因素来预测鲍鱼的年龄。


构建Pybrain神经网络的基本步骤：

1. 构建神经网路
2. 构造数据集
3. 训练神经网络
4. 预测测试集结果
5. 提交,验证和分析

## 1. 分析问题

分析什么特征是更重要的

**<font color=red>先看看数据长什么样 </font>** 还是用pandas加载数据


```python
# 这个ipython notebook主要是我解决Kaggle Titanic问题的思路和过程

import pandas as pd #数据分析
import numpy as np #科学计算
from pandas import Series,DataFrame

data_train = pd.read_csv("traindata.csv")
print data_train.columns
print "============ df info ============"
data_train.info()
```

    Index([u'Sex', u'Length', u'Diameter', u'Hight', u'Whole', u'Shucked',
           u'Viscera', u'Shell', u'Rings'],
          dtype='object')
    ============ df info ============
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 3177 entries, 0 to 3176
    Data columns (total 9 columns):
    Sex         3177 non-null object
    Length      3177 non-null float64
    Diameter    3177 non-null float64
    Hight       3177 non-null float64
    Whole       3177 non-null float64
    Shucked     3177 non-null float64
    Viscera     3177 non-null float64
    Shell       3177 non-null float64
    Rings       3177 non-null int64
    dtypes: float64(7), int64(1), object(1)
    memory usage: 223.5+ KB


<font color=blue>我们看大概有以下这些字段</font>

 1. Sex
 2. Length
 3. Diameter
 4. Hight
 5. Whole
 6. Shucked
 7. Viscera
 8. Shell
 9. Rings => Age

上面的数据说什么了？它告诉我们，一共有9 Column 数据，训练数据中总共有 3177 只 abalone，所有的数据都是全的。


```python
data_train.describe()
```

~ | Length | Diameter | Hight | Whole | Shucked | Viscera | Shell | Rings
------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- | -------
count | 3177 | 3177 | 3177 | 3177 | 3177 | 3177 | 3177 | 3177
mean | 0.52 | 0.41 | 0.14 | 0.83 | 0.36 | 0.18 | 0.24 | 9.92

* <font color=blue>『对数据的认识太重要了！』<font>
* <font color=red>『对数据的认识太重要了！』<font>
* <font color=green>『对数据的认识太重要了！』<font>

```python
data_train
```

## 2. 准备数据

```python
# 对 sex 进行 one-hot 编码
dummies_Sex = pd.get_dummies(data_train['Sex'], prefix= 'Sex')

df = pd.concat([data_train, dummies_Sex], axis=1)
df.drop(['Sex'], axis=1, inplace=True)
train_df = df
train_df
```

## 3. 构造神经网络 NN


```python
import numpy as np
import pandas as pd

from pandas import Series,DataFrame

import matplotlib.pyplot as plt

import pandas.io.data as wb

from pybrain.structure import *
from pybrain.datasets import SupervisedDataSet
from pybrain.supervised.trainers import BackpropTrainer

# createa neural network
fnn = FeedForwardNetwork()

# create three layers, input layer:2 input unit; hidden layer: 10 units; output layer: 1 output
inLayer = LinearLayer(10, name='inLayer')
hiddenLayer0 = SigmoidLayer(3, name='hiddenLayer0')
outLayer = LinearLayer(1, name='outLayer')

# add three layers to the neural network
fnn.addInputModule(inLayer)
fnn.addModule(hiddenLayer0)
fnn.addOutputModule(outLayer)

# link three layers
in_to_hidden0 = FullConnection(inLayer,hiddenLayer0)
hidden0_to_out = FullConnection(hiddenLayer0, outLayer)

# add the links to neural network
fnn.addConnection(in_to_hidden0)
fnn.addConnection(hidden0_to_out)

# make neural network come into effect
fnn.sortModules()
```

## 4. 构造数据集


```python
# obtain the original data

x1 = train_df['Length']
x2 = train_df['Diameter']
x3 = train_df['Hight']
x4 = train_df['Whole']
x5 = train_df['Shucked']
x6 = train_df['Viscera']
x7 = train_df['Shell']
x8 = train_df['Sex_F']
x9 = train_df['Sex_I']
x10 = train_df['Sex_M']

y = train_df['Rings']

# definite the dataset as two input , one output
DS = SupervisedDataSet(10,1)

# add data element to the dataset
# 往数据集内加样本点
# 假设x1，x2，x3是输入的三个维度向量，y是输出向量，并且它们的长度相同
for i in np.arange(len(train_df)):
    DS.addSample([x1[i],x2[i],x3[i],x4[i],x5[i],x6[i],x7[i],x8[i],x9[i],x10[i]],[y[i]])

# you can get your input/output this way
# 如果要获得里面的输入／输出时，可以用
X = DS['input']
Y = DS['target']

# split the dataset into train dataset and test dataset
# 如果要把数据集切分成训练集和测试集，可以用下面的语句，训练集：测试集＝8:2
# 为了方便之后的调用，可以把输入和输出拎出来
dataTrain, dataTest = DS.splitWithProportion(0.8)
xTrain, yTrain = dataTrain['input'],dataTrain['target']
xTest, yTest = dataTest['input'], dataTest['target']

print "bulid data sets end ！"

#print xTest[1]
type(xTest)
```

    bulid data sets end ！

    numpy.ndarray



## 5. 训练神经网络


```python
# train the NN
# we use BP Algorithm
# verbose = True means print th total error
print "trainer start..."
trainer = BackpropTrainer(fnn, dataTrain, verbose=False,learningrate=0.01)
print "run..."
# set the epoch times to make the NN  fit
trainer.trainUntilConvergence(maxEpochs=500)
print "trainer end!"
```

    trainer start...
    run...
    trainer end!


## 6. 预测testdata


```python
data_test = pd.read_csv("testdata.csv")
# 对 sex 进行 one-hot 编码
dummies_Sex = pd.get_dummies(data_test['Sex'], prefix= 'Sex')

df = pd.concat([data_test, dummies_Sex], axis=1)
df.drop(['Sex'], axis=1, inplace=True)
df_test = df
df_test

test = df_test.filter(regex='Length|Diameter|Hight|Whole|Shucked|Viscera|Shell|Sex_F|Sex_I|Sex_M')
test
```

```python
xTest = test.as_matrix()
xTest
# prediction = fnn.activate(xTest[1])
# print("the prediction number is :",prediction," the real number is:  ",yTest[1])
predict_resutl=[]
for i in np.arange(len(xTest)):
    res = fnn.activate(xTest[i])[0]
    predict_resutl.append(round(res))

final_res = np.array(predict_resutl).T

result = pd.DataFrame({'ID':data_test['ID'].as_matrix(), 'Rings':final_res})
result
```

```python
result.to_csv("abalone_predictions.csv", index=False)
```
