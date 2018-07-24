---
title: Structured Machine Learning Projects (week1) - ML Strategy
toc: true
date: 2018-07-23 20:00:21
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

<img src="/images/deeplearning/C3W1-4_1.png" width="600" />

> 大致的思想就是首先按照单一数字评估指标对模型进行评价和优化。以精确率和召回率为例，这二者一般来说是一个不可兼得的指标，所以为了更好的衡量模型的好坏，引入F1算法来综合精确率和召回率对模型进行评估.

<img src="/images/deeplearning/C3W1-6_1.png" width="700" />

[Ref: sklearn中 F1-micro 与 F1-macro区别和计算原理][F1]

<img src="/images/deeplearning/C3W1-7_1.png" width="700" />


[F1]: https://www.cnblogs.com/techengin/p/8962024.html

## 4. Satisficing and optimizing metrics

It's not always easy into a single real number evaluation metric

<img src="/images/deeplearning/C3W1-9_1.png" width="750" />

> So more generally, if you have N metrics that you care about, it's sometimes reasonable to pick one of them to be optimizing. So you want to do as well as is possible on that one. And then N minus 1 to be satisficing.
> 
> 满足和优化指标是很重要的

## 5. Train/dev/test distributions

## 6. Size of dev and test sets

## 7. When to change dev/test sets and metrics

- 改善深层神经网络：超参数调试、正则化

## 8. Reference

- [网易云课堂 - deeplearning][1]
- [deeplearning.ai 专项课程二第一周][2]
- [Coursera - Deep Learning Specialization][3]
- [DeepLearning.ai学习笔记汇总][4]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/p/7470989.html

