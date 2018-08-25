---
title: Convolutional Neural Networks (week1) - CNN
toc: true
date: 2018-08-21 10:00:21
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

-	理解如何搭建一个神经网络，包括最新的变体，例如残余网络。
-	知道如何将卷积网络应用到视觉检测和识别任务。
-	知道如何使用神经风格迁移生成艺术。
-	能够在图像、视频以及其他2D或3D数据上应用这些算法。

<!-- more -->

## 1. Computer vision

<img src="/images/deeplearning/C4W1-1_1.png" width="700" />

<img src="/images/deeplearning/C4W1-2_1.png" width="700" />

> 如图示，之前课程中介绍的都是 64 \* 64 \* 3的图像 (**3 代表**:因为每个图片都有3个颜色通道 channels, 12288 So $X$, **the input features has dimension 12288**)，而一旦图像质量增加，例如变成 1000 \* 1000 \* 3 的时候那么此时的神经网络的计算量会巨大，显然这不现实。所以需要引入其他的方法来解决这个问题.

## 2. Edge detection example

使用边缘检测作为入门样例, you see how the convolution operation works.

<img src="/images/deeplearning/C4W1-3_1.png" width="700" />

> 边缘检测可以是垂直边缘检测，也可以是水平边缘检测，如上图所示.

至于算法如何实现，下面举一个比较直观的例子：

<img src="/images/deeplearning/C4W1-4_1.png" width="700" />

> 可以很明显的看出原来 6 \* 6 的矩阵有明显的垂直边缘，通过 3 \* 3 的过滤器 **filter** (也叫做 “核”)卷积之后，仍然保留了原来的垂直边缘特征，虽然这个边缘貌似有点粗，这是因为数据不够大的原因，如果输入数据很大的话这个不是很明显了.
> 
> 关于用编程语言实现：python / tensorflow / keras 等，都有一些函数来实现卷积运算.

## 3. More edge detection

<img src="/images/deeplearning/C4W1-5_1.png" width="700" />

除了上面的垂直，水平边缘检测，其实也可以检测初颜色过度变化，例如是亮变暗，还是暗变亮？

<img src="/images/deeplearning/C4W1-5_2.png" width="600" />

**在计算机视觉的历史上，层曾经公平的争论过哪些什么样的 `filter` 数字组合才是最好的:
**
> **下面是一些常见的过滤器，第二个是`Sobel filter`，具有较强的鲁棒性，第三个是`Schoss filter`.**

<img src="/images/deeplearning/C4W1-6_1.png" width="700" />

Filter | desc
:-------: | :-------:
Sobel Filter | it puts a little bit more weight to the central row <br> 增加了中间一行的权重
Schoss Filter | 实际它也是一种垂直边缘检测 <br> 翻转90度，它就变为水平边缘检测 
Other Filter | 9个参数也可以通过学习(反向传播)的方式获得 

> 其实过滤器的9个参数也可以通过学习(反向传播)的方式获得，虽然比较费劲，但是可能会学到很多其他除了垂直，水平的边缘特征，例如  45°，70° 等各种特征.

## 4. Padding

> **由前面的例子, 卷积的方法，有2个缺点:**
>
> 1. 每经过一次卷积计算，原数据都会减小，但有时我们并不希望这样。举个比较极端的例子：假设原数据是 30 \* 30 的一只猫的图像，经过10次卷积 (过滤器是3 \* 3) 后，最后图像只剩下了 10 \* 10 了 😳😳
>
> 2. 由卷积的计算方法可知，图像边缘特征计算次数显然少于图像中间位置的像素点，如下图示 (绿色的位置明显是冷宫), 图像边缘的大部分信息都丢失了.

### 4.1 运用 Padding 的原因

<img src="/images/deeplearning/C4W1-7_1.png" width="500" />

原来的 6 \* 6 填充后变成了 8 \* 8，此时在经过一次卷积得到的仍旧是 6 \* 6 的矩阵。

下面总结一下卷积之后得到矩阵大小的计算方法，假设：

Title | Size | desc
:-------: | :-------: | :-------: 
原数据 | $n \* n$ | 矩阵 $n \* n$ 
Filter | $f \* f$ | 过滤器
Padding | $p \* p$ | 填充数量
| |
**综上：** | **$n+2p-f+1$** | 得到的矩阵大小

> padding 后，虽然边缘像素点仍旧计算的比较少，但是这个缺点至少一定程度上被削弱了.

### 4.2 如何 padding 的大小

Type | desc | Size
:-------: | :-------: | :-------: 
Valid convolutions | 不添加 padding | $n - f + 1$
Same convolutions | Pad so that output size is the same as the input size. <br><br> 保持原图像矩阵的大小 | 满足 $n+2p-f+1 = n$ <br><br> 即 $p=\frac{f-1}{2}$, 为了满足上式，$f$ 一般奇数

## 5. Strided convolutions

过滤器 纵向、横向 都需要按 步长 $S$ 来移动，如图示:

<img src="/images/deeplearning/C4W1-8_1.png" width="700" />

结合之前的内容，输出矩阵大小计算公式方法为，假设：

Title | Size | desc
:-------: | :-------: | :-------: 
原数据 | $n \* n$ | 矩阵 $n \* n$ 
Filter | $f \* f$ | 过滤器
Padding | $p \* p$ | 填充数量
Stride | $s \* s$ | 步长
| |
**综上：** | 得到的矩阵大小是 | **⌊$\frac{n+2p-f}{s}$⌋ \* ⌊$\frac{n+2p-f}{s}$⌋**

> ⌊⌋: 向下取整符号 ⌊59/60⌋ = 0
>
> ⌈⌉: 向上取整符号 ⌈59/60⌉ = 1

## 6. Convolutions over volumes

这一节用立体卷积来解释

<img src="/images/deeplearning/C4W1-9_1.png" width="700" />

> **如图**:
>
> - 输入矩阵是 $6 \* 6 \* 3$ (height \* width \* channels), 过滤器是 $3 \* 3 \* 3$，计算方法是一一对应相乘相加
> - 最后得到 $4 \* 4$ 的二维矩阵.
>
> 有时可能需要检测 水平边缘 或 垂直边缘，或 其他特征，所以我们可以使用多个过滤器。上图则使用了两个过滤器 (黄色和橘黄色)，得到的特征矩阵大小为 $4 \* 4 \* 2$.
> 
> **Filter** 数字组合参数的选择不同，你可以得到不同的特征检测器.

## 7. One layer of a convolutional network

<img src="/images/deeplearning/C4W1-10_1.png" width="700" />

如图示得到 $4 \* 4$ 的矩阵后还需要加上一个偏差 $b\_n$ (Python 广播机制)，之后还要进行非线性转换，即用 ReLU 函数.

因此假如在某一卷积层中使用了 10 个 3 \* 3 的过滤器，那么一共有 $(3\*3+1)\*10=280$ 个参数.

<img src="/images/deeplearning/C4W1-11_1.png" width="700" />

下面总结了各项参数的大小和表示方法：

Title | Formula | desc 
:-------:  | :-------: | :-------: 
过滤器大小 | $f^{[l]}$ |
填充 padding | $p^{[l]}$ |
步长 stride | $s^l$ |
激活函数 | $a^{l}$ = $n\_H^{l} \* n\_W^{l} \* n\_c^{l}$ |
权重 weight | $f^{l} \* f^{l} \* n\_c^{[l-1]} \* n\_c^{[l]}$ |
偏差 bias | $1 \* 1 \* 1 \* n\_c^{[l]}$ |
输入矩阵 | $n\_H^{l-1} \* n\_W^{l-1} \* n\_c^{l-1}$ | height \* width \* channels
| | 每一卷积层的过滤器的通道的大小 = 输入层的通道大小
输出矩阵 | $n\_H^{l} \* n\_W^{l} \* n\_c^{l}$ | height \* width \* channels
| | 输出层的通道的大小 = 过滤器的个数

输出层与输入层计算公式：

$$
n\_{H/W}^{[l]}=[\frac{n\_{H/W}^{[l-1]}+2p^{[l]}-f^{[l]}}{s^{[l]}}+1]
$$

## 8. A simple convolution network example

## 9. Pooling layers


最大池化很少用 padding

## 10. Convolutional neural network example

## 11. Why Convolutions ?

## Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][2]

[1]: https://study.163.com/my#/smarts
[2]: http://www.cnblogs.com/marsggbo/p/7470989.html
