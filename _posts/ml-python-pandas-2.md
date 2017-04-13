---
title: Python pandas.DataFrame 类型数据操作函数 (not finish)
toc: true
date: 2017-02-15 16:43:21
categories: machine-learning
tags: [python]
description: pandas.DataFrame       
mathjax: true
---

Extension lib | introduction
------- | -------
Numpy | 提供数组支持，以及相应的高效处理函数
Scipy | 提供矩阵支持，以及矩阵相关的数值计算模块
Matplotlib | 数据可视化工具，作图库
Pandas | 数据分析和探索工具
Scikit-Learn | 支持回归，分类，聚类 等强大的机器学习库

> Python数据分析工具pandas中DataFrame和Series作为主要的数据结构. 本文主要是介绍如何对DataFrame数据进行操作并结合一个实例测试操作函数。

## 1. 查看DataFrame数据及属性

```python
df_obj = DataFrame() #创建DataFrame对象
df_obj.dtypes #查看各行的数据格式
df_obj['列名'].astype(int)#转换某列的数据类型
df_obj.head() #查看前几行的数据,默认前5行
df_obj.tail() #查看后几行的数据,默认后5行
df_obj.index #查看索引
df_obj.columns #查看列名
df_obj.values #查看数据值
df_obj.describe() #描述性统计
df_obj.T #转置
df_obj.sort_values(by=['',''])#同上
```

## 2. DataFrame选择数据

```python
df_obj.ix[1:3] #获取1-3行的数据,该操作叫切片操作,获取行数据
df_obj.ix[columns_index] #获取列的数据
df_obj.ix[1:3，[1,3]]#获取1列3列的1~3行数据
df_obj[columns].drop_duplicates() #剔除重复行数据
```

## 3. DataFrame重置数据

```python
df_obj.ix[1:3，[1,3]]=1 #所选位置数据替换为1
```

## 4. DataFrame筛选数据

```python
alist = ['023-18996609823']
df_obj['用户号码'].isin(alist) #将要过滤的数据放入字典中,使用isin对数据进行筛选,返回行索引以及每行筛选的结果,若匹配则返回ture
df_obj[df_obj['用户号码'].isin(alist)] #获取匹配结果为ture的行
```

## Refence article

[csdn-LY_ysys629][1]

[1]: http://blog.csdn.net/ly_ysys629/article/details/54428838