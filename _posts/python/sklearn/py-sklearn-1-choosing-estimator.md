---
title: Sklearn Choosing The Right Estimator
date: 2018-01-03 13:22:21
categories: python
tags: Sklearn
---

Sciki-learn 选择学习方法，选择模型 [流程图][4]

<!-- more -->

Sklearn 官网提供了一个流程图，蓝色圆圈内是判断条件，绿色方框内是可以选择的算法：[详情][4]

![http://scikit-learn.org/stable/tutorial/machine_learning_map/index.html]][img-1]

从 START 开始，首先看数据的样本是否 `>50`，小于则需要收集更多的数据。

由图中，可以看到算法有四类，`分类`，`回归`，`聚类`，`降维`。


algorithm | desc
------- | -------
分类 | 监督式学习，即每个数据对应一个 label 
回归 | 监督式学习，即每个数据对应一个 label 
聚类 | 非监督式学习，即没有 label。 
降维 | 当数据集有很多很多属性的时候，可以通过 降维 算法把属性归纳起来。<br><br> 例如 20 个属性只变成 2 个，注意，这不是挑出 2 个，而是压缩成为 2 个，<br>它们集合了 20 个属性的所有特征，相当于把重要的信息提取的更好，不重要的信息就不要了

然后看问题属于哪一类问题，是分类还是回归，还是聚类，就选择相应的算法。 当然还要考虑数据的大小，例如 `100K` 是一个阈值。

可以发现有些方法是既可以作为分类，也可以作为回归，例如 `SGD`。

## Reference

- [scikit-learn.org][1]
- [scikit-learn docs][2]
- [scikit-learn machine_learning_map][4]

[1]: http://scikit-learn.org/
[2]: http://scikit-learn.org/stable/tutorial/basic/tutorial.html
[3]: https://morvanzhou.github.io
[4]: http://scikit-learn.org/stable/tutorial/machine_learning_map/index.html

[img-1]: /images/python/sklearn-1-model-choosing.png

