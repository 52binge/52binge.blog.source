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

谈谈机器学习中，常用的性能评估指标：

<img class="img-fancy" src="/images/ml/metric/metric-2.jpg" width="600" border="0" alt=""/>

## 1. Accuracy

正反比例严重失衡，则没意义，存在 accuracy paradox 现象

<img src="/images/ml/metric/metric-3.jpg" width="800" alt=""/>

> accuracy 准确率 = (TP+TN)/(TP+TN+FP+FN), **准确率可以判断总的正确率**

## 2. Precision

precision 查准率 (80% = 你一共预测了100个正例，80个是对的正例)

<img src="/images/ml/metric/metric-4.jpg" width="800" alt=""/>

> Precision = TP/(TP+FP)

## 3. Recall

recall (样本中的正例有多少被预测正确 TPR = TP/(TP+FN))

<img src="/images/ml/metric/metric-5.jpg" width="800" alt=""/>

## 4. F1-score

F1-score （precision 和 recall 的 metric）

> 2\*precision\*recall / (precision + recall)

## 5. P-R curve

P-R（precision-recall）PRC

> 依靠 LR 举例:
>
> 这条曲线是根据什么变化的？为什么是这个形状的曲线？
>
> 这个阈值是我们随便定义的，我们并不知道这个阈值是否符合我们的要求
>
> 遍历 0 到 1 之间所有的阈值, 得到了这条曲线

## 6. ROC

**ROC curve** （TPR 纵轴，FPR 横轴，TP（真正率）和 FP（假正率），设一个阈值）

> ROC（Receiver Operating Characteristic）曲线。 ROC 曲线 是基于混淆矩阵得出的。 
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

## 7. AUC  

AUC = 0.5，跟随机猜测一样， ROC 纵轴 TPR 越大， 横轴 FPR 越小 模型越好

> 0.5 - 0.7：效果较低，但用于预测股票已经很不错了
> 0.7 - 0.85：效果一般
> 0.85 - 0.95：效果很好
>
> real world data 经常会面临 class imbalance 问题，即正负样本比例失衡。
> 
> 根据计算公式可以推知，在 testing set 出现 `imbalance 时 ROC曲线 能保持不变`，而 PR 则会出现大变化。

## 8. multi-class classification 

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

## 9. Bias-Variance Tradeoff

<img src="https://charlesliuyx.github.io/2017/09/12/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0%E5%88%86%E7%B1%BB%E5%99%A8%E6%80%A7%E8%83%BD%E6%8C%87%E6%A0%87%E8%AF%A6%E8%A7%A3/BV-Tradeoff.png" width="450" />

> - [Bias-Variance Tradeoff](https://charlesliuyx.github.io)

## Reference 

- [精确率、召回率、F1 值、ROC、AUC 各自的优缺点是什么？](https://www.zhihu.com/question/30643044)
- [机器学习之类别不平衡问题 (2) —— ROC和PR曲线](https://zhuanlan.zhihu.com/p/34655990)
- [sklearn中 F1-micro 与 F1-macro 区别和计算原理](https://www.cnblogs.com/techengin/p/8962024.html)
- [Bias-Variance Tradeoff](https://charlesliuyx.github.io)
