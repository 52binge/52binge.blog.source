---
title: scikit-learn 为机器学习准备文本数据
date: 2019-12-08 22:00:21
categories: data-science
tags: scikit-learn
---

{% image "/images/nlp/scikit-learn-logo.jpg", width="500px", alt="scikit-learn" %}

<!-- more -->

有关特征的提取，scikit-learn给出了很多方法，具体分成了图片特征提取和文本特征提取。

文本特征提取的接口是`sklearn.feature_extraction.text`，那么接下来学习里面封装的函数。

## CountVectorizer

```python
from sklearn.feature_extraction.text import CountVectorizer

vectorizer = CountVectorizer(min_df=1)

corpus = [
            'This is the first document.',
            'This is the second second document.',
            'And the third one.',
            'Is this the first document?',
         ]
X = vectorizer.fit_transform(corpus)
feature_name = vectorizer.get_feature_names()

print feature_name
print X.toarray()
```

程序的结果为

```python
[u'and', u'document', u'first', u'is', u'one', u'second', u'the', u'third', u'this']
[[0 1 1 1 0 0 1 0 1]
 [0 1 0 1 0 2 1 0 1]
 [1 0 0 0 1 0 1 1 0]
 [0 1 1 1 0 0 1 0 1]]
```

## Reference

- [scikit-learn 为机器学习准备文本数据][1]
- [学习sklearn之文本特征提取][2]
- [Scikit-Learn Vectorizer`max_features`][3]

Keras

- [Keras入门（一）搭建深度神经网络（DNN）解决多分类问题][4]

[1]: https://zhuanlan.zhihu.com/p/33779124
[2]: https://zhangzirui.github.io/posts/Document-14%20%28sklearn-feature%29.md
[3]: https://codeday.me/bug/20190429/1001523.html
[4]: https://www.cnblogs.com/jclian91/p/9777108.html


