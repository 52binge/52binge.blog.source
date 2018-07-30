---
title: Improving Deep Neural Networks (week3) - 超参数调试、Batch 正则化 和 程序框架
toc: true
date: 2018-07-23 20:00:21
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

<!-- more -->

## 1. Hyperparameter Tuning process

正常情况有如下超参数:

Hyperparameter | Desc | Importance level
:-------: | :-------: | :-------: 
<font color="red">α</font> | 最重要 | 1
<font color="orange">hidden units</font> | | 2
<font color="orange">mini-batch size</font> | | 2
<font color="orange">β</font> | | 2
<font color="purple">layers</font> | | 3
<font color="purple">learning rate decay</font> | | 3
$β\_1,β\_2,ε$ | 最不重要 | 4

> 颜色表示重要性，以及调试过程中可能会需要修改的程度.

### 那么如何选择超参数的值呢？:

- 首先是粗略地随机地寻找最优参数

<img src="/images/deeplearning/C2W3-1_1.png" width="700" />

**建议使用图右的方式，原因如下：**

> 对于图左的超参数分布而言，可能会使得参考性降低，我们假设超参1是学习率α，超参2是ε，根据week2中Adam算法的介绍，我们知道ε的作用几乎可以忽略，所以对于图左25中参数分布来说，其本质只有5种参数分布。而右边则是25种随机分布，更能帮助我们选择合适的超参数.

**其次在上面找到的最优参数分布周围再随机地寻找最有参数**

<img src="/images/deeplearning/C2W3-2_1.png" width="700" />

## 2. Using an appropriate scale to pick hyperparameters

上一节提到的的随机采样虽然能帮助我们寻找最优参数分布，但是这有点像大海捞针，如果能够指出参数取值的范围，然后再去寻找最优的参数分布岂不是更加的美滋滋？那如何为超参数选择合适的范围呢？

> $n^{[l]}=50,……,100$
>
> $layers=2~4$
>
> $α=0.0001，……,1$

此时注意: 如按照线性划分的话(如下图)，那么随机采样的值90%的数据来自[0.1,1]这个区间, 这显然与不太符合随机性.

<img src="/images/deeplearning/C2W3-3_1.png" width="700" />

> 所以为了改进这一问题，我们需要将区间对数化来采样.
> 
> **举个🌰：** 我们将 [0.0001,1] 转化成四个区间 [0.0001,0.001], [0.001,0.01], [0.01,0.1], [0.1,1], 再转化成对数就是 [-4,-3], [-3,-2], [-2,-1], [-1,0].
> 
> ($10^{−4}=0.0001$，其他同理取指数).

然后我们可以用Python中提供的方法来实现随机采样：

```python
r = -4*np.random.rand() # rand()表示在[0,1]上均匀采样, 最后的采样区间是[-4, 0]
a = pow(10, r)
```

<img src="/images/deeplearning/C2W3-4_1.png" width="700" />

**$β=0.9,……,0.999$**

同理这里也不能使用线性轴来采样数据，我们可以通过对 **1-β=0.1,……,0.001** 来间接采样。转化成 [0.1, 0.01],[0.01,0.001], 转化成对数指数[-1,-2],[-2,-3]。

即: $r∈[-3,-1], 1-β=10^r, β=1-10^r$

> 当 β 接近 1 时, β 就会对细微的变化变得很敏感.
> 
> for example : 0.999, 0.9995 => 1000 -> 2000
> 
> 所以你需要更加密集的取值，在 β 接近 1 的时候.

## 3. 超参数训练的实践

## 4. 正则化网络的激活函数

> In practice， normlizing $Z^{\[2\]}$ is done much more often.

## 5. 将 Batch Norm 拟合进神经网络

## 6. Batch Norm 为什么奏效 ?

> batch 归一化减少了输入值改变的问题
> 
> batch norm 中有一个作用，可以起到轻微 正则化 的作用

## 7. Softmax 回归

## 8. 深度学习框架 & TensorFlow

## 7. 本周内容回顾

- 改善深层神经网络：超参数调试、正则化

## 8. Reference

- [网易云课堂 - deeplearning][1]
- [deeplearning.ai 专项课程二第一周][2]
- [Coursera - Deep Learning Specialization][3]
- [DeepLearning.ai学习笔记汇总][4]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/p/7470989.html

