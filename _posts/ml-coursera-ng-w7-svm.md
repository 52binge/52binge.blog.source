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

<img src="/images/ml/coursera/ml-ng-w3-02.png" width="820" height="500" align="middle" /img>

> $ y = 1 \; when \; h_\theta(x) = g(\theta^T x) \geq 0.5 \; when \; \theta^T x \geq 0 $.   

> $ y = 0 \; when \; h_\theta(x) = g(\theta^T x) \le 0.5 \; when \; \theta^T x \le 0 $ 

We can compress our cost function's two conditional cases into one case:

$ \mathrm{Cost}(h\_\theta(x),y) = - y \cdot \log(h\_\theta(x)) - (1 - y) \cdot \log(1 - h\_\theta(x))$

We can fully write out our entire cost function as follows:

$
J(\theta) = - \frac{1}{m} \displaystyle \sum\_{i=1}^m [y^{(i)}\log (h\_\theta (x^{(i)})) + (1 - y^{(i)})\log (1 - h\_\theta(x^{(i)}))]
$

$
J(\theta) = \mathop{min}\limits\_{\_\theta} \frac{1}{m} \left[ \displaystyle \sum\_{i=1}^m y^{(i)}\ \left(-\log h\_\theta (x^{(i)}) \right) + (1 - y^{(i)}) \left( - \log (1 - h\_\theta(x^{(i)})) \right) \right]+ \frac{\lambda}{2m} \displaystyle \sum\_{j=1}^n \theta\_j^2
$

> $cost\_1(\theta^T x^{i}) = -\log h\_\theta (x^{(i)})$
> $cost\_0(\theta^T x^{i}) = - \log (1 - h\_\theta(x^{(i)}))$

$
J(\theta) = \mathop{min}\limits\_{\_\theta} \frac{1}{m} \left[ \displaystyle \sum\_{i=1}^m y^{(i)}\ \left(cost\_1(\theta^T x^{i}) \right) + (1 - y^{(i)}) \left( cost\_0(\theta^T x^{i}) \right) \right]+ \frac{\lambda}{2m} \displaystyle \sum\_{j=1}^n \theta\_j^2
$

### 1.1 Optimization Objective

$
J(\theta) = \mathop{min}\limits\_{\_\theta} \frac{1}{m} \left[ \displaystyle \sum\_{i=1}^m y^{(i)}\ \left(cost\_1(\theta^T x^{i}) \right) + (1 - y^{(i)}) \left( cost\_0(\theta^T x^{i}) \right) \right]+ \frac{\lambda}{2m} \displaystyle \sum\_{j=1}^n \theta\_j^2
$

> 令 $C = \frac{1}{\theta}$ 

$
J(\theta) = \mathop{min}\limits\_{\_\theta} C \displaystyle \sum\_{i=1}^m \left[  y^{(i)}\ cost\_1(\theta^T x^{i}) + (1 - y^{(i)}) cost\_0(\theta^T x^{i}) \right]+ \frac{1}{2m} \displaystyle \sum\_{j=1}^n \theta\_j^2
$

### 1.2 Large Margin Intuition

<img src="/images/ml/coursera/ml-ng-w7-svm-1.png" width="620" height="400" align="middle" /img>

<img src="/images/ml/coursera/ml-ng-w7-svm-2.png" width="620" height="400" align="middle" /img>

<img src="/images/ml/coursera/ml-ng-w7-svm-3.png" width="620" height="400" align="middle" /img>


### 1.3 Mathematics Behind Large Margin Classification

<img src="/images/ml/coursera/ml-ng-w7-svm-4.png" width="620" height="400" align="middle" /img>

<img src="/images/ml/coursera/ml-ng-w7-svm-5.png" width="620" height="400" align="middle" /img>

<img src="/images/ml/coursera/ml-ng-w7-svm-6.png" width="620" height="400" align="middle" /img>

## 2. Kernels

### 2.1 Kernels I

### 2.2 Kernels II

## 3. SVMs in Practice

### 3.1 Using An SVM

## Reference

- [零基础学SVM—Support Vector Machine(一)][z1]

[z1]: https://zhuanlan.zhihu.com/p/24638007

[0]: /images/ml/coursera/ml-ng-w7-svm-0.png
[0]: /images/ml/coursera/ml-ng-w3-02.png
[1]: /images/ml/coursera/ml-ng-w7-svm-1.png
[2]: /images/ml/coursera/ml-ng-w7-svm-2.png
[3]: /images/ml/coursera/ml-ng-w7-svm-3.png
[4]: /images/ml/coursera/ml-ng-w7-svm-4.png
[5]: /images/ml/coursera/ml-ng-w7-svm-5.png
[6]: /images/ml/coursera/ml-ng-w7-svm-6.png

