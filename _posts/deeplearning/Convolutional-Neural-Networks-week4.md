---
title: CNN (week4) - Face recognition & Neural style transfer
toc: true
date: 2018-09-08 15:00:21
categories: deeplearning
tags: deeplearning.ai
---

Face recognition & Neural style transfer 能够在图像、视频以及其他 2D 或 3D 数据上应用这些算法。

<!-- more -->

## 1. What is face recognition?

这一节中的人脸识别技术的演示的确很NB..., 演技不错，😄

<img src="/images/deeplearning/C4W4-1_1.png" width="750" />

## 2. One Shot Learning

作为老板希望与时俱进，所以想使用人脸识别技术来实现打卡。

假如我们公司只有4个员工，按照之前的思路我们训练的神经网络模型应该如下：

<img src="/images/deeplearning/C4W4-2.jpg" width="550" />

> 如图示，输入一张图像，经过CNN，最后再通过 Softmax 输出 5 个可能值的大小 (4个员工中的一个，或者都不是，所以共5种可能性)。
>
> 看起来好像没什么毛病，但是我们要相信我们的公司会越来越好啊，所以难道公司每增加一个人就要重新训练**CNN** 及 最后一层的输出数量吗 ？

**one-shot：**

这显然有问题，所以有人提出了一次学习(one-shot)，更具体地说是通过一个函数来求出输入图像与数据库中的图像的差异度，用 $d(img1,img2)$ 表示。

<img src="/images/deeplearning/C4W4-3_1.png" width="750" />

如上图示，如果两个图像之间的差异度不大于某一个阈值 **τ**，那么则认为两张图像是同一个人。反之，亦然。

> 下一小节介绍了如何计算差值。

## 3. Siamese Network

注意：下图中两个网络参数是一样的。

先看上面的网络。记输入图像为 $x^{(1)}$，经过卷积层，池化层 和 全连接层 后得到了箭头所指位置的数据 (一般后面还会接上 $softmax$ 层，但在这里暂时不用管)，假设有 **128** 个节点，该层用 $f(x^{(1)})$ 表示，可以理解为输入 $x^{(1)}$ 的编码。

那么下一个网络同理，不再赘述。

因此上一节中所说的差异度函数即为

$$
d(x^{(1)},x^{(2)})=||f(x^{(1)})-f(x^{(2)})||^2
$$

<img src="/images/deeplearning/C4W4-4_1.png" width="750" />

问题看起来好像解决了，但感觉还漏了点什么。。**神经网络的参数咋确定啊？也就是说 $f(x^{(i)})$ 的参数怎么计算呢？**

首先可以很明确的是如果两个图像是同一个人，那所得到的参数应该使得 $||f(x^{(1)})-f(x^{(2)})||^2$ 的值较小，反之较大。

<img src="/images/deeplearning/C4W4-5_1.png" width="750" />

## 4. Triplet Loss

### 4.1 Learning Objective

这里首先介绍一个三元组，即 **(Anchor, Positive, Negative)，简写为(A,P,N)**

(A,P,N) | 三元组 各个含义
:-------:  | :-------: 
Anchor | 可以理解为用于识别的图像 （锚）
Positive | 表示是这个人
Negative | 表示不是同一个人

由上一节中的思路，我们可以得到如下不等式：

> $d(A,P)\leqq d(A,N)$, 即 $||f(A)-f(P)||^2-||f(A)-f(N)||^2\leqq0$ (如下图示)

<img src="/images/deeplearning/C4W4-6_1.png" width="750" />

但是这样存在一个问题，即如果神经网络什么都没学到，返回的值是0，也就是说如果 $f(x)=\vec{0}$ 的话，那么这个不等式是始终成立的。(如下图示)

<img src="/images/deeplearning/C4W4-7_1.png" width="750" />

为了避免上述特殊情况，且左边值必须小于0，所以在右边减去一个变量**α**，但按照惯例是加上一个值，所以将**α**加在左边。

<img src="/images/deeplearning/C4W4-8_1.png" width="750" />

<img src="/images/deeplearning/C4W4-9_1.png" width="750" />

综上，所得到的参数需要满足如下不等式

$$
||f(A)-f(P)||^2-||f(A)-f(N)||^2+α\leqq0
$$

### 4.2 Lost function

介绍完三元组后，我们可以对单个图像定义如下的损失函数(如下图示)

$$
L(A,P,N)=max(||f(A)-f(P)||^2-||f(A)-f(N)||^2+α,0)
$$

> 解释一下为什么用**max**函数，因为如果只要满足 $||f(A)-f(P)||^2-||f(A)-f(N)||^2+α\leqq0$，我们就认为已经正确识别出了图像中的人，所以对于该图像的损失值是 0.

<img src="/images/deeplearning/C4W4-10_1.png" width="750" />

所以总的损失函数是 : $J=\sum{L(A^{(i)},P^{(i)},N^{(i)})}$

要注意的是使用这种方法要保证每一个人不止有一张图像，否则无法训练。另外要注意与前面的 **One-shot** 区分开来，这里是在训练模型，所以训练集的数量要多一些，每个人要有多张照片。而One-shot是进行测试了，所以只需一张用于输入的照片即可。

### 4.3 Choosing the triplets(A,P,N)

还有一个很重要的问题就是如何选择三元组 **(A,P,N)**。因为实际上要满足不等式 $d(A,P)+α\leqq d(A,N)$ 是比较简单的,即只要将 Negative 选择的比较极端便可，比如 Anchor 是一个小女孩，而 Negative 选择一个老大爷。

所以还应该尽量满足 $d(A,N)\approx{d(A,N)}$

<img src="/images/deeplearning/C4W4-11_1.png" width="750" />

## 5. Face Verification and Binary Classification

通过以上内容，我们可以确定下图中的网络的参数了，那么现在开始进行面部验证了。

**上面的是测试图，下面的是数据库中的一张照片**

和之前一样假设 $f(x^{(i)})$ 有 128个节点，之后这两个数据作为输入数据输入到后面的逻辑回归模型中去，即

$$
\hat{y} = σ(\sum\_{k=1}^{128}w\_i|f(x^{(i)})\_k-f(x^{(j)})\_k|+b\_i)
$$

若 $\hat{y}=1$, 为同一人。反之，不是。

如下图示，绿色下划线部分可以用其他公式替换，即有

$$
\hat{y}=σ(\sum\_{k=1}^{128}w\_i \frac{(f(x^{(i)})\_k-f(x^{(j)})\_k)^2}{f(x^{(i)})\_k+f(x^{(j)})\_k}+b\_i)
$$

<img src="/images/deeplearning/C4W4-12_1.png" width="750" />

当然数据库中的图像不用每次来一张需要验证的图像都重新计算，其实可以提前计算好，将结果保存起来，这样就可以加快运算的速度了。

<img src="/images/deeplearning/C4W4-13_1.png" width="750" />

## 6. What is neural style transfer?

<img src="/images/deeplearning/C4W4-14_1.png" width="750" />

## 7. What are deep ConvNets learning?

<img src="/images/deeplearning/C4W4-15_1.png" width="750" />

> 第一层只能看到小部分卷积神经.
> 
> 你选择一个隐藏单元，发现有9个图片，最大化了单元激活，你可能找到类似这样的图片浅层区域.

<img src="/images/deeplearning/C4W4-16_1.png" width="750" />

## 8. Cost Function

如下图示：

<img src="/images/deeplearning/C4W4-17_1.png" width="750" />

左上角的包含 Content 的图片简称为 C，右上角包含 Style 的简称 S，二者融合后得到的图片简称为 G。

我们知道计算问题须是有限的，所以融合的标准是什么？也就是说 Content 的保留程度和 Style 的运用程度如何取舍呢？

此时引入损失函数，并对其进行最优化，这样便可得到最优解。

$$
J(G)=αJ\_{Content}(C,G)+βJ\_{Style}(S,G)
$$

> $J(G)$ 定义用来生成图像的好坏，$J\_{Content}(C,G)$ 表示 图像$C$ 和 图像$G$ 之间的差异，$J\_{Style}(S,G)$ 同理。

**计算过程示例**：

> 随机初始化图像 $G$，假设为 100\*100\*3 （maybe 500\*500\*3） (如下图右边四个图像最上面那个所示)
> 
> 使用梯度下降不断优化 $J(G)$。 (优化过程如下图右边下面3个图像所示)

<img src="/images/deeplearning/C4W4-18_1.png" width="750" />

> 下面一小节将具体介绍 **Cost Function** 的计算。

## 9. Content Cost Function

首先假设我们使用 **第 $l$ 层** 隐藏层 来计算 $J\_{Content}(C,G)$，注意这里的 **$l$** 一般取在中间层，而不是最前面的层，或者最后层

> 原因如下：
>
> - 假如取**第1层**，那么得到的 $G$ 图像 将会与 图像$C$ 像素级别的相似，这显然不行。
> - 假如取很深层，那么该层已经提取出了比较重要的特征，例如 图像$C$ 中有一条狗，那么得到的 图像$G$ 会过度的保留这个特征。

- 然后使用预先训练好的卷积神经网络，如 VGG网络。这样我们就可以得到 图像$C$ 和 图像$G$ 在第$l$层的激活函数值，分别记为 $a^{[l][C]},a^{[l][G]}$
- 内容损失函数 $J\_{Content}(C,G) = \frac{1}{2} || a^{[l][C]} - a^{[l][G]} ||^2$

<img src="/images/deeplearning/C4W4-19_1.png" width="750" />

## 10. Style Cost Function

### 10.1 什么是“风格”

要计算风格损失函数，我们首先需要知道“风格(Style)”是什么。

我们使用 $l$ 层的激活来度量“Style”，将“Style”定义为通道间激活值之间的**相关系数**。(**Define style as correlation between activation across channels**)

<img src="/images/deeplearning/C4W4-20_1.png" width="750" />

那么我们如何计算这个所谓的相关系数呢？

下图是我们从上图中所标识的第 $l$ 层，为方便说明，假设只有 5 层通道。

<img src="/images/deeplearning/C4W4-21_1.png" width="350" />

如上图示，红色通道和黄色通道对应位置都有激活项，而我们要求的便是它们之间的**相关系数**。

但是为什么这么求出来是有效的呢？为什么它们能够反映出风格呢？

继续往下看↓

### 10.2 图像风格的直观理解

如图风格图像有 **5** 层通道，且该图像的可视化特征如 <font color="blue">左下角图</font> 所示。

<img src="/images/deeplearning/C4W4-22_1.png" width="800" />

其中红色通道可视化特征如图中**箭头**所指是**垂直条纹**，而**黄色通道的特征则是橘色背景**。
<!--<img src="/images/deeplearning/C4W4-22_2.png" width="750" />
-->
那么通过计算这两层通道的相关系数有什么用呢？

> 其实很好理解，如果**二者相关系数性强，那么如果出现橘色背景，那么就应该很大概率出现垂直条纹**。反之，亦然。

### 10.3 风格相关系数矩阵

令 $a\_{i,j,k}^{[l]}$ 表示 **(i,j,k)** 的激活项，其中 **i,j,k** 分别表示高度值(H)，宽度值(W) 及 所在通道层次(C)。

风格矩阵(也称为“**Gram Matrix**”)用 $G^{[l]}$ 表示，其大小为 $n\_c^{l]}*n\_c^{l]}$.

因此风格图像的风格矩阵为：

$$
G\_{kk'}^{[l](S)}=\sum\_{i=1}^{n\_H^{[l]}}\sum\_{j=1}^{n\_W^{[l]}}a\_{i,j,k}^{[l](S)}a\_{i,j,k'}^{[l](S)}
$$

生成图像的相关系数矩阵

$$
G\_{kk'}^{[l](G)}=\sum\_{i=1}^{n\_H^{[l]}}\sum\_{j=1}^{n\_W^{[l]}}a\_{i,j,k}^{[l](G)}a\_{i,j,k'}^{[l](G)}
$$

<img src="/images/deeplearning/C4W4-23_1.png" width="750" />

### 10.4 风格损失函数

<img src="/images/deeplearning/C4W4-24_1.png" width="750" />

第 $l$ 层的风格损失函数为：

$$
J\_{Style}^{[l]} (S, G) = \frac {1} { (2n\_H^{[l]} n\_W^{[l]} n\_C^{[l]})^2 } \sum\_{k}\sum\_{k'} (G\_{kk'}^{[l]\(S\)} - G\_{kk'}^{[l]\(G\)})
$$

总的风格损失函数：

$$
J\_{Style}(S,G) = \sum\_{l}λ^{[l]}J\_{Style}C4^{[l]}(S,G)
$$

## 11. 1D and 3D Generalizations

1D generalizations of models

<img src="/images/deeplearning/C4W4-25_1.png" width="750" />

3D generalizations of models

<img src="/images/deeplearning/C4W4-26_1.png" width="750" />

> 医学图像 与 视频检测 都是 3D 的.

## Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][2]

[1]: https://study.163.com/my#/smarts
[2]: http://www.cnblogs.com/marsggbo/p/7470989.html
