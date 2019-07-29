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
 
### 1. Language Model and Perplexity

$$
P(w\_{i}|w\_{1}, w\_{2}, ..., w\_{i-1}) = P(w\_i | w\_{i-N+1}, w\_{i-N+2}, ..., w\_{i-1})
$$

计算perplexity的公式如下：

<img src="/images/tensorflow/tf-google-9.1.2_1-equation.svg" width="600" />

**perplexity** 刻画的是语言模型预测一个语言样本的能力. 比如已经知道 (w1,w2,w3,…,wm) 这句话会出现在语料库之中，那么通过语言模型计算得到的这句话的概率越高，说明语言模型对这个语料库拟合得越好。

perplexity 实际是计算每一个单词得到的概率倒数的几何平均，因此 perplexity 可以理解为平均分支系数（average branching factor），即模型预测下一个词时的平均可选择数量。

在语言模型的训练中，通常采用 perplexity 的对数表达形式：

<img src="/images/tensorflow/tf-google-9.1.2_2-equation.svg" width="600" />

> 相比较乘积求平方根的方式，加法的形式可加速计算，同时避免概率乘积数值过小而导致浮点数向下溢出的问题.
> 
> 在数学上，log perplexity 可以看作真实分布与预测分布之间的交叉熵 Cross Entropy, 交叉熵描述了两个概率分布之间的一种距离. log perplexity 和 Cross Entropy 是等价的

## 2. NNLM

NNLM,直接从语言模型出发，将模型最优化过程转化为求词向量表示的过程.

<img src="/images/nlp/word2vec-nnlm.png" width="600" />

**使用词嵌三步**

> 1. 获得词嵌：获得的方式可以通过训练大的文本集或者下载很多开源的词嵌库
> 2. 应用词嵌：将获得的词嵌应用在我们的训练任务中
> 3. 可选：通过我们的训练任务更新词嵌库（如果训练量很小就不要更新了）

## 3. word2vec

word2vec 并不是一个模型， 而是一个 2013年 google 发表的工具. 该工具包含2个模型： Skip-Gram 和 CBOW. 及两种高效训练方法： negative sampling 和 hierarchicam softmax.

## Reference

- [Language Model and Perplexity][3]
- [sklearn: TfidfVectorizer 中文处理及一些使用参数][1]
- [sklearn.feature_extraction.text.TfidfVectorizer函数说明][2]

[1]: https://blog.csdn.net/blmoistawinde/article/details/80816179
[2]: https://blog.csdn.net/binglingzy666/article/details/79241486
[3]: /2019/06/16/nlp/Language-Model-and-Word-Embedding/