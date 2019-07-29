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

perplexity 实际是计算每一个单词得到的概率倒数的几何平均，因此 perplexity 可以理解为平均分支系数（average branching factor），即模型预测下一个词时的平均可选择数量。

在语言模型的训练中，通常采用 perplexity 的对数表达形式：

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

word2vec 并不是一个模型， 而是一个 2013年 google 发表的工具. 该工具包含2个模型： Skip-Gram 和 CBOW. 及两种高效训练方法： negative sampling 和 hierarchicam softmax.

> 词向量（词的特征向量）既能够降低维度，又能够capture到当前词在本句子中上下文的信息

**CBOW**

<img src="/images/nlp/word2vec-CBOW_1.png" width="600" />

> 纠错 : 上图”目标函数“的第一个公式，应该是 连乘 公式，不是 连加 运算。
> 
> 理解 : 背景词向量与 中心词向量 内积 等部分，你可考虑 softmax $w \* x+b$ 中 $x$ 和 $w$ 的关系来理解.

## 5. fastText

FastText是一个快速文本分类算法，在使用标准多核CPU的情况下，在10分钟内可以对超过10亿个单词进行训练。 不需要使用预先训练好的词向量，因为FastText会自己训练词向量。

<img src="/images/nlp/fastText-4.webp" width="500" />

fastText 能够做到效果好，速度快，主要依靠两个秘密武器：

> 1. 利用了 词内的n-gram信息 (subword n-gram information)
> 2. 用到了 层次化Softmax回归 (Hierarchical Softmax) 的训练 trick.

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

## Reference

- [Language Model and Perplexity][3]
- [sklearn: TfidfVectorizer 中文处理及一些使用参数][1]
- [sklearn.feature_extraction.text.TfidfVectorizer函数说明][2]

[1]: https://blog.csdn.net/blmoistawinde/article/details/80816179
[2]: https://blog.csdn.net/binglingzy666/article/details/79241486
[3]: /2019/06/16/nlp/Language-Model-and-Word-Embedding/