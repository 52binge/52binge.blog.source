---
title: Evaluation Metric
toc: true
date: 2019-06-03 10:01:21
categories: machine-learning
tags: Metric
---


<img class="img-fancy" src="/images/ml/metric/metric-1.gif" width="580" border="0" alt="机器学习性能评估指标"/>

<!--<a href="/2019/06/02/ml/Random_Forest_and_GBDT/" target="_self" style="display:block; margin:0 auto; background:url('/images/ml/ensumble/ensumble-1.png') no-repeat 0 0 / contain; height:304px; width:550px;"></a>
-->

<!-- more -->

--------

选择与问题相匹配的评估方法，才能快速发现在 **模型选择和训练过程** 中可能出现的问题，迭代地对模型进行优化. 针对 **`分类、排序、回归、序列预测`** 等不同类型的机器学习问题，评估指标的选择也有所不同:

本文将谈谈机器学习中，常用的性能评估指标：

<img class="img-fancy" src="/images/ml/metric/metric-2.jpg" width="600" border="0" alt=""/>

关于模型评估的基础概念:

>【误差(error)】：学习器的预测输出与样本的真实输出之间的差异。根据产生误差的数据集，可分为：
>
> - **Training error**：又称为经验误差(empirical error)，学习器在训练集上的误差。
> - **Test error**：学习器在测试集上的误差。
> - **Generalization error**：学习器在未知新样本上的误差。
>
> 需要注意的是，上述所说的“误差”均指误差期望，排除数据集大小的影响。
> 
> 应该从训练样本中尽可能学出适用于所有 **潜在样本的“普遍规律”**，这样才能在遇到新样本时做出正确的判别。因为，泛化误差无法测量，因此，通常我们会将 **Test error 近似等同于 Generalization error**。

## 1. Classification Metric

### 1.1 Accuracy

准确率：指的是分类正确的样本数量占样本总数的比例，定义如下：

$$
Accuracy = \frac{n\_{correct}}{n\_{total}}, Error = \frac{n\_{error}}{n\_{total}}
$$

正反比例严重失衡，则没意义，存在 accuracy paradox 现象.

<img src="/images/ml/metric/metric-3.jpg" width="800" alt=""/>

> accuracy 准确率 = (TP+TN)/(TP+TN+FP+FN), **准确率可以判断总的正确率**

### 1.2 Precision

precision 查准率 (80% = 你一共预测了100个正例，80个是对的正例)

<img src="/images/ml/metric/metric-4.jpg" width="800" alt=""/>

> Precision = TP/(TP+FP)

### 1.3 Recall

recall (样本中的正例有多少被预测正确 TPR = TP/(TP+FN))

<img src="/images/ml/metric/metric-5.jpg" width="800" alt=""/>

### 1.4 F1-score

F1-score （precision 和 recall 的 metric）

> 2\*precision\*recall / (precision + recall)

**multi-class classification**

如果非要用一个综合考量的 metric 的话，

> 1. macro-average（宏平均）- 分布计算每个类别的F1，然后做平均（各类别F1的权重相同）
> 2. micro-average（微平均）- 通过先计算总体的TP，FN和FP的数量，再计算F1
>  
> macro-average（宏平均） 会比 micro-average（微平均）好一些哦，因为 macro 会受 minority class 影响更大，也就是说更能体现在 small class 上的 performance.
> 
> [sklearn中 F1-micro 与 F1-macro 区别和计算原理](https://www.cnblogs.com/techengin/p/8962024.html)

precision & recall

> precision 是相对你自己的模型预测而言
> recall 是相对真实的答案而言

### 1.5 P-R curve

P-R（precision-recall）PRC

> 依靠 LR 举例:
>
> 这条曲线是根据什么变化的？为什么是这个形状的曲线？
>
> 这个阈值是我们随便定义的，我们并不知道这个阈值是否符合我们的要求
>
> 遍历 0 到 1 之间所有的阈值, 得到了这条曲线

### 1.6 ROC

**ROC curve** （TPR 纵轴，FPR 横轴，TP（真正率）和 FP（假正率），设一个阈值）

> ROC（Receiver Operating Characteristic Curve）曲线。 ROC 曲线 是基于混淆矩阵得出的。 
>
> TPR = recall = 灵敏度 = P（X=1 | Y=1）
> FPR = 特异度 = P（X=0 | Y=0）
 
![](https://pic3.zhimg.com/80/v2-947f270aaae4164a14c9093859cf0cce_hd.jpg)

**ROC曲线的阈值问题:**

> 与前面的P-R曲线类似，ROC曲线也是通过遍历所有阈值来绘制整条曲线的。 

![](https://pic4.zhimg.com/50/v2-296b158ebb205a2b90d05f5d2074bbe9_hd.gif)

**ROC曲线无视样本不平衡**

> - [精确率、召回率、F1 值、ROC、AUC 各自的优缺点是什么？](https://www.zhihu.com/question/30643044)
> - [机器学习之类别不平衡问题 (2) —— ROC和PR曲线](https://zhuanlan.zhihu.com/p/34655990)

### 1.7 AUC  

AUC = 0.5，跟随机猜测一样， ROC 纵轴 TPR 越大， 横轴 FPR 越小 模型越好

> 0.5 - 0.7：效果较低，但用于预测股票已经很不错了
> 0.7 - 0.85：效果一般
> 0.85 - 0.95：效果很好
>
> real world data 经常会面临 class imbalance 问题，即正负样本比例失衡。
> 
> 根据计算公式可以推知，在 testing set 出现 **`imbalance 时 ROC曲线 能保持不变`**，而 PR 则会出现大变化。


## 2 Regression Metric

### 2.1 MSE

MSE （Mean Squared Error）称为均方误差，，又被称为 L2范数损失:

$$
MSE=\frac{1}{n}\sum_{i=1}^n{(f\_i - y\_i)^2}
$$

### 2.2 RMSE

均方根误差(Root Mean Squared Error, RMSE)，定义如下：

$$
RMSE=\sqrt{MSE}
$$

### 2.3 MAE

$$
MAE = \frac{1}{n}\sum\_{i=1}^n|f\_i-y\_i|
$$

> 缺点：因为它使用的是平均误差，而平均误差对异常点较敏感，如果回归器对某个点的回归值很不合理，那么它的误差则比较大，从而会对RMSE的值有较大影响，即平均值是非鲁棒的。

### 2.4 MAPE

全称是 Mean Absolute Percentage Error（WikiPedia）, 也叫 mean absolute percentage deviation (MAPD)，在统计领域是一个预测准确性的衡量指标。 

$$
MAPE=\frac{100}{n}\sum\_{t=1}^{n}|\frac{y\_i-f\_i}{y\_i}|
$$

## 3. 余弦距离

## 4. A/B 测试的陷阱

## 5. 模型评估方法

## 6. 超参数调优

## 7. 过拟合/欠拟合

## 8. 其他评价指标

- 计算速度：模型训练和预测需要的时间；
- 鲁棒性：处理缺失值和异常值的能力；
- 可拓展性：处理大数据集的能力；
- 可解释性：模型预测标准的可理解性，比如决策树产生的规则就很容易理解，而神经网络被称为黑盒子的原因就是它的大量参数并不好理解。


## Reference 

- [精确率、召回率、F1 值、ROC、AUC 各自的优缺点是什么？](https://www.zhihu.com/question/30643044)
- [机器学习之类别不平衡问题 (2) —— ROC和PR曲线](https://zhuanlan.zhihu.com/p/34655990)
- [sklearn中 F1-micro 与 F1-macro 区别和计算原理](https://www.cnblogs.com/techengin/p/8962024.html)
- [Bias-Variance Tradeoff](https://charlesliuyx.github.io)
- [程序员大本营-百面](http://www.pianshen.com/article/9039255388/)
- [CSDN 模型评估](https://blog.csdn.net/weixin_43378396/article/details/90707493)
- [简单聊聊模型的性能评估标准](https://blog.csdn.net/lc013/article/details/88583580)
