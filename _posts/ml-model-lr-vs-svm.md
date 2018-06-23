---
title: LR 与 SVM 的异同
toc: true
date: 2018-06-23 16:08:21
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

LR 和 SVM 之间的相同点和不同点, 查询了网络上的一些资料，特整理汇总如下 : 😄

1. LR 和 SVM 放在一起来进行比较, why？
2. LR 和 SVM 的 相同点和不同点?

<!-- more -->
 
## 1. 为什么将LR和SVM放在一起来进行比较？

回答这个问题其实就是回答LR和SVM有什么相同点

### LR 和 SVM 都是分类算法

> 判断一个算法是分类还是回归算法的唯一标准就是样本label的类型，如果label是离散的，就是分类算法，如果label是连续的，就是回归算法。很明显，LR的训练数据的label是“0或者1”，当然是分类算法.

### LR 和 SVM 都是线性分类算法 

> 如果不考虑核函数，LR和SVM都是线性分类算法，也就是说他们的分类决策面都是线性

> 这里要先说明一点，那就是LR也是可以用核函数的，至于为什么通常在SVM中运用核函数而不在LR中运用，后面讲到他们之间区别的时候会重点分析。总之，原始的LR和SVM都是线性分类器，这也是为什么通常没人问你决策树和LR什么区别，决策树和SVM什么区别，你说一个非线性分类器和一个线性分类器有什么区别？
> 
> 

### LR 和 SVM 都是判别模型

- | generative approach | discriminative approach
---- | :----: | :----:
定义 | 由数据学习联合概率分布$P(X,Y)$ 然后,<br>求出在$X$情况下，$P(Y)$作为预测的模型 | 决策函数$f(x)$或条件概率分布$P(X)$作为预测模型
特点 | 1. 可还原出$P(X,Y)$；<br> 2. 学习收敛速度更快；<br> 3. 存在隐变量时仍可用 | 1. 直接面对预测，准确率更高些; <br> 2. 便于数据抽象，特征定义使用;
模型 | native bayes、hidden markov	| Logistic Regression、SVM、Gradient Boosting、CRF.. 
Note | 给定输入$X$产生输出$Y$的生成关系 | 对给定的输入$X$，应预测什么样的输出$Y$


> **discriminative model** 判别模型不关心数据是怎么生成的，关心信号之间的差别，后用差别来对给定的一个信号进行分类
> 常见的判别模型有：KNN、SVM、LR

## 2. LR 和 SVM 的 不同

1. Linear SVM 和 LR 都是线性分类器
2. Linear SVM 不直接依赖数据分布，分类平面不受一部分样本点影响；LR则受所有数据点的影响，如果数据不同类别strongly unbalance一般需要先对数据做balancing。
3. Linear SVM 依赖数据表达的距离测度，所以需要对数据先做normalization；LR不受其影响
4. Linear SVM 依赖penalty的系数，实验中需要做validation
5. Linear SVM 和 LR 的 performance 都会收到outlier的影响，其敏感程度而言，谁更好很难下明确结论.

## 3. SVM 和 LR 的比较

两种方法都是常见的分类算法，从目标函数来看，区别在于逻辑回归采用的是logistical loss，svm采用的是hinge loss。这两个损失函数的目的都是**增加对分类影响较大的数据点的权重，减少与分类关系较小的数据点的权重**。

SVM 的处理方法是只考虑support vectors，也就是和分类最相关的少数点，去学习分类器。而LR通过非线性映射，大大减小了离分类平面较远的点的权重，相对提升了与分类最相关的数据点的权重。两者的根本目的都是一样的。此外，根据需要，两个方法都可以增加不同的正则化项，如l1,l2等等。所以在很多实验中，两种算法的结果是很接近的。

逻辑回归相对来说模型更简单，好理解，实现起来，特别是大规模线性分类时比较方便。而SVM的理解和优化相对来说复杂一些。但是SVM的理论基础更加牢固，有一套结构化风险最小化的理论基础，虽然一般使用的人不太会去关注。还有很重要的一点，SVM转化为对偶问题后，分类只需要计算与少数几个支持向量的距离，这个在进行复杂核函数计算时优势很明显，能够大大简化模型和计算量。

## 4. LR & SVM 选型

在Andrew NG的课里讲到过：

1. 如果Feature的数量很大，跟样本数量差不多，这时候选用LR或者是Linear Kernel的SVM
2. 如果Feature的数量比较小，样本数量一般，不算大也不算小，选用SVM+Gaussian Kernel
3. 如果Feature的数量比较小，而样本数量很多，需要手工添加一些feature变成第一种情况


## Reference article

- [LR 与 SVM的异同][1]
- [懒死骆驼 - 统计学习方法笔记(一)][2]
- [知乎 : 最小二乘、极大似然、梯度下降有何区别？][3]
- [知乎 : Linear SVM 和 LR 有什么异同？][4]
- [白开水加糖 SVM与LR的比较][5]
- [懒死骆驼 - 口述模型整理][6]

[img1]: /images/svm/svm-1-1.jpg


[1]: https://www.cnblogs.com/zhizhan/p/5038747.html
[2]: http://izhaoyi.top/2017/06/02/Note-StatisticalML/
[3]: https://www.zhihu.com/question/24900876
[4]: https://www.zhihu.com/question/26768865/answer/139613835
[5]: http://www.cnblogs.com/peizhe123/p/5674730.html
[6]: http://izhaoyi.top/2017/09/03/model-pre/


