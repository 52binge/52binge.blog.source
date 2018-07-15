---
title: Neural Networks and Deep Learning (week3)
toc: true
date: 2018-07-14 14:55:21
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

我们要正式地进入神经网络的学习. 当然, 我们先从简单的只有一个隐藏层的神经网络开始. 

在学习完本周内容之后, 我们将会使用Python实现一个单个隐藏层的神经网络, 并在Planar data上测试.

<!-- more -->

## 1. 常用符号与基本概念

<img src="/images/deeplearning/C1W3-1_1.png" width="750" />

> 该神经网络完全可以使用上一周所讲的计算图来表示, 和 $LR$ 计算图的区别仅仅在于多了一个 $z$ 和 $a$ 的计算而已. 
>
> 如果你已经完全掌握了上一周的内容, 那么其实你已经知道了神经网络的前向传播, 反向传播(梯度计算)等等.
>
> 要注意的是各种参数, 中间变量$(a, z)$的维度问题. 关于神经网络的基本概念, 这里就不赘述了. 见下图回顾一下:

<img src="/images/deeplearning/C1W3-2_1.png" width="750" />

## 2. 神经网络中的前向传播

> 我们先以一个训练样本来看神经网络中的前向传播. 
> 我们只看这个神经网络中的输入层和隐藏层的第一个激活单元(如下图右边所示). 其实这就是一个Logistic Regression. 
>
> 1. 神经网络中输入层和隐藏层(不看输出层), 这就不就是四个LR放在一起吗? 
> 2. 在LR中 $z$ 和 $a$ 的计算我们已经掌握了, 那么在神经网络中 $z$ 和 $a$ 又是什么呢? 
>
> **我们记隐藏层第一个 $z$ 为 $z\_1$, 第二个 $z$ 记为 $z\_2$ 以此类推**. 
> 只要将这四个 $z$ 纵向叠加在一起称为一个**`列向量` 即可得到神经网络中这一层的$z$**($a$同理).

<img src="/images/deeplearning/C1W3-3_1.png" width="750" />

那么这一层的 $w, b$ 又是如何得到的? 别忘了, 对于参数 $w$ 来说, 它本身就是一个列项量, 那么它是如何做纵向叠加的呢? 我们只需要将其转置变成一个横向量, 再纵向叠加即可.

<img src="/images/deeplearning/C1W3-4_1.png" width="750" />

得到隐藏层的 $a$ 之后, 我们可以将其视为输入, 现只看神经网络的隐藏层和输出层, 我们发现这不就是个 $LR$ 嘛.

<img src="/images/deeplearning/C1W3-5_1.png" width="750" />

这里总结一下各种变量的维度(注意这里是针对一个训练样本来说的, $n\_L$ 代表的 $L$ 层的节点个数):

- $w.shape : (n\_L, n\_{(L-1)})$
- $b.shape : (n\_L, 1)$
- $z.shape : (n\_L, 1)$
- $a.shape : (n\_L, 1)$

那么如果有 $m$ 个训练样本这些变量的维度又是怎样的呢. 我们思考哪些变量的维度会随着样本数的变化二变化. $w$ 是参数显然它的维度是不会变的. 而输入每一个样本都会有一个 $z$ 和 $a$, 还记得 $X$ 的形式吗? 同样地, $Z$ 就是将每个样本算出来的 $z$ 横向叠加(A同理). 具体计算过程如下图:

## 3. 神经网络中的激活函数

## 4. 神经网络中的反向传播

## 5. 神经网络中的参数初始化

## 6. 用Python搭建简单神经网络

## 7. 本周内容回顾

- 学习了神经网络的基本概念
- 掌握了神经网络中各种变量的维度
- 掌握了神经网络中的前向传播与反向传播
- 了解了神经网络中的激活函数
- 学习了神经网络中参数初始化的重要性
- 掌握了使用Python实现简单的神经网络

## Reference

- [网易云课堂 - deeplearning][3]
- [deeplearning.ai 专项课程一第三周][2]
- [Coursera - Deep Learning Specialization][4]

[1]: http://7xrrje.com1.z0.glb.clouddn.com/deeplearningnotation.pdf
[2]: http://daniellaah.github.io/2017/deeplearning-ai-Neural-Networks-and-Deep-Learning-week3.html
[3]: https://study.163.com/my#/smarts
[4]: https://www.coursera.org/specializations/deep-learning

