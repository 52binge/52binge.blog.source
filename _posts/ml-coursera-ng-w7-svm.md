---
title: Coursera 7 - Support Vector Machines
toc: true
date: 2017-10-13 16:08:21
categories: machine-learning
tags: SVM
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

From `Logistic Regression` to `Support Vector Machines`

<!-- more -->

## 1. Large Margin Classification

**Alternation view of logistic regression**

$ \begin{align} h\_\theta (x) = g({\theta^T x}) = \dfrac{1}{1 + e^{-\theta^T x}} \end{align}  \; , \; h\_\theta (x) \in [0, 1] $ 

![][2]

> $ y = 1 \; when \; h_\theta(x) = g(\theta^T x) \geq 0.5 \; when \; \theta^T x \geq 0 $.   

> $ y = 0 \; when \; h_\theta(x) = g(\theta^T x) \le 0.5 \; when \; \theta^T x \le 0 $ 

We can compress our cost function's two conditional cases into one case:

$ \mathrm{Cost}(h\_\theta(x),y) = - y \cdot \log(h\_\theta(x)) - (1 - y) \cdot \log(1 - h\_\theta(x))$

We can fully write out our entire cost function as follows:

$
J(\theta) = - \frac{1}{m} \displaystyle \sum\_{i=1}^m [y^{(i)}\log (h\_\theta (x^{(i)})) + (1 - y^{(i)})\log (1 - h\_\theta(x^{(i)}))]
$

### 1.1 Optimization Objective

### 1.2 Large Margin Intuition

### 1.3 Mathematics Behind Large Margin Classification

> 大间距分类器

## 2. Kernels

### 2.1 Kernels I

### 2.2 Kernels II

## 3. SVMs in Practice

### 3.1 Using An SVM




[1]: /images/ml/ml-svm-01.png
[2]: /images/ml/ml-ng-w3-02.png



