---
title: 模型评估 Precision、Recall、ROC、AUC 总结
toc: true
date: 2018-07-05 16:43:21
categories: machine-learning
tags: [ROC、AUC]
mathjax: true
list_number: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

实际上非常简单，Precision 是针对我们预测结果而言的，它表示的是预测为正的样本中有多少是对的。那么预测为正就有两种可能了，一种就是把正类预测为正类(**TP**)，另一种就是把负类预测为正类(**FP**).

<!-- more -->

$$
P = TP/(TP+FP)
$$

> Precision 准后 P

而召回率是针对我们原来的样本而言的，它表示的是样本中的正例有多少被预测正确了。那也有两种可能，一种是把原来的正类预测成正类(TP)，另一种就是把原来的正类预测为负类(FN).

$$
R = TP/(TP+FN) 
$$

> 召原正

<img src="/images/ml/model/Precision_Recall-1.png" width="300" />

## ROC 曲线

> In signal detection theory, a receiver operating characteristic (ROC), or simply ROC curve, is a graphical plot which illustrates the performance of a binary classifier system as its discrimination threshold is varied.
>
> 比如在逻辑回归里面，我们会设一个阈值，大于这个值的为正类，小于这个值为负类。如果我们减小这个阀值，那么更多的样本会被识别为正类。这会提高正类的识别率，但同时也会使得更多的负类被错误识别为正类。为了形象化这一变化，在此引入 ROC ，ROC 曲线可以用于评价一个分类器好坏。

ROC 关注两个指标，

> 直观上，TPR 代表能将正例分对的概率，FPR 代表将负例错分为正例的概率。在 ROC 空间中，每个点的横坐标是 FPR，纵坐标是 TPR，这也就描绘了分类器在 TP（`真正率`）和 FP（`假正率`）间的 trade-off2。

<img src="/images/ml/model/ROC.png" width="780" />

> ROC曲线，如果为 y=x 表示模型的预测能力与随机结果没有差别.

## AUC

AUC（Area Under Curve）被定义为ROC曲线下的面积，显然这个面积的数值不会大于 1.

由于ROC曲线一般都处于 $y=x$ 这条直线的上方，所以 AUC 的取值范围在 0.5~1 之间.
 
简单说：AUC值越大的分类器，正确率越高.

<img src="/images/ml/model/AUC.png" width="780" />

AUC值为ROC曲线所覆盖的区域面积，显然，AUC越大，分类器分类效果越好。
　　
> - AUC = 1，是完美分类器，采用这个预测模型时，不管设定什么阈值都能得出完美预测。绝大多数预测的场合，不存在完美分类器。
> - 0.5 < AUC < 1，优于随机猜测。这个分类器（模型）妥善设定阈值的话，能有预测价值。
> - AUC = 0.5，跟随机猜测一样（例：丢铜板），模型没有预测价值。
> - AUC < 0.5，比随机猜测还差；但只要总是反预测而行，就优于随机猜测

[img1]: /images/ml/model/Precision_Recall.png
[img2]: /images/ml/model/ROC.png
[img3]: /images/ml/model/AUC.png

## Reference article

- [模型评估准确率、召回率、ROC曲线、AUC总结][1]
- [ROC、AUC、K-S][2]
- [关于模型检验的ROC值和KS值的异同_ROC曲线和KS值][3]
- [（原创）sklearn中 F1-micro 与 F1-macro区别和计算原理][4]
- [分类问题的几个评价指标（Precision、Recall、F1-Score、Micro-F1、Macro-F1）][5]


[1]: https://blog.csdn.net/qq_36330643/article/details/79522537
[2]: https://zhuanlan.zhihu.com/p/25993786
[3]: http://cda.pinggu.org/view/21012.html
[4]: https://www.cnblogs.com/techengin/p/8962024.html
[5]: https://blog.csdn.net/sinat_28576553/article/details/80258619 