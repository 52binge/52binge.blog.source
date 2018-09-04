---
title: Convolutional Neural Networks (week3) - Object detection
toc: true
date: 2018-09-01 15:00:21
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

知道如何将卷积网络应用到视觉检测和识别任务。 知道如何使用神经风格迁移生成艺术。

<!-- more -->

## 1. Object Localization

这一小节视频主要介绍了我们在实现目标定位时标签该如何定义

<img src="/images/deeplearning/C4W3-1_1.png" width="750" />

输出 softmax 的同时，在输出4个值 $b\_x,b\_y,b\_w,b\_h$, 边界框的具体位置 （图片左上角坐标为 (0, 0)， 右下角为 (1, 1) )

> 在上面的例子中，$b\_x$ 的值大约为 0.5，$b\_y$ 的值大约为 0.7，最佳位置.

**how we define the target label $y$ for this as a supervised learning task.**

<img src="/images/deeplearning/C4W3-2_1.png" width="750" />

> 上图左下角给出了损失函数的计算公式 (这里使用的是平方差)
>
> 注意: 我们假设图像中存在这三者 (**pedestrian**，**car**，**motorcycles**) 中的一种 或者 都不存在，所以共有四种可能.

$P\_c=1$ **表示有三者中的一种**

- $C\_1=1$ 表示有 pedestrian，反之没有

- $C\_2=1$ 表示有 car

- $C\_3=1$ 表示有 motorcycles

$b\_\*$ **用于标识所识别食物的位置**

- $b\_x,b\_y$: 表示识别物体的中心坐标

- $b\_w,b\_h$: 表示识别物体的宽和高

<img src="/images/deeplearning/C4W3-3.png" width="450" />

> 注意: $P\_c=0$ 表示三者都没有，所以此时 $C\_\*,b\_\*$ 的值我们并不在乎了.
> 
> 为了让大家便于了解对象定位的细节，这里我用平方误差简化了描述过程. (实际应用中 $P\_c$ 更多是应用逻辑回归函数)

## 2. Landmark Detection

特征点检测，这一节的内容和上一节感觉很类似.

<img src="/images/deeplearning/C4W3-4_1.png" width="750" />

要输出眼角的位置，你可以让神经网络输出的最后一层，多输出 2 个数字 $l\_x, l\_y$.

## 3. Object Detection

<img src="/images/deeplearning/C4W3-5_1.png" width="750" />

目标检测常使用的是滑动窗口技术检测，即使用一定大小的窗口按照指定的步长对图像进行遍历

<img src="/images/deeplearning/C4W3-6.jpg" width="750" />

因为图像中车辆的大小我们是不知道的，所以可以更改窗口大小，从而识别并定位出车辆的位置。

<img src="/images/deeplearning/C4W3-7_1.png" width="750" />

<img src="/images/deeplearning/C4W3-8_1.png" width="750" />

## 4. Convolutional Implementation of Sliding Windows

> 注意：该节视频的例子和上一节一样，都是识别图像中是否有 pedestrian，car，motorcycles，background，所以最后输出y是 4个节点

### 4.1 全连接层→卷积层

在介绍卷积滑动窗口之前我们首先要知道如何把神经网络的**全连接层**转化成**卷积层**，下面是使用了全连接层的网络结构

<img src="/images/deeplearning/C4W3-9_1.png" width="750" />

那么如何将**全连接层转化成卷积层**呢？如下图示

<img src="/images/deeplearning/C4W3-10_1.png" width="750" />

我们可以看到经过 Max Pooling 之后的数据大小是 (5, 5, 16), 第一个FC层是400个节点。我们可以使用400 个 5\*5 的过滤器进行卷积运算，随后我们就得到了 (1, 1, 400)的矩阵。

第二个FC层也是400个节点，由之前的 1\*1 过滤器的特点，我们可以使用400个 1\*1 的过滤器，也可以得到(1,1,400)的矩阵。至此，我们已经成功将全连接层转化成了卷积层。

### 4.2 卷积滑动窗口实现

目标检测一节中介绍了滑动窗口。要实现窗口遍历，那么就需要很大的计算量，看起来似乎可操作性不强。But！这怎么可能难倒哪些newB的大神们呢，他们自然有办法。

首先我们先看下图，这个就是上面提到的将全连接层转化成卷积层的示意图，只不过画的看起来更正规一些了2333，但是有个需要提醒的是吴大大为了方便只花了平面图，就没有画出3D的效果了。

<img src="/images/deeplearning/C4W3-11_1.png" width="750" />

下面，假设我们的测试图大小是16*16，并令滑动窗口大小是14*14的(为了方便理解，下图用蓝色清楚地表明了14*14窗口的大小),步长是2，所以这个测试图可以被窗口划分成4个部分。随后和上面执行一样的操作，最后可以得到(2,2,4)的矩阵，此时我们不难看出测试图被滑动窗口选取的左上角部分对应的结果也是输出矩阵的左上角部分，其他3个部分同理。

所以这说明了什么？

说明我们没有必要用滑动窗口截取一部分，然后带入卷积网络运算。相反我们可以整体进行运算，这样速度就快很多了。

<img src="/images/deeplearning/C4W3-12_1.png" width="750" />

下图很清楚的展示了卷积滑动窗口的实现。我们可以看到图片被划分成了64块

<img src="/images/deeplearning/C4W3-13_1.png" width="750" />

<img src="/images/deeplearning/C4W3-14_1.png" width="750" />

## 5. Bounding Box Predictions

上面介绍的滑动窗口方法存在一个问题就是很多情况下滑动窗口并不能很好的切割出车体，如下图示：

<img src="/images/deeplearning/C4W3-16_1.png" width="750" />

为了解决这个问题，就有了**YOLO(you only look once)**算法，即只需要计算一次便可确定需要识别物体的位置的大小。

原理如下：

首先将图像划分成 3\*3 (即9份)，每一份最后由一个向量表示，这个向量在本文最前面介绍过，即

$$
y=[P\_c,b\_x,b\_y,b\_h,b\_w,c\_1,c\_2,c\_3]
$$



因为有9份，所以最后输出矩阵大小是(3,3,8),如下图示：

## 6. Intersection Over Union

## 7. Non-max Suppression

## 8. Anchor Boxes

## 9. YOLO Algorithm

## 10. (Optional) Region Proposals
​
## Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][2]

[1]: https://study.163.com/my#/smarts
[2]: http://www.cnblogs.com/marsggbo/p/7470989.html
