

## 1. NLP高频问题

### 2.1 word2vec vs tf-idf 

> **word2vec:** 
>
> 1). 稠密的 低维度的 
> 
> 2). 表达出相似度； 
> 
> 3). 表达能力强；
> 
> 4). 泛化能力强；

**2. word2vec 和 NNLM 对比有什么区别？**（word2vec vs NNLM）

> 1）其本质都可以看作是 Language Model；

> 2）词向量只不过 NNLM 一个产物， word2vec 虽然其本质也是语言模型，但是其专注于**词向量本身**，因此做了许多优化来提高计算效率：

与 NNLM 相比，词向量直接sum，不再拼接，并舍弃隐层；
考虑到 sofmax归一化 需要遍历整个词汇表，采用 hierarchical softmax 和 negative sampling 进行优化

hierarchical softmax 实质上生成一颗带权路径最小的哈夫曼树，让高频词搜索路劲变小；
negative sampling 更为直接，实质上对每一个样本中每一个词都进行负例采样；

3.  word2vec负采样有什么作用？

4. word2vec和fastText对比有什么区别？（word2vec vs fastText）

1）都可以无监督学习词向量， fastText训练词向量时会考虑subword；

2）fastText还可以进行有监督学习进行文本分类，其主要特点：

结构与CBOW类似，但学习目标是人工标注的分类结果；
采用hierarchical softmax对输出的分类标签建立哈夫曼树，样本中标签多的类别被分配短的搜寻路径；
引入N-gram，考虑词序特征；
引入subword来处理长词，处理未登陆词问题；

5. glove和word2vec、 LSA对比有什么区别？（word2vec vs glove vs LSA）

6. elmo、GPT、bert三者之间有什么区别？（elmo vs GPT vs bert）

7. RNN 和 LSTM 和 GRU 的区别？

## 3. 其他算法问题

1、怎么进行单个样本的学习？
2、 决策树 bagging boosting adaboost 区别？RF的特征随机目的是什么？
3、transformer各部分怎么用？Q K V怎么计算；Attention怎么用？
4、HMM 假设是什么？CRF解决了什么问题？CRF做过特征工程吗？HMM中的矩阵意义？5、说以一下空洞卷积？膨胀卷积怎么理解？什么是Piece-CNN？
6、怎么解决beam-search局部最优问题？global embedding 怎么做？
7、数学题：什么是半正定矩阵？机器学习中有什么应用？
8、卷积的物理意义是什么？傅里叶变换懂吗？
9、说一下Bert？
10、推导word2vec？
11、怎么理解传统的统计语言模型？现在的神经网络语言模型有什么不同？
12、神经网络优化的难点是什么？这个问题要展开来谈。
13、attention你知道哪些？
14、自动文章摘要抽取时，怎么对一篇文章进行分割？（从序列标注、无监督等角度思考）
15、在做NER任务时，lstm后面可以不用加CRF吗？
16、通过画图描述TextRank？
17、LDA和pLSA有什么区别？
18、Transformer在实际应用中都会有哪些做法？
19、讲出过拟合的解决方案？
20、说一下transforemr、LSTM、CNN间的区别？从多个角度进行讲解？
21、梯度消失的原因和解决办法有哪些？
22、数学题：贝叶斯计算概率？
23、数学题：25只兔子赛跑问题，共5个赛道，最少几次比赛可以选出前5名？
24、数学题：100盏灯问题？

## Reference

- [【NLP/AI算法面试必备-2】NLP/AI面试全记录（持续更新）][1]
- [【NLP/AI算法面试必备-1】学习NLP/AI，必须深入理解“神经网络及其优化问题”][2]
- [JayLouNLP算法工程师][2]

[1]: https://zhuanlan.zhihu.com/p/57153934
[2]: https://www.zhihu.com/people/lou-jie-9/posts
[3]: https://zhuanlan.zhihu.com/p/56633392
