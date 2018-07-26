---
title: Structured Machine Learning Projects (week1) - ML Strategy 1
toc: true
date: 2018-07-24 19:00:21
categories: deeplearning
tags: deeplearning.ai
mathjax: true
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

这次我们要学习专项课程中第三门课 **Structured Machine Learning Projects**

学完这门课之后，你将会:

> - 理解如何诊断机器学习系统中的错误
> - 能够优先减小误差最有效的方向
> - 理解复杂ML设定，例如训练/测试集不匹配，比较并/或超过人的表现
> - 知道如何应用端到端学习、迁移学习以及多任务学习

很多团队浪费数月甚至数年来理解这门课所教授的准则，也就是说，这门两周的课可以为你节约数月的时间

<!-- more -->

## 1. Why ML Strategy?

<img src="/images/deeplearning/C3W1-1_1.png" width="700" />

> 如上图示，假如我们在构建一个喵咪分类器，数据集就是上面几个图，训练之后准确率达到90%。虽然看起来挺高的，但是这显然并不具一般性，因为数据集太少了。那么此时可以想到的ML策略有哪些呢？总结如上图中 **`Ideas`**.

## 2. Orthogonalization

> Orthogonalization [ɔ:θɒɡənəlaɪ'zeɪʃn] 正交化

<img src="/images/deeplearning/C3W1-2_1.png" width="600" />
 
> And when I train a neural network，I tend not to use early shopping.
> 
> 因为 Early Stropping，这个按钮能同时影响两件事情. 就像一个按钮同时影响电视机的宽度和高度. 如果你有更多的正交化(Orthogonalization)的手段，用这些手段调网络会简单不少.
When a supervised learning system is design, these are the 4 assumptions that needs to be true and orthogonal.

<img src="/images/deeplearning/C3W1-3_1.png" width="600" />

No. | strategy | solutions
:-------:  | :-------:  | :-------:
1. | Fit training set well in cost function | If it doesn’t fit well, the use of a bigger neural network or switching to a better optimization algorithm might help.
2. | Fit development set well on cost function | If it doesn’t fit well, regularization or using bigger training set might help.
3. | Fit test set well on cost function | If it doesn’t fit well, the use of a bigger development set might help
4. | Performs well in real world | If it doesn’t perform well, the development test set is not set correctly or the cost function is not evaluating the right thing

## 3. Single number evaluation metric

<img src="/images/deeplearning/C3W1-4_1.png" width="700" />

> 大致的思想就是首先按照单一数字评估指标对模型进行评价和优化。以精确率和召回率为例，这二者一般来说是一个不可兼得的指标，所以为了更好的衡量模型的好坏，引入F1算法来综合精确率和召回率对模型进行评估.

<!--<img src="/images/deeplearning/C3W1-6_1.png" width="700" />
-->

<img src="/images/deeplearning/C3W1-7_1.png" width="700" />

[Ref: sklearn中 F1-micro 与 F1-macro区别和计算原理][F1]

[F1]: https://www.cnblogs.com/techengin/p/8962024.html

## 4. Satisficing and optimizing metrics

It's not always easy into a single real number evaluation metric

<img src="/images/deeplearning/C3W1-9_1.png" width="750" />

> So more generally, if you have N metrics that you care about, it's sometimes reasonable to pick one of them to be optimizing. So you want to do as well as is possible on that one. And then N minus 1 to be satisficing.
> 
> 满足和优化指标是很重要的

## 5. Train/dev/test distributions

<img src="/images/deeplearning/C3W1-10_1.png" width="700" />

**Training, development and test distributions**

> Setting up the training, development and test sets have a huge impact on productivity. It is important to
choose the development and test sets from the same distribution and it must be taken randomly from all
the data.

**Guideline**

> Choose a development set and test set to reflect data you expect to get in the future and consider important to do well.

**所以为了实现服从同一分布，我们可以这样做:**

> 首先将所有国家和地区的数据打散，混合, 按照一定的比例将上面混合打散后的数据划分为 **development and test sets**

## 6. Size of dev and test sets

<img src="/images/deeplearning/C3W1-11_1.png" width="750" />

## 7. When to change dev/test sets and metrics

**举个🌰:** 假设现在一个公司在做一个喵咪图片推送服务（即给用户推送喵咪的照片），部署的有两个算法:

> - 算法A: 喵咪图片识别误差是3%，但是可能会一不小心就给用户发了一些少儿不宜的图片
> - 算法B：误差是5%，但是不会给用户推送不健康的图片
>
> 所以对于技术人员来说可能希望准确性高一些的算法A，而用户可能会非常在意你给他推送了某些不想看的东西, 也许更喜欢算法B。所以总的来说就是根据实际需要来 改变开发/测试集合指标.

<img src="/images/deeplearning/C3W1-12_1.png" width="750" />

## 8. Why human-level performance?

<img src="/images/deeplearning/C3W1-14_1.png" width="750" />

> 如图示：
>
> - 蓝色虚线：表示人类识别的准确率
> - 紫色曲线：表示机器学习不断训练过程中准确率的变化
> - 绿色虚线：表示最高的准确率，即100%
>
> 其中紫色曲线在末尾收敛后与绿色虚线之间的差距称为贝叶斯优化误差(Bayse Optima Error)

<!--<img src="/images/deeplearning/C3W1-13_1.png" width="750" />-->

因此在实际操作过程中，我们可以以人类准确率为指标来评判我们训练的模型好坏程度

<img src="/images/deeplearning/C3W1-15_1.png" width="750" />

## 9. Avoidable bias

<img src="/images/deeplearning/C3W1-16_1.png" width="750" />

> Humans error 与 Training Error 之间的差距我们成为 Avoidable bias
> Training Error 与 Dev Error 之间的差距我们成为 Variance

## 10. Understanding human-level performance

<img src="/images/deeplearning/C3W1-18_1.png" width="750" />

> **解释说明 Example 1**:
> 
> 假如一个医院需要对一个医学影像进行分类识别，普通人，普通医生，有经验的医生和一群有经验的医生识别错误率分别为3%，1%，0.7%，0.5%。上一节中提到过Human Error，那此时的该如何确定Human Error呢？你可能会说取平均值，只能说Too Naive！当然是取最好的结果啦，也就是由一群经验丰富的医生组成的团体得到的结果作为Human Error。另外贝叶斯误差一定小于0.5%。

<img src="/images/deeplearning/C3W1-19_1.png" width="750" />

> **解释说明 Example 2**:
>
> 还是以医学影像分类识别为例，假如现在分成了三种情况：

> Scenario A
> 让三类人群来划分后得到的误差分别为1%，0.7%，0.5%，而训练集和测试集误差分别为5%，6%。很显然此时的Avoidable Bias=4%~4.5%，Variance=1%，bias明显大于variance，所以此时应该将重心放到减小bias上去。

> Scenario Bayse
> 同理此情况下的Avoidable Bias=0%~0.5%，Variance=4%，所以需要减小variance。

> Scenario C
> Avoidable Bias=0.2%，Variance=0.1%，二者相差无几，但是此时训练的模型准确率还是不及人类，所以没办法咱们还得继续优化，都说枪打出头鸟，所以继续优化bias~

## 11. Surpassing human-level performance

<img src="/images/deeplearning/C3W1-20_1.png" width="750" />

> **Scenario A**
> 
> - Avoidable Bias=0.1%，Variance=0.2%，所以此时应该将重心放到减小Variance上去

> **Scenario B**
> 
> - Avoidable Bias=-0.2%，Variance=0.1%.乍一看可能会有点不知所措，而且训练集准确度也超过了人的最好成绩，不知道应该选择优化哪一项了，或者说这是不是就说明可以不用再优化了呢？
> 
> （还是可以继续优化的。不可否认在图像识别方面人类的确其优于机器的方面，但是在其他方面，如在线广告推送，贷款申请评测等方面机器人要远远比人类优秀，所以如果是在上面课件中提到的一些领域，即使机器准确度超过了人类，也还有很大的优化空间。具体怎么优化。。。以后再探索。。。）

## 12. Improving your model performance

<img src="/images/deeplearning/C3W1-21_1.png" width="750" />

## 13. Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][4]
- [DeepLearning.ai学习笔记（三）结构化机器学习项目--week1 机器学习策略][5]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/p/7470989.html
[5]: http://www.cnblogs.com/marsggbo/p/7681619.html

