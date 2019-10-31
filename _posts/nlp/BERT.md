---
title: BERT 完全指南
date: 2019-06-20 11:00:21
categories: nlp
tags: BERT
---

<a href="/2019/06/20/nlp/BERT/" target="_self"><img src="/images/nlp/Bert-Ernie-logo.jpg" width="550" alt="Bert-Ernie" />
</a>

<!--<a href="/2019/06/30/nlp/BERT/" target="_self" style="display:block; margin:0 auto; background:url('/images/nlp/Bert-Ernie-logo.jpg') no-repeat 0 0 / contain; height:323px; width:550px;"></a>-->

<!-- more -->

**2018.10** google 发布 **BERT** 模型. 引爆整个AI圈的 NLP 模型. 在 NLP领域 刷新 11 项记录.

**BERT** 其实是 language_encoder，把输入的 sentence 或 paragraph 转成 feature_vector（embedding）.

**Paper**: [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805)

**BERT** 创新点在于提出了一套完整的方案，利用之前最新的算法模型，去解决各种各样的 NLP 任务.

<!-- more -->

---

<!--![](/images/nlp/language-mode-l.jpg)
-->

## 1. NLP 的发展

[NLP 神经网络发展历史中最重要的 8 个里程碑](https://www.infoq.cn/article/66vicQt*GTIFy33B4mu9)

> 1. Language Model (语言模型就是要看到上文预测下文, So NNLM)
> 
> 2. n-gram model（n元模型）（基于 马尔可夫假设 思想）**上下文相关的特性 建立数学模型**。
> 
> 3. 2001 - **NNLM** , @Bengio , 火于 2013 年， 沉寂十年终时来运转。 但很快又被NLP工作者祭入神殿。 
> 
> 4. 2008 - Multi-task learning
> 
> 5. 2013 - Word2Vec (Word Embedding的工具word2vec : CBOW 和 Skip-gram)
> 
> 6. 2014 - sequence-to-sequence 
> 
> 7. 2015 - Attention
> 
> 8. 2015 - Memory-based networks
> 
> 9. 2018 - Pretrained language models

[good 张俊林: 深度学习中的注意力模型（2017版）](https://zhuanlan.zhihu.com/p/37601161)

[good 张俊林: 从Word Embedding到Bert模型—自然语言处理中的预训练技术发展史](https://zhuanlan.zhihu.com/p/49271699) 
 
**NNLM vs Word2Vec**

> 1. NNLM 目标： 训练语言模型， 语言模型就是要看上文预测下文， word embedding 只是无心的一个副产品。
> 2. Word2Vec目标： 它单纯就是要 word embedding 的，这是主产品。
> 
> 2018 年之前的 Word Embedding 有个缺点就是无法处理 **多义词** 的问题, 静态词嵌.

**ELMO: Embedding from Language Models**

> ELMO的论文题目：“Deep contextualized word representation”
> 
> NAACL 2018 最佳论文 - ELMO： Deep contextualized word representation
>
> ELMO 本身是个根据当前上下文对Word Embedding动态调整的思路。
>
> **ELMO 有什么缺点？**
> 
>  1. LSTM 抽取特征能力远弱于 Transformer
>  2. 拼接方式双向融合特征能力偏弱

**GPT (Generative Pre-Training) **

> 1. 第一个阶段是利用 language 进行 Pre-Training.
> 2. 第二阶段通过 Fine-tuning 的模式解决下游任务。
>
> **GPT: 有什么缺点？**
>
> 1. 要是把 language model 改造成双向就好了
> 2. 不太会炒作，GPT 也是非常重要的工作.
 
**Bert 亮点 : 效果好 和 普适性强**

> 1. Transformer 特征抽取器
> 2. Language Model 作为训练任务 (双向)
>
> Bert 采用和 GPT 完全相同的 **两阶段** 模型：
>
> 1. Pre-Train Language Model；
> 2. Fine-> Tuning模式解决下游任务。

**NLP 的 4大任务**

4 NLP task | description
:----: | :---:
序列标注 | 特点是句子中**每个单词**要求模型根据上下文都要给出一个 分类**label**；
分类任务 | 特点是不管文章有多长，总体给出一个分类**label** 即可；
句子关系判断 | 特点是给定两个句子，模型**判断出两个句子** 是否具备某种语义关系；
生成式任务 |  特点是输入文本内容后，需要自主生成另外一段文字。

---

![](https://pic3.zhimg.com/80/v2-0245d07d9e227d1cb1091d96bf499032_hd.jpg)

<!--
## 2. Word Representation

要处理 NLP 问题，首先要解决 **Word Representation 文本表示** 问题。虽然我们人去看文本，能够清楚明白文本中的符号表达什么含义，但是计算机只能做数学计算，需要将文本表示成计算机可以处理的形式。

![](https://pic3.zhimg.com/80/v2-597b011ddd148eb53b5a90730b6090ae_hd.jpg)

后来出现了词向量，word embedding，用一个低维稠密的向量去表示一个词。通常这个向量的维度在几百到上千之间，词向量可以通过一些无监督的方法学习得到，比如 CBOW 或 Skip-Gram 等.

> 更多 Word Embeddings 请参见： [Sequence Models (week2) - NLP - Word Embeddings ](/2018/08/02/deeplearning/Sequence-Models-week2/)
> 
> 在图像中就不存在表示方法的困扰，因为图像本身就是数值矩阵，计算机可以直接处理。

NLP 领域经常引入一种做法，在非常大的语料库上进行 pre-training，然后在特定任务上进行 fine-tuning.
BERT 就是用了一个已有的模型结构，提出了一整套的 pre-training 方法和 fine-tuning 方法.-->

[good 张俊林: 放弃幻想，全面拥抱Transformer：自然语言处理三大特征抽取器（CNN/RNN/TF）比较][2]

## 2. Feature Extraction

> 1. RNN 人老珠黄，已经基本完成它的历史使命，将来会逐步退出历史舞台；
> 2. CNN 如果改造成功并超出期望，那么还有一丝可能继续生存壮大；
> 3. Transformer 明显会很快成为 NLP里 担当大任的最主流的特征抽取器。
>
> 特征抽取器能否具备长距离特征捕获能力这一点对于解决NLP任务来说也是很关键的。
>
> 一个特征抽取器是否适配问题领域的特点，有时候决定了它的成败，而很多模型改进的方向，其实就是改造得使得它更匹配领域问题的特性。

Three Feature Extraction:

> “Transformer考上了北京大学；CNN进了中等技术学校，希望有一天能够考研考进北京大学；RNN在百货公司当售货员：我们都有看似光明的前途。”

> **1. 进退维谷的 RNN**
>
> 1. RNN (包括LSTM、GRU + Attention) 效果与 Transformer 差距很明显
> 2. RNN 很难并行计算。 由于 RNN 特点 ： 线形序列收集前面的信息。
>
> 一个严重阻碍RNN将来继续走红的问题是：RNN本身的序列依赖结构对于大规模并行计算来说相当之不友好。通俗点说，就是RNN很难具备高效的并行计算能力，这个乍一看好像不是太大的问题，其实问题很严重。
>
> 对于小数据集 RNN 可能速度更快些， Transformer 慢些， 但是可以改进 Transformer 缓解：
>
>  1. 可把Block数目降低，减少参数量；
>  2. 引入Bert两阶段训练模型，那么对于小数据集合来说会极大缓解效果问题。
> 
> **2. 一希尚存的 CNN**
> 
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
>
> **CNN的进化**：物竞天择的模型斗兽场
> 
> 摩登CNN（使用Skip Connection来辅助优化）、Dilated CNN 
> 
> 想方设法把CNN的深度做起来，随着深度的增加，很多看似无关的问题就随之解决了。
>
>
> **3. Transformer**
> 
> Transformer作为新模型，并不是完美无缺的。它也有明显的缺点：首先，对于长输入的任务，典型的比如篇章级别的任务（例如文本摘要），因为任务的输入太长，Transformer会有巨大的计算复杂度，导致速度会急剧变慢。
> 
> 做语义特征抽取能力比较时，结论是对于距离远与13的长距离特征，Transformer性能弱于RNN，比较出乎意料，因为Transformer通过Self attention使得远距离特征直接发生关系，按理说距离不应该成为它的问题，但是效果竟然不如RNN，这背后的原因是什么呢？这也是很有价值的一个探索点。

**华山论剑：三大特征抽取器比较**

> 总而言之，关于三者速度对比方面，目前的主流经验结论基本如上所述：Transformer Base最快，CNN次之，再次Transformer Big，最慢的是RNN。RNN比前两者慢了3倍到几十倍之间。

> 单从任务综合效果方面来说，Transformer明显优于CNN，CNN略微优于RNN。速度方面Transformer和CNN明显占优，RNN在这方面劣势非常明显。这两者再综合起来，如果我给的排序结果是Transformer>CNN>RNN
> 
> 从速度和效果折衷的角度看，对于工业界应用，特征抽取选择方面配置**Transformer base**是个较好的选择。

[good 张俊林: 放弃幻想，全面拥抱Transformer：自然语言处理三大特征抽取器（CNN/RNN/TF）比较][2]

**NLP 4 大任务：**

1. 序列标注 (分词、POS Tag、NER、语义标注)
2. 分类任务
3. 句子关系判断 （Entailment、QA、语义改写）
4. 生成式任务 （机器翻译、文本摘要、写诗造句、看图说话）

> 解决这些不同的任务，从模型角度来讲什么最重要？是特征抽取器的能力。尤其是深度学习流行开来后，这一点更凸显出来。因为深度学习最大的优点是“端到端（end to end）”，当然这里不是指的从客户端到云端，意思是以前研发人员得考虑设计抽取哪些特征，而端到端时代后，这些你完全不用管，把原始输入扔给好的特征抽取器，它自己会把有用的特征抽取出来。


## 3. Attention

![](/images/nlp/attention.jpg)

> Attention model 物理含义: 看作是输出 Target句子 中某个单词和输入 Source句子 每个单词的 **对齐模型**.
> 
> Self Attention 可以认为是一种特殊的 Source == Target 的情况.

[good 张俊林: 深度学习中的 Attention Model（2017版）](https://zhuanlan.zhihu.com/p/37601161)

## 4. Transformer

BERT 所采用的算法来自于 **2017.12 google Transformer**: [Attenion Is All You Need](https://arxiv.org/abs/1706.03762)

入门 Transformer 的可以参考以下三篇文章：

> 第一篇是 Jay Alammar's Blog
> 
> [Transformer](https://jalammar.github.io/illustrated-transformer/)
> 
> [The Illustrated Transformer【译】](https://blog.csdn.net/yujianmin1990/article/details/85221271)
> 
> [good The Illustrated Transformer 中文版](https://zhuanlan.zhihu.com/p/54356280)
> 
> 
> <!--![](/images/nlp/bert-4.jpg)-->
> 
> **Q、K、V 它们都是有助于计算和理解注意力机制**的抽象概念
> 
> ![](/images/nlp/bert-6.jpg)
> 
> 第二篇是 Calvo's Blog
> 
> [Dissecting BERT Part 1: The Encoder](https://medium.com/dissecting-bert/dissecting-bert-part-1-d3c3d495cdb3)
> 
> 第三篇是 哈佛大学NLP研究组
> 
> [The Annotated Transformer](http://nlp.seas.harvard.edu/2018/04/03/attention.html)
> 
> [good Transformer 知乎模型笔记，阅读心得](https://zhuanlan.zhihu.com/p/39034683)

<!--![](/images/nlp/bert-2.jpg)-->

> 本文所说的Transformer特征抽取器并非原始论文所指。因为Encoder部分目的比较单纯，就是从原始句子中提取特征，而Decoder部分则功能相对比较多，除了特征提取功能外，还包含语言模型功能，以及用attention机制表达的翻译模型功能。

![](/images/nlp/bert-3.jpg)

- [完全图解自然语言处理中的Transformer——BERT基础（入门长文）](https://blog.csdn.net/qq_42208267/article/details/84967446)
- [tensor2tensor 助于理解](https://colab.research.google.com/github/tensorflow/tensor2tensor/blob/master/tensor2tensor/notebooks/hello_t2t.ipynb)

- [Transformer 知识点理解](https://zhuanlan.zhihu.com/p/58009338)

### 4.1 step

[务必阅读： The Illustrated Transformer 中文版](https://zhuanlan.zhihu.com/p/54356280)

> ![](https://pic4.zhimg.com/80/v2-f5e99be76f0727be85df0d8f4ab88057_hd.jpg)

所有的编码器在结构上都是相同的，但它们没有共享参数。每个解码器都可以分解成两个子层。

> ![](https://pic2.zhimg.com/80/v2-fbb5dbc286b9f9cec2ddbc5eae2bf5a9_hd.jpg)

> 1. 从编码器输入的句子首先会经过一个自注意力（self-attention）层
> 2. 这层帮助编码器在对`每个单词编码时关注输入句子的其他单词`。我们将在稍后的文章中更深入地研究自注意力。

> 自注意力层的输出会传递到前馈（feed-forward）神经网络中。每个位置的单词对应的前馈神经网络都完全一样（译注：另一种解读就是一层窗口为一个单词的一维卷积神经网络）。

> 解码器中也有编码器的自注意力（self-attention）层和前馈（feed-forward）层。除此之外，这两个层之间还有一个注意力层，用来关注输入句子的相关部分（和seq2seq模型的注意力作用相似）。

> ![](https://pic2.zhimg.com/80/v2-1cfd35f0ff43407e25da3ab25631f82d_hd.jpg)

**将张量引入图景**

> ![](https://pic2.zhimg.com/80/v2-d7b0bb93c9f7e7185d690b6df83d8859_hd.jpg)

**现在我们开始“编码”**

> ![](https://pic2.zhimg.com/80/v2-7173f8fa4d601a5255af46d48e9d370d_hd.jpg)

这个softmax分数决定了每个单词对编码当下位置（“Thinking”）的贡献。显然，已经在这个位置上的单词将获得最高的softmax分数，但有时关注另一个与当前单词相关的单词也会有帮助。

第五步是将每个值向量乘以softmax分数(这是为了准备之后将它们求和)。这里的直觉是希望关注语义上相关的单词，并弱化不相关的单词(例如，让它们乘以0.001这样的小数)。

第六步是对加权值向量求和（译注：自注意力的另一种解释就是在编码某个单词时，就是将所有单词的表示（值向量）进行加权求和，而权重是通过该词的表示（键向量）与被编码词表示（查询向量）的点积并通过softmax得到。），然后即得到自注意力层在该位置的输出(在我们的例子中是对于第一个单词)。

> ![](https://pic4.zhimg.com/80/v2-609de8f8f8e628e6a9ca918230c70d67_hd.jpg)

> ![](https://pic4.zhimg.com/80/v2-f8c32c325da61ee587abcd2426854b33_hd.jpg)

> ![](https://pic4.zhimg.com/80/v2-12e11c0fea79bc485a6d9f4a2cb12f7f_hd.jpg)

## 5. BERT

**Action:**

- [hanxiao大佬开源出来的bert-as-service框架很适合初学者][a1]
- [Netycc's blog 利用Bert构建句向量并计算相似度][a2]
- [BERT使用详解(实战)][a3]
- [BERT中文文本相似度计算与文本分类][a4]

[a1]: https://github.com/hanxiao/bert-as-service/blob/master/README.md
[a2]: https://netycc.com/2018/12/05/利用bert构建句向量并计算相似度/
[a3]: https://juejin.im/post/5c6d65a56fb9a04a0f65c45d
[a4]: https://terrifyzhao.github.io/2018/11/29/使用BERT做中文文本相似度计算.html
[a5]: https://terrifyzhao.github.io/2019/01/11/Transformer模型详解.html

**Bert完全指南**

- [BERT完全指南][a6]

[a6]: https://terrifyzhao.github.io/2019/01/17/BERT完全指南.html

## Reference

- [张俊林: 天空之城：拉马努金式思维训练法](https://zhuanlan.zhihu.com/p/51934140)
- [互联网人到了 30 岁，大部分都去干什么了？](https://www.zhihu.com/question/20584585/answer/15559213)
- [AINLP BERT相关论文、文章和代码资源汇总][6]
- [自然语言处理中的Transformer和BERT][1]
- [RNN和LSTM弱！爆！了！注意力模型才是王道][3]
- [NLP突破性成果 BERT 模型详细解读][5]
- [一步步理解BERT][7]
- [当Bert遇上Keras：这可能是Bert最简单的打开姿势][8]


[1]: https://zhuanlan.zhihu.com/p/53099098
[2]: https://zhuanlan.zhihu.com/p/54743941
[3]: https://zhuanlan.zhihu.com/p/36331888
[5]: https://zhuanlan.zhihu.com/p/46997268
[6]: https://zhuanlan.zhihu.com/p/50717786
[7]: https://mp.weixin.qq.com/s/H4at_BDLwZWqlBHLjMZWRQ
[8]: https://kexue.fm/archives/6736

