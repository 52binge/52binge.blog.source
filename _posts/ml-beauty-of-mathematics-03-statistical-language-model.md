---
title: 数学之美 03 statistical language model
date: 2016-09-13 16:06:16
categories: machine-learning
tags: [markov, beauty-of-mathematics]
toc: true
description: 《数学之美》 03 统计语言模型 Reading Notes
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

## 1. 用数学的方法描述语言规律

> 数学的美妙在于`简单的模型可以干大事`

### 1.1 S 在文本中出现的可能性

S 这个序列出现的概率等于每个词出现的概率相乘

$$
P(w\_1, w\_2, ..., w\_n) = P(w\_1) \cdot P(w\_2|w\_1) \cdot P(w\_3|w\_1, w\_2)...P(w\_n|w\_1, w\_2, ..., w\_{n-1}) \qquad (fml.1.1)
$$

> $ P(w\_3|w\_1, w\_2)  $ 的概率已经非常难算，每个变量的可能性都是一种语言字典的大小了。$P(w\_n|w\_1, w\_2, ..., w\_{n-1})$ 更是可能性太多，无法估算。怎么办 ?

### 1.2 马尔科夫假设

20世纪初，Andrey Markov 提出偷懒但有效的方法,任意一个词 $w\_i$ 出现的概率只同它前面的 $w\_{i-1}$ 有关 ， 数学上称为 `马尔科夫假设`

$$
P(w\_1, w\_2, ..., w\_n) = P(w\_1) \cdot P(w\_2|w\_1) \cdot P(w\_3|w\_2)...P(w\_n| w\_{n-1}) \qquad (fml.1.2)
$$

公式 $ (fml.1.2) $ 对应的  Statistical language model 是 二元模型 Bigram Model

因为

$$
p(w\_{i-1}, w\_i) \approx \frac {\kappa (w\_{i-1}, w\_i)} {\kappa}
$$

$$
p(w\_{i-1}) \approx \frac {\kappa (w\_{i-1})} {\kappa}
$$

所以

$$
P(w\_i|w\_{i-1}) = \frac { p(w\_{i-1}, w\_i)} {p(w\_{i-1})}
$$