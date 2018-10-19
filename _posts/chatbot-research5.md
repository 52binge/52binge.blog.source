---
title: Chatbot Research 5 - 基于深度学习的检索聊天机器人
toc: true
date: 2019-08-15 14:00:21
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

介绍基于检索式机器人。检索式架构有预定好的语料答复库。

检索式模型的输入是上下文潜在的答复。模型输出对这些答复的打分，可以选择最高分的答案作为回复。

<!-- more -->

> 既然生成式的模型更弹性，也不需要预定义的语料，为何不选择它呢？
>
> 生成式模型的问题就是实际使用起来并不能好好工作，至少现在是。因为答复比较自由，容易犯语法错误和不相关、不合逻辑的答案，并且需要大量的数据且很难做优化。
>
> 大量的生产系统上还是采用 检索模型 或者 `检索模型` 和 `生成模型` 结合的方式。
> 
> - 例如 google 的 [smart reply][5]。
> 
> 生成模型是研究的热门领域，但是我们还没到应用它的程度。如果你想要做一个聊天机器人，最好还是选用检索式模型

更聪明的聊天机器人

1. 生成式模型 VS 检索匹配模型 
2. Chatterbot的进化: 深度学习提高智能度

模型构建 

1. 问题的分析与转化
2. 数据集与样本构造方法 
3. 网络结构的构建 
4. 模型的评估 
5. 代码实现与解析

## 1. 聊天机器人

<img src="/images/chatbot/chatbot-5_1.jpg" width="700" />

### 1.1 基于检索的 chatbot

- 根据 input 和 context，结合知识库的算法得到合适回复    
- 从一个固定的数据集中找到合适的内容作为回复
- 检索和匹配的方式有很多种
- 数据和匹配方法对质量有很大影响

### 1.2 基于生成模型的chatbot

- 典型的是 seq2seq 的方法
- 生成的结果需要考虑通畅度和准确度

> 以前者为主(可控度高)，后者为辅

## 2. 回顾 chatterbot

<img src="/images/chatbot/chatbot-5_2.png" width="600" />

### 2.1 chatterbot 的问题

**应答模式的匹配方式太粗暴**
  
> - 编辑距离无法捕获深层语义信息   
> - 核心词 + word2vec 无法捕获整句话语义   
> - LSTM 等 RNN模型 能捕获序列信息
>  ...
> 用深度学习来提高匹配阶段准确率!!

心得 :
  
> Open Domain 的 chatbot 很难做，话题太广，因为无法预知用户会问到什么问题. 
> 
> 你想吃什么 ： 随便
> 你感觉怎么样 : 还好
> 
> 没问题其实
> 
> 所以针对一个 Closed Domain + 检索 + 知识库，还应该可以做一个可以用的机器人.
  
### 2.2 应该怎么做

**匹配本身是一个模糊的场景**

> 转成排序问题
  
**排序问题怎么处理?**  

> 转成能输出概率的01分类问题
> 
> **Q1 -> { A1: 0.8, A2: 0.1, A3: 0.05, A4: 0.2 }**

**数据构建?**

> 我们需要正样本(正确的回答) 和 负样本(不对的回答)
> 
> **{ 正样本 : Q1-A1 1 }, { 负样本 : Q1-A3 0 }**

**Loss function?**

> 回忆一下 logistic regression

**心得 :**

> 定义问题 和 解决问题 很重要
> 
> 有一个问题，可以转换为 机器学习 或 深度学习 可以解决的问题，这非常重要。

## 3. 用深度学习来完成

<img src="/images/chatbot/chatbot-5_3.png" width="700" />
  
> [2016 Google Brain deep-learning-for-chatbots-2-retrieval-based-model-tensorflow, wildml blog][2]

## 4. 数据 - Ubuntu 对话语料库

ubuntu 语料库（UDC），它是目前公开的最大的数据集。

### 4.1 Train sets

<img src="/images/chatbot/chatbot-5_4.png" width="900" />

> 注意: 
>
> - 上面的数据集生成脚本已经使用 [NLTK][6] 做了一系列的语料处理包括（[分词][6_1]，[提取词干][6_2]，[词意恢复][6_3]）
> - 脚本也做了把 名字、地点、组织、URL。系统路径等实体信息用特殊的 token 来替代。
> 
> 这些预处理不是严格必要的，但是能改善一些系统的表现。
> 
> 语料的上下文平均有86个词语，答复平均有17个词语长。有人做了语料的统计分析：[data analysis][6_4]

### 4.2 Test / Validation sets

- 每个样本，有一个正例和九个负例数据 (也称为干扰数据)。
- 建模的目标在于给正例的得分尽可能的高，而给负例的得分尽可能的低。(有点类似分类任务)
- 语料做过分词、stemmed、lemmatized 等文本预处理。 
- 用 NER(命名实体识别) 将文本中的 **实体**，如姓名、地点、组织、URL等 替换成特殊字符

<img src="/images/chatbot/chatbot-5_5.png" width="900" />

## 5. 评估准则 BASELINE

**Recall@K**

> - 常见的 Kaggle 比赛评判准则
> - 经模型对候选的 response 排序后，前 k 个候选中 存在正例数据(正确的那个)的占比。
>    让 K=10，这就得到一个 100% 的召回率，因最多就 10 个备选。如果 K=1，模型只一次机会选中正确答案。
> - K 值 越大，指标值越高，对模型性能的要求越松。

**9个干扰项目怎么选出来**

> 这个数据集里是随机的方法选择的。
> 
> 但是现实世界里你可能数百万的可能答复，并且你并不知道答复是否合理正确。你没能力从数百万的可能的答复里去挑选一个得分最高的正确答复。成本太高了！ google 的 smart reply 用分布式集群技术计算一系列的可能答复去挑选,.
> 
> 可能你只有百来个备选答案，可以去评估每一个。

```python
def evaluate_recall(y, y_test, k=1):
    num_examples = float(len(y))
    num_correct = 0
    for predictions, label in zip(y, y_test):
        if label in predictions[:k]:
            num_correct += 1
    return num_correct/num_examples
```

其中，y 是所预测的以降序排列的模型预测分值，y_test 是实际的 label 值。举个例子，假设 y 的值为 [0,3,1,2,5,6,4,7,8,9]，这说明 第0号 的候选的预测分值最高、作为回复的可能性最高，而9号则最低。这里的第0号同时也是正确的那个，即正例数据，标号为1-9的为随机生成的负例数据。

### 5.1  基线模型:random guess

理论上，最base的随机模型（Random Predictor）的 recall@1 的值为10%，recall@2 的值为20%。相应的代码如下：

```python
# Random Predictor
def predict_random(context, utterances):
    return np.random.choice(len(utterances), 10, replace=False)

# Evaluate Random predictor
y_random = [predict_random(test_df.Context[x], test_df.iloc[x,1:].values) for x in range(len(test_df))]
y_test = np.zeros(len(y_random))
for n in [1, 2, 5, 10]:
    print("Recall @ ({}, 10): {:g}".format(n, evaluate_recall(y_random, y_test, n)))
```

实际的模型结果如下：

```python
Recall @ (1, 10): 0.0937632
Recall @ (2, 10): 0.194503
Recall @ (5, 10): 0.49297
Recall @ (10, 10): 1
```

这与理论预期相符，但这不是我们所追求的结果。

### 5.2 基线模型:TF-IDF检索

另外一个 baseline 的模型为 **tfidf predictor**。直观上，两篇文档对应的 tfidf 向量 越接近，两篇文章的内容也越相似。同样的，对于一个 QR pair，它们语义上接近的词共现的越多，也将越可能是一个正确的 QR pair（这句话存疑，原因在于 Q R 之间也有可能不存在语义上的相似，一个Q对应的 R 是多样的。）。tfidf predictor 对应的代码如下（利用scikit-learn工具能够轻易实现）：

> tfidf表示词频（term frequency）和逆文档词频（inverse document frequency），它衡量了一个词在一篇文档中的重要程度（基于整个语料库）。

```python
class TFIDFPredictor:
    def __init__(self):
        self.vectorizer = TfidfVectorizer()

    def train(self, data):
        self.vectorizer.fit(np.append(data.Context.values,data.Utterance.values))

    def predict(self, context, utterances):
        # Convert context and utterances into tfidf vector
        vector_context = self.vectorizer.transform([context])
        vector_doc = self.vectorizer.transform(utterances)
        # The dot product measures the similarity of the resulting vectors
        result = np.dot(vector_doc, vector_context.T).todense()
        result = np.asarray(result).flatten()
        # Sort by top results and return the indices in descending order
        return np.argsort(result, axis=0)[::-1]


# Evaluate TFIDF predictor
pred = TFIDFPredictor()
pred.train(train_df)
y = [pred.predict(test_df.Context[x], test_df.iloc[x,1:].values) for x in range(len(test_df))]
for n in [1, 2, 5, 10]:
    print("Recall @ ({}, 10): {:g}".format(n, evaluate_recall(y, y_test, n)))
```

模型结果如下：

```python
Recall @ (1, 10): 0.495032
Recall @ (2, 10): 0.596882
Recall @ (5, 10): 0.766121
Recall @ (10, 10): 1
```

显然这比 Random 的模型要好得多，但这还不够。之前的假设并不完美，首先 query 和 response 之间并不一定要是语义上的相近；其次 tfidf模型 忽略了词序这一重要的信息。使用 NN模型 我们能做得更好一些。

### 5.3 LSTM

建立的 NN模型 为两层 Encoder 的 LSTM模型（Dual Encoder LSTM Network），这种形式的网络被广泛应用 chatbot 中。

[seq2seq模型][7] 常用于机器翻译领域，并取得了较大的效果。使用 Dual LSTM模型 的原因在于这个模型被证明在这个数据集有较好的效果（[详情见这里][8]）, 这可以作为我们后续模型效果的验证。

两层 Encoder 的 LSTM模型 的结构图如下（[论文来源][9]）：

**大致流程：**

> - (1). Q 和 R 都是经过分词的，分词后每个词 embedded 为向量形式。初始的词向量使用 GloVe vectors，之后词向量随着模型的训练会进行 fine-tuned（实验发现，初始的词向量使用GloVe 并没有在性能上带来显著的提升）。
>
> - (2). 分词且向量化的 Query 和 Response 经过相同的RNN（word by word）。RNN最终生成一个向量表示，捕捉了 Query 和 Response 之间的[语义联系]（图中的c和r）；这个向量的维度是可以指定的，这里指定为256维。
>
> - (3). 将向量c与一个矩阵M相乘，来预测一个可能的回复r’。如果c为一个256维的向量，M维256*256的矩阵，两者相乘的结果为另一个256维的向量，我们可以将其解释为[一个生成式的回复向量]。矩阵M是需要训练的参数。
>
> - (4). 通过点乘的方式来预测生成的回复r’和候选的回复r之间的相似程度，点乘结果越大表示候选回复作为回复的可信度越高；之后通过sigmoid函数归一化，转成概率形式。图中把第(3)步和第(4)步结合在一起了。
>
> - (5). 损失函数（loss function）。这里使用二元的交叉熵（binary cross-entropy）作为损失函数。我们已知实例的真实label y，值为0或1；通过上面的第(4)步可以得到一个概率值 y'；因此，交叉熵损失值为 $L = -y * ln(y') - (1 - y) * ln(1 - y')$。这个公式的意义是直观的，即当 $y=1$ 时，$L = -ln(y')$，我们期望y'尽量地接近1使得损失函数的值越小；反之亦然。


## Reference

- [About ChatterBot][1]
- [2016 Google Brain deep-learning-for-chatbots-2-retrieval-based-model-tensorflow, wildml blog][2]
- [聊天机器人深度学习应用-part2：基于tensorflow实现检索架构模型][3]
- [聊天机器人深度学习应用-part1：引言][4]

[1]: https://chatterbot.readthedocs.io/en/stable/
[2]: http://www.wildml.com/2016/07/deep-learning-for-chatbots-2-retrieval-based-model-tensorflow/
[3]: https://www.jianshu.com/p/412bcfa67770
[4]: https://www.jianshu.com/p/4fb194d143cf
[5]: https://arxiv.org/abs/1606.04870
[6]: http://www.nltk.org/
[6_1]: http://www.nltk.org/api/nltk.tokenize.html#module-nltk.tokenize
[6_2]: http://www.nltk.org/api/nltk.stem.html#module-nltk.stem.snowball
[6_3]: http://www.nltk.org/api/nltk.stem.html#module-nltk.stem.wordnet
[6_4]: https://github.com/dennybritz/chatbot-retrieval/blob/master/notebooks/Data%20Exploration.ipynb

[7]: https://www.tensorflow.org/versions/r0.9/tutorials/seq2seq/index.html
[8]: https://arxiv.org/abs/1510.03753
[9]: https://arxiv.org/abs/1506.08909

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