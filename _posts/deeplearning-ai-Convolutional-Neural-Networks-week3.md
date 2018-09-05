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

> 要输出眼角的位置，你可以让神经网络输出的最后一层，多输出 2 个数字 $l\_x, l\_y$.
> 
> 假设 脸部 有 64 个特征点. 具体做法是准备一个 CNN 和 一些关键特征集. 将人脸图片输入 CNN. 输出 1 或者 0. 
> 
> 1 表示有 人脸。 这里一共有 **128 + 1** 个输出单元，因为有 64 个特征 64 \* 2， 来实现对人脸的检测和定位.
> 
> Snapchat 应用，AR (Augmented Reality) 增强现实 Filter 有所了解，Snapchat Filter 实现了在人脸上画皇冠 还有一些其他效果。检测脸部特征也是计算机图形学的关键构造模块.
> 
> 最后一个例子是，检测人体姿态.

## 3. Object Detection

假设你想构造一个汽车检测算法:

1. 首先，创建一个标签训练集 Training Set， 也就是 $x$ 和 $y$
2. 选定一个大小确定的窗口，输入 CNN，CNN 开始预测红色方框中是否有汽车.
3. 然后，滑动窗口继续, 红色方框稍向右滑动之后的区域, 处理下一个，输入 CNN..
4. 依次重复操作.., 知道这个红色的窗口滑过每一个角落。
5. 如果上面到最后角落还是没有检测到汽车， 那么选用更大的窗口，然后还是以固定步长..依次重复..滑过..检测

这个算法叫做 : **滑动窗口目标检测**

<img src="/images/deeplearning/C4W3-5_1.png" width="750" />

目标检测常使用的是滑动窗口技术检测，即使用一定大小的窗口按照指定的步长对图像进行遍历

<img src="/images/deeplearning/C4W3-6.jpg" width="750" />

因为图像中车辆的大小我们是不知道的，所以可以更改窗口大小，从而识别并定位出车辆的位置。

<img src="/images/deeplearning/C4W3-7_1.png" width="750" />

<img src="/images/deeplearning/C4W3-8_1.png" width="750" />

> **滑动窗口目标检测** 算法的缺点就是计算成本的问题.
> 1. 如果你把窗口调大，显然会减少输入CNN的窗口个数，但是粗粒度可能会影响性能.
> 2. 如果采用小粒度，那么输入给CNN的窗口个数就会特别多。这意味着超高计算成本.
> 
> 人们通常采用更简单的分类器做对象检测. 比如简单的线性分类器. 计算成本就会很低. 滑动窗口算法表现良好. 然而 CNN 运行单个分类任务的成本确高得多。 这样的滑动窗口太慢了。
> 
> 庆幸的是，人们已经找到了方法解决计算成本，下一节见.

## 4. Convolutional Implementation of Sliding Windows

> 注意：该节视频的例子和上一节一样，都是识别图像中是否有 pedestrian，car，motorcycles，background，所以最后输出y是 4个节点

### 4.1 全连接层→卷积层

在介绍卷积滑动窗口之前我们首先要知道如何把神经网络的**全连接层**转化成**卷积层**，下面是使用了全连接层的网络结构

<img src="/images/deeplearning/C4W3-9_1.png" width="750" />

那么如何将**全连接层转化成卷积层**呢？如下图示

<img src="/images/deeplearning/C4W3-10_1.png" width="750" />

我们可以看到经过 Max Pooling 之后的数据大小是 (5, 5, 16), 第一个FC层是 400 个节点。我们可以使用 400 个 5\*5 的过滤器进行卷积运算，随后我们就得到了 (1, 1, 400) 的矩阵。

第二个 FC层 也是 400 个节点，由之前的 1\*1 过滤器的特点，我们可以使用 400 个 1\*1 的过滤器，也可以得到 (1,1,400) 的矩阵。至此，我们已经成功将全连接层转化成了卷积层。

> 以上就是用卷积层代替全连接层的过程， 下面再看如何通过卷积实现滑动窗口对象检测算法，借鉴 OverFeat Paper。

### 4.2 卷积滑动窗口实现

目标检测一节中介绍了滑动窗口。要实现窗口遍历，那么就需要很大的计算量，But 大神们自然已经有了解决办法。

注意: 下面的第一幅图，Andrew Ng 为了方便只花了平面图，就没有画出3D的效果了。

**首先我们先看下图，这就是上面提到的将全连接层转化成卷积层的示意图:**

<img src="/images/deeplearning/C4W3-11_1.png" width="750" />

下面，假设我们的测试图大小是 16\*16，并令滑动窗口大小是 14\*14 的 (为了方便理解，下图用蓝色清楚地表明了 14\*14 窗口的大小), 步长是 2，所以这个测试图可以被窗口划分成 4 个部分。随后和上面执行一样的操作，最后可以得到 (2,2,4) 的矩阵（这样发现很多计算部分是重复的），此时我们不难看出**测试图被滑动窗口选取的左上角部分对应的结果也是输出矩阵的左上角部分，其他3个部分同理**。

<img src="/images/deeplearning/C4W3-12_1.png" width="750" />

> 所以这说明了什么？
>
> 说明我们没有必要用滑动窗口截取一部分，然后带入卷积网络运算。相反我们可以整体进行运算，这样速度就快很多了。


下图很清楚的展示了卷积滑动窗口的实现。我们可以看到图片被划分成了 64 块

<img src="/images/deeplearning/C4W3-13_1.png" width="750" />

<img src="/images/deeplearning/C4W3-14_1.png" width="750" />

> 目前这个算法还有一个缺点，就是边界框的位置可能不够准确，下一节，我们将学习解决这个缺点。

## 5. Bounding Box Predictions

上面介绍的滑动窗口方法存在一个问题就是很多情况下滑动窗口并不能很好的切割出车体，如下图示：

<img src="/images/deeplearning/C4W3-15.png" width="400" />

为了解决这个问题，就有了 **YOLO (you only look once)** 算法，即只需要计算一次便可确定需要识别物体的位置的大小。

**原理如下：**

首先将图像划分成 3\*3 (即9份)，每一份最后由一个向量表示，这个向量在本文最前面介绍过，即

$$
y=[P\_c,b\_x,b\_y,b\_h,b\_w,c\_1,c\_2,c\_3]
$$

<img src="/images/deeplearning/C4W3-16.png" width="450" />

因为有 9 份，所以最后输出矩阵大小是 (3,3,8) , 如下图示：

<img src="/images/deeplearning/C4W3-17_1.png" width="750" />

那么如何构建卷积网络呢？

输入矩阵是 (100,100,3),然后是 Conv，Maxpool层，……，最后只要确保输出矩阵大小是 (3,3,8) 即可。

<img src="/images/deeplearning/C4W3-18_1.png" width="750" />

**下图是以右边的车辆作为示**例介绍该车辆所在框的输出矩阵

> - 很显然 $P\_c=1$
> - 然后 $b\_x,b\_y$ 的值是右边车辆的中心点相对于该框的位置,所以它们的值是一定小于 1 的，我们可以很容易的得到近似值 $b\_x=0.4, b\_y=0.3$
> - $b\_h,b\_w$ 的值同理也是车辆的宽高相对于其所在框的比例，但是要注意的是这两个值是可以大于 1 的，因为有可能部分车身在框外。但是也可以使用 sigmoid函数 将值控制在 1 以内。

<img src="/images/deeplearning/C4W3-19_1.png" width="750" />

## 6. Intersection Over Union

> 交并比 Intersection Over Union

前面说到了实现目标定位时可能存在滑动窗口与真实边框存在出入，如下图示：

红色框是车身边界，紫色框是滑动窗口，那么此窗口返回的值是有车还是无车呢？

<img src="/images/deeplearning/C4W3-20.jpg" width="340" />

为了解决上面的问题引入了交并比(IoU)，也就是两个框之间的交集与并集之比，依据这个值可以评价定位算法是否精准。

示意图如下，黄色区域表示紫色框和红色框的交集，绿色区域表示紫色框和红色框的并集，交并比(IoU)就等于黄色区域大小比上绿色区域大小。

如果 $IoU\geq0.5$，则表示紫色框中有车辆，反之没有。

当然 0.5 这个阈值是人为设定的，没有深入的科学探究，所以如果希望结果更加精确，也可以用 0.6 或 0.7 设为阈值，但是不建议用小于 0.5 的阈值。

<img src="/images/deeplearning/C4W3-21_1.png" width="750" />

## 7. Non-max Suppression

## 8. Anchor Boxes

## 9. YOLO Algorithm

## 10. (Optional) Region Proposals
​
## Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][2]
- [][3]

[1]: https://study.163.com/my#/smarts
[2]: http://www.cnblogs.com/marsggbo/p/7470989.html
[3]: https://www.zhihu.com/question/49432647/answer/144958145
