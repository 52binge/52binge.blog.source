---
title: deeplearning.ai Neural Networks and Deep Learning (week2)
toc: true
date: 2018-07-07 09:55:21
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

本周我们将要学习 Logistic Regression, 它是神经网络的基础. 

Logistic Regression 可以看成是一种只有输入层和输出层(没有隐藏层)的神经网络. 

我们将使用 **Python** 来实现一个这样的模型, 并将其应用在 **cat** 和 **non-cat** 的图像识别上.

<!-- more -->

## Binary Classification

<img src="/images/deeplearning/C1W2-1.jpg" width="750" />

<img src="/images/deeplearning/C1W2-2.jpg" width="750" />

## 一. 基本概念回顾

这次Andrew出的系列课程在符号上有所改动(和机器学习课程中的行列有所区别, 主要是为了后面代码实现方便), 如下图所示.

<img src="/images/deeplearning/C1W2-3_1.jpg" width="700" />

更多关于本系列课程的符号点[这里][2]同样地, 参数也有所变化(bias 单独拿出来作为$b$, 而不是添加 $\theta\_0$)

<!-- more -->

## 1. Notation

更多关于本系列课程的符号点[这里][1]同样地, 参数也有所变化($bias$ 单独拿出来作为$b$, 而不是添加 $\theta\_0$

## 2. Logistic Regression

<img src="/images/deeplearning/C1W2-4_1.jpg" width="750" />

 - 一个是 **Loss function**, 即损失函数, 它代表了对于一个样本估计值与真实值之间的误差; 
 - 一个是 **Cost function**, 它代表了所有样本loss的平均值.

<img src="/images/deeplearning/C1W2-6_1.jpg" width="750" />

## 3. Logistic Regression Cost Function

<img src="/images/deeplearning/C1W2-8_1.jpg" width="750" />

## 4. Gradient Descent

<img src="/images/deeplearning/C1W2-9_1.jpg" width="750" />

<img src="/images/deeplearning/C1W2-10_1.jpg" width="750" />

## 5. Derivatives

<img src="/images/deeplearning/C1W2-11_1.png" width="750" />

<img src="/images/deeplearning/C1W2-12_1.png" width="750" />

## 7. Computation Graph

神经网络中, forward propagation 用来计算输出, backward propagation 用来计算梯度, 得到梯度后就可更新对应的参数了. 

<img src="/images/deeplearning/C1W2-13_1.jpg" width="750" />

如上图所示通过前向传播, 我们得到 $J = 33$. 

> 这里说明一下, 在后面代码实现中, 这些导数都可以用 $dvar$ 来表示, 例如 dw1, db1 等等.

## 8. Computation Graph Derivatives

反向传播本质上就是通过链式法则不断求出前面各个变量的导数的过程.

<img src="/images/deeplearning/C1W2-14_1.png" width="750" />

## 9. Logistic regression recap

有了计算图的概念之后, 我们将其运用到 Logistic Regression 上. 

<img src="/images/deeplearning/C1W2-16_1.png" width="700" />

上面的式子可以用下面的计算图来表达:

<img src="/images/deeplearning/C1W2-16_2.png" width="700" />

有了上面的图之后, 我们现在来计算反向传播.

首先我们来计算 $\frac{dL}{da}$:

$$
\begin{align} \frac{dL}{da} & = - (\frac{y}{a} - \frac{(1-y)}{(1-a)}) \end{align}
$$

通过链式法则, 计算 $\frac{dL}{dz}$:

$$
\begin{align} \frac{dL}{dz} & = \frac{dL}{da}\frac{da}{dz} \\\\ \\\\ & = - (\frac{y}{a} - \frac{(1-y)}{(1-a)})\sigma(z)(1-\sigma(z)) \\\\ \\\\ & = - (\frac{y}{a} - \frac{(1-y)}{(1-a)})a(1-a)) \\\\ \\\\ & = -y(1-a) + (1-y)a \\\\ \\\\ & = a - y \end{align}
$$

最后计算 $\frac{dL}{dw1}, \frac{dL}{dw2}, \frac{dL}{db}$:

$$
\frac{dL}{dw\_1} = \frac{dL}{dz}\frac{dz}{dw\_1} = (a - y)x\_1
$$

$$
\frac{dL}{dw\_2} = \frac{dL}{dz}\frac{dz}{dw\_2} = (a - y)x\_2
$$

$$
\frac{dL}{db} = \frac{dL}{dz}\frac{dz}{db} = a - y
$$

怎么样? 是不是很简单呢? 这里我们所有的计算都是针对一个训练样本的. 当然我们不可能只有一个样本, 那么对于整个训练集, 我们应该怎么做呢? 其实很简单, 我们只需要将 $J(w, b)$ 拆开来写就很清晰.

$$
J(w, b) = \frac{1}{m}(L(a^{(1)}, y^{(1)}) + L(a^{(2)}, y^{(2)}) + … + L(a^{(m)}, y^{m)}))
$$

<img src="/images/deeplearning/C1W2-17_1.jpg" width="750" />

对于每一个样本都有一个对应的 $dz^{(i)}$, 而对于 $dw, db$ 来说是对于所有求平均.

<img src="/images/deeplearning/C1W2-18_1.png" width="750" />


## Reference

- [网易云课堂 - deeplearning][3]
- [deeplearning.ai 专项课程一第二周][2]

[1]: http://7xrrje.com1.z0.glb.clouddn.com/deeplearningnotation.pdf
[2]: http://daniellaah.github.io/2017/deeplearning-ai-Neural-Networks-and-Deep-Learning-week2.html
[3]: https://study.163.com/my#/smarts

