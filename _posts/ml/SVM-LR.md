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

## Reference

- [支持向量机(SVM)硬核入门-基础篇](https://zhuanlan.zhihu.com/p/53944720)

