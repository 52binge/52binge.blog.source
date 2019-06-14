---
title: L1、L2 Regularization
date: 2019-06-09 10:06:16
categories: machine-learning
tags: [L1-L2]
toc: true
---

<img class="img-fancy" src="/images/ml/intro/L1l2regularization.png" width="550" border="0" alt="L1 L2 Regularization"/>

<!--<a href="/2019/06/02/ml/Random_Forest_and_GBDT/" target="_self" style="display:block; margin:0 auto; background:url('/images/ml/ensumble/ensumble-1.png') no-repeat 0 0 / contain; height:304px; width:550px;"></a>
-->

<!-- more -->

Supervised Learning:  “minimizeyour error while regularizing your parameters”

$$
w^*=argmin_w\sum_iL(y_i,f(x_i;w))+\lambda\Omega(w)
$$

> 我们不仅要保证训练误差最小，我们更希望我们的模型测试误差小.
> 
> 第二项 $\lambda\Omega(w)$，也就是对参数$w$的规则化函数 $Ω(w)$ 去约束我们的模型尽量的简单.

> 1. 第一项对应模型的训练损失函数 (Square Loss、Hinge loss、Exp loss、Log loss)
> 2. 第二项对应模型的正则化项 （模型参数向量的范数）

> 经验风险最小化 empirical risk minimization, 结构风险最小化 structural risk minimization

李沐曾经说过：
 
> model是用离散特征还是连续特征，其实是“**海量离散特征+简单模型**” 同 “**少量连续特征+复杂模型**”的权衡。
> 
> 既可以离散化用线性模型，也可以用连续特征加深度学习。就看是喜欢折腾 **feature** 还是折腾 **model** 了。通常来说，前者容易，而且可以n个人一起并行做，有成功经验；后者目前看很赞，能走多远还须拭目以待。 

结构风险最小化: 规则化项是结构风险最小化策略的实现，即在经验风险上加一个正则化项或惩罚项

> **最小化误差**是为了让我们的模型拟合我们的训练数据，**regularized parameters**是防止我们的模型**过分拟合**我们的**训练数据**。 因为参数太多，会导致我们的模型复杂度上升，容易过拟合，也就是我们的训练误差会很小。但训练误差小并不是我们的最终目标，我们的**目标是希望模型的测试误差小**，也就是能准确的预测新的样本。
>
> 我们需要**保证模型“`简单`”的基础上最小化训练误差**，**这样得到的参数才具有好的泛化性能（也就是测试误差也小）**.
> 
> 而模型**“简单”就是通过规则函数来实现的**。**regularized item**的使用还可以约束我们的模型的特性。**这样就可以将人对这个模型的先验知识融入到模型的学习当中**，强行地让学习到的模型具有人想要的特性，例如 稀疏、低秩、平滑 等等。
> 
> 人的先验是非常重要的。前人的经验会让你少走很多弯路，这就是为什么我们平时学习最好找个大牛带带的原因。一句点拨可以为我们拨开眼前乌云，还我们一片晴空万里，醍醐灌顶。对机器学习也是一样，如果被我们人稍微点拨一下，它肯定能更快的学习相应的任务。只是由于人和机器的交流目前还没有那么直接的方法，目前只能由规则项来担当了.

## 1. Supervised Learning Obj

**第一项对应模型的训练损失函数:**

> - Square Loss –> 最小二乘
> - Hinge Loss –> SVM
> - Exp Loss –> AdaBoost
> - Log Loss –> LR

**第二项对应模型的正则化项:** (一般是模型复杂度的单调递增函数)

> - 模型参数向量的范数，不同的选择对参数的约束不同，取得的效果也不同
>
> 论文中常都聚集在：零范数、一范数、二范数、核范数等等。这么多范数，到底它们表达啥意思？具有啥能力？

[zhihu1]: https://zhuanlan.zhihu.com/p/27424282

## 2. Norm

在机器学习中，我们经常使用称为范数(norm)的函数来衡量向量大小. 

$L^p$  范数定义如下：

$$
\|x\|\_{p}=\left(\sum\_{i}\left|x\_{i}\right|^{p}\right)^{\frac{1}{p}}
$$

- $L^0$ 范数：$\|x\|\_{0}$ 为 $x$ 向量各个非零元素的个数。

- $L^1$ 范数：$\|x\|\_{1}$ 为 $x$ 向量各个元素绝对值之和，也叫“稀疏规则算子”（Lasso Regularization）。

- $L^2$ 范数：$\|x\|\_{2}$ 为 $x$ 向量各个元素平方和的 $1/2$ 次方，$L^2$ 范数又称 Euclidean、 Frobenius 范数。

## 3. L1 Regularization

L1 可以实现稀疏，为什么要稀疏？

$$
\|\boldsymbol{x}\|\_{1}=\sum\_{i}\left|x\_{i}\right|
$$

让我们的参数稀疏有什么好处呢？这里扯两点：

**特征选择(Feature Selection)：**

> 大家对**稀疏规则化**趋之若鹜的一个关键原因在于它能实现特征的自动选择。$x\_i$ 的大部分元素（也就是特征）都是和最终的输出 $y\_i$ 没有关系或者不提供任何信息的，在最小化目标函数的时候考虑$x\_i$这些额外的特征，虽然可以获得更小的训练误差，**但在预测新的样本时，这些没用的信息反而会被考虑，从而干扰了对正确$y\_i$的预测**。稀疏规则化算子的引入就是为了完成特征自动选择的光荣使命，它会学习地去掉这些没有信息的特征，也就是把这些特征对应的权重置为0。

**可解释性(Interpretability)：**

> 模型更容易解释。例如患某种病的概率是$y$，我们收集到的数据$x$是 1000 维的，也就是我们需要寻找这 1000种 因素到底是怎么影响患上这种病的概率的。
> 
> 假设我们这个是个回归模型：$y=w\_1 x\_1 + w\_2 x\_2 + w\_{1000} x\_{1000} + b$（当然了，为了让 $y$ 限定在[0,1]的范围，一般还得加个Logistic函数）。
> 
> 通过学习，如果最后学习到的 $w\*$ 就只有很少的非零元素，例如只有5个非零的 $w\_i$，那么我们就有理由相信，这些对应的特征在患病分析上面提供的信息是巨大的，决策性的。
> 
> 患不患这种病只和这5个因素有关，那医生就好分析多了。但如果1000个 $w\_i$ 都非0，医生面对这1000种因素，累觉不爱.

## 4. L2 Regularization

### 4.1 L2 能防止过拟合？

通过 L2范数 的规则项最小来使参数值都较小、甚至趋于0(但不会为0)，模型参数值越小则对应的特征对于模型的影响就比较小，这样相当于对这部分无关特征做了一个惩罚，即使他们的值波动比较大，受限于参数值很小，也不会对模型的输出结果造成太大影响，也就使得模型不会习得这部分特征而发生过拟合

### 4.2 L2 范数的好处

- 学习理论的角度：可以防止过拟合，提升模型的泛化能力
- 优化、数值计算的角度：L2范数能够让我们的优化求解变得稳定和快速.

## Reference

- [懒死骆驼][1]
- [机器学习中的范数规则化之（一）L0、L1与L2范数][2]
- [机器学习算法系列（28）：L1、L2正则化][3]
- [L1 / L2 正规化](https://morvanzhou.github.io/tutorials/machine-learning/ML-intro/3-09-l1l2regularization/)
- [什么是过拟合 (Overfitting)](https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/5-02-A-overfitting/)
- [迭代自己: 范数](http://www.iterate.site/post/01-数字的张力/02-机器学习/01-机器学习理论/01-数学基础/02-线性代数/25-范数/)

[1]: http://izhaoyi.top/2017/09/15/l1-l2/
[2]: https://blog.csdn.net/zouxy09/article/details/24971995
[3]: https://plushunter.github.io/2017/07/22/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0%E7%AE%97%E6%B3%95%E7%B3%BB%E5%88%97%EF%BC%8828%EF%BC%89%EF%BC%9AL1%E3%80%81L2%E6%AD%A3%E5%88%99%E5%8C%96/





