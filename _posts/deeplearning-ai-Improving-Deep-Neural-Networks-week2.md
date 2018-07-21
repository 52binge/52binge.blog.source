---
title: Improving Deep Neural Networks (week2) - 优化算法
toc: true
date: 2018-07-21 10:00:21
categories: deeplearning
tags: deeplearning.ai
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

这次我们要学习专项课程中第二门课 `Improving Deep Neural Networks`

**优化算法**

<!-- more -->


## 1. Mini-batch

> 随机梯度下降法的一大缺点是, 你会失去所有向量化带给你的加速，因为一次性只处理了一个样本，这样效率过于低下, 所以实践中最好 选择不大不小 的 Mini-batch 尺寸. 实际上学习率达到最快，你会发现2个好处，你得到了大量向量化，另一方面 你不需要等待整个训练集被处理完，你就可以开始进行后续工作.
> 
> 它不会总朝着最小值靠近，但它比随机梯度下降要更持续地靠近最小值的方向. 它也不一定在很小的范围内收敛，如出现这个问题，你可以减小 学习率.
> 
> 样本集比较小，就没必要使用 mini-batch.
> 
> Notes: 经验值 ： 如果 m <= 2000, 可以使用 batch， 不然样本数目 m 较大，一般 mini-batch 大小设置为 64 or 128 or 256 or 512..

## 2. Exponentially weighted averages



>  The most common value for $\beta$ is 0.9.

## 3. Momentum

## 4. RMSprop

## 5. Adam (Adaptive Moment Estimation)



> Notes: Adam 优化算法 我会毫不犹豫的推荐给你， 它是 Momentum 和 RMSprop 的结合. 事实证明，它其实解决了很多问题.

## 6. Learning rate decay



## 7. 本周内容回顾

- 改善深层神经网络：超参数调试、正则化

## 8. Reference

- [网易云课堂 - deeplearning][1]
- [深度学习笔记：优化方法总结(BGD,SGD,Momentum,AdaGrad,RMSProp,Adam)][2]
- [Deep Learning 之 最优化方法][3]

[1]: https://study.163.com/my#/smarts
[2]: https://blog.csdn.net/u014595019/article/details/52989301
[3]: https://blog.csdn.net/BVL10101111/article/details/72614711

