## NLP 的发展

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
 
## 1. Language Model

$$
P(w\_{i}|w\_{1}, w\_{2}, ..., w\_{i-1}) = P(w\_i | w\_{i-N+1}, w\_{i-N+2}, ..., w\_{i-1})
$$

## 2. Perplexity

计算perplexity的公式如下：

<img src="/images/tensorflow/tf-google-9.1.2_1-equation.svg" width="600" />

**perplexity** 刻画的是语言模型预测一个语言样本的能力. 比如已经知道 (w1,w2,w3,…,wm) 这句话会出现在语料库之中，那么通过语言模型计算得到的这句话的概率越高，说明语言模型对这个语料库拟合得越好。

perplexity 实际是计算每一个单词得到的概率倒数的 几何平均(**geometric mean**) ，因此 perplexity 可以理解为平均分支系数（average branching factor），即模型预测下一个词时的平均可选择数量。

[参见： arithmetic average vs geometric mean](https://zhuanlan.zhihu.com/p/23809612)

在语言模型的训练中，通常采用 perplexity 的 **`log`** 表达形式：

<img src="/images/tensorflow/tf-google-9.1.2_2-equation.svg" width="600" />

> 相比较乘积求平方根的方式，加法的形式可加速计算，同时避免概率乘积数值过小而导致浮点数向下溢出的问题.
> 
> 在数学上，log perplexity 可以看作真实分布与预测分布之间的交叉熵 Cross Entropy, 交叉熵描述了两个概率分布之间的一种距离. log perplexity 和 Cross Entropy 是等价的

## 2. Recurrent Neural Networks

- **输入和输出的长度不尽相同**
- **无法共享从其他位置学来的特征**

<img src="/images/deeplearning/RNN-01.png" width="500" />

> - 很多数据是以序列形式存在的，例如文本、语音、视频、点击流等等。

**Typical RNN Structure:**

在 $h\_T$ 后面直接接一个 Softmax 层，输出文本所属类别的预测概率 $y$，就可以实现文本分类.

<img src="/images/deeplearning/RNN-02.png" width="650" />

可应用于多种具体任务：

$$
net\_{t}=U x\_{t}+W h\_{t-1}
$$

$$
h\_{t}=f\left(\text {net}\_{t}\right)
$$

$$
y=g\left(V h\_{T}\right)
$$

其中 $f$ 和 $g$ 为激活函数，$U$ 为输入层到隐含层的权重矩阵，$W$ 为隐含层从上一时刻到下一时刻状态转移的权重矩阵。在文本分类任务中，$f$ 可以选取 Tanh 函数或者 ReLU 函数，$g$ 可以采用 Softmax 函数。

**TensorFlow RNN**

<img src="/images/tensorflow/tf-google-8-1.jpg" width="700" alt="Forward Propagation" />

[更多详情参见本博： TensorFlow：第8章 Recurrent Neural Networks 1](/2018/11/08/tensorflow/tf-google-8-rnn-1/)

> 1. RNN 优点： 最大程度捕捉上下文信息，这可能有利于捕获长文本的语义。
> 2. RNN 缺点： 是一个有偏倚的模型，在这个模型中，后面的单词比先前的单词更具优势。因此，当它被用于捕获整个文档的语义时，它可能会降低效率，因为关键组件可能出现在文档中的任何地方，而不是最后。

- [Recurrent Neural Networks](/2019/06/14/deeplearning/RNN-LSTM-GRU/)

## 3. NNLM

NNLM,直接从语言模型出发，将模型最优化过程转化为求词向量表示的过程.

<img src="/images/nlp/word2vec-nnlm.png" width="600" />

**使用词嵌三步**

> 1. 获得词嵌：获得的方式可以通过训练大的文本集或者下载很多开源的词嵌库
> 2. 应用词嵌：将获得的词嵌应用在我们的训练任务中
> 3. 可选：通过我们的训练任务更新词嵌库（如果训练量很小就不要更新了）

## 4. word2vec

word2vec 并不是一个模型， 而是一个 2013年 google 发表的工具. 

该工具包含2个模型： 

1. Skip-Gram 
2. CBOW. 

该工具包含2种高效训练方法： 

1. negative sampling 
2. hierarchicam softmax.

> 词向量（词的特征向量）既能够降低维度，又能够capture到当前词在本句子中上下文的信息

**CBOW** (context(W)->center)

<img src="/images/nlp/word2vec-CBOW_1.png" width="600" />

> 纠错 : 上图”目标函数“的第一个公式，应该是 连乘 公式，不是 连加 运算。
> 
> 理解 : 背景词向量与 中心词向量 内积 等部分，你可考虑 softmax $w \* x+b$ 中 $x$ 和 $w$ 的关系来理解.

### 4.1 Negative Sampling

> 1）如何通过一个正例和neg个负例进行二元逻辑回归呢？ 2） **`如何进行负采样呢`**？

-  **如何进行 negative sampling**？

每个词𝑤的线段长度由下式决定：

$$
len(w) = \frac{count(w)}{\sum\limits\_{u \in vocab} count(u)}
$$

- 在word2vec中，分子和分母都取了3/4次幂如下：

$$
len(w) = \frac{count(w)^{3/4}}{\sum\limits\_{u \in vocab} count(u)^{3/4}}
$$

<img src="/images/nlp/word2vec-neg.png" width="600" />

负采样这个点引入 word2vec 非常巧妙，两个作用，

> 1. 加速了模型计算
> 2. 保证了模型训练的效果
> 
> 第一，model 每次只需要更新采样的词的权重，不用更新所有的权重，那样会很慢。
> 
> 第二，中心词其实只跟它周围的词有关系，位置离着很远的词没有关系，也没必要同时训练更新，作者这点聪明.

- [good, word2vec Negative Sampling 刘建平Pinard](https://www.cnblogs.com/pinard/p/7249903.html)

### 4.2 Hierarchicam Softmax

> [知乎: Huffman Tree](https://zhuanlan.zhihu.com/p/46430775)
> 
> 给定n权值作为n个叶子节点，构造一棵二叉树，若这棵二叉树的带权路径长度达到最小，则称这样的二叉树为最优二叉树，也称为Huffman树。

**word2vec vs glove**

1. 目标函数不同 （crossentrpy vs 平方损失函数）
2. glove 全局统计固定语料信息

> - word2vec 是局部语料库训练的，其特征提取是基于滑窗的；而glove的滑窗是为了构建co-occurance matrix，是基于全局语料的，可见glove需要事先统计共现概率；因此，word2vec可以进行在线学习，glove则需要统计固定语料信息。
> 
> - 总体来看，glove 可以被看作是更换了目标函数和权重函数的全局 word2vec。

## 5. fastText

FastText是一个快速文本分类算法，在使用标准多核CPU的情况下，在10分钟内可以对超过10亿个单词进行训练。 不需要使用预先训练好的词向量，因为FastText会自己训练词向量。

<img src="/images/nlp/fastText-4.webp" width="500" />

fastText 能够做到效果好，速度快，主要依靠两个秘密武器：

> 1. 结构与CBOW类似，但学习目标是人工标注的分类结果；
> 2. 用到了 层次化Softmax回归 (Hierarchical Softmax) 的训练 trick.
> 3. 引入 N-gram，考虑词序特征；
> 4. 引入 subword 来处理长词，处理未登陆词问题；

## 6. Seq2Seq 

<img src="/images/deeplearning/Seq2Seq-03.jpg" width="600" alt="Encoder-Decoder" />

Source 和 Target 分别由各自的单词序列构成：

$$
Source = ({x}\_1, {x}\_2, ..., {x}\_m)
$$

$$
Target = ({y}\_1, {y}\_2, ..., {y}\_n)
$$


Encoder 顾名思义就是对输入句子Source进行编码，将输入句子通过非线性变换转化为中间语义表示C：

$$
C = F({x}\_1, {x}\_2, ..., {x}\_m)
$$

对于 Decoder 来说，其任务是根据句子 Source 的 中间语义表示 C 和 之前已经生成的历史信息

$$
({y}\_1, {y}\_2, ..., {y}\_{i-1})
$$

来生成 i时刻 要生成的单词 ${y}\_{i}$

$$
y\_{i} = g(C, {y}\_1, {y}\_2, ..., {y}\_{i-1})
$$

> 每个 $y\_i$ 都依次这么产生，那么看起来就是整个系统根据输入 句子Source 生成了目标句子Target。
> 
> (1). 如果Source是中文句子，Target是英文句子，那么这就是解决机器翻译问题；
> (2). 如果Source是一篇文章，Target是概括性的几句描述语句，那么这是文本摘要；
> (3). 如果Source是一句问句，Target是一句回答，那么这是问答系统。

在模型训练中，所有输出序列损失的均值通常作为需要最小化的损失函数。

**train seq2seq model**

根据最大似然估计，我们可以最大化输出序列基于输入序列的条件概率

$$
\begin{split}\begin{aligned}
{P}(y\_1, \ldots, y\_{T'} \mid x\_1, \ldots, x\_T)
&= \prod\_{t'=1}^{T'} {P}(y\_{t'} \mid y\_1, \ldots, y\_{t'-1}, x\_1, \ldots, x\_T)\\\\
&= \prod\_{t'=1}^{T'} {P}(y\_{t'} \mid y\_1, \ldots, y\_{t'-1}, \boldsymbol{c}),
\end{aligned}\end{split}
$$

并得到该输出序列的损失

$$ - \log{P}(y\_1, \ldots, y\_{T'} \mid x\_1, \ldots, x\_T) = -\sum\_{t'=1}^{T'} \log {P}(y\_{t'} \mid y\_1,  \ldots, y\_{t'-1}, \boldsymbol{c}),
$$

> 在 train 中，所有输出序列损失的均值通常作为需要最小化的损失函数。
> 
> 在 predict 中，我们需要将decode在上一个时间步的输出作为当前时间步的输入 Or **teacher forcing**。

**summary**

> - Encoder—Decoder（seq2seq）可以输入并输出不定长的序列。Encoder—Decoder 使用了两个 RNN .
> - Encoder—Decoder 的训练中，我们可以采用 teacher forcing。(这也是 Seq2Seq 2 的内容)
> 
> 将source进行反序输入：输入的时候将“ABC”变成“CBA”，这样做的好处是解决了长序列的long-term依赖，使得模型可以学习到更多的对应关系，从而达到比较好的效果。
> 
> Beam Search：这是在test时的技巧，也就是在训练过程中不会使用。

## 7. Attention

请务必要阅读： [张俊林 深度学习中的注意力模型（2017版）](https://zhuanlan.zhihu.com/p/37601161)

<img src="/images/deeplearning/Attention-01.jpg" width="600" />

**Attention 本质思想**

把Attention机制从上文讲述例子中的Encoder-Decoder框架中剥离，并进一步做抽象，可以更容易懂:

<img src="/images/deeplearning/Attention-04.jpg" width="600" />

**Attention 的三阶段**

> 1. 第一个阶段根据Query和Key计算两者的相似性或者相关性；
> 2. 第二个阶段对第一阶段的原始分值进行归一化处理；
> 3. 根据权重系数对Value进行加权求和。

<img src="/images/deeplearning/Attention-03.jpg" width="600" />

## 8. GPT & ELMO

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

## 9. Transformer

Transformer 改进了RNN最被人诟病的训练慢的缺点，利用self-attention机制实现快速并行。

Transformer 可以增加到非常深的深度，充分发掘DNN模型的特性，提升模型准确率。

[务必阅读： The Illustrated Transformer 中文版](https://zhuanlan.zhihu.com/p/54356280)
 
Q、K、V 它们都是有助于计算和理解注意力机制的抽象概念

<!--![](/images/nlp/bert-zh-3.jpg)-->

<img src="/images/nlp/bert-zh-3.jpg" width="600" />

所有的编码器在结构上都是相同的，但它们没有共享参数。每个解码器都可以分解成两个子层。

<!--![](/images/nlp/bert-zh-4.jpg)-->

<img src="/images/nlp/bert-zh-4.jpg" width="600" />

解码器中也有编码器的自注意力（self-attention）层和前馈（feed-forward）层。除此之外，这两个层之间还有一个注意力层，用来关注输入句子的相关部分（和seq2seq模型的注意力作用相似）。

一个公式来计算自注意力层的输出

<img src="/images/nlp/bert-zh-14.jpg" width="600" />

<!--<img src="/images/nlp/bert-zh-17.jpg" width="500" />
-->
解码组件

<img src="/images/nlp/bert-11.gif" width="650" />

<!--![](/images/nlp/bert-zh-12.jpg)-->

<!--![](/images/nlp/bert-zh-17.jpg)-->

<!--![](/images/nlp/bert-11.gif)-->

> Transformer作为新模型，并不是完美无缺的。它也有明显的缺点：首先，对于长输入的任务，典型的比如篇章级别的任务（例如文本摘要），因为任务的输入太长，Transformer会有巨大的计算复杂度，导致速度会急剧变慢。

## 10. Task tricks

在文本分类任务中，有哪些论文中很少提及却对性能有重要影响的tricks？

> 1. 数据预处理时vocab的选取（前N个高频词或者过滤掉出现次数小于3的词等等）
> 2. 词向量的选择，可以使用预训练好的词向量如谷歌、facebook开源出来的，当训练集比较大的时候也可以进行微调或者随机初始化与训练同时进行。训练集较小时就别微调了
> 3. 结合要使用的模型，这里可以把数据处理成char、word或者都用等
> 4. 有时将词性标注信息也加入训练数据会收到比较好的效果
> 5. 至于PAD的话，取均值或者一个稍微比较大的数，但是别取最大值那种应该都还好
> 6. 神经网络结构的话到没有什么要说的，可以多试几种比如fastText、TextCNN、RCNN、char-CNN/RNN、HAN等等。加上dropout和BN可能会有意外收获。反正模型这块还是要具体问题具体分析吧，（比如之前参加知乎竞赛的时候，最终的分类标签也有文本描述，所以就可以把这部分信息也加到模型之中等等）

**Overfiting 8 条**

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

## Reference

- [Language Model and Perplexity][3]
- [sklearn: TfidfVectorizer 中文处理及一些使用参数][1]
- [sklearn.feature_extraction.text.TfidfVectorizer函数说明][2]

[1]: https://blog.csdn.net/blmoistawinde/article/details/80816179
[2]: https://blog.csdn.net/binglingzy666/article/details/79241486
[3]: /2019/06/16/nlp/Language-Model-and-Word-Embedding/