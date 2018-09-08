---
title: Convolutional Neural Networks (week4) - Face recognition & Neural style transfer
toc: true
date: 2018-09-08 15:00:21
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

能够在图像、视频以及其他2D或3D数据上应用这些算法。

<!-- more -->

## 1. What is face recognition?

这一节中的人脸识别技术的演示的确很NB..., 演技不错，😄

## 2. One Shot Learning

作为老板希望与时俱进，所以想使用人脸识别技术来实现打卡。

假如我们公司只有4个员工，按照之前的思路我们训练的神经网络模型应该如下：

<img src="/images/deeplearning/C4W4-1_1.png" width="750" />

如图示，输入一张图像，经过CNN，最后再通过Softmax输出5个可能值的大小(4个员工中的一个，或者都不是，所以一一共5种可能性)。

看起来好像没什么毛病，但是我们要相信我们的公司会越来越好的啊，所以难道公司每增加一个人就要重新训练CNN 以及 最后一层的输出数量吗？

这显然有问题，所以有人提出了一次学习(one-shot)，更具体地说是通过一个函数来求出输入图像与数据库中的图像的差异度，用 $d(img1,img2)$ 表示。

<img src="/images/deeplearning/C4W4-2_1.png" width="750" />

如上图示，如果两个图像之间的差异度不大于某一个阈值 **τ**，那么则认为两张图像是同一个人。反之，亦然。

下一小节介绍了如何计算差值。

## 3. Siamese Network

## 4. Triplet Loss

## 5. Face Verification and Binary Classification

## 6. What is neural style transfer?

## 7. What are deep ConvNets learning?

## 8. Cost Function

## 9. Content Cost Function

## 10. Style Cost Function

## 11. 1D and 3D Generalizations
​
## Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][2]

[1]: https://study.163.com/my#/smarts
[2]: http://www.cnblogs.com/marsggbo/p/7470989.html
