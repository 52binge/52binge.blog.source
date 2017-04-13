---
title: Python数据分析与挖掘实战 P3 data exploring
toc: true
date: 2016-08-09 13:43:21
categories: machine-learning
tags: [machine-learning, python]
description: python data mining - data exploring for chap 3，Reading notes
mathjax: true
list_number: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$'], ['\[','\]'] ],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

**data mining steps**

1. 挖掘目标
2. 数据取样
3. `数据探索`
4. 数据预处理
5. 挖掘建模
6. 模型评价

## 1. Data Quality analysis

### 1.1 脏数据

- 缺失值
- 异常值
- 不一致值
- 重复数据及含有特殊符号 (如: #、*) 的数据。

**缺失值**

(1). 缺失值的影响

- data mining model 将丢失大量的有用信息
- data mining model 不确定性增加，model 蕴涵的规律更难把握
- 包含 NULL 值的数据会使 model 过程陷入混乱, 导致不可靠输出

(2). 缺失值的分析

- 处理可以选择忽略，或者补全等。

**异常值**

> 异常值 是指样本中的个别值, 其数值明显偏离其余的观测值。也称为 离群点。

- 简单统计量分析（0~199 age）
- 3 $\sigma$ 原则 ( $p(|x-u| > 3\sigma|) <= 0.003$)
- 箱型图分析

> 3 $\sigma$ 原则 (服从正态分布下，异常值定义为测定值与均值超过3倍标准差的值 $p(|x-u| > 3\sigma|) <= 0.003$)

## 2. Data Feature analysis

### 2.1 定量数据的分布分析

1. 极差
2. 组距、组数
3. 分点、频率

### 2.2 对比分析

1. 绝对数
2. 相对数

### 2.3 统计量分析

用统计指标对定量数据进行统计描述，常从集中趋势和离中趋势两个方面进行分析。

- 集中度量 : **均值** & **中位数**  
- 离中度量 : **标准差 (方差)、四分位间距**  

**(1). 集中趋势度量**  

1. 均值
2. 中位数
3. 众数

**(2). 离中趋势度量**  

1. 极差
2. 标准差
3. 变异系数
4. 四分位数间距

> 变异系数度量 标准差 相对于 均值的离中趋势

statistics_analyze.py

```python
#-*- coding: utf-8 -*-
#餐饮销量数据统计量分析
from __future__ import print_function
import pandas as pd

catering_sale = '../data/catering_sale.xls' #餐饮数据
data = pd.read_excel(catering_sale, index_col = u'日期') #读取数据，指定“日期”列为索引列
data = data[(data[u'销量'] > 400)&(data[u'销量'] < 5000)] #过滤异常数据
statistics = data.describe() #保存基本统计量

statistics.loc['range'] = statistics.loc['max']-statistics.loc['min'] #极差
statistics.loc['var'] = statistics.loc['std']/statistics.loc['mean'] #变异系数
statistics.loc['dis'] = statistics.loc['75%']-statistics.loc['25%'] #四分位数间距

print(statistics)
```

Output

```
           销量
count   195.000000
mean   2744.595385
std     424.739407
min     865.000000
25%    2460.600000
50%    2655.900000
75%    3023.200000
max    4065.200000
range  3200.200000
var       0.154755
dis     562.600000

```

### 2.4 周期性分析

### 2.5 贡献度分析

> 贡献度分析 称 帕累托分析。原理是 帕累托 法则。又称 20/80 定律。同样的投入放在不同的地方会产生不同的效益。对于 公司 来说，一般情况都是 80% 的利润常常来自于 20% 最畅销的产品。

### 2.6 相关性分析

> 分析连续变量之间线性相关程序的强弱，并用适当的统计指标表示出来的过程称为相关分析。

1. 直接绘制散点图
2. 绘制散点图矩阵
3. 计算相关系数

**计算机相关系数**

(1). Pearson 相关系数

一般用于分析两个连续性变量之间的关系

(2). Spearman 轶相关系数

不服从正态分布的变量, 分类或等级变量之间的相关性可采用 Spearman 轶相关系数。

(3). 判定系数

判定系数 是相关系数的平方，用 $r^2$ 表示; 用来衡量回归方式对 $y$ 的解释程度。

```bash
           百合酱蒸凤爪    翡翠蒸香茜饺   金银蒜汁蒸排骨     乐膳真味鸡     蜜汁焗餐包      生炒菜心    铁板酸菜豆腐
百合酱蒸凤爪   1.000000  0.009206  0.016799  0.455638  0.098085  0.308496  0.204898   
翡翠蒸香茜饺   0.009206  1.000000  0.304434 -0.012279  0.058745 -0.180446 -0.026908   
金银蒜汁蒸排骨  0.016799  0.304434  1.000000  0.035135  0.096218 -0.184290  0.187272   
乐膳真味鸡    0.455638 -0.012279  0.035135  1.000000  0.016006  0.325462  0.297692   
蜜汁焗餐包    0.098085  0.058745  0.096218  0.016006  1.000000  0.308454  0.502025   
生炒菜心     0.308496 -0.180446 -0.184290  0.325462  0.308454  1.000000  0.369787   
铁板酸菜豆腐   0.204898 -0.026908  0.187272  0.297692  0.502025  0.369787  1.000000   
```

## 3. Python data discovery function

### 3.1 feature functions

name | function | lib
------- | ------- | -------
D.sum() | data sample 总和 (按列计算) | pandas
mean() | 算术平均数 | pandas
var() | 方差 | pandas
std() | 标准差 | pandas
corr() | Spearman (Pearson)相关系数矩阵 | pandas
cov() | 协方差矩阵 | pandas
skew() | 样本值的偏度(三阶矩) | pandas
kurt() | 样本值的峰度(四阶矩) | pandas
describe() | 给出样本的基本描述(如：mean, var 等基本统计量) | pandas

name | function | lib
------- | ------- | -------
cumsum() | 依次给出前 1、2、3...n 个数的 sum | pandas
cumprod() | 依次给出前 1、2、3...n 个数的 积 | pandas
cummax() | 依次给出前 1、2、3...n 个数的 max | pandas
cummin() | 依次给出前 1、2、3...n 个数的 min | pandas
rolling_sum() | 计算data sample的总和(按列计算) | pandas
rolling_mean() | 计算data sample的算术平均数 | pandas
rolling_var() | 计算data sample的方差 | pandas
... | ... |pandas

### 3.2 make-picture functions

name | function | lib
------- | ------- | -------
plot() | 绘制线性二维图、折线图 | Matplotlib / Pandas
pie() | 绘制线饼型图 | Matplotlib / Pandas
hist() | 绘制线性二维条形直方图，可显示数据的分配情形 | Matplotlib / Pandas
boxplot() | 绘制样本数据的箱型图 | Pandas
plot(logy=true) | 绘制 $y$ 轴的对数图形 | Pandas
plot(yerr=error) | 绘制误差条形图 | Pandas

```python
import matplotlib.pyplot as plt #导入图像库
plt.rcParams['font.sans-serif'] = ['SimHei'] #用来正常显示中文标签
plt.rcParams['axes.unicode_minus'] = False #用来正常显示负号
plt.figure(figsize = (7, 5)) # 创建图像区域，指定比例
...
plt.show()
```

## 4. Summary

- Data Quality analysis
- Data Feature analysis
- Data discovery function

> Data Feature analysis 在数据挖掘建模之前，通过 `频率分布分析`、对比分析、周期性分析、`相关性分析` 等方法，对 data sample 的 feature 规律 进行分析，了解数据的规律和趋势，为数据挖掘提供支持。