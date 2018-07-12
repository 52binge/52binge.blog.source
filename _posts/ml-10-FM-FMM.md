---
title: 机器学习之FM与FFM（Factorization Machines）(not finish)
toc: true
date: 2018-07-12 17:43:21
categories: machine-learning
tags: [FM]
mathjax: true
list_number: true
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

因子分解机（Factorization Machine，简称FM），又称分解机器。是由Konstanz大学（德国康斯坦茨大学）Steffen Rendle（现任职于Google）于2010年最早提出的，旨在解决大规模稀疏数据下的特征组合问题。

<!-- more -->

在系统介绍FM之前，我们先了解一下在实际应用场景中，稀疏数据是怎样产生的？

## Reference article

- [机器学习之FM与FFM（Factorization Machines）][1]
- [factorization machine和logistic regression的区别？][2]
- [深入浅出ML之Factorization家族][3]
- [分解机(Factorization Machines)推荐算法原理][4]
- [机器学习算法系列（26）：因子分解机（FM）与场感知分解机（FFM）][5]
- [Free Will][6]

[1]: https://blog.csdn.net/wyisfish/article/details/79998959
[2]: https://www.zhihu.com/question/27043630?from=profile_question_card
[3]: http://www.52caml.com/head_first_ml/ml-chapter9-factorization-family/
[4]: https://www.cnblogs.com/pinard/p/6370127.html
[5]: https://plushunter.github.io/2017/07/13/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0%E7%AE%97%E6%B3%95%E7%B3%BB%E5%88%97%EF%BC%8826%EF%BC%89%EF%BC%9A%E5%9B%A0%E5%AD%90%E5%88%86%E8%A7%A3%E6%9C%BA%EF%BC%88FM%EF%BC%89%E4%B8%8E%E5%9C%BA%E6%84%9F%E7%9F%A5%E5%88%86%E8%A7%A3%E6%9C%BA%EF%BC%88FFM%EF%BC%89/
[6]: https://plushunter.github.io/tech-stack/