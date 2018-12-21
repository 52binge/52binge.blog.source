---
title: myfer
toc: true
date: 2018-12-03 13:36:21
categories: tools
tags: Useful-Links
---

Summarize prepare offer road

<!-- more -->

## chatbot 项目

- [聊天机器人Chatbot的训练质量如何评价？](https://www.zhihu.com/question/60530973/answer/184454797)

> 可以类比语言模型的ppl，在词表几万的情况下，我的经验是100左右就已经能生成流畅的话了，如果远高于100，如200，生成的基本不流畅。如果远小于100，倒不一定非常过拟合。

- [實現基於seq2seq的聊天機器人](https://www.smwenku.com/a/5b7c8a4a2b71770a43db78ed/)

> Cornell Movie-Dialogs Corpus 困惑度降到了二十多

- [小黄鸡-多语言](http://www.simsimi.com/ChatSettings)

- [从产品完整性的角度浅谈chatbot](https://zhuanlan.zhihu.com/p/34927757)

## Seq2Seq

1. seq2seq模型，seq2seq的缺点, attention机制
2. attention的公式，怎样计算得分和权重
3. soft attention 和 hard attention的区别
4. tensorflow里面seq2seq的借口， 自己实现的模型里面的一些细节和方法。

## Seq2Seq

- seq2seq时遇到的deepcopy和beam_search两个问题以及解决方案.
- 知名博主WildML给google写了个通用的seq2seq，[文档地址][7] ， [Github地址][8]
- [Tensorflow动态seq2seq使用总结](https://www.jianshu.com/p/c0c5f1bdbb88)
- [荷楠仁 tensorflow sequence_loss](https://www.cnblogs.com/zhouyang209117/p/8338193.html)

## 多标签分类

8. 都用过那些模型实现文本分类？
9. 现在文本分类中还有哪些没有解决的问题，我想了会说样本不平衡问题？
10. 多标签的分类问题，以及损失函数等。

在文本分类任务中，有哪些论文中很少提及却对性能有重要影响的tricks？

> 1. 数据预处理时vocab的选取（前N个高频词或者过滤掉出现次数小于3的词等等）
> 2. 词向量的选择，可以使用预训练好的词向量如谷歌、facebook开源出来的，当训练集比较大的时候也可以进行微调或者随机初始化与训练同时进行。训练集较小时就别微调了
> 3. 结合要使用的模型，这里可以把数据处理成char、word或者都用等
> 4. 有时将词性标注信息也加入训练数据会收到比较好的效果
> 5. 至于PAD的话，取均值或者一个稍微比较大的数，但是别取最大值那种应该都还好
> 6. 神经网络结构的话到没有什么要说的，可以多试几种比如fastText、TextCNN、RCNN、char-CNN/RNN、HAN等等。哦，对了，加上dropout和BN可能会有意外收获。反正模型这块还是要具体问题具体分析吧，根据自己的需求对模型进行修改（比如之前参加知乎竞赛的时候，最终的分类标签也有文本描述，所以就可以把这部分信息也加到模型之中等等）
> 7. 超参数的话，推荐看看之前TextCNN的一篇论文，个人感觉足够了“A Sensitivity Analysis of (and Practitioners’ Guide to) Convolutional Neural Networks for Sentence Classification”
> 8. 之前还见别人在文本领域用过数据增强的方法，就是对文本进行随机的shuffle和drop等操作来增加数据量

## MMI

11. 对话项目的模型的缺点以及使用MMI的改进方案。
12. Attention机制的计算细节和公式是怎样的，然后我就介绍了一下公式的计算方法，然后说了一下改进的方案等。
13. MMI模型第一个改进目标函数中P(T)是如何计算的？ 我说每个词的联合概率分布乘积，当时他面露疑问，我还没反应过来是什么意思，到后面有说到这个问题才明白，原来他的意思是P(T)应该是单纯语言模型学习出来的结果，而按照我的说法，P(T)是在输入的基础上进行计算的

## deep

14. FastText，CNN，RNN的区别？

> 对话 与 多标签分类 是重中之重

## 临时突击

无外乎是一些正则化、dropout、BN、LR推导、交叉熵损失函数、softmax求导、BP反向传播、过拟合、BPTT反向传播、梯度爆炸和梯度弥散、ReLu、激活函数、文本分类、对话系统评价指标、word2vec、attention、seq2seq、优化算法、GBDT、Bagging、Boosting等等等等

但是我感觉临时突击这些东西价值不大，主要还是看面试的一个整体效果

## 深度学习的坑

- [深度学习的坑](https://www.cnblogs.com/rocketfan/p/7482786.html)

- [如何理解互信息公式的含义?](https://www.zhihu.com/question/24059517)

- [简单的交叉熵损失函数，你真的懂了吗？](https://zhuanlan.zhihu.com/p/38241764)


## Reference

- [2019 11家互联网公司，NLP面经回馈][1]
- [暑期实习NLP算法岗面经总结][2]
- [在文本分类任务中，有哪些论文中很少提及却对性能有重要影响的tricks？][3]
- [深度学习与文本分类总结第一篇--常用模型总结][4]
- [用深度学习（CNN RNN Attention）解决大规模文本分类问题 - 综述和实践][5]
- [严重数据倾斜文本分类，比如正反比1:20～100，适合什么model][6]

[1]: https://zhuanlan.zhihu.com/p/46999592
[2]: https://zhuanlan.zhihu.com/p/36387348
[3]: https://www.zhihu.com/question/265357659
[4]: https://blog.csdn.net/liuchonge/article/details/77140719
[5]: https://zhuanlan.zhihu.com/p/25928551
[6]: https://www.zhihu.com/question/59236897
[7]: https://google.github.io/seq2seq/
[8]: https://github.com/google/seq2seq


