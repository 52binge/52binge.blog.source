---
title: Ensemble Learning (part3)
toc: true
date: 2018-06-13 16:08:21
categories: machine-learning
tags: machine-learning
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

提升（boosting）方法是一类应用广泛且非常有效的统计学习方法。

- Boosting 概念

<!-- more -->

Adaboost 在处理二类分类问题时，随着弱分类器的个数增加，训练误差与测试误差的曲线图。

## Reference article

- [机器学习-一文理解GBDT的原理-20171001][1]
- [GBDT：梯度提升决策树][3]
- [模型融合：bagging、Boosting、Blending、Stacking][4]
- [Huber Loss function][2]

[1]: https://zhuanlan.zhihu.com/p/29765582
[2]: https://blog.csdn.net/lanchunhui/article/details/50427055
[3]: https://www.jianshu.com/p/005a4e6ac775
[4]: https://blog.csdn.net/u012969412/article/details/76636336

[img1]: /images/ml/ml_boosting_adaboost_binary_classification.png
[img8]: /images/ml/ml-ensumble-8-adaboost.jpeg


