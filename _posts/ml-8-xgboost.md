---
title: Boosting - Xgboost (not finish)
toc: true
date: 2018-07-03 17:43:21
categories: machine-learning
tags: [LR]
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

Github上和机器学习工具包（如sklearn）中有很多优秀的开源boosting实现。在这里重点介绍[@陈天奇怪][tqchen]同学的 [Xgboost][xgboost].

Kaggle上的许多数据挖掘竞赛，Boosting 类方法都帮助参赛者取得了好成绩. 其中很多优秀战果都是用的 [Xgboost][xgboost]神器

<!-- more -->

Xgboost 提供了Graident Boosting算法的框架，给出了GBDT，GBRT，GBM具体实现。提供了多语言接口（C++, Python, Java, R等），供大家方便使用。

最新版本的xgboost是基于分布式通信协议rabit开发的，可部署在分布式资源调度系统上（如yarn，s3等）。我们完全可以利用最新版的xgboost在分布式环境下解决分类、预估等场景问题。

> XGBoost是DMLC（即分布式机器学习社区）下面的一个子项目，由@陈天奇怪，@李沐等机器学习大神发起。
> Rabit是一个为分布式机器学习提供Allreduce和Broadcast编程范式和容错功能的开源库（也是@陈天奇同学的又一神器）。它主要是解决MPI系统机器之间无容错功能的问题，并且主要针对Allreduce和Broadcast接口提供可容错功能。


### 1. Overfitting 过拟合

XGBoost里可以使用两种方式防止 Overfitting

直接控制模型复杂度

- **max_depth**,基学习器的深度，增加该值会使基学习器变得更加复杂，荣易过拟合，设为0表示不设限制，对于`depth-wise`的基学习器学习方法需要控制深度
- **min_child_weight**，子节点所需的样本权重和(hessian)的最小阈值，若是基学习器切分后得到的叶节点中样本权重和低于该阈值则不会进一步切分，在线性模型中该值就对应每个节点的最小样本数，该值越大模型的学习约保守，同样用于防止模型过拟合
- **gamma**，叶节点进一步切分的最小损失下降的阈值(超过该值才进一步切分)，越大则模型学习越保守，用来控制基学习器的复杂度(有点LightGBM里的leaf-wise切分的意味)

给模型训练增加随机性使其对噪声数据更加鲁棒

- 行采样：subsample
- 列采样：colsample_bytree
- 步长：eta即shrinkage

### 2. 数据类别分布不均

### 3. 调参

### 4. 一般参数

### 5. 基学习器参数

### 6. 任务参数

### 7. 命令行参数

## Reference article

- [逗比算法工程师][9]
- [算法杂货铺][10]
- [52caml][11]
- 《机器学习导论》
- 《统计学习方法》
- [懒死骆驼][12]

[tqchen]: https://weibo.com/u/2397265244?is_all=1
[xgboost]: https://github.com/dmlc/xgboost.git


[c1]: http://blog.csdn.net/blueloveyyt/article/details/45013403
[c2]: http://blog.csdn.net/ljp812184246/article/details/47402639

[1]: /images/model-dt-01.jpg
[2]: /images/model-dt-02.png
[3]: /2016/08/18/ml-entropy-base/
[4]: /2016/08/24/ml-CART/

[5]: https://en.wikipedia.org/wiki/Heuristic_(computer_science)
[6]: https://en.wikipedia.org/wiki/Greedy_algorithm
[7]: https://en.wikipedia.org/wiki/ID3_algorithm
[8]: https://en.wikipedia.org/wiki/C4.5_algorithm

[9]: http://www.cnblogs.com/fengfenggirl/p/classsify_decision_tree.html
[10]: http://www.52caml.com/
[11]: http://www.cnblogs.com/leoo2sk/archive/2010/09/19/decision-tree.html
[12]: http://izhaoyi.top/2017/06/19/Decision-Tree
[13]: https://www.zybuluo.com/mdeditor
