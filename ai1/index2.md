你可能想不到，Machine Learning and Logic Programming 有一种奇妙的关系，她们就像亲姐妹.

**Machine Learning and Logic Programming**

> 1. 逻辑编程是什么 （X + 2 = 5 询问 X 的值，回答： X=3）类比 **forward pass + back propagation**
> 2. **ML框架** 其实是一种 **程序语言** : differentiable programming language
> 
> &nbsp;&nbsp; Pytorch 和 TensorFlow 的动态计算图和静态计算图. 对应动态静态语言。
> 
> **简单表达 & 递归：**
> 
> 1. Feed-forward 网络，比如 CNN 一类的，对应了最简单的表达式，它只能处理图像一类具有固定长度的数据。
> 2. RNN（LSTM）对应的是单个递归（循环）的函数。这就是为什么 RNN 可以处理文本这类线性“链表”数据。

> [machine learning and logic programming 机器学习与逻辑编程](http://www.yinwang.org/blog-cn/2019/01/30/machine-learning)

**NLP 发展方向**

未来十年将是 NLP 发展的黄金档：

> 1. 来自各个行业的文本大数据将会更好地采集、加工、入库。
> 2. 来自 搜索引擎、客服、商业智能、语音助手、翻译、教育 等领域对 NLP 的需求会大幅度上升。
> 3. 文本数据和语音、图像数据的多模态融合成为未来机器人的刚需。

因此，NLP 研究将会向如下几个方面倾斜：

> 1. 将知识和常识引入目前基于数据的学习系统中。
> 2. 低资源的NLP任务的学习方法。
> 3. 上下文建模、多轮语义理解。
> 4. 基于语义分析、知识和常识的可解释 NLP。

![趋势热点：值得关注的NLP技术][ai1]

[ai1]: /images/ai/nlp-1.jpg

除了备受关注的 NN Pre-Train 外，知识和常识的引入将大幅推动NLP技术的发展：

> - [2019：迈向高能NLP之路！](https://zhuanlan.zhihu.com/p/53794989)
> - [高能NLP之路的专栏](https://zhuanlan.zhihu.com/c_1064159241216102400)
> - [NLP将迎来黄金十年 from MSRA](https://www.msra.cn/zh-cn/news/executivebylines/tech-bylines-nlp) 通篇似乎都在强调知识和常识引入对NLP乃至整个AI的重要性。

**2018 美团技术团队发表两篇重磅级文章：**

- [美团餐饮娱乐知识图谱——美团大脑揭秘](https://tech.meituan.com/2018/11/22/meituan-brain-nlp-01.html)
- [美团大脑：知识图谱的建模方法及其应用](https://tech.meituan.com/2018/11/01/meituan-ai-nlp.html)

> 人工智能背后两大技术驱动力：**深度学习和知识图谱**，知识图谱就是人工智能的基础。

## 1. AI 算法基础

### 1.1 防止 overfiting 的 8 条

> 1). get more data
> 2). Data augmentation
> 3). Regularization（权值衰减）. (L1 拉普拉斯先验, L2 高斯先验)
> 4). Dropout (类似 RF bagging 作用，最后以投票的方式降低过拟合；)
> 5). Choosing Right Network Structure
> 6). Early stopping
> 7). Model Ensumble
> 8). Batch Normalization

> [张俊林 - Batch Normalization导读](https://zhuanlan.zhihu.com/p/38176412) 、 [张俊林 - 深度学习中的Normalization模型](https://zhuanlan.zhihu.com/p/43200897)
> 
> `Internal Covariate Shift` & Independent and identically distributed，缩写为 `IID`
> 
> Batch Normalization 可以有效避免复杂参数对网络训练产生的影响，也可提高泛化能力.
>
> 神经网路的训练过程的本质是学习数据分布，如果训练数据与测试数据分布不同，将大大降低网络泛化能力， BN 是针对每一批数据，在网络的每一层输入之前增加 BN，(均值0，标准差1)。
>
> Dropout 可以抑制过拟合，作用于每份小批量的训练数据，随机丢弃部分神经元机制. bagging 原理.
>
> [ML算法： 关于防止过拟合，整理了 8 条迭代方向](https://posts.careerengine.us/p/5cae13b2d401440a7fe047af)

### 1.2 机器学习之类别不平衡问题

机器学习之类别不平衡问题 (1) —— 各种评估指标

> 1）过采样和欠采样；（1. 随机过采样(不太使用了，重采样往往会导致严重的过拟合)， 2. **Border-line SMOTE**）
> 2）修改权重（修改损失函数）；
> 3）集成方法：bagging，类似随机森林、自助采样；
> 4）多任务联合学习；

> - [机器学习之类别不平衡问题 (1) —— 各种评估指标][2.1]
> - [机器学习之类别不平衡问题 (2) —— ROC和PR曲线][2.2]
> - [机器学习之类别不平衡问题 (3) —— 采样方法][2.3]

[2.1]: https://zhuanlan.zhihu.com/p/34473430
[2.2]: https://zhuanlan.zhihu.com/p/34655990
[2.3]: https://zhuanlan.zhihu.com/p/41237940

### 1.6 Linear vs Nonlinear classifier

> 线性和非线性是针对，模型参数和输入特征来讲的；
>
> 比如输入x，模型 y=ax+ax^2 那么就是 nonlinear model 如果输入是x和X^2则模型是线性的。
>
> 1. Linear classifier 可解释性好，计算复杂度较低，不足之处是模型的拟合效果相对弱些。
> 2. nonlinear classifier 拟合能力较强，不足之处是数据量不足容易 **overfiting** 、计算复杂度高、解释性不好。
> 
> Linear classifier ：LR,贝叶斯分类，单层感知机、线性回归
> 
> nonlinear classifier：决策树、RF、GBDT、多层感知机
> 
> SVM 两种都有（看线性核还是高斯核）

## 2. NLP高频问题

[NLP 神经网络发展历史中最重要的 8 个里程碑](https://www.infoq.cn/article/66vicQt*GTIFy33B4mu9)

> 1. Language Model (语言模型就是要看到上文预测下文, So NNLM)
> 
> 2. n-gram model（n元模型）（基于 马尔可夫假设 思想）
> 
> 3. 2001 - **NNLM** , @Bengio , 火于 2013 年， 沉寂十年终时来运转。 但很快又被NLP工作者祭入神殿。
> 
> 4. 2008 - Multi-task learning
> 
> 5. 2013 - Word2Vec (Word Embedding的工具word2vec : CBOW 和 Skip-gram)
> 
> 6. 2014 - Glove
> 
> 6. 2014 - sequence-to-sequence
> 
> 7. 2015 - Attention
> 
> 8. 2015 - Memory-based networks
> 
> 9. 2017 - fastText
> 
> 10. 2018 - Pretrained language models

[Word2Vec介绍: 为什么使用负采样（negtive sample）？](https://zhuanlan.zhihu.com/p/29488930)

> 1）其本质都可以看作是 Language Model；

> 2）词向量只不过 NNLM 一个产物， word2vec 虽然其本质也是 Language Model，但是其专注于**词向量本身**，因此做了许多优化来提高计算效率：

> 与 NNLM 相比，词向量直接sum，不再拼接，并舍弃隐层；
> 考虑到 sofmax归一化 需要遍历整个词汇表，采用 hierarchical softmax 和 negative sampling 进行优化

> 1. hierarchical softmax 实质上生成一颗带权路径最小的哈夫曼树，让高频词搜索路劲变小；
> 2. negative sampling 更为直接，实质上对每一个样本中每一个词都进行负例采样；

**Hierarchical Softmax 缺点:**

> 如果我们的训练样本里的中心词w是一个很生僻的词，那么就得在霍夫曼树中辛苦的向下走很久了.


### 2.2 negative sampling

> 1）如果通过一个正例和neg个负例进行二元逻辑回归呢？ 2） 如何进行负采样呢？

负采样这个点引入 word2vec 非常巧妙，两个作用，

> 1. 加速了模型计算
> 2. 保证了模型训练的效果
> 
> 第一，model 每次只需要更新采样的词的权重，不用更新所有的权重，那样会很慢。
> 
> 第二，中心词其实只跟它周围的词有关系，位置离着很远的词没有关系，也没必要同时训练更新，作者这点聪明.

- [good good, word2vec Negative Sampling 刘建平Pinard](https://www.cnblogs.com/pinard/p/7249903.html)

> [知乎: 哈夫曼树](https://zhuanlan.zhihu.com/p/46430775)
> 
> 给定n权值作为n个叶子节点，构造一棵二叉树，若这棵二叉树的带权路径长度达到最小，则称这样的二叉树为最优二叉树，也称为Huffman树。

### 2.3 word2vec vs fastText

> 1. 都可以无监督学习词向量， fastText 训练词向量时会考虑 subword；
> 2. fastText 还可以进行有监督学习进行文本分类

其主要特点：

> - 结构与CBOW类似，但学习目标是人工标注的分类结果；
> - 采用 hierarchical softmax 对输出的分类标签建立哈夫曼树，样本中标签多的类别被分配短的搜寻路径；
> - 引入 N-gram，考虑词序特征；
> - 引入 subword 来处理长词，处理未登陆词问题；

### 2.4 word2vec vs glove

1. 目标函数不同 （crossentrpy vs 平方损失函数）
2. glove 全局统计固定语料信息

> - word2vec 是局部语料库训练的，其特征提取是基于滑窗的；而glove的滑窗是为了构建co-occurance matrix，是基于全局语料的，可见glove需要事先统计共现概率；因此，word2vec可以进行在线学习，glove则需要统计固定语料信息。
>
>
> - word2vec 是无监督学习，同样由于不需要人工标注；glove通常被认为是无监督学习，但实际上glove还是有label的，即共现次数log(X_{ij})。
>
>
> - word2vec 损失函数实质上是带权重的**crossentrpy**，权重固定；glove的损失函数是最小**平方损失函数**，权重可以做映射变换。
> 
>
> - 总体来看，glove 可以被看作是更换了目标函数和权重函数的全局 word2vec。

### 2.5 ELMO vs GPT vs BERT

![](https://pic1.zhimg.com/80/v2-004df09bcc2f085c72cc0938c08b1910_hd.jpg)

之前介绍词向量均是静态的词向量，无法解决一次多义等问题。下面介绍三种elmo、GPT、bert词向量，它们都是基于语言模型的动态词向量。下面从几个方面对这三者进行对比：

（1）**特征提取器**：elmo采用LSTM进行提取，GPT和bert则采用Transformer进行提取。很多任务表明Transformer特征提取能力强于LSTM，elmo采用1层静态向量+2层LSTM，多层提取能力有限，而GPT和bert中的Transformer可采用多层，并行计算能力强。

（2）**单/双向语言模型**：

GPT采用单向语言模型，elmo和bert采用双向语言模型。但是elmo实际上是两个单向语言模型（方向相反）的拼接，这种融合特征的能力比bert一体化融合特征方式弱。
GPT和bert都采用Transformer，Transformer是encoder-decoder结构，GPT的单向语言模型采用decoder部分，decoder的部分见到的都是不完整的句子；bert的双向语言模型则采用encoder部分，采用了完整句子。

**1. 进退维谷的 RNN**

> 1. RNN (包括LSTM、GRU + Attention) 效果与 Transformer 差距很明显
> 2. RNN 很难并行计算。 由于 RNN 特点 ： 线形序列收集前面的信息。
>
> 一个严重阻碍RNN将来继续走红的问题是：RNN本身的序列依赖结构对于大规模并行计算来说相当之不友好。通俗点说，就是RNN很难具备高效的并行计算能力，这个乍一看好像不是太大的问题，其实问题很严重。
>
> 对于小数据集 RNN 可能速度更快些， Transformer 慢些， 但是可以改进 Transformer 缓解：
>
>  1. 可把Block数目降低，减少参数量；
>  2. 引入Bert两阶段训练模型，那么对于小数据集合来说会极大缓解效果问题。

**2. 一希尚存的 CNN**
 
> 1. CNN 天生自带的高并行计算能力
> 2. 一些深度网络的优化trick，CNN在NLP领域里的深度逐步能做起来了。dilated CNN
> 
> 
> 早期CNN做不好NLP的一个很大原因是网络深度做不起来。 原生的CNN在很多方面仍然是比不过Transformer的，典型的还是长距离特征捕获能力方面，而这点在NLP界算是比较严重的缺陷。
> 
> 对于远距离特征，单层怀旧版CNN是无法捕获到的，如果滑动窗口k最大为2，而如果有个远距离特征距离是5，那么无论上多少个卷积核，都无法覆盖到长度为5的距离的输入，所以它是无法捕获长距离特征的
> 
> 滑动窗口从左到右滑动，捕获到的特征也是如此顺序排列，所以它在结构上已经记录了相对位置信息了。但是如果卷积层后面立即接上Pooling层的话，Max Pooling的操作逻辑是：从一个卷积核获得的特征向量里只选中并保留最强的那一个特征，所以到了Pooling层，位置信息就被扔掉了，这在NLP里其实是有信息损失的。所以在NLP领域里，目前CNN的一个发展趋势是抛弃Pooling层，靠全卷积层来叠加网络深度。
> 
> 怀旧版 CNN模型 一直处于被 RNN模型 压制到抑郁症早期的尴尬局面。

> **CNN的进化**：物竞天择的模型斗兽场
 
> 摩登CNN（使用Skip Connection来辅助优化）、Dilated CNN 
> 
> 想方设法把CNN的深度做起来，随着深度的增加，很多看似无关的问题就随之解决了。

**3. Transformer**
 
Transformer改进了RNN最被人诟病的训练慢的缺点，利用self-attention机制实现快速并行。并且Transformer可以增加到非常深的深度，充分发掘DNN模型的特性，提升模型准确率。
 
> Transformer作为新模型，并不是完美无缺的。它也有明显的缺点：首先，对于长输入的任务，典型的比如篇章级别的任务（例如文本摘要），因为任务的输入太长，Transformer会有巨大的计算复杂度，导致速度会急剧变慢。


### 2.8 Attention

除此之外模型为了取得比较好的效果还是用了下面三个小技巧来改善性能：

> 深层次的LSTM：作者使用了4层LSTM作为encoder和decoder模型，并且表示深层次的模型比shallow的模型效果要好（单层，神经元个数多）。
>
> 将source进行反序输入：输入的时候将“ABC”变成“CBA”，这样做的好处是解决了长序列的long-term依赖，使得模型可以学习到更多的对应关系，从而达到比较好的效果。
> 
> Beam Search：这是在test时的技巧，也就是在训练过程中不会使用。
>
> 一般来讲我们会采用greedy贪婪式的序列生成方法，也就是每一步都取概率最大的元素作为当前输出，但是这样的缺点就是一旦某一个输出选错了，可能就会导致最终结果出错，所以使用beam search的方法来改善。也就是每一步都取概率最大的k个序列（beam size），并作为下一次的输入。更详细的解释和例子可以参考下面这个链接：https://zhuanlan.zhihu.com/p/28048246

### 2.9 文本分类任务 tricks

在文本分类任务中，有哪些论文中很少提及却对性能有重要影响的tricks？

> 1. 数据预处理时vocab的选取（前N个高频词或者过滤掉出现次数小于3的词等等）
> 2. 词向量的选择，可以使用预训练好的词向量如谷歌、facebook开源出来的，当训练集比较大的时候也可以进行微调或者随机初始化与训练同时进行。训练集较小时就别微调了
> 3. 结合要使用的模型，这里可以把数据处理成char、word或者都用等
> 4. 有时将词性标注信息也加入训练数据会收到比较好的效果
> 5. 至于PAD的话，取均值或者一个稍微比较大的数，但是别取最大值那种应该都还好
> 6. 神经网络结构的话到没有什么要说的，可以多试几种比如fastText、TextCNN、RCNN、char-CNN/RNN、HAN等等。哦，对了，加上dropout和BN可能会有意外收获。反正模型这块还是要具体问题具体分析吧，根据自己的需求对模型进行修改（比如之前参加知乎竞赛的时候，最终的分类标签也有文本描述，所以就可以把这部分信息也加到模型之中等等）
> 7. 超参数的话，推荐看看之前TextCNN的一篇论文，个人感觉足够了“A Sensitivity Analysis of (and Practitioners’ Guide to) Convolutional Neural Networks for Sentence Classification”
> 8. 之前还见别人在文本领域用过数据增强的方法，就是对文本进行随机的shuffle和drop等操作来增加数据量

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


