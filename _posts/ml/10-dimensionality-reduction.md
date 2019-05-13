---
title: Dimensionality Reduction： PCA
toc: true
date: 2019-04-21 17:01:21
categories: machine-learning
tags: PCA
---

<img src="/images/logo/pca-lg1.png" width="550" />

<!-- more --><br>

常见的 Dimensionality Reduction 方法： PCA、LDA 等。 [PCA主成分分析](https://terrifyzhao.github.io/2018/06/30/PCA主成分分析.html)

Machine Learning 中的数据维数 与 现实世界中的空间维度本同末离。在 Machine Learning 中，数据通常需要被表示成向量形式以输入模型进行训练。用一个 **低维度的向量** 表示原始 **高纬度的特征** 显得尤为重要。 

降维的好处很明显，它不仅可以数据减少对内存的占用，而且还可以加快学习算法的执行

## 1. Motivation

如果我们有许多冗余的数据，我们可能需要对特征量进行降维(Dimensionality Reduction)

### 1.1 Data Compression

![一个2维到1维的例子][tu1]

如图10-2所示的3维到2维的例子，通过对x1,x2,x3的可视化，发现虽然样本处于3维空间，但是他们大多数都分布在同一个平面中，所以我们可以通过投影，将3维降为2维。

![一个3维到2维的例子][tu2]

### 1.2 Visualization

特征量维数大于3时，我们几乎不能对数据进行可视化。所以，有时为了对数据进行可视化，我们需要对其进行降维。我们可以找到2个或3个具有代表性的特征量，他们(大致)可以概括其他的特征量。

例如，描述一个国家有很多特征量，比如GDP，人均GDP，人均寿命，平均家庭收入等等。

![Visualization][tu3]

## 2. Principal Component Analysis

主成分分析(Principal Component Analysis : PCA)是最常用的降维算法。

### 2.1 Problem formulation

首先我们思考如下问题，对于正交属性空间(对2维空间即为直角坐标系)中的样本点，如何用一个超平面(直线/平面的高维推广)对所有样本进行恰当的表达？

事实上，若存在这样的超平面，那么它大概应具有这样的性质：

- `最近重构性` : 样本点到这个超平面的距离都足够近；
- `最大可分性` : 样本点在这个超平面上的投影能尽可能分开。

![样本在3维正交空间的分布][tu4]

> 对当前样本而言，s1平面比s2平面的最近重构性要好（样本离平面的距离更近）；

![样本投影在2维平面后的结果][tu5]

> 对当前样本而言，s1平面(左边) 比s2平面的最大可分性要好(样本点更分散)。
>
> 总结: 让上面的例子也说明了 **最近重构性** 和 **最大可分性** 可以同时满足。分别以最近重构性和最大可分性为目标，能够得到 **PCA 的两种等价推导**。

**丢失信息对比：**

> s2平面 进行投影降维，我们会丢失更多（相当多）的特征量信息，因为它的投影结果甚至可以在转化为1维。
> 
> 而 s1平面 上的投影包含更多的信息(丢失的更少)。

**将特征量从n维降到k维：**

> 1. 以最近重构性为目标，PCA的目标是找到k个向量，将所有样本投影到这k个向量构成的超平面，使得**投影的距离最小**（或者说投影误差projection error最小）。
> 
> 2. 以最大可分性为目标，PCA的目标是找到k个向量，将所有样本投影到这k个向量构成的超平面，使得**样本点的投影能够尽可能的分开**，也就是使投影后的**样本点方差最大化**。

摘要：

> PCA 与 线性回归 有一点相似，但是他们是2种不同的算法.
>
> [good CSDN 主成分分析PCA之协方差矩阵的理解](https://blog.csdn.net/u014665013/article/details/78669835)
>
> [知乎: 如何直观地理解「协方差矩阵」？](https://zhuanlan.zhihu.com/p/37609917)

> 方差是用来度量单个随机变量的离散程度，而协方差则一般用来刻画两个随机变量的相似程度.

### 2.2 PCA Algorithm

输入： 

> 训练集 $x^{(1)}, x^{(2)}, ..., x^{(m)}$ 和 低维空间维数 $k$

过程：

> (1) 数据预处理：对所有样本进行中心化(即使得样本和为0)
>
> <img src="/images/ml/pca-7.png" width="350" />
>
> (2) 计算样本的协方差矩阵
>
> <img src="/images/ml/pca-8.png" width="350" />
> 
> (3) 对2中求得的协方差矩阵Sigma进行特征值分解
> 
>   &nbsp;&nbsp;&nbsp;&nbsp;在实践中通常对协方差矩阵进行 **SVD分解** 代替 特征值分解.
> $$
    [U, S, V] = svd(Sigma);
> $$
>
> (4) 取最大的k个特征值所对应的特征向量 $u^{(1)}, u^{(2)}, ..., u^{(k)}$


### 2.3 Choosing the Number of Principal Components

如何选择k（又称为主成分的个数）的值？

首先，试想我们可以使用PCA来压缩数据，我们应该如何解压？或者说如何回到原本的样本值？事实上我们可以利用下列等式计算出原始数据的近似值Xapprox：

### 2.4 Advice for Applying PCA  

1. PCA 通常用来加快监督学习算法.
 
2. PCA 应该只是通过 **训练集的特征量** 来获取 投影矩阵 Ureduce，而不是交叉检验集或测试集。
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;但是获取到 Ureduce 之后可以应用在交叉检验集和测试集。
3. 避免使用 PCA 来防止 overfiting，PCA 只是对 特征 $X$ 进行降维，并没有考虑 $Y$ 的值；
4. 不应在项目开始就用PCA: 花大量时间来选择k值，可能项目并不需用PCA来降维。同时降维定会丢失一些信息。
5. 仅在需用 PCA 的时使用 PCA: 降维丢失的信息可能在一定程度上是噪声，使用 PCA 可以起到一定的去噪效果。
6. PCA 通常用来 Data Compression 以加快算法，减少内存使用或磁盘占用，或者用于可视化(k=2, 3)。

[tu1]: /images/ml/pca-1.png
[tu2]: /images/ml/pca-2.png
[tu3]: /images/ml/pca-3.png
[tu4]: /images/ml/pca-4.png
[tu5]: /images/ml/pca-5.png
[tu6]: /images/ml/pca-6.png

## Reference article

- 百面机器学习
- [Stanford Machine Learning][1]
- [网易云课堂][2]

[1]: https://www.cnblogs.com/llhthinker/p/5522054.html
[2]: https://study.163.com/course/courseLearn.htm?courseId=1004570029#/learn/video?lessonId=1052320898&courseId=1004570029

