---
title: Coursera Week 4 - Neural Networks Preface
toc: true
date: 2016-11-17 10:28:21
categories: machine-learning
tags: Neural Networks
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


coursera week 4 - ml neural networks representation

<!-- more -->

## 1. Non-linear Hypotheses

![Non-linear Hypotheses][1]

Performing linear regression with a complex set of data with many features is very unwieldy. Say you wanted to create a hypothesis from three features that included all the `quadratic [kwɑ'drætɪk]` terms:

$$
\begin{align}& g(\theta\_0 + \theta\_1x_1^2 + \theta\_2x\_1x\_2 + \theta\_3x\_1x\_3 \newline& + \theta\_4x\_2^2 + \theta\_5x\_2x\_3 \newline& + \theta\_6x\_3^2 )\end{align}
$$

## 1.1 Computer Vision

> For many machine learning problems, `n will be pretty large`. Here's an example. 


![Computer Vision][2]

> It turns out that where you and I see a car, the computer sees that. What it sees is this matrix, or this grid

## 1.2 Car detection

![Computer Vision][3]

![Computer Vision][4]

![Computer Vision][5]

## Reference article

[1]: /images/ml/coursera/ml-ng-w4-01-01.png
[2]: /images/ml/coursera/ml-ng-w4-01-02.png
[3]: /images/ml/coursera/ml-ng-w4-01-03.png
[4]: /images/ml/coursera/ml-ng-w4-01-04.png
[5]: /images/ml/coursera/ml-ng-w4-01-05.png
