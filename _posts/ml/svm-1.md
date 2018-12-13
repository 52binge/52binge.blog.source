---
title: Support Vecor Machine (六部曲)
toc: true
date: 2018-06-20 16:08:21
categories: machine-learning
tags: machine-learning
mathjax: true
---

Support Vecor Machine, 自一诞生便由于它良好的分类性能席卷了机器学习领域，并牢牢压制了神经网络领域好多年。 如果不考虑集成学习的算法，不考虑特定的训练数据集，在分类算法中的表现SVM说是排第一估计是没有什么异议的.

<!-- more -->

## 1. SVM 间隔 Margin

1. 支持向量机（SVM）的目标是什么？
2. 什么是分离超平面， Margin

详情可参 : [机器学习系列(13)_SVM碎碎念part1：间隔][1]

> 认识一下SVM中很重要的一个概念：Margin，也就是间隔。

## 2. SVM 向量与空间距离

1. 从向量到距离计算 (向量定义、计算方向向量、向量的和与差、向量内积、向量正交投影)
2. SVM的超平面 (1 计算点到超平面距离、2 计算超平面的间隔)

详情可参 : [机器学习系列(14)_SVM碎碎念part2：SVM中的向量与空间距离][2]

> 回顾了一下向量中的一些概念，依用向量的知识，怎么帮助我们去计算超平面间隔，有兴趣的同学请接着看part3
> 
> $ w^{T}X = 0 $， w

## 3. SVM 如何找到最优分离超平面

1. 如何找到最优超平面
2. 如何计算两超平面间的距离
3. SVM的最优化问题是什么

> 找到两个平行超平面，可以划分数据并且两平面之间没有数据点
> 两个超平面之间的距离最大化

详情可参 : [机器学习系列(15)_SVM碎碎念part3：如何找到最优分离超平面][3]

## 4. SVM 无约束最小化问题

详情可参 : [机器学习系列(21)_SVM碎碎念part4：无约束最小化问题][4]

## 5. SVM 凸函数与优化

详情可参 : [机器学习系列(22)_SVM碎碎念part5：凸函数与优化][5]

## 6. SVM 对偶和拉格朗日乘子

详情可参 : [机器学习系列(23)_SVM碎碎念part6：对偶和拉格朗日乘子][6]

## Reference article

[1]: https://blog.csdn.net/han_xiaoyang/article/details/52678373
[2]: https://blog.csdn.net/han_xiaoyang/article/details/52679559
[3]: https://blog.csdn.net/han_xiaoyang/article/details/52683653
[4]: https://blog.csdn.net/han_xiaoyang/article/details/79079540
[5]: https://blog.csdn.net/yaoqiang2011/article/details/79080100
[6]: https://blog.csdn.net/yaoqiang2011/article/details/79080123

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
