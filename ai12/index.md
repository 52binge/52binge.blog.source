
- F1-micro 
- F1-macro

## f1-value

$$
2\*(P\*R) / (P+R)
$$

> 准确率(P): TP / (TP+FP) 所有预测为正类的数据中，预测正确的比例
>
> 召回率(R): TP(TP + FN) 所有真实为正类的数据中，预测正确的比例
>
> TPR = TP / (TP+FN); 所有真实为正类的数据中，预测正确的比例； （=召回率）
>
> FPR = FP / (FP + TN); 所有真实为负类的数据中，被正确预测的比例
 
对于数据测试结果有下面4种情况：

> 真阳性（TP）: 预测为正， 实际也为正
> 假阳性（FP）: 预测为正， 实际为负
> 假阴性（FN）: 预测为负，实际为正
> 真阴性（TN）: 预测为负， 实际也为负

## micro-f1 与 macro-f1

> 'micro': 通过先计算总体的 TP，FN 和 FP 的数量，再计算 F1
>
> 'macro': 分布计算每个类别的 F1，然后做平均（各类别F1 的权重相同）

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

## KS

如何评判该模型对客户的分类准确性呢？

我们都期望模型能达到这样一个目的：误杀率最低，漏网率最低，同时通过率最高，即误杀的好客户的数量最少并且正确识别出全部的坏客户，但是这事儿好像不太好办啊，只能奢求尽可能的接近这两个目标吧。

### K-S曲线与K-S值

如上图中第一个折线图。
用10等份（即根据模型计算的概率排序后的客户累积数）做为横坐标，用真阳性率和假阳性率的累计值分别做为纵坐标就得到两个曲线，即两条洛伦兹曲线，用每等份下的真阳性率减去假阳性率后得到的值与横坐标即10等份组成的曲线就是KS曲线。ks值就是ks曲线中两条曲线之间的最大间隔距离。
K-S值仅仅代表模型的分割样本的能力，不能表示分割的是否准确，即便好坏客户完全分错，K-S值依然可以很高。

[玩转逻辑回归之金融评分卡](https://zhuanlan.zhihu.com/p/36539125)

## WOE

WOE编码相当于把分箱后的特征从非线性可分映射到近似线性可分的空间内。

> odds 即赔率，是一个0到正无穷的实数值，相比于 [0, 1] 的概率值具有更大的范围. 比如： 0.01


**总结一下WOE编码的优势**：

1. 可提升模型的预测效果
2. 将自变量规范到同一尺度上
3. WOE能反映自变量取值的贡献情况
4. 有利于对变量的每个分箱进行评分
5. 转化为连续变量之后，便于分析变量与变量之间的相关性
6. 与独热向量编码相比，可以保证变量的完整性，同时避免稀疏矩阵和维度灾难

信息增益、基尼(gini)系数

## 挑选入模变量

挑选入模变量需要考虑很多因素，比如：

1. 变量的预测能力
2. 变量之间的线性相关性
3. 变量的简单性（容易生成和使用）
4. 变量的强壮性（不容易被绕过）
5. 变量在业务上的可解释性（被挑战时可以解释的通）等等。

其中最主要和最直接的衡量标准是**变量的预测能力**和**变量的线性相关性**。

本文主要探讨基于变量预测能力的单变量筛选，变量两两相关性分析，变量的多重共线性分析。


## Reference article

- [模型评估准确率、召回率、ROC曲线、AUC总结][1]
- [ROC、AUC、K-S][2]
- [关于模型检验的ROC值和KS值的异同_ROC曲线和KS值][3]
- [（原创）sklearn中 F1-micro 与 F1-macro区别和计算原理][4]
- [分类问题的几个评价指标（Precision、Recall、F1-Score、Micro-F1、Macro-F1）][5]
- [ks（洛伦兹曲线）指标理解][6]


[1]: https://blog.csdn.net/qq_36330643/article/details/79522537
[2]: https://zhuanlan.zhihu.com/p/25993786
[3]: http://cda.pinggu.org/view/21012.html
[4]: https://www.cnblogs.com/techengin/p/8962024.html
[5]: https://blog.csdn.net/sinat_28576553/article/details/80258619 
[6]: https://blog.csdn.net/sinat_30316741/article/details/80018932