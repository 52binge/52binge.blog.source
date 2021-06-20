---
title: Language Model and Perplexity
date: 2019-06-16 11:00:21
categories: nlp
tags: PPL
---

{% image "/images/nlp/LM-01.jpg", width="550px", alt="2001 NNLM, @Yoshua bengio" %}

<!-- more -->

计算机很多事情比人类做得好，那么机器是否能懂 Natural Language?

一些 NLP 技术的应用:

> * 简单的任务：拼写检查，关键词检索，同义词检索等
> * 复杂的任务：信息提取、情感分析、文本分类等
> * 更复杂任务：机器翻译、人机对话、QA系统

Natural Language 逐渐演变成一种 **上下文信息表达** 和 **传递** 的方式。


让计算机处理自然语言，一个基本的问题就是为 自然语言 这种 上下文相关的特性 建立数学模型。

## 1. Language Model

> 1. 美联储主席昨天告诉媒体 7000 亿美金的救助资金将借给上百家银行、汽车公司。
> 2. 美联储主席昨天 7000 亿美金的救助资金告诉媒体将借给上百家银行、汽车公司。
> 3. 美联储主席昨天 告媒诉体 70 亿00美金的救助资金上百家银行将借给、汽车公司。
>
> 上世纪70年代科学家们试图用规则文法判断句子是否合理。贾里尼克用统计模型解决方法更有效。

如果 S 表示一连串特定顺序排列的词 $w_1$， $w_2$，…， $w_n$ ，换句话说，S 表示的是一个有意义的句子。机器对语言的识别从某种角度来说，就是想知道 S 在文本中出现的可能性，也就是数学上所说的 S 的概率用 P(S) 来表示。利用条件概率的公式，S 这个序列出现的概率等于每一个词出现的概率相乘，于是 P(S) 可展开为：

$$
P(S) = P(w_1)P(w_2|w_1)P(w_3| w_1 w_2)…P(w_n|w_1 w_2…w_{n-1})
$$

### 1.1 Markov assumption

假定文本中的每个词 $w_i$ 和 前面N-1个词有关，而和更前面的词无关，这样当前词 $w_i$ 的概率值取决于前面 N-1个词 $P(w_{i-N+1}, w_{i-N+2}, ..., w_{i-1})$

$$
P(w_{i}|w_{1}, w_{2}, ..., w_{i-1}) = P(w_i | w_{i-N+1}, w_{i-N+2}, ..., w_{i-1})
$$

> N元模型， N=2 时，为二元模型。 在实际中应用最多的是 N=3 的三元模型.

### 1.2 n-gram, n=2

$$
P(S) = P(w_1)P(w_2|w_1)P(w_3|w_2)…P(w_i|w_{i-1})…
$$

接下来如何估计 $P (w_i|w_{i-1})$。只要机器数一数这对词 $(w_i{-1}, w_i)$ 在统计的文本中出现了多少次，以及 $w_{i-1}$ 本身在同样的文本中前后相邻出现了多少次，然后用两个数一除就可以了,

$$
P(w_i|w_{i-1}) = \frac {P(w_{i-1}, w_i)} {P(w_{i-1})}
$$

## 2. Perplexity, PPL

语言模型效果的常用指标 perplexity， 在测试集上 perplexity 越低，说明建模效果越好. 

计算perplexity的公式如下：

{% image "/images/tensorflow/tf-google-9.1.2_1-equation.svg", width="600px" %}

**perplexity** 刻画的是语言模型预测一个语言样本的能力. 比如已经知道 (w1,w2,w3,…,wm) 这句话会出现在语料库之中，那么通过语言模型计算得到的这句话的概率越高，说明语言模型对这个语料库拟合得越好。

**perplexity** 实际是计算每一个单词得到的概率倒数的几何平均，因此 perplexity 可以理解为平均分支系数（average branching factor），即模型预测下一个词时的平均可选择数量。

> 例如，考虑一个由0~9这10个数字随机组成的长度为m的序列，由于这10个数字出现的概率是随机的，所以每个数字出现的概率是 。因此，在任意时刻，模型都有10个等概率的候选答案可以选择，于是perplexity就是10（有10个合理的答案）。
> 
> perplexity的计算过程如下：
> 
> {% image "/images/tensorflow/tf-google-9.1.2_3-ppl.jpg", width="800px" %}

在语言模型的训练中，通常采用 perplexity 的对数表达形式：

{% image "/images/tensorflow/tf-google-9.1.2_2-equation.svg", width="600px" %}

> 相比较乘积求平方根的方式，加法的形式可加速计算，同时避免概率乘积数值过小而导致浮点数向下溢出的问题.
> 
> 在数学上，log perplexity 可以看作真实分布与预测分布之间的交叉熵 Cross Entropy, 交叉熵描述了两个概率分布之间的一种距离. log perplexity 和 Cross Entropy 是等价的

在神经网络模型中，$P(w_i | w_{1}, , ..., w_{i-1})$ 分布通常是由一个 softmax层 产生的，TensorFlow 中提供了两个方便计算交叉熵的函数，可以将 logits 结果直接放入输入，来帮助计算 softmax 然后再进行计算 Cross Entropy.

```py
cross_entropy = tf.nn.softmax_cross_entropy_with_logits(labels = y, logits = y)
cross_entropy = tf.nn.sparse_softmax_cross_entropy_with_logits(labels = y, logits = y)
```

- [知乎_习翔宇](https://www.zhihu.com/people/xi-xiang-yu-20/posts)

## 3. NNLM

NNLM,直接从语言模型出发，将模型最优化过程转化为求词向量表示的过程.

既然离散的表示有辣么多缺点，于是有小伙伴就尝试着用模型最优化的过程去转换词向量了.

{% image "/images/nlp/word2vec-nnlm.png", width="600px" %}

计算复杂度： ($N \* D + N \* D \* H + H \* V$) 相当之高, 于是有了 CBOW 和 Skip-Gram .

> NN 训练 语言模型， 会顺带产生一个 Word Embedding 矩阵.
>
> 词嵌矩阵 * 单词的独热编码 = 单词的词嵌
>
> (300, 10000) * (10000, 1) = (300, 1)

可以通过训练神经网络的方式构建词嵌表 `E` .

下图展示了预测单词的方法，即给出缺少一个单词的句子：

“**I want a glass of orange ___**”

> 计算方法是将已知单词的特征向量都作为输入数据送到神经网络中去，然后经过一系列计算到达 Softmax分类层，在该例中输出节点数为 10000个。经过计算 juice 概率最高，所以预测为
>
> “I want a glass of orange `juice`”

{% image "/images/deeplearning/C5W2-5_1.png", width="750px" %}

在这个训练模式中，是通过全部的单词去预测最后一个单词然后反向传播更新词嵌表 $E$

> 假设要预测的单词为 $W$，词嵌表仍然为 $E$，需要注意的是训练词嵌表和预测 $W$ 是两个不同的任务。
>
> 如果任务是预测 $W$，最佳方案是使用 $W$ 前面 $n$ 个单词构建语境。
>
> 如果任务是训练 $E$，除了使用 $W$ 前全部单词还可以通过：前后各4个单词、前面单独的一个词、前面语境中随机的一个词（这个方式也叫做 Skip Gram 算法），这些方法都能提供很好的结果。

### 3.1 Word Representation

单词与单词之间是有很多共性的，或在某一特性上相近，比如“苹果”和“橙子”都是水果；或者在某一特性上相反，比如“父亲”在性别上是男性，“母亲”在性别上是女性，通过构建他们其中的联系可以将在一个单词学习到的内容应用到其他的单词上来提高模型的学习的效率，这里用一个简化的表格说明:

| Man (5391) | Woman (9853) | Apple (456) | Orange (6257)
:-------:  | :-------: | :-------: | :-------: | :-------:
性别 | -1 | 1 | 0 | 0.1
年龄 | 0.01 | 0.02 | -0.01 | 0.00
食物 | 0.04 | 0.01 | 0.95 | 0.97
颜色 | 0.03 | 0.01 | 0.70 | 0.30

在表格中可以看到不同的词语对应着不同的特性有不同的系数值，代表着这个词语与当前特性的关系。括号里的数字代表这个单词在独热编码中的位置，可以用这个数字代表这个单词比如 Man = ，Man 的特性用 ，也就是那一纵列。

在实际的应用中，特性的数量远不止 4 种，可能有几百种，甚至更多。对于单词 “orange” 和 “apple” 来说他们会共享很多的特性，比如都是水果，都是圆形，都可以吃，也有些不同的特性比如颜色不同，味道不同，但因为这些特性让 RNN 模型理解了他们的关系，也就增加了通过学习一个单词去预测另一个的可能性。

> 压缩到二维的可视化平面上，每一个单词 嵌入 属于自己的一个位置，相似的单词离的近，没有共性的单词离得远，这个就是 “Word Embeddings” 的概念.

{% image "/images/deeplearning/C5W2-2.png", width="500px" %}

> 上图通过聚类将词性相类似的单词在二维空间聚为一类.

### 3.2 Word Embeddings

先下一个非正规定义 “词嵌 - 描述了词性特征的总量，也是在高维词性空间中嵌入的位置，拥有越多共性的词，词嵌离得越近，反之则越远”。值得注意的是，表达这个“位置”，需要使用所有设定的词性特征，假如有 300 个特征（性别，颜色，...），那么词嵌的空间维度就是 300.

### 3.3 使用词嵌三步

1. 获得词嵌：获得的方式可以通过训练大的文本集或者下载很多开源的词嵌库
2. 应用词嵌：将获得的词嵌应用在我们的训练任务中
3. 可选：通过我们的训练任务更新词嵌库（如果训练量很小就不要更新了）

**词嵌实用场景:**

No. | sencentce | replace word | target
:-------:  | :-------: | :-------: | :-------:
1 | Sally Johnson is an `orange` farmer. | orange | Sally Johnson
2 | Robert Lin is an `apple` farmer. | apple | Robert Lin
3 | Robert Lin is a `durian cultivator`. | durian cultivator | Robert Lin

> 我们继续替换，我们将 apple farmer 替换成不太常见的 durian cultivator (榴莲繁殖员)。此时词嵌入中可能并没有 durian 这个词，cultivator 也是不常用的词汇。这个时候怎么办呢？我们可以用到迁移学习。

**词嵌入迁移学习步骤如下：**

> 1. 学习含有大量文本语料库的词嵌入 (一般含有 10亿 到 1000亿 单词)，或者下载预训练好的词嵌入
> 2. 将学到的词嵌入迁移到相对较小规模的训练集 (例如 10万 词汇).
> 3. (可选) 这一步骤就是对新的数据进行 fine-tune。

## 4. word2vec

word2vec 并不是一个模型， 而是一个 2013年 google 发表的工具. 该工具包含2个模型： Skip-Gram 和 CBOW. 及两种高效训练方法： negative sampling 和 hierarchicam softmax.

> 1. CBOW  Continous Bag of Words Model
> 2. Skip-Gram Model
>
> 词向量（词的特征向量）既能够降低维度，又能够capture到当前词在本句子中上下文的信息.

[Word2Vec](https://blog.csdn.net/u012052268/article/details/77170517/#63个人对word-embedding的理解)
[Word2Vec词嵌入矩阵](https://blog.csdn.net/sinat_33761963/article/details/54631367)

### 4.1 CBOW

{% image "/images/nlp/word2vec-CBOW_1.png", width="600px" %}

> 纠错 : 上图”目标函数“的第一个公式，应该是 连乘 公式，不是 连加 运算。
> 
> 理解 : 背景词向量与 中心词向量 内积 等部分，你可考虑 softmax $w \* x+b$ 中 $x$ 和 $w$ 的关系来理解.

### 4.2 Skip-Gram

跳字模型假设基于某个词来生成它在文本序列周围的词。举个例子，假设文本序列是“the”“man”“loves”“his”“son”。以“loves”作为中心词，设背景窗口大小为2。如图10.1所示，跳字模型所关心的是，给定中心词“loves”，生成与它距离不超过2个词的背景词“the”“man”“his”“son”的条件概率，即

$$
P(\textrm{the},\textrm{man},\textrm{his},\textrm{son}\mid\textrm{loves}).
$$

假设给定中心词的情况下，背景词的生成是相互独立的，那么上式可以改写成

$$
P(\textrm{the}\mid\textrm{loves})\cdot P(\textrm{man}\mid\textrm{loves})\cdot P(\textrm{his}\mid\textrm{loves})\cdot P(\textrm{son}\mid\textrm{loves}).
$$

{% image "/images/nlp/word2vec-skip-gram.svg", width="300px" %}

**训练 Skip-Gram**

跳字模型的参数是每个词所对应的中心词向量和背景词向量。训练中我们通过最大化似然函数来学习模型参数，即最大似然估计。这等价于最小化以下损失函数：

$$ - \sum_{t=1}^{T} \sum_{-m \leq j \leq m,\ j \neq 0} \text{log}\, P(w^{(t+j)} \mid w^{(t)}).
$$

如果使用随机梯度下降，那么在每一次迭代里我们随机采样一个较短的子序列来计算有关该子序列的损失，然后计算梯度来更新模型参数。梯度计算的关键是条件概率的对数有关中心词向量和背景词向量的梯度。根据定义，首先看到

$$
\log P(w_o \mid w_c) =
\boldsymbol{u}_o^\top \boldsymbol{v}_c - \log\left(\sum_{i \in \mathcal{V}} \text{exp}(\boldsymbol{u}_i^\top \boldsymbol{v}_c)\right)
$$

{% image "/images/nlp/word2vec-skip.png", width="700px" %}

它的计算需要词典中所有词以 $w_c$ 为中心词的条件概率。有关其他词向量的梯度同理可得。

训练结束后，对于词典中的任一索引为 $i$ 的词，我们均得到该词作为中心词和背景词的两组词向量 $v_i$ 和 $u_i$ 。在自然语言处理应用中，一般使用跳字模型的中心词向量作为词的表征向量。

> 两个向量越相似，他们的点乘也就越大.

**小结：**

1. 最大似然估计 MLE
2. 最小化损失函数（与第一步等价），损失函数对数联合概率的相反数
3. 描述概率函数，该函数的自变量是词向量（u和v），词向量也是模型参数
4. 对第二步中每一项求梯度。有了梯度就可以优化第二步中的损失函数，从而迭代学习到模型参数，也就是词向量。

### 4.3 高效近似训练

- hierarchicam softmax
- negative sampling

## 5. fastText

FastText是一个快速文本分类算法，在使用标准多核CPU的情况下，在10分钟内可以对超过10亿个单词进行训练。 不需要使用预先训练好的词向量，因为FastText会自己训练词向量。

文本分类：

{% image "/images/nlp/fastText-3.webp", width="500px" %}

情感分类:

{% image "/images/nlp/fastText-4.webp", width="500px" %}

fastText 能够做到效果好，速度快，主要依靠两个秘密武器：

> 1. 利用了 词内的n-gram信息 (subword n-gram information)
> 2. 用到了 层次化Softmax回归 (Hierarchical Softmax) 的训练 trick.

**fastText 和 word2vec 的区别:**

**两者表面的不同：**

> **模型的输出层：**
> 
> word2vec的输出层，对应的是每一个term，计算某term的概率最大；而fasttext的输出层对应的是 分类的label。不过不管输出层对应的是什么内容，起对应的vector都不会被保留和使用；
> 
> **模型的输入层：**
> 
> word2vec的输出层，是 context window 内的term；而fasttext对应的整个sentence的内容，包括term，也包括 n-gram的内容；

**两者本质的不同，体现在 h-softmax 的使用：**

> Wordvec的目的是得到词向量，该词向量最终是在输入层得到，输出层对应的 h-softmax也会生成一系列的向量，但最终都被抛弃，不会使用。
>
> fasttext则充分利用了h-softmax的分类功能，遍历分类树的所有叶节点，找到概率最大的label（一个或者N个）

## Reference

- 《数学之美》 读书笔记 
- [word2vec前世今生][3]
- [CS224N NLP with Deep Learning: Lecture 1 课程笔记][4]
- [good, sklearn 中 CountVectorizer、TfidfTransformer 和 TfidfVectorizer][5]

[3]: https://whiskytina.github.io/word2vec.html
[4]: https://whiskytina.github.io/14947653164873.html
[5]: https://blog.csdn.net/m0_37324740/article/details/79411651
