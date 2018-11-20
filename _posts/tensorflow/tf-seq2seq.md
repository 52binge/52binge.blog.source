---
title: 从 Encoder 到 Decoder 实现 Seq2Seq 模型
toc: true
date: 2018-10-15 13:10:21
categories: python
tags: tensorflow
---

简单的 Seq2Seq 实现，我们将使用 TensorFlow 来实现个基础版的 Seq2Seq，主要帮助理解 Seq2Seq 中的基础架构。

<!-- more -->

<img src="/images/tensorflow/tf-nlp-seq2seq.jpg" width="800" />

自己做了一个示意图，希望帮助初学者更好地理解. 

## Reference

- [技术人员的发展之路][8]
- [从 Encoder 到 Decoder 实现 Seq2Seq 模型][9]
- [zhihu/basic_seq2seq/][10]
- [隔壁小王 LSTM 神经网络输入输出究竟是怎样的？][4]
- [colab.research.google][5]
- [zh.gluon.ai 动手学深度学习][6]
- [discuss.gluon.ai 论坛][7]

[1]: https://blog.csdn.net/jerr__y/article/category/6747409
[1_1]: https://blog.csdn.net/Jerr__y/article/details/61195257
[2]: https://blog.csdn.net/u014595019/article/details/52759104
[3]: http://wiki.jikexueyuan.com/project/tensorflow-zh/tutorials/mnist_download.html
[4]: https://www.zhihu.com/question/41949741
[5]: https://colab.research.google.com
[6]: https://zh.gluon.ai/
[7]: http://discuss.gluon.ai/
[8]: https://coolshell.cn/articles/17583.html
[9]: https://zhuanlan.zhihu.com/p/27608348
[10]: https://github.com/NELSONZHAO/zhihu/tree/master/basic_seq2seq?1521452873816


