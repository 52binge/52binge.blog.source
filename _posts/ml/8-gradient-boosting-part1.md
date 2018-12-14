---
title: 学习笔记(八) - Boosting
toc: true
date: 2018-06-29 17:43:21
categories: machine-learning
tags: [LR]
---

我们需要对多个模型进行融合以提高效果时，常常会用到 Bagging，Boosting，Stacking 等这几个框架算法.

Boosting 有很多种，比如 Adaptive Boosting、Gradient Boosting等，这里以AdaBoost，Gradient Boosting 为典型.

<!-- more -->

> 在分类问题中，Boosting通过改变训练样本的权重，学习多个分类器，并将这些分类器进行线性组合，提高分类的性能。

**三个臭皮匠，顶个诸葛亮**

> 🌰🌰🌰 :
> 
> 关于boosting，机器学习技法一课中开头举的一个小学生认苹果的例子比较传神，假设给定一堆水果，让一群小学生来识别其中的苹果，逐个的询问小学生根据什么样的规则来认为一个水果是苹果，比如学生A认为形状为圆的是苹果，第二个学生认为颜色为红的为苹果等等，逐一询问学生的过程中，每问一个学生之后，按照他的规则对当前水果分类，记录其中的错分的水果然后让下一个同学重点根据这些被错分的水果来找找规则，这样一步一步的最后全班同学得到一个较为完备的规则来判定出苹果.
> 
> 🌰🌰🌰 总结 :
> 
> 这个过程中单个学生扮演的较色就是基分类器，比如常用的决策树桩，类似某一维的的感知机，在该维度将空间一分为二的划分样本，而教师的角色则是在这一过程中不断引导学生关注被上一个学生错分的样本来做出判定规则，并最终得出一个较为完备的输出结果

**Boosting试图解决这么一个问题**：

> 由于发现弱学习算法通常比发现强学习算法容易，所以Boosting试图解决这么一个问题：“如果已经发现了‘弱学习算法’，那么能否将它提升为‘强学习算法’？”
>
> **提升方法**就是从弱学习算法出发，反复学习(改变训练数据的权值分布)，得到一系列弱分类器，然后组合这些弱分类器，构成一个强分类器；

**提升方法需要解决的两个问题**：

> - 在每一轮训练中，如何改变训练数据的权值/概率分布？
> - 在得到一系列弱分类器后，如何将弱分类器组合成一个强分类器？

## 1. AdaBoost: Adaptive Boosting

## Reference article

- [逗比算法工程师][9]
- [算法杂货铺][10]
- [52caml][11]
- 《机器学习导论》
- 《统计学习方法》
- [懒死骆驼][12]


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
