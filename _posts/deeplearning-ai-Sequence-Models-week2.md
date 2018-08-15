---
title: Sequence Models (week2) - NLP - Word Embeddings
toc: true
date: 2018-08-02 16:00:21
categories: deeplearning
tags: deeplearning.ai
mathjax: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

- 能够将序列模型应用到自然语言问题中，包括文字合成。

<!-- more -->

## 1. Word Representation

上周的学习中，学习了如何用独热编码来代表一个词，这一节我们来探究一下词和词之间的联系。比如有下面这句话：

```
“I want a glass of orange ________”
```

假如我们的RNN的模型通过训练已经学会了短语“orange juice”，并准确的预测了这句话的空格部分，那么如果遇到了另一句话时，比如：

```
“I want a glass of apple _________”
```

是否需要从头学习短语“apple juice”呢？能否通过构建“`apple`” 与 “`orange`” 的联系让它不需要重学就能进行判断呢？

> 能否通过构建 “apple” 与 “orange” 的联系让它不需要重学就能进行判断呢？
> 所以下面给出了一种改进的表示方法，称之为“词嵌入(**Word Embedding**)”

### 1.1 词汇的特性

单词与单词之间是有很多共性的，或在某一特性上相近，比如“苹果”和“橙子”都是水果；或者在某一特性上相反，比如“父亲”在性别上是男性，“母亲”在性别上是女性，通过构建他们其中的联系可以将在一个单词学习到的内容应用到其他的单词上来提高模型的学习的效率，这里用一个简化的表格说明:

| Man (5391) | Woman (9853) | Apple (456) | Orange (6257)
:-------:  | :-------: | :-------: | :-------: | :-------:
性别 | -1 | 1 | 0 | 0.1
年龄 | 0.01 | 0.02 | -0.01 | 0.00
食物 | 0.04 | 0.01 | 0.95 | 0.97
颜色 | 0.03 | 0.01 | 0.70 | 0.30

在表格中可以看到不同的词语对应着不同的特性有不同的系数值，代表着这个词语与当前特性的关系。括号里的数字代表这个单词在独热编码中的位置，可以用这个数字代表这个单词比如 Man = ，Man的特性用 ，也就是那一纵列。

在实际的应用中，特性的数量远不止4种，可能有几百种，甚至更多。对于单词“orange”和“apple”来说他们会共享很多的特性，比如都是水果，都是圆形，都可以吃，也有些不同的特性比如颜色不同，味道不同，但因为这些特性让RNN模型理解了他们的关系，也就增加了通过学习一个单词去预测另一个的可能性。

> 这里还介绍了一个 `t-SNE` 算法，因为词性表本身是一个很高维度的空间，通过这个算法压缩到二维的可视化平面上，每一个单词 嵌入 属于自己的一个位置，相似的单词离的近，没有共性的单词离得远，这个就是 “Word Embeddings” 的概念.

<img src="/images/deeplearning/C5W2-2.png" width="500" />

> 上图通过聚类将词性相类似的单词在二维空间聚为一类.

## 2. Using Word Embeddings

先下一个非正规定义 “词嵌 - 描述了词性特征的总量，也是在高维词性空间中嵌入的位置，拥有越多共性的词，词嵌离得越近，反之则越远”。值得注意的是，表达这个“位置”，需要使用所有设定的词性特征，假如有300个特征（性别，颜色，...），那么词嵌的空间维度就是300.

### 2.1 使用词嵌三步

1. 获得词嵌：获得的方式可以通过训练大的文本集或者下载很多开源的词嵌库
2. 应用词嵌：将获得的词嵌应用在我们的训练任务中
3. 可选：通过我们的训练任务更新词嵌库（如果训练量很小就不要更新了）

### 2.2 词嵌实用场景

No. | sencentce | replace word | target
:-------:  | :-------: | :-------: | :-------:
1 | Sally Johnson is an `orange` farmer. | orange | Sally Johnson
2 | Robert Lin is an `apple` farmer. | apple | Robert Lin
3 | Robert Lin is a `durian cultivator`. | durian cultivator | Robert Lin

> 我们继续替换，我们将apple farmer替换成不太常见的durian cultivator(榴莲繁殖员)。此时词嵌入中可能并没有durian这个词，cultivator也是不常用的词汇。这个时候怎么办呢？我们可以用到迁移学习

**词嵌入迁移学习步骤如下：**

> 1. 学习含有大量文本语料库的词嵌入(一般含有10亿到1000亿单词)，或者下载预训练好的词嵌入
> 2. 将学到的词嵌入迁移到相对较小规模的训练集(例如10万词汇).
> 3. (可选) 这一步骤就是对新的数据进行fine-tune。

## 3. Properties of Word Embeddings

**假设有如下的问题：**

```
"Man" -> "Woman" 那么 "King" -> ？
```

这个问题被称作词汇的类比问题，通过研究词嵌的特征可以解决这样的问题.

<img src="/images/deeplearning/C5W2-3_1.png" width="750" />

数学的表达式为：

$$
e\_{man} - e\_{woman} \, \approx \, e\_{king}-e\_w
$$

$e\_w$ 是什么呢？ 在高纬度空间中（300D）

$$
argmax\_w \;\, Similarity(e\_w, e\_{king}-e\_{man}+e\_{woman})
$$

这个公式相当于在算两个向量(vector)的cos相似度

$$
Similarity(u,v) = \frac {u^Tv} {||u||\_2||v||\_2}
$$

> 当然也可以用其他距离公式, 但是多数是用这个余弦相似度.

如下图用几何方式能够更容易理解，即只要找到与向量 $\vec{AB}$ 最接近平行的向量 $\vec{CD}$ 即可.

<img src="/images/deeplearning/C5W2-4_1.png" width="750" />

## 4. Embedding Matrix

这一节中主要讲了词嵌矩阵的shape，如果词嵌（词性特征的总量）是300，独热编码的长度是10000，那么词嵌矩阵的的shape就是 `300 * 10000` 。所以就有了下面的式子：

> 词嵌矩阵 * 单词的独热编码 = 单词的词嵌
>
> (300, 10000) * (10000, 1) = (300, 1)

## 5. Learning Word Embeddings

可以通过训练神经网络的方式构建词嵌表 `E` .

下图展示了预测单词的方法，即给出缺少一个单词的句子：

“**I want a glass of orange ___**”

> 计算方法是将已知单词的特征向量都作为输入数据送到神经网络中去，然后经过一系列计算到达 Softmax分类层，在该例中输出节点数为10000个。经过计算juice概率最高，所以预测为
>
> “I want a glass of orange `juice`”

<img src="/images/deeplearning/C5W2-5_1.png" width="750" />

在这个训练模式中，是通过全部的单词去预测最后一个单词然后反向传播更新词嵌表 $E$

> 假设要预测的单词为 $W$，词嵌表仍然为 $E$，需要注意的是训练词嵌表和预测 $W$ 是两个不同的任务。
>
> 如果任务是预测 $W$，最佳方案是使用 $W$ 前面 $n$ 个单词构建语境。
>
> 如果任务是训练 $E$，除了使用 $W$ 前全部单词还可以通过：前后各4个单词、前面单独的一个词、前面语境中随机的一个词（这个方式也叫做 Skip Gram 算法），这些方法都能提供很好的结果。

## 6. Word2Vec

视频中一直没有给 Word2Vec 下一个明确的定义，我们再次下一个非正式定义便于理解:

“**word2vec**” 是指将词语 word 变成向量vector 的过程，这一过程通常通过浅层的神经网络完成，例如 CBOW 或者skip gram，这一过程同样可以视为构建词嵌表 $E$ 的过程”。

### 6.1 Skip-grams

这里着重介绍了**skip gram model**，这是一个用一个随机词预测其他词的方法。比如下面这句话中

> “I want a glass of orange juice.”

我们可以选 **orange**作为随机词 c(**Context**)，通过设置窗口值例如前后 5 个单词以监督学习的方式去预测其中的词t(**Target**) 例如 “juice, glass, a, of” 但需要注意的是，这个过程仍然是为了搭建（更新）词嵌表 $E$ 而不是为了真正
的去预测，所以如果预测效果不好并不用担心，表达式：

$$
O\_{c}\rightarrow E \rightarrow e\_{c} \rightarrow \underset{Softmax}{Output} \rightarrow \hat{y}
$$

**Softmax**公式为(假设输出节点数为10000)：

$$
p(t|c)=\frac{e^{θ\_t^Te\_c}}{\sum\_{j=1}^{10000}e^{θ\_j^Te\_c}}
$$

> $θ\_t$ 表示与$t$有关的参数

损失函数：

$$
l(\hat{y},y)=\sum\_{i=1}^{10000}y\_ilog\hat{y\_i}
$$

<img src="/images/deeplearning/C5W2-6_1.png" width="750" />

在skip gram中有一个不足是 **softmax** 作为激活函数需要的运算量太大，在上限为10000个单词的词库中就已经比较慢了。一种补救的办法是用一个它的变种 “**Hierachical Softmax** (分层的Softmax)”，通过类似二叉树的方法提高训练的效率

例如一些常见的单词，如**the**、**of**等就可以在很浅的层次得到，而像**durian**这种少用的单词则在较深的层次得到

<img src="/images/deeplearning/C5W2-7_1.png" width="750" />

## 7. Negative Sampling 负采样

对于skip gram model而言，还要解决的一个问题是如何取样（选择）有效的随机词 $c$ 和目标词 $t$ 呢？如果真的按照自然随机分布的方式去选择，可能会大量重复的选择到出现次数频率很高的单词比如说 “the, of, a, it, I, ...” 重复的训练这样的单词没有特别大的意义.

如何有效的去训练选定的词如 orange 呢？在设置训练集时可以通过“负取样”的方法, 下表中第一行是通过和上面一样的窗口法得到的“正”（1）结果，其他三行是从字典中随机得到的词语，结果为“负”（0）。通过这样的负取样法可以更有效地去训练 skip gram model.

context | word | target?
:-------:  | :-------: | :-------:
orange | juice | 1
orange | king | 0
orange | book | 0
orange | the | 0

<img src="/images/deeplearning/C5W2-8_1.png" width="700" />

负取样的个数 **k** 由数据量的大小而定，上述例子中为3. 实际中数据量大则 k = 2 ~ 5，数据量小则可以相对大一些 k = 5 ~ 20

> 通过负取样，我们的神经网络训练从 **softmax** 预测每个词出现的频率变成了经典 binary logistic regression 问题，概率公式用 **sigmoid** 代替 **softmax** 从而大大提高了速度.

$$
x\_1=(orange, juice) \rightarrow y\_1=1 \\\\
x\_2=(orange, king) \rightarrow y\_2=0 \\\\
... \\\\
P(y=1|c,t)=\sigma(\theta\_t^Te\_c)
$$

最后我们通过一个并没有被理论验证但是实际效果很好的方式来确定每个被负选样选中的概率为：

$$
P(w\_i)=\frac{f(w\_i^{\frac{3}{4}})} {\sum\_{j=1}^{10000}f(w\_j^{\frac{3}{4}})}
$$

<img src="/images/deeplearning/C5W2-9_1.png" width="750" />

## 8. GloVe Word Vectors

GloVe(Global vectors for word representation)虽不像Word2Vec模型那样流行，但是它也有自身的优点，即简单.

## 9. Sentiment Classification

平时上淘宝我们都会对买的东西给出文字评价和对应的星级评价，如下图示。

商家可以通过对这些数据来构建一个情绪分类器，从而可以在一些社交平台上如微博、QQ等大家的文字评论然后对应输出相应的星级等级，这样就可以更容易知道自家店是蒸蒸日上还是日落西山了,hehehe。

<img src="/images/deeplearning/C5W2-10_1.png" width="750" />

可以看到下图中的模型先将评语中各个单词通过 词嵌表(数据量一般比较大，例如有100Billion的单词数) 转化成对应的特征向量，然后对所有的单词向量做求和或者做平均，然后构建Softmax分类器，最后输出星级评级。

<img src="/images/deeplearning/C5W2-11_1.png" width="750" />

但是上面的模型存在一个问题，一般而言如果评语中有像"good、excellent"这样的单词，一般都是星级评分较高的评语，但是该模型对下面这句评语就显得无能为力了：

“**Completely lacking in good taste, good service, and good ambience**.”

该评语中出现大量的good，如果直接做求和或者平均运算，经过分类器得到的输出很大概率上是高星级评分的，但这显然与该评语的本意不符.

<img src="/images/deeplearning/C5W2-12_1.png" width="750" />

之所以上面的模型存在那样的缺点，就是因为它没有把单词的时序考虑进去，所以我们可以使用RNN构建模型来解决这种问题。RNN模型如下图示：

<img src="/images/deeplearning/C5W2-13_1.png" width="750" />

另外使用RNN模型还有另一个好处，假设测试集中的评语是这样的

“Completely absent of good taste, good service, and good ambience.”

该评语只是将**lacking in**替换成了**absent of**，而且我们即使假设**absent**并没有出现在训练集中，但是因为词嵌表很庞大，所以词嵌表中包含**absent**，所以算法依旧可以知道**absent**和**lacking**有相似之处，最后输出的结果也依然可以保持正确。

<img src="/images/deeplearning/C5W2-14_1.png" width="750" />

## 10. Debiasing Word Embeddings

现如今机器学习已经被用到了很多领域，例如银行贷款决策，简历筛选。但是因为机器是向人们学习，所以好的坏的都会学到. 因为 **RNN** 通常是通过大量的网络数据文本集进行训练得到的，所以很多时候文本集中的偏见会反映在词嵌以及最终 的结果中，例如

> 当说到Man：程序员的时候，算法得出Woman：家庭主妇，这显然存在偏见。
> 
> 又如Man：Doctor，算法认为Woman：Nurse。这显然也存在其实和偏见。

这种带有偏见的结果是应该尽力避免的，这类偏见大量存在于网络数据文本中，包括 性别偏见，种族偏见，年龄偏见，等等... 人类在这方面已经做的不对了，所以机器应当做出相应的调整来减少歧视.  

**给词嵌去偏见主要分三步**(在词嵌的高维空间中完成):

1. 找到偏见的方向(确定偏见的x，y轴)
2. 将非定义化的词平移到x=0(父亲，母亲这类词就是定义化的词，本身就带有了性别的暗示) 
3. 使定义化的词据离移动的词距离相等

> So word embeddings can reflect the gender, ethnicity, age, sexual, orientation, and other biases of the text used to train the model. One that I'm especially passionate about is bias relating to socioeconomic status. I think that every person, whether you come from a wealthy family, or a low income family, or anywhere in between, I think everyone should have a great opportunities.

<img src="/images/deeplearning/C5W2-15_1.png" width="750" />

下面将主要从性别歧视上来举例说明如何让机器学习消除偏见。

下图展示了一些单词，你可以在心里先想想你看到这些单词的第一时间认为他们所对应的性别是什么吧~~~

<img src="/images/deeplearning/C5W2-16_1.png" width="450" />

### 1. 识别偏见方向

因为该例子是以消除性别歧视为目的，所以我们需要计算出图中这些单词之间的距离的平均值，进而作为偏见方向(bias direction)

$$
e\_{he}-e\_{she} \\\\
e\_{boy}-e\_{girl} \\\\
e\_{grandmother}-e\_{grandfather}
$$

将上面所求做平均运算，得到的向量方向即为偏见方向

为方便理解，已在图中画出偏见方向，其余299D(除gender以外的其他单词特征)向量与偏见方向正交，也在下图中画出.

<img src="/images/deeplearning/C5W2-17_1.png" width="700" />

### 2. 词性中和

像“ **boy, girl** ”这类词在性别词性上是很明确的，而且不存在歧视，所以无需中和(Neutralize).

而图中的 **babysister、doctor** 则需要中和，具体方法就是将该词像非偏见方向投影得到一个新的坐标.

<img src="/images/deeplearning/C5W2-18_1.png" width="700" />

### 3. 单词对等距离化

如下图示，虽然 **babysister** 中和化，但是它还是离 **grandmother** 更近，所以依旧带有偏见

<img src="/images/deeplearning/C5W2-19_1.png" width="700" />

所以我们还需要将grandmother、grandfather这类与性别有关的对应词等距分布在非偏见方向的两侧(红色剪头表示移动方向，红色点表示移动后的新坐标)，如下图示。

<img src="/images/deeplearning/C5W2-20_1.png" width="700" />

## 11. Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][4]
- [deeplearning.ai深度学习课程字幕翻译项目][5]
- [seq2seq学习笔记][6]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/p/7470989.html
[5]: https://www.ctolib.com/Yukong-Deeplearning-ai-Solutions.html
[6]: https://blog.csdn.net/Jerr__y/article/details/53749693

