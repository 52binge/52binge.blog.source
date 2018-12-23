---
title: FastText 用于高效文本分类的技巧
toc: true
date: 2018-12-19 07:00:21
categories: nlp
tags: fastText
---

fastText 是 2016年 FAIR(Facebook AIResearch) 推出的一款文本分类与向量化工具.

论文链接： [Bag of Tricks for Efficient Text Classification](https://arxiv.org/abs/1607.01759)

<!-- more -->






## 小结

- FastText 提出了子词嵌入方法。它在 word2vec 中的跳字模型的基础上，将中心词向量表示成单词的子词向量之和。
- 子词嵌入利用构词上的规律，通常可以提升生僻词表示的质量。

## Reference

- [子词嵌入（fastText）][1]
- [fastText，智慧与美貌并重的文本分类及向量化工具][2]

[1]: https://zh.gluon.ai/chapter_natural-language-processing/fasttext.html
[2]: https://www.jiqizhixin.com/articles/2018-06-05-3
