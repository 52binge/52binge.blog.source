---
title: LR 与 SVM 的异同
toc: true
date: 2018-06-23 16:08:21
categories: machine-learning
tags: machine-learning
---

LR 和 SVM 之间的相同点和不同点, 查询了网络上的一些资料，特整理汇总如下 : 😄

<!-- more -->

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

LR 相对来说模型更简单，好理解，实现起来，特别是大规模线性分类时比较方便。而SVM的理解和优化相对来说复杂一些。但是SVM的理论基础更加牢固，有一套结构化风险最小化的理论基础，虽然一般使用的人不太会去关注。还有很重要的一点，SVM转化为对偶问题后，分类只需要计算与少数几个支持向量的距离，这个在进行复杂核函数计算时优势很明显，能够大大简化模型和计算量。

### LR & SVM 不同点

> 要说有什么本质区别，那就是两个模型对数据和参数的敏感程度不同

model | desc
:----: | :----:
**Linear SVM** | 比较依赖 penalty的系数 和 数据表达空间的测度
**LR(自带正则项)** | 比较依赖对参数做 L1 regularization 的系数

> 但是由于他们或多或少都是线性分类器，所以实际上对低维度数据overfitting的能力都比较有限，相比之下对高维度数据，LR的表现会更加稳定，为什么呢？

> 因为Linear SVM在计算margin有多“宽”的时候是依赖数据表达上的距离测度的，换句话说如果这个测度不好（badly scaled，这种情况在高维数据尤为显著），所求得的所谓Large margin就没有意义了，这个问题即使换用kernel trick（比如用Gaussian kernel）也无法完全避免。

> 所以使用**Linear SVM**都需要先对数据做**normalization**，而求解LR（without regularization）时则不需要或者结果不敏感。

> 注：不带正则化的LR，其做normalization的目的是为了方便选择优化过程的起始值，不代表最后的解的performance会跟normalization相关，而其线性约束是可以被放缩的（等式两边可同时乘以一个系数），所以做normalization只是为了求解优化模型过程中更容易选择初始值。

### loss function

> 具体到 loss function 上来看， LR 用的是 `log-loss`, SVM 用的是 `hinge-loss`, 两者的相似之处在于 loss 在错误分类的时候都很大，但是对于正确分类的点，hinge-loss 就不管了，而 log-loss 还要考虑进去。此外因为 log-loss 在 mis-classified 的点上是指数级增长的，而 hinge-loss 是线性增长，所以 **LR 在偶尔出现 mis-label 的情况下的表现会比较糟糕**。

> 另外 regularization 在这里没有区别，L1/L2 两个都能用，效果也差不多。Class imbalance 的话 SVM 一般用 weight 解决，LR 因为可以预测概率，所以也可以直接对最后的结果进行调整，取不同的阈值来达到理想的效果。

> 实践中 LR 的速度明显更快，维度小的时候 bias 小 也不容易 overfit. 相反 Kernel SVM 在大规模数据集的情况下基本不实用，但是如果数据集本身比较小而且维度高的的话一般 SVM 表现更好。

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


