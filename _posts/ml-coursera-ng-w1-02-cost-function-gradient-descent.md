---
title: Coursera Week 1 - Linear Regression Cost Function & Gradient descent
toc: true
date: 2016-09-28 17:22:21
categories: machine-learning
tags: machine-learning
description: coursera week 1 - gradient descent
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

## 1. Linear Regression

![How to choose parameters][1]

## 2. Cost Function

> Choose $\theta\_0，\theta\_1$ so that $h_{\theta} (x) $ is close to $y$ for our training examples ${(x, y)}$

ml | fmt
------- | -------
Hypothesis | $h\_{\theta}  (x) = \theta\_0 + \theta\_1 x$
Parameters | $\theta\_0 、\theta\_1$
Cost Function | $J(\theta\_0，\theta\_1) = {\frac {1} {2m}} \sum\_{i=1}^m (h_{\theta} (x^{i}) - (y^{i}))^2$
Goal | $minimize J(\theta\_0，\theta\_1)$

## 3. Simplified Fmt 

> $\theta\_0$ = 0

**hypothesis function $h\_{\theta} (x)$  cost function $J(\theta\_1)$**

![cost][3]

## 4. Cost function visable

![cost][4]

> 把 x, y 想象成向量，确定的向量，向量再想象为一个确定的数，总之它是一个二次函数，抽象的想一下，会不会理解

- contour plots
- contour figures

![cost][5]

## 5. Gradient descent target

![Gradient descent][6]

## 6. Gradient descent visable

![Local optimization][7]

**Convex function**

![Global optimization][8]

## 7. Gradient descent algorithm

> $ \alpha $ : learning rate

![Gradient descent][9]

## 8. Gradient descent only $ \theta\_{1} $

![Gradient descent for one param : $ \theta\_{1} $][10]

![Gradient descent][11]

![Gradient descent][12]

![Gradient descent][13]

## 9. Linear Regression Model

![Gradient descent][14]

### 9.1 Batch Gradient Descent

> Batch : Each step of gradient descent uses all the training examples

![Gradient descent][15]

> Coursera Learning Notes

[1]: /images/ml/ml-ng-w1-02-1.png
[2]: /images/ml/ml-ng-w1-02-2.png
[3]: /images/ml/ml-ng-w1-02-3.png
[4]: /images/ml/ml-ng-w1-02-4.png
[5]: /images/ml/ml-ng-w1-02-5.png

[6]: /images/ml/ml-ng-w1-02-6.png
[7]: /images/ml/ml-ng-w1-02-7.png
[8]: /images/ml/ml-ng-w1-02-8.png
[9]: /images/ml/ml-ng-w1-02-9.png
[10]: /images/ml/ml-ng-w1-02-10.png
[11]: /images/ml/ml-ng-w1-02-11.png
[12]: /images/ml/ml-ng-w1-02-12.png
[13]: /images/ml/ml-ng-w1-02-13.png
[14]: /images/ml/ml-ng-w1-02-14.png
[15]: /images/ml/ml-ng-w1-02-15.png