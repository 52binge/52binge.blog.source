---
title: Perceptron Model
toc: true
date: 2016-05-20 18:01:21
categories: machine-learning
tags: classification
description: Perceptron model learning for classification
mathjax: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$']],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

perceptron model learning

<!--more-->

**Written Before**

- 豆瓣链接 : [《统计学习方法》][1]
- 李航微博 : [@李航博士][2]
- 维基百科 : [perceptron][3]

**Content List**

- 1.感知机模型
- 2.感知机学习策略
- 3.感知机学习算法
  - 3.1. 原始形式  
  - 3.2. 算法收敛性
  - 3.3. 对偶形式

## 1. Perceptron model

**model applicable premise**

perceptron 能够解决的问题首先要求 `feature_space` 线性可分，再者是二类分类，即将 sample 分为 {+1, -1} 两类

由`input_space` to `output_space` 的函数：

$$
f(x) = sign (w \bullet x + b)
$$

$w$ 和 $b$ 为 model 参数，$w$ 为权值（weight），$b$ 为偏置（bias）


$$
    sign(x) = \begin{Bmatrix}
        +1, &\mbox{$w \bullet x + b > 0;$} \\\\
        -1, &\mbox{$w \bullet x + b < 0;$}
    \end{Bmatrix}
$$


感知机模型的 <font color=#DC143C face="STCAIYUN">hypothesis_space</font> 是定义在`feature_space`中的所有线性分类模型，即函数集合 $$ {f|f(x) = w·x + b} $$

感知机的定义中，线性方程 $w·x + b = 0$ 对应于问题空间中的一个超平面S，位于这个超平面两侧的样本分别被归为两类，例如下图，红色作为一类，蓝色作为另一类，它们的 feature 很简单，就是它们的坐标

<p align="center">![图1][6]

As a method of supervised learning，Perceptron learning from the training set to obtain the perceptron model，即求得模型参数 $w，b$，这里 $x$ 和 $y$ 分别是 feature_vector 和 类别（也称为目标）。基于此，Perceptron model 可以对新的 input样本 进行分类。

## 2. Perceptron learning strategy

perceptron model is a linear classification model for two kinds of classification。 Linear classification model is required that our sample is linearly separable. But, What kind of sample is linearly separable？

举例来说，在二维平面中，可以用一条直线将 +1类 和 -1类 完美分开，那么这个样本空间就是线性可分的。如图1就是线性可分的，图2中的样本就是线性不可分的，感知机就不能处理这种情况。因此，在本章中的所有问题都基于一个前提，就是问题 空间线性可分。

<p align="center">![图2][7]<2>

为说明问题，假设数据集 

$$
T = \{ \(x_1, y_1), (x_2, y_2), ... , (x_N, y_N) \}
$$ 

对所有 

$y_i = +1$ 的实例 $i$ 有 $w \bullet x + b > 0$ , 
$y_i = -1$ 的实例 $i$ 有 $w \bullet x + b < 0$

这里先给出 `input_space`  $R^n$ 中任一点 $x_0$ 到超平面 $S$ 的距离：

$$
\frac{1}{||w||}  |w \bullet x_0 + b|
$$
> 这里 $||w||$ 是 $w$ 的 $L_2$ 范数
> 
> [more_info_点到平面的距离](https://segmentfault.com/a/1190000005138706)

对于误分类的数据  $(x_i, y_i)$ ，根据我们之前的假设，有

$$
-y_i (w \bullet x_i + b) > 0
$$

因此误分类点到超平面 $S$ 的距离可以写作 :

$$
-\frac{1}{||w||} y_i (w \bullet x_i + b)
$$

假设超平面 $S$ 的误分类点集合为 $M$，那么所有误分类点到超平面S的总距离为 :

$$
-\frac{1}{||w||}\sum_{x_i \in M } y_i (w \bullet x_i + b)
$$

> $\frac{1}{||w||}$ 值是固定的。<?>

这样就得到了感知机学习的 **`loss_function`**。根据我们的定义，loss_function自然是越小越好，因为这样就代表着 误分类点 越少、误分类点 距离超平面 $S$ 的距离越近，即我们的分类越正确。显然，这个 **`loss_function`** 是非负的，若所有的样本都分类正确，那么我们的**`loss_function`** 值为0。一个特定的样本集 $T$ 的损失函数：在误分类时是参数  $w$ 、 $b$ 的线性函数。也就是说，为求得正确的参数 $w，b$，我们的目标函数为

$$
\min \limits_{w, b} L(w, b) = -\sum_{x_i \in M } y_i (w \bullet x_i + b)
$$

`loss_function` $L(w, b)$ 是  $w, b$ 的连续可导函数. 

> ?

The learning strategy of the perceptron model is to select the model parameters $w, b$ for minimize loss function in the hypothesis space.


## 3. Perceptron learning algorithm

根据感知机学习的策略，我们将寻找超平面 $S$ 的问题转化为求解  

$$
\min \limits_{w, b} L(w, b) = -\sum_{x_i \in M } y_i (w \bullet x_i + b)
$$

的最优化问题，最优化的方法是随机梯度下降法.

**随机梯度下降法两种形式 :**

- 原始形式
- 对偶形式

并证明了在 train_sets 线性可分时 算法的收敛性。

### 3.1 原始形式

所谓原始形式，就是我们用梯度下降的方法，对 $w$ 和 $b$ 进行不断的迭代更新。具体来说，就是先任意选取一个超平面 $S_0$ ，对应的参数分别为 $w_0$ 和 $x_0$ ，当然现在是可以任意赋值的，比如说选取 $w_0$ 为全为 0 的向量， $b$ 的值为0,  然后用梯度下降不断地极小化 损失函数。由于随机梯度下降（stochastic[stə'kæstɪk] gradient descent）的效率要高于批量梯度下降（batch gradient descent）（ [Andrew Ng，在Part 1的LMS algorithm部分讲义](http://cs229.stanford.edu/notes/cs229-notes1.pdf)），所以这里采用随机梯度下降的方法，每次随机选取一个误分类点对 $w$ 和 $b$ 进行更新。

设误分类点集合  $M$ 是固定的，为求 *loss_function* 的最小值，我们需要知道往哪个方向下降速率最快，这是可由对损失函数 $L(w, b)$ 求梯度得到，$L(w, b)$ 的梯度为

$$
\nabla_w L(w, b) = -\sum_{x_i \in M } y_i x_i
$$

$$
\nabla_b L(w, b) = -\sum_{x_i \in M } y_i
$$

> ?

接下来随机选取一个 误分类点 $(x_i, y_i)$ 对 $w$ , $b$ 进行更新 :

$$
w \leftarrow w + \eta y_i x_i
$$

$$
b \leftarrow b + \eta y_i
$$

其中 $\eta (0 \lt \eta \le 1)$  为步长，也称为学习速率（learning rate），一般在0到1之间取值，步长越大，我们梯度下降的速度越快，也就能更快接近极小点。如果步长过大，就有直接跨过极小点导致函数发散的问题；如果步长过小，可能会耗费比较长的时间才能达到极小点。通过这样的迭代，我们的损失函数就不断减小，直到为0。综上所述，得到如下算法：

**算法1 (感知机学习算法的原始形式)**

输入 : 训练数据集 

$$
T = \{ (x_1, y_1), (x_2, y_2), ... , (x_N, y_N) \}
$$ 


输出 : $w，b$ ; 感知机模型 $
f(x) = sign (w \bullet x + b)
$

（1）选取初始值，$w_0, b_0$

（2）在训练集中选取数据 $(x_i, y_i)$

（3）如果 $y_i(w \bullet x_i + b) \le 0$

$$
w \leftarrow w + \eta y_i x_i
$$

$$
b \leftarrow b + \eta y_i
$$

（4）转至（2），直至训练集中没有误分类点

这种学习算法直观上有如下解释：当一个样本被误分类时，就调整 $w$ 和 $b$ 的值，使超平面 $S$ 向误分类点的一侧移动，以减少该误分类点到超平面的距离，直至超平面越过该点使之被正确分类。

> 凡是只讲理论不给例子的行为都是耍流氓！

例1 : 如图3所示的训练数据集，其正实例点是 $x_1 = (3, 3)^T$, $x_2 = (4, 3)^T$, 负实例点是 $x_3 = (1, 1)^T$, 试用 Perceptron learning algorithm 的原始形式 求 Perceptron model，即求出 $w$ 和 $b$。这里，

<p align="center">![图3](http://images.cnitblog.com/blog/414721/201304/12175006-26817264c38a47f5b93d2f56aee2f9d1.png)

### 3.2 算法收敛性

纯数学的东西，Novikoff于1962年证明了感知机算法的收敛性，具体请参见 哥伦比亚大学有这样的一篇叫 [《Convergence Proof for the Perceptron Algorithm》](http://www.cs.columbia.edu/~mcollins/courses/6998-2012/notes/perc.converge.pdf) 讲解了这个定理的证明过程


### 3.3 对偶形式

对偶形式的基本想法是，将 $w$ 和 $b$ 表示为实例和的 线性组合形式，通过求解其系数而求得 $w$ 和 $b$.

> 2016-06-22 第 18 周, 我欠下的债...

[更多参见.][1]

## 4. 小结

虽然大部分是抄书，但是自己整理出来，对以后复习 有莫大的好处。

本章介绍了统计学习中最简单的一种算法——感知机，但是 它是很多现在流行算法的基础，比如 Neural network、 SVM、etc..

[感知机和多分类](http://wenku.baidu.com/view/27b97e69b84ae45c3b358cb0)




  [1]: https://book.douban.com/subject/10590856/
  [2]: http://weibo.com/u/2060750830
  [3]: https://en.wikipedia.org/wiki/Perceptron
  [6]: http://images.cnitblog.com/blog/414721/201304/11142837-31e4844d63c2478e8f978af1ebd59512.png
  [7]: http://images.cnitblog.com/blog/414721/201304/11153222-be953a21074145b880ace08984b4f788.png


