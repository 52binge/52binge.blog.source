---
title: Word2vec Learning Note
toc: true
date: 2017-11-16 10:08:21
categories: nlp
tags: word2vec
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

2013年，Google开源了用于词向量计算的工具—`word2vec`，也称 Word Embedding，Word2Vec 是一个可以将语言中字词转为向量形式表达 (Vector Representations) ，模型通常都是用浅层（两层）神经网络训练词向量。
<!-- more -->


Word2vec的模型以大规模语料库作为输入，然后生成一个向量空间（通常为几百维）。词典中的每个词都对应了向量空间中的一个独一的向量，而且语料库中拥有共同上下文的词映射到向量空间中的距离会更近。

> Information Retrieval

## Reference

- [Word2Vec-知其然知其所以然][1]
- [word2vec前世今生][2]

[1]: https://www.zybuluo.com/Dounm/note/591752#word2vec-知其然知其所以然
[2]: https://whiskytina.github.io/word2vec.html
