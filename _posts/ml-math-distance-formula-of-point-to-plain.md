---
title: Distance formula of point to plane
toc: true
date: 2016-05-17 15:07:21
categories: machine-learning
tags: math
mathjax: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$'], ['\[','\]'] ],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

平面的一般式方程, 向量的模（长度）, 向量的数量积, 点到平面的距离

<!--more-->

[维基百科_Vector](https://zh.wikipedia.org/wiki/%E5%90%91%E9%87%8F)

## 1. 平面的一般式方程

Ax +By +Cz + D = 0

其中n = (A, B, C)是平面的法向量，D是将平面平移到坐标原点所需距离（所以D=0时，平面过原点）

## 2. 向量的模（长度）

给定一个向量V（x, y, z),则|V| = sqrt(x * x + y * y + z * z)

> 在数学中，矢量常采用更为抽象的矢量空间（也称为线性空间）来定义，而定义具有物理意义上的大小和方向的矢量概念则需要引进了范数和内积的欧几里得空间。
> 范数， 模长

## 3. 向量的数量积/点积/内积

给定两个向量V1(x1, y1, z1)和V2(x2, y2, z2)则他们的内积是 V1V2 = x1x2 + y1y2 + z1z2

> 数量积被广泛应用于物理中，如做功就是用力的矢量乘位移的矢量，即![][1]

## 4. 点到平面的距离(Yes)

求点到直线的距离不再是难事，有图有真相

![Distance formula of point to plane][2]

> 如果法向量是单位向量的话，那么分母为1


  [1]: /images/math-pointdis.png
  [2]: /images/math-pointToPlane.jpeg