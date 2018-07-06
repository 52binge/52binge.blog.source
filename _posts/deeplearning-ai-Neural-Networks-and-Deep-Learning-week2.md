---
title: deeplearning.ai Neural Networks and Deep Learning (week2)
toc: true
date: 2018-07-06 23:55:21
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

Neural Networks and Deep Learning 第二周 Neural Networks Basic 的学习笔记. 

本周我们将要学习Logistic Regression, 它是神经网络的基础. 

<!-- more -->

**Logistic Regression** 可以看成是一种只有输入层和输出层(没有隐藏层)的神经网络. 在学习完本周的内容后, 我们将使用Python来实现一个这样的模型, 并将其应用在cat和non-cat的图像识别上.

## Binary Classification

<img src="/images/deeplearning/C1W2-1.jpg" width="750" />

<img src="/images/deeplearning/C1W2-2.jpg" width="750" />

## 一. 基本概念回顾

这次Andrew出的系列课程在符号上有所改动(和机器学习课程中的行列有所区别, 主要是为了后面代码实现方便), 如下图所示.

<img src="/images/deeplearning/C1W2-3_1.jpg" width="700" />

更多关于本系列课程的符号点[这里][2]同样地, 参数也有所变化(bias 单独拿出来作为$b$, 而不是添加 $\theta\_0$)

## Reference

- [Andrew Ng - deeplearning.ai][1]
- [网易云课堂 - 第一周深度学习概论][2]

[1]: https://www.deeplearning.ai/
[2]: http://7xrrje.com1.z0.glb.clouddn.com/deeplearningnotation.pdf