---
title: K-means
toc: true
date: 2019-04-20 17:01:21
categories: machine-learning
tags: Kmeans
---

<img src="https://coolshell.cn/wp-content/uploads/2012/06/K-Means.gif" width="550" />

<!-- more --><br>

在数据挖掘中， k-Means 算法是一种 cluster analysis 的算法，其主要是来计算数据聚集的算法，主要通过不断地取离种子点最近均值的算法。

## 1. 问题

K-Means算法主要解决的问题如下图所示。我们可以看到，在图的左边有一些点，我们用肉眼可以看出来有四个点群，但是我们怎么通过计算机程序找出这几个点群来呢？于是就出现了我们的K-Means算法

## 2. 算法概要

这个算法其实很简单，如下图所示：

![K-Means 算法概要](https://coolshell.cn/wp-content/uploads/2012/06/K-Means.jpg)

从上图中，我们可以看到，A, B, C, D, E 是五个在图中点。而灰色的点是我们的种子点，也就是我们用来找点群的点。有两个种子点，所以K=2。

## Reference article

- 百面机器学习
- [COOLSHELL K-MEANS 算法][1]
- [网易云课堂][2]

[1]: https://coolshell.cn/articles/7779.html
[2]: https://study.163.com/course/courseLearn.htm?courseId=1004570029#/learn/video?lessonId=1052320898&courseId=1004570029

