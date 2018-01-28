---
title: K-Means
toc: true
date: 2018-01-26 18:08:21
categories: machine-learning
tags: K-Means
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

k-Means 是一种 [cluster analysis][3] 的算法，其主要是来计算数据聚集的算法，主要通过不断地取离种子点最近均值的算法.

<!-- more -->

## Question

[K-Means][4] 算法主要解决的问题如下图所示。我们可以看到，在图的左边有一些点，我们用肉眼可以看出来有四个点群，但是我们怎么通过计算机程序找出这几个点群来呢？于是就出现了我们的K-Means算法（[Wikipedia链接][4]）

![K-Means 要解决的问题][img4]

## Algorithm 

这个算法其实很简单，如图所示：

<div class="limg1">
<img src="/images/ml/coursera-week-8-5-K-Means-2.jpg" width="600" />
</div>

从上图中，我们可以看到，`A`, `B`, `C`, `D`, `E` 是五个在图中点。而**灰色的点是我们的种子点**，也就是我们用来找点群的点。有两个种子点，所以K=2。

**K-Means的算法如下:**

1. 随机在图中取K（这里K=2）个种子点。
2. 然后对图中的所有点求到这K个种子点的距离，假如点Pi离种子点Si最近，那么Pi属于Si点群。（上图中，我们可以看到A,B属于上面的种子点，C,D,E属于下面中部的种子点）
3. 接下来，我们要移动种子点到属于他的“点群”的中心。（见图上的第三步）
4. 然后重复第2）和第3）步，直到，种子点没有移动（我们可以看到图中的第四步上面的种子点聚合了A,B,C，下面的种子点聚合了D，E）.


**求点群中心的算法:**



## Reference

- [酷壳 K-Means][1]
- [知乎 K-Means][2]

[1]: https://coolshell.cn/articles/7779.html
[2]: https://zhuanlan.zhihu.com/p/20432322

[3]: https://en.wikipedia.org/wiki/Cluster_analysis
[4]: https://en.wikipedia.org/wiki/K-means_clustering

[img1]: /images/ml/coursera-week-8-1.png
[img2]: /images/ml/coursera-week-8-2.jpg
[img3]: /images/ml/coursera-week-8-3.png
[img4]: /images/ml/coursera-week-8-4-K-Means.gif
[img5]: /images/ml/coursera-week-8-5-K-Means-2.jpg





