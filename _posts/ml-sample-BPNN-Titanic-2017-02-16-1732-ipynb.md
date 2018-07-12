---
title: Kaggle_Titanic
toc: true
date: 2017-02-16 17:28:21
categories: machine-learning
tags: Neural Networks
description: neural networks example - pybrain kaggle titanic
mathjax: true
---

## [泰坦尼克号](https://www.kaggle.com/c/titanic)
『Jack and Rose』的故事，豪华游艇倒了，大家都惊恐逃生，可是救生艇的数量有限，无法人人都有，副船长发话了『lady and kid first！』，所以是否获救其实并非随机，而是基于一些背景有rank先后的。<br>
训练和测试数据是一些乘客的个人信息以及存活状况，要尝试根据它生成合适的模型并预测其他人的存活状况。<br>

这是一个二分类问题，很多分类算法都可以解决。

```
构建Pybrain神经网络的基本步骤：

1. 构建神经网路
2. 构造数据集
3. 训练神经网络
4. 预测测试集结果
5. 验证和分析
```

## 1. 分析问题

> 分析什么特征是更重要的

先看看数据长什么样？ 还是用pandas加载数据

```python
# 这个ipython notebook主要是我解决Kaggle Titanic问题的思路和过程

import pandas as pd #数据分析
import numpy as np #科学计算
from pandas import Series,DataFrame

data_train = pd.read_csv("Train.csv")
print data_train.columns
print "============ df info ============"
data_train.info()
```

    Index([u'PassengerId', u'Survived', u'Pclass', u'Name', u'Sex', u'Age',
           u'SibSp', u'Parch', u'Ticket', u'Fare', u'Cabin', u'Embarked'],
          dtype='object')
    ============ df info ============
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 891 entries, 0 to 890
    Data columns (total 12 columns):
    PassengerId    891 non-null int64
    Survived       891 non-null int64
    Pclass         891 non-null int64
    Name           891 non-null object
    Sex            891 non-null object
    Age            714 non-null float64
    SibSp          891 non-null int64
    Parch          891 non-null int64
    Ticket         891 non-null object
    Fare           891 non-null float64
    Cabin          204 non-null object
    Embarked       889 non-null object
    dtypes: float64(2), int64(5), object(5)
    memory usage: 83.6+ KB


我们看大概有以下这些字段

PassengerId => 乘客ID
Pclass => 乘客等级(1/2/3等舱位)
Name => 乘客姓名
Sex => 性别
Age => 年龄
SibSp => 堂兄弟/妹个数
Parch => 父母与小孩个数
Ticket => 船票信息
Fare => 票价
Cabin => 客舱
Embarked => 登船港口

上面的数据说什么了？它告诉我们，训练数据中总共有891名乘客，但是很不幸，我们有些属性的数据不全，比如说：

- Age（年龄）属性只有714名乘客有记录
- Cabin（客舱）更是只有204名乘客是已知的

再瞄一眼具体数据数值情况，得到数值型数据的一些分布(因为有些属性，比如姓名，是文本型；而另外一些属性，比如登船港口，是类目型。这些我们用下面的函数是看不到的)


```python
data_train.describe()
```

- | PassengerId | Survived | Pclass | Age | SibSp | Parch | Fare
------- | ------- | ------- | ------- | ------- | ------- | -------
count | 891.000000 | 891.000000 | 891.000000 | 714.000000 | 891.000000 | 891.000000 | 891.000000
mean | 446.000000 | 0.383838 | 2.308642 | 29.699118 | 0.523008 | 0.381594 | 32.204208

<font color=red>mean字段告诉我们，大概0.383838的人最后获救了，2/3等舱的人数比1等舱要多，平均乘客年龄大概是29.7岁(计算这个时候会略掉无记录的)等等…<font>

* <font color=blue>『对数据的认识太重要了！』<font>
* <font color=red>『对数据的认识太重要了！』<font>
* <font color=green>『对数据的认识太重要了！』<font>

总结 : 

 1. Cabin，没看出什么明显特征，缺失值又太多
 2. Age：可以尝试补全缺失的数据

**通常遇到缺值的情况，我们会有几种常见的处理方式**<br><br>

 1. 如果缺值的样本占总数比例极高，我们可能就直接舍弃了，作为特征加入的话，可能反倒带入noise，影响最后的结果了
 2. 如果缺值的样本适中，而该属性非连续值特征属性(比如说类目属性)，那就把NaN作为一个新类别，加到类别特征中
 3. 如果缺值的样本适中，而该属性为连续值特征属性，有时候我们会考虑给定一个step(比如这里的age，我们可以考虑每隔2/3岁为一个步长)，然后把它离散化，之后把NaN作为一个type加到属性类目中。
 4. 有些情况下，缺失的值个数并不是特别多，那我们也可以试着根据已有的值，拟合一下数据，补充上。

本例中，后两种处理方式应该都是可行的，我们先试试拟合补全吧(没有特别多的背景可供我们拟合，这不一定是一个好的选择)

我们这里用scikit-learn中的RandomForest来拟合一下缺失的年龄数据<br>

 1. 从数据来估计 Age 应该是比较重要的, 还有毕竟 副船长发话了『lady and kid first！』
 2. Cabin 缺失值太多了，先按Cabin有无数据，将这个属性处理成Yes和No两种类型吧


## 2. 准备数据

1. Age 与 cabin 补全
2. one-hot 编码
3. Feature Scaling


```python
# 我们这里用scikit-learn中的RandomForest来拟合一下缺失的年龄数据

from sklearn.ensemble import RandomForestRegressor
 
### 使用 RandomForestClassifier 填补缺失的年龄属性
def set_missing_ages(df):
    
    # 把已有的数值型特征取出来丢进Random Forest Regressor中
    age_df = df[['Age','Fare', 'Parch', 'SibSp', 'Pclass']]

    # 乘客分成已知年龄和未知年龄两部分
    known_age = age_df[age_df.Age.notnull()].as_matrix()
    unknown_age = age_df[age_df.Age.isnull()].as_matrix()

    # y即目标年龄
    y = known_age[:, 0] ## Age ‘s value list

    # X即特征属性值
    X = known_age[:, 1:] ## Fare 的值 list

    # fit到RandomForestRegressor之中
    rfr = RandomForestRegressor(random_state=0, n_estimators=2000, n_jobs=-1)
    rfr.fit(X, y)
    
    # 用得到的模型进行未知年龄结果预测
    predictedAges = rfr.predict(unknown_age[:, 1::])
    
    # 用得到的预测结果填补原缺失数据
    df.loc[ (df.Age.isnull()), 'Age' ] = predictedAges 
    
    return df, rfr

def set_Cabin_type(df):
    df.loc[ (df.Cabin.notnull()), 'Cabin' ] = "Yes"
    df.loc[ (df.Cabin.isnull()), 'Cabin' ] = "No"
    return df

data_train, rfr = set_missing_ages(data_train)
data_train = set_Cabin_type(data_train)
data_train
```

**one-hot 编码**

因为逻辑回归建模时，需要输入的特征都是数值型特征，我们通常会先对类目型的特征因子化/one-hot编码。 <br>
什么叫做因子化/one-hot编码？举个例子：<font><br>

以Embarked为例，原本一个属性维度，因为其取值可以是[‘S’,’C’,’Q‘]，而将其平展开为’Embarked_C’,’Embarked_S’, ‘Embarked_Q’三个属性<font><br>

1. 原Embarked取S的，在此处的”Embarked_S”下取值为1，在’Embarked_C’, ‘Embarked_Q’下取值为0<br>
2. 原Embarked取C的，在此处的”Embarked_C”下取值为1，在’Embarked_S’, ‘Embarked_Q’下取值为0<br>
3. 原Embarked取Q的，在此处的”Embarked_Q”下取值为1，在’Embarked_C’, ‘Embarked_S’下取值为0<br>


我们使用pandas的”get_dummies”来完成这个工作，并拼接在原来的”data_train”之上，如下所示。<br>


```python
# 因为逻辑回归建模时，需要输入的特征都是数值型特征
# 我们先对类目型的特征离散/因子化
# 以Cabin为例，原本一个属性维度，因为其取值可以是['yes','no']，而将其平展开为'Cabin_yes','Cabin_no'两个属性
# 原本Cabin取值为yes的，在此处的'Cabin_yes'下取值为1，在'Cabin_no'下取值为0
# 原本Cabin取值为no的，在此处的'Cabin_yes'下取值为0，在'Cabin_no'下取值为1
# 我们使用pandas的get_dummies来完成这个工作，并拼接在原来的data_train之上，如下所示
dummies_Cabin = pd.get_dummies(data_train['Cabin'], prefix= 'Cabin')

dummies_Embarked = pd.get_dummies(data_train['Embarked'], prefix= 'Embarked')

dummies_Sex = pd.get_dummies(data_train['Sex'], prefix= 'Sex')

dummies_Pclass = pd.get_dummies(data_train['Pclass'], prefix= 'Pclass')
df = pd.concat([data_train, dummies_Cabin, dummies_Embarked, dummies_Sex, dummies_Pclass], axis=1)
df.drop(['Pclass', 'Name', 'Sex', 'Ticket', 'Cabin', 'Embarked'], axis=1, inplace=True)
df
```

PassengerId | ... |  Embarked_C| Embarked_Q| Embarked_S| Sex_female| Sex_male| Pclass_1| Pclass_2| Pclass_3
------- | ------- | ------- | ------- | ------- | -------| ------- | ------- | ------- | -------
1|...| 1.0| 0.0| 0.0| 0.0| 1.0| 0.0| 0.0| 1.0

**Feature Scaling**

<font color=red>Age和Fare两个属性，乘客的数值幅度变化，scaling，其实就是将一些变化幅度较大的特征化到[-1,1]之内。<font>


```python
# 接下来我们要接着做一些数据预处理的工作，比如scaling，将一些变化幅度较大的特征化到[-1,1]之内
# 这样可以加速logistic regression的收敛
import sklearn.preprocessing as preprocessing
scaler = preprocessing.StandardScaler()
age_scale_param = scaler.fit(df['Age'])
df['Age_scaled'] = scaler.fit_transform(df['Age'], age_scale_param)
fare_scale_param = scaler.fit(df['Fare'])
df['Fare_scaled'] = scaler.fit_transform(df['Fare'], fare_scale_param)
df
train_df = df.filter(regex='Survived|Age_.*|SibSp|Parch|Fare_.*|Cabin_.*|Embarked_.*|Sex_.*|Pclass_.*')
train_df
```

## 3. 构造神经网络


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
inLayer = LinearLayer(9, name='inLayer')
hiddenLayer0 = SigmoidLayer(1, name='hiddenLayer0')
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

x1 = train_df['SibSp']
x2 = train_df['Parch']
x3 = train_df['Sex_female']
x4 = train_df['Sex_male']
x5 = train_df['Pclass_1']
x6 = train_df['Pclass_2']
x7 = train_df['Pclass_3']
x8 = train_df['Age_scaled']
x9 = train_df['Fare_scaled']

y = train_df['Survived']

# definite the dataset as two input , one output
DS = SupervisedDataSet(9,1)

# add data element to the dataset
# 往数据集内加样本点
# 假设x1，x2，x3是输入的三个维度向量，y是输出向量，并且它们的长度相同
for i in np.arange(len(train_df)):
    DS.addSample([x1[i],x2[i],x3[i],x4[i],x5[i],x6[i],x7[i],x8[i],x9[i]],[y[i]])

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


## 6. 预测 test.csv

```python
data_test = pd.read_csv("test.csv")
data_test.loc[ (data_test.Fare.isnull()), 'Fare' ] = 0
# 接着我们对test_data做和train_data中一致的特征变换
# 首先用同样的RandomForestRegressor模型填上丢失的年龄
tmp_df = data_test[['Age','Fare', 'Parch', 'SibSp', 'Pclass']]
null_age = tmp_df[data_test.Age.isnull()].as_matrix()
# 根据特征属性X预测年龄并补上
X = null_age[:, 1:]
predictedAges = rfr.predict(X)
data_test.loc[ (data_test.Age.isnull()), 'Age' ] = predictedAges

data_test = set_Cabin_type(data_test)
dummies_Cabin = pd.get_dummies(data_test['Cabin'], prefix= 'Cabin')
dummies_Embarked = pd.get_dummies(data_test['Embarked'], prefix= 'Embarked')
dummies_Sex = pd.get_dummies(data_test['Sex'], prefix= 'Sex')
dummies_Pclass = pd.get_dummies(data_test['Pclass'], prefix= 'Pclass')


df_test = pd.concat([data_test, dummies_Cabin, dummies_Embarked, dummies_Sex, dummies_Pclass], axis=1)
df_test.drop(['Pclass', 'Name', 'Sex', 'Ticket', 'Cabin', 'Embarked'], axis=1, inplace=True)
df_test['Age_scaled'] = scaler.fit_transform(df_test['Age'], age_scale_param)
df_test['Fare_scaled'] = scaler.fit_transform(df_test['Fare'], fare_scale_param)
df_test

test = df_test.filter(regex='SibSp|Parch|Sex_female|Sex_male|Pclass_1|Pclass_2|Pclass_3|Age_scaled|Fare_scaled')
xTest = test.as_matrix()
# prediction = fnn.activate(xTest[1])
# print("the prediction number is :",prediction," the real number is:  ",yTest[1])
predict_resutl=[]
for i in np.arange(len(xTest)):
    res = fnn.activate(xTest[i])[0]
    if (res > 0.5) :
        res = 1
    else :
        res = 0
    predict_resutl.append(res)

final_res = np.array(predict_resutl).T

result = pd.DataFrame({'PassengerId':data_test['PassengerId'].as_matrix(), 'Survived':final_res})
result
```
## 7. 结果写入文件

```python
result.to_csv("logistic_regression_predictions.csv", index=False)
```

## 8. 验证和分析



```python
for mod in fnn.modules:
  print ("Module:", mod.name)
  if mod.paramdim > 0:
    print ("--parameters:", mod.params)
  for conn in fnn.connections[mod]:
    print ("-connection to", conn.outmod.name)
    if conn.paramdim > 0:
       print ("- parameters", conn.params)
  if hasattr(fnn, "recurrentConns"):
    print ("Recurrent connections")
    for conn in fnn.recurrentConns:
       print ("-", conn.inmod.name, " to", conn.outmod.name)
       if conn.paramdim > 0:
          print ("- parameters", conn.params)
```

    ('Module:', 'outLayer')
    ('Module:', 'inLayer')
    ('-connection to', 'hiddenLayer0')
    ('- parameters', array([-0.47294263, -0.04334279,  0.77615167, -2.03865708,  2.38243634,
            0.69678661, -0.82062356, -0.70921933, -0.12044558]))
    ('Module:', 'hiddenLayer0')
    ('-connection to', 'outLayer')
    ('- parameters', array([ 1.08050317]))

## Reference

- [寒小阳-Titanic][1]
- [一蓑烟雨任平生][2]

[1]: http://blog.csdn.net/han_xiaoyang/article/details/49797143
[2]: http://www.zengmingxia.com/topics/computing/