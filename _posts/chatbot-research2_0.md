---
title: Chatbot Research 2 - 文本预处理小计
toc: true
date: 2019-08-12 10:00:21
categories: nlp
tags: NLTK
mathjax: true
---

拿到原始的一条条文本，直接喂给 Model 肯定不行，需要进行对文本进行预处理。预处理的精细程度很大程度上也会影响模型的性能。这篇 Blog 就记录一些预处理的方法。

<!-- more -->

## Remove Stop Words

Stop Words，也叫停用词，通常意义上，停用词大致分为两类。一类是人类语言中包含的功能词，这些功能词极其普遍，与其他词相比，功能词没有什么实际含义，比如'the'、'is'、'at'、'which'、'on'等。另一类词包括词汇词，比如'want'等，这些词应用十分广泛，但是对这样的词搜索引擎无法保证能够给出真正相关的搜索结果，难以帮助缩小搜索范围，同时还会降低搜索的效率，所以通常会把这些词从问题中移去，从而提高搜索性能。

一般在预处理阶段我们会将它们从文本中去除，以更好地捕获文本的特征和节省空间（Word Embedding）。Remove Stop Words 的方法有很多，Stanford NLP 组有一个工具就能够办到，Python 中也有 nltk 库来做一些常见的预处理，这里就以 nltk 为例来记录去除停用词的操作：

首先我们导入 nltk.corpus 中的 stopwords 对象，选取 english 的 stopwords，生成一个 set

## Reference

- [文本预处理方法小记][1]
- [用tf的VocabularyProcessor创建词汇表vocab][2]
- [PYTHON-进阶-FUNCTOOLS模块小结][3]
- [tensorflow学习笔记（六）：TF.contrib.learn大杂烩][4]

[1]: https://zhuanlan.zhihu.com/p/31767633
[2]: https://www.jianshu.com/p/db400a569730
[3]: http://www.wklken.me/posts/2013/08/18/python-extra-functools.html
[4]: https://blog.csdn.net/woaidapaopao/article/details/73007741
