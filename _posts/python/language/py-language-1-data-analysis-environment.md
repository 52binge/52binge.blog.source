---
title: Python Data Mining and Analysis environment
date: 2016-08-02 16:43:21
categories: [python]
tags: [machine-learning, python]
---

这是用 Python 进行数据分析挖掘的一小部分，包括 高维数组、数值计算、机器学习、神经网络 和 语言模型等。

<!--more-->

## 1. Python data analysis intro

[Python](http://www.python.org)

- 优雅的语法和动态类型
- 拥有高级数据结构、OO
- Functional Programming
- 解释性、胶水语言，开发效率高
- 库丰富, NumPy, SciPy, Matplotlib, Pandas
- 适合于 Scientific Computing、Mathematical Modeling、Data mining ...

**import `future` feature**

```
from __futrue__ import print_function
from __futrue__ import division
```

**install third package**

> 三种方式  
> 1. 下载源代码自行安装 : 安装灵活， 但需要自行解决上级依赖问题。  
> 2. 用 pip 安装 : 比较方便，自动解决上级依赖问题  
> 3. 系统自带的安装方式 : apt-get or brew ..

### 1.1 Install pip

> pip 是安装python包的工具，提供了安装包，列出已经安装的包，升级包以及卸载包的功能。
> pip 是对easy_install的取代，提供了和easy_install相同的查找包的功能

```bash
which python
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
```

```
修改pip源 （可选）
由于天朝原因,使用pip安装一些模块会特别慢甚至无法下载,因此我们需要修改pip的源到国内的一些镜像地址.
cd ~
mkdir .pip
vim pip.conf
添加以下两行
[global]
index-url = http://pypi.v2ex.com/simple
把index-url的值设置为自己实际源的地址.
至此pip源修改成功,以后使用pip安装模块时都会从这个源去下载安装.
```

or

```bash
➜  tar.gz ll
-rw-r--r-- 1 hp staff   1138794 Mar 11 16:09 pip-8.1.0.tar.gz
-rw-r--r-- 1 hp staff    630700 Mar 11 13:38 setuptools-18.1.tar.gz
tar -xvf setuptools-18.1.tar.gz
tar -xvf pip-8.1.0.tar.gz
cd setuptools-18.1
python setup.py build
python setup.py install
cd pip-9.0.1/
python setup.py build
python setup.py install
```

> 9.0.1 见 https://pypi.python.org/pypi/pip

**ipython**

> sudo pip install --upgrade ipython --ignore-installed six
> sudo pip install notebook

startup ipython notebook

```python
ipython notebook
```

```python
PYSPARK_DRIVER_PYTHON=ipython PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip=192.168.140.159" $SPARK_HOME/bin/pyspark
```

## 2. Python Tools for data analysis

Extension lib | introduction
------- | -------
Numpy | 提供数组支持，以及相应的高效处理函数
Scipy | 提供矩阵支持，以及矩阵相关的数值计算模块
Matplotlib | 数据可视化工具，作图库
Pandas | 数据分析和探索工具
StatsModels | 统计建模和计量经济学，包括描述统计，统计模型估计和推断
Scikit-Learn | 支持回归，分类，聚类 等强大的机器学习库
Keras | 深度学习库，用于建立神经网络以及 deep learning model
Gensim | 用来做 text topic model 的库
Pillow | 旧版的PIL, 图片处理相关
OpenCV | video 处理相关
GMPY2 | 高精度计算相关

***

### 2.1 Numpy

[Numpy](www.numpy.prg) 提供了数据功能, 后续 Scipy、Matplotlib、Pandas 等都依赖于它。    

```python
# -*- coding: utf-8 -*-

# sudo pip install numpy
import numpy as np
a = np.array([2, 0, 1, 5])

print(a)
print("hello world 3.0 !")
```

### 2.2 Scipy

> Numpy 提供了多维数据功能，但它只是数组，并不是矩阵。Scipy 提供了真正的矩阵，以及大量矩阵运算的对象和函数。
> Scipy 依赖于 Numpy

### 2.3 Matplotlib
 
> 著名的绘图库，主要用于二维绘图，当然也可以进行三维绘图。
> sudo pip install matplotlib 

### 2.4 Pandas

Pandas 是 Python 下最强大的数据分析 Tool，没有之一。Pandas 构建在 Numpy 之上。  

**Pandas Function**

1. 类SQL，CRUD
2. 数据处理函数
3. 时间序列分析功能
4. 灵活处理缺失数据

> sudo pip install pandas  
> sudo pip install xlrd  
> sudo pip install xlwt   
> 《利用python进行数据分析》讲解详细，针对 Pandas。  

Pandas 基本的数据结构是 : Series 和 DataFrame (它的每一列都是一个Series)。每个 Series 都会有一个对应的 Index，用来标记元。(Index类似于 SQL 主键)

```python
# -*- coding: utf-8 -*-
import pandas as pd

s = pd.Series([1, 2, 3], index=['a', 'b', 'c']) # 创建一个序列 s
d2 = pd.DataFrame(s)

d = pd.DataFrame([[1, 2, 3], [4, 5, 6]], columns=['a', 'b', 'c']) # 创建一个 table

d.head() # 默认预览前 5 行

d.describe() # 数据基本统计量

# 读取文件
pd.read_excel('data.xls') # 读取 Excel 文件, 创建 DataFrame.
# pd.read_csv('data.csv', encoding='utf-8') # 读取文本, 一般指定 encoding
```

### 2.5 StatsModels

> StatsModels 主要是对，数据的读取、处理、探索，更加注重数据的统计建模分析，有 R 语言味道。
> StatsModels 与 Pandas 结合, 成为 Python 下强大的数据挖掘组合。
> sudo pip install StatsModels

### 2.6 Scikit-Learn

> Scikit-Learn 强大的 ML 工具包。包括 数据预处理、分类、回归、聚类、预测 和 模型分析等。
> Scikit-Learn 依赖于 Numpy、Scipy、Matplotlib。

**install**

pip install scikit-learn 用 pip 安装这个包之后，在使用的时候会出现 ValueError: numpy.dtype has the wrong 等错误。

**solution fun**

sudo pip install cython
git clone https://github.com/scikit-learn/scikit-learn
sudo make
sudo python setup.py install

> 不安装 cython ，安装 scikit-learn 会报错。  
> 这种方式 安装 scikit-learn 过程中的一些错误或警告不需要管。安装完成测试使用正常
> pip list
> scikit-learn (0.18.dev0)
> scipy (0.13.0b1)

### 2.7 Keras

> 神经网络model

### 2.8 Gensim

> topic modelling for humans！NLP

