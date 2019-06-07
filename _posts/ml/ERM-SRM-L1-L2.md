---
title: Empirical Risk Minimization and Structural Risk Minimization
date: 2019-06-09 10:06:16
categories: machine-learning
tags: [L1-L2]
toc: true
---

<img class="img-fancy" src="/images/ml/intro/L1l2regularization.png" width="550" border="0" alt="L1 L2 Regularization"/>

<!--<a href="/2019/06/02/ml/Random_Forest_and_GBDT/" target="_self" style="display:block; margin:0 auto; background:url('/images/ml/ensumble/ensumble-1.png') no-repeat 0 0 / contain; height:304px; width:550px;"></a>
-->

<!-- more -->

Supervised Learning Obj

$$
w^*=argmin_w\sum_iL(y_i,f(x_i;w))+\lambda\Omega(w)
$$

> 1. 第一项对应模型的训练损失函数 (Square Loss、Hinge loss、Exp loss、Log loss)
> 2. 第二项对应模型的正则化项 （模型参数向量的范数）

> 经验风险最小化 empirical risk minimization, 结构风险最小化 structural risk minimization

李沐曾经说过：
 
> model是用离散特征还是连续特征，其实是“**海量离散特征+简单模型**” 同 “**少量连续特征+复杂模型**”的权衡。
> 
> 既可以离散化用线性模型，也可以用连续特征加深度学习。就看是喜欢折腾 **feature** 还是折腾 **model** 了。通常来说，前者容易，而且可以n个人一起并行做，有成功经验；后者目前看很赞，能走多远还须拭目以待。
> 


## Reference

- [L1 / L2 正规化](https://morvanzhou.github.io/tutorials/machine-learning/ML-intro/3-09-l1l2regularization/)
- [什么是过拟合 (Overfitting)](https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/5-02-A-overfitting/)