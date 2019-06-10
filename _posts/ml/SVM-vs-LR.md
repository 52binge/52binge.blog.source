---
title: SVM 和 LR 的区别与联系？
date: 2019-06-10 10:06:16
categories: machine-learning
tags: [SVM]
toc: true
---

<img class="img-fancy" src="/images/ml/svm/svm-01.jpg" width="600" border="0" alt="Claude Shannon"/>

<!--<a href="/2019/06/02/ml/Random_Forest_and_GBDT/" target="_self" style="display:block; margin:0 auto; background:url('/images/ml/ensumble/ensumble-1.png') no-repeat 0 0 / contain; height:304px; width:550px;"></a>
-->

<!-- more -->

## 1. LR vs SVM

1. Linear SVM 和 LR 都是线性分类器
2. Linear SVM 不直接依赖数据分布，分类平面不受一部分样本点影响；LR则受所有数据点的影响，如果数据不同类别strongly unbalance一般需要先对数据做balancing。
3. Linear SVM 依赖数据表达的距离测度，所以需要对数据先做normalization；LR不受其影响


> 1). 对非线性表达上，LR 只能通过人工的特征组合来实现，而 SVM 可以很容易引入非线性核函数来实现非线性表达，当然也可以通过特征组合。
> 
> 2). LR 产出的是概率值，而SVM只能产出是正类还是负类，不能产出概率。LR 的损失函数是 log loss，而 SVM 使用的是 hinge loss。
> 
> 3). SVM 不直接依赖数据分布，而LR则依赖, SVM 主要关注的是“支持向量”，也就是和分类最相关的少数点，即关注局部关键信息；而 LR 是在全局进行优化的。这导致 SVM 天然比 LR 有**更好的泛化能力**，防止过拟合。
> 
> 4). 损失函数的优化方法不同，LR 是使用 GD 来求解 **对数似然函数** 的最优解；SVM 使用 (Sequnential Minimal Optimal) 顺序最小优化，来求解条件约束损失函数的对偶形式。
>
> ---
>
> 一般用线性核和高斯核，也就是Linear核与RBF核需要注意的是需要对 **数据归一化处理**.
>
> 一般情况下RBF效果是不会差于Linear但是时间上RBF会耗费更多

## 2. Andrew Ng

> 1. 如果Feature的数量很大，跟样本数量差不多，这时候选用LR或者是Linear Kernel的SVM
> 2. 如果Feature的数量比较小，样本数量一般，不算大也不算小，选用SVM+Gaussian Kernel
> 3. 如果Feature的数量比较小，而样本数量很多，需要手工添加一些feature变成第一种情况

**如何量化 feature number 和 sample number：**

> n 是feature的数量, m是样本数   

> 1). feature number >> sample number，则使用LR算法或者不带核函数的SVM（线性分类）
>   &nbsp;&nbsp;&nbsp;&nbsp; feature number = 1W， sample number = 1K
>     
> 2). **fn** 小， sample number **一般**1W，使用带有 **kernel函数** 的 SVM算法.  
>    
> 3). **fn** 小， sample number **很大**5W+（n=1-1000，m=50000+）
> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 增加更多的 feature 然后使用LR 算法或者 not have kernel 的 SVM

## 3. SVM 和 LR 的比较

两种方法都是常见的分类算法，从目标函数来看，区别在于逻辑回归采用的是logistical loss，svm采用的是hinge loss。这两个损失函数的目的都是**增加对分类影响较大的数据点的权重，减少与分类关系较小的数据点的权重**。

SVM 的处理方法是只考虑support vectors，也就是和分类最相关的少数点，去学习分类器。而LR通过非线性映射，大大减小了离分类平面较远的点的权重，相对提升了与分类最相关的数据点的权重。两者的根本目的都是一样的。此外，根据需要，两个方法都可以增加不同的正则化项，如l1,l2等等。所以在很多实验中，两种算法的结果是很接近的。

LR 相对来说模型更简单，好理解，实现起来，特别是大规模线性分类时比较方便。而SVM的理解和优化相对来说复杂一些。但是SVM的理论基础更加牢固，有一套结构化风险最小化的理论基础，虽然一般使用的人不太会去关注。还有很重要的一点，SVM转化为对偶问题后，分类只需要计算与少数几个支持向量的距离，这个在进行复杂核函数计算时优势很明显，能够大大简化模型和计算量。

**LR & SVM 不同点:**

> 要说有什么本质区别，那就是两个模型对数据和参数的敏感程度不同

> 但是由于他们或多或少都是线性分类器，所以实际上对低维度数据overfitting的能力都比较有限，相比之下对高维度数据，LR的表现会更加稳定，为什么呢？

> 因为Linear SVM在计算margin有多“宽”的时候是依赖数据表达上的距离测度的，换句话说如果这个测度不好（badly scaled，这种情况在高维数据尤为显著），所求得的所谓Large margin就没有意义了，这个问题即使换用kernel trick（比如用Gaussian kernel）也无法完全避免。

> 所以使用**Linear SVM**都需要先对数据做**normalization**，而求解LR（without regularization）时则不需要或者结果不敏感。

> 注：不带正则化的LR，其做normalization的目的是为了方便选择优化过程的起始值，不代表最后的解的performance会跟normalization相关，而其线性约束是可以被放缩的（等式两边可同时乘以一个系数），所以做normalization只是为了求解优化模型过程中更容易选择初始值。

## Reference

- [LR 与 SVM的异同][1]
- [懒死骆驼 - 统计学习方法笔记(一)][2]
- [知乎 : 最小二乘、极大似然、梯度下降有何区别？][3]
- [知乎 : Linear SVM 和 LR 有什么异同？][4]
- [白开水加糖 SVM与LR的比较][5]
- [懒死骆驼 - 口述模型整理][6]
- [支持向量机(SVM)硬核入门-基础篇](https://zhuanlan.zhihu.com/p/53944720)
- [scikit-learn 逻辑回归类库使用小结](https://www.cnblogs.com/pinard/p/6035872.html)

[1]: https://www.cnblogs.com/zhizhan/p/5038747.html
[2]: http://izhaoyi.top/2017/06/02/Note-StatisticalML/
[3]: https://www.zhihu.com/question/24900876
[4]: https://www.zhihu.com/question/26768865/answer/139613835
[5]: http://www.cnblogs.com/peizhe123/p/5674730.html
[6]: http://izhaoyi.top/2017/09/03/model-pre/



