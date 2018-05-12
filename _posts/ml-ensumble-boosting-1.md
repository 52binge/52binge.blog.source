---
title: Ensemble Learning (part1)
toc: true
date: 2018-05-07 16:08:21
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

Ensemble learning（集成学习）：是目前机器学习的一大热门方向，所谓集成学习简单理解就是指采用多个分类器对数据集进行预测，从而提高整体分类器的泛化能力。

<!-- more -->

1. Bootstraping
2. Bagging、Boosting、Stacking

## Bootstraping

Bootstraping的名称来自成语 “pull up by your own bootstraps”，意思是依靠你自己的资源，它是一种有放回的抽样方法.

> 注:Bootstrap本义是指高靴子口后面的悬挂物、小环、带子，是穿靴子时用手向上拉的工具。“pull up by your own bootstraps”即“通过拉靴子让自己上 升”，意思是“不可能发生的事情”。后来意思发 生了转变，隐喻“不需要外界帮助，仅依靠自身力 量让自己变得更好”

bootstraping 的思想和步骤如下：

举个🌰：我要统计鱼塘里面的鱼的条数，怎么统计呢？假设鱼塘总共有鱼1000条，我是开了上帝视角的，但是你是不知道里面有多少。

步骤：

1. 承包鱼塘，不让别人捞鱼(规定总体分布不变)。
2. 自己捞鱼，捞100条，都打上标签(构造样本)
3. 把鱼放回鱼塘，休息一晚(使之混入整个鱼群，确保之后抽样随机)
4. 开始捞鱼，每次捞100条，数一下，自己昨天标记的鱼有多少条，占比多少(一次重采样取分布)。
5. 重复3，4步骤n次。建立分布。

> 假设一下，第一次重新捕鱼100条，发现里面有标记的鱼12条，记下为12%，放回去，再捕鱼100条，发现标记的为9条，记下9%，重复重复好多次之后，假设取置信区间95%，你会发现，每次捕鱼平均在10条左右有标记，所以，我们可以大致推测出鱼塘有1000条左右。其实是一个很简单的类似于一个比例问题。这也是因为提出者Efron给统计学顶级期刊投稿的时候被拒绝的理由--"太简单"。这也就解释了，为什么在小样本的时候，bootstrap效果较好，你这样想，如果我想统计大海里有多少鱼，你标记100000条也没用啊，因为实际数量太过庞大，你取的样本相比于太过渺小，最实际的就是，你下次再捕100000的时候，发现一条都没有标记，，，这TM就尴尬了。。

### Bootstrap 经典语录

> Bootstrap是现代统计学较为流行的一种统计方法，在小样本时效果很好。通过方差的估计可以构造置信区间等，其运用范围得到进一步延伸。
> 就是一个在自身样本重采样的方法来估计真实分布的问题

> 当我们不知道样本分布的时候，bootstrap方法最有用。

## Ensemble learning

了解 boosting 和 bagging 之前，先了解一下什么是 ensemble，一句话，三个臭皮匠顶个诸葛亮，一箭易折十箭难折，千里之堤溃于蚁穴 …😄😄😄 ，在分类的表现上就是，多个弱分类器组合变成强分类器。

## Reference article

- [总结：Bootstrap(自助法)，Bagging，Boosting(提升)][l5]
- [Bagging（Bootstrap aggregating）、随机森林（random forests）、AdaBoost][l6]
- [机器学习选讲：AdaBoost方法详解][l4]
- [52caml][l1]
- [统计学习方法][l2]
- [Scikit-Learn 中文文档 概率校准 - 监督学习][l3]

[l1]: http://www.52caml.com/head_first_ml/ml-chapter6-boosting-family/
[l2]: https://www.zhihu.com/question/49386395
[l3]: https://blog.csdn.net/u010859707/article/details/78677989
[l4]: http://bbs.quanttech.cn/article/524
[l5]: https://www.jianshu.com/p/708dff71df3a
[l6]: https://blog.csdn.net/xlinsist/article/details/51475345

[img1]: /images/ml/ml_boosting_adaboost_binary_classification.png
[img2]: /images/ml/ml-en-boosting-1.jpg


