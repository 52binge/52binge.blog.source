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

**更聪明的聊天机器人 ：**

1. 生成式模型 VS 检索匹配模型 
2. Chatterbot的进化: 深度学习提高智能度

**模型构建 ：** 

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
> **Q1 -> { R1: 0.8, R2: 0.1, R3: 0.05, R4: 0.2 }**
> 
> Query <> Response

**数据构建?**

> 我们需要正样本(正确的回答) 和 负样本(不对的回答)
> 
> **{ 正样本 : Q1-R1 1 }, { 负样本 : Q1-R3 0 }**

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

我们将使用Ubuntu对话数据集（[论文来源](https://arxiv.org/abs/1506.08909) [github地址](https://github.com/rkadlec/ubuntu-ranking-dataset-creator)）。这个数据集（Ubuntu Dialog Corpus, UDC）是目前最大的公开对话数据集之一，它是来自 Ubuntu 的 IRC网络 上的对话日志。[这篇论文](https://arxiv.org/abs/1506.08909)介绍了该数据集生成的具体细节。下面简单介绍一下数据的格式。

训练数据有 100W 条实例，其中一半是正例（label为1），一半是负例（label为0，负例为随机生成）。每条实例包括一段上下文信息（context），即Query；和一段可能的回复内容，即Response；Label为1表示该Response确实是Query的回复，Label为0则表示不是。下面是数据示例：

> 数据集生成脚本已经使用 [NLTK][6] 做了一系列的语料处理包括（[分词][6_1]，[stemmed][6_2]，[lemmatized][6_3]）等文本预处理步骤；
> 
> 使用了NER技术，将文本中的实体，如 姓名、地点、组织、URL 等替换成特殊字符。
> 
> 这些预处理不是严格必要的，但是能改善一些系统的表现。
> 
> 语料的上下文平均有86个词语，答复平均有17个词语长。有人做了语料的统计分析：[data analysis][6_4]
>
> 数据集也包括了 **Test / Validation sets**，但这两部分的数据和训练数据在格式上不太一样。
> 
> 在 **Test / Validation sets** 中，对于每一条实例，有一个正例和九个负例数据（也称为干扰数据）。
> 
> 模型的目标在于给正例的得分尽可能的高，而给负例的得分尽可能的低。下面是数据示例：

### 4.1 Train sets

<img src="/images/chatbot/chatbot-5_4.png" width="900" />

### 4.2 Test / Validation sets

- 每个样本，有一个正例和九个负例数据 (也称为干扰数据)。
- 建模的目标在于给正例的得分尽可能的高，而给负例的得分尽可能的低。(有点类似分类任务)
- 语料做过分词、stemmed、lemmatized 等文本预处理。

NLTK stemmed

> ```python
from nltk.stem.porter import PorterStemmer
p = PorterStemmer()
p.stem('wenting') 
```

NLTK Lemma

```python
from nltk.stem import WordNetLemmatizer
wordnet_lemmatizer = WordNetLemmatizer()
wordnet_lemmatizer.lemmatize(‘dogs’)
u’dog’
```

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

其中，y 是所预测的以降序排列的模型预测分值，y_test 是实际的 label 值。举个例子，假设 y 的值为 [0,3,1,2,5,6,4,7,8,9]，这说明 第0号 的候选的预测分值最高、作为回复的可能性最高，而9号则最低。这里的 第0号 同时也是正确的那个，即正例数据，标号为 1-9 的为随机生成的负例数据。

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

## 6. LSTM

建立的 NN模型 为两层 Encoder 的 LSTM模型（Dual Encoder LSTM Network），这种形式的网络被广泛应用 chatbot 中。

[seq2seq模型][7] 常用于机器翻译领域，并取得了较大的效果。使用 Dual LSTM模型 的原因在于这个模型被证明在这个数据集有较好的效果（[详情见这里][8]）, 这可以作为我们后续模型效果的验证。

两层 Encoder 的 LSTM模型 的结构图如下（[论文来源][9]）：

**大致流程：**

> (1). Query 和 Response 都是经过分词的，分词后每个词 embedding 为向量形式。初始的词向量使用 GloVe / Word2vec，之后词向量随着模型的训练会进行 fine-tuned 。
>
> (2). 分词且向量化的 Query 和 Response 经过相同的 RNN（word by word）。RNN 最终生成一个向量表示，捕捉了 Query 和 Response 之间的[语义联系]（图中的$c$和$r$）；这个向量的维度是可以指定的，这里指定为 256维。
>
> (3). 将 向量c 与一个 矩阵M 相乘，来预测一个可能的 回复$r’$。如果 $c$ 为一个256维的向量，M维 256*256 的矩阵，两者相乘的结果为另一个256维的向量，我们可以将其解释为[一个生成式的回复向量]。矩阵M 是需要训练的参数。
>
> (4). 通过点乘的方式来预测生成的 回复$r’$ 和 候选的 回复$r$ 之间的相似程度，点乘结果越大表示候选回复作为回复的可信度越高；之后通过 sigmoid 函数归一化，转成概率形式。
> 
>  (sigmoid作为压缩函数经常使用) 图中把第(3)步和第(4)步结合在一起了。
>  
> - (5). 损失函数（loss function）。这里使用二元的交叉熵（binary cross-entropy）作为损失函数。我们已知实例的真实 label $y$， 值为 0 或 1； 通过上面的第(4)步可以得到一个概率值 $y'$；因此，交叉熵损失值为 $L = -y \* ln(y') - (1 - y) \* ln(1 - y')$。
> 
>   这个公式意义是直观的，即当 $y=1$ 时，$L = -ln(y')$，期望 $y'$ 尽量接近 1 使得损失函数的值越小；反之亦然。
>
>
> 实现过程中使用了 numpy、pandas、TensorFlow 和 TF Learn 等工具。

### 6.1. 数据预处理

[数据集][16]的原始格式为csv格式，我们需要先将其转为 TensorFlow 专有的格式，这种格式的好处在于能够直接从输入文件中 load tensors，并让 TensorFlow 来处理洗牌(shuffling)、批量(batching) 和 队列化(queuing) 等操作。预处理中还包括创建一个字典库，将词进行标号，TFRecord 文件将直接存储这些词的标号。

每个实例包括如下几个字段：

- Query：表示为一串词标号的序列，如 [231, 2190, 737, 0, 912]；
- Query 的长度；
- Response：同样是一串词标号的序列；
- Response 的长度；
- Label；
- Distractor\_[N]：表示负例干扰数据，仅在验证集和测试集中有，N 的取值为 0-8；
- Distractor_[N]的长度；

数据预处理的 [Python脚本][17]，生成了3个文件：train.tfrecords, validation.tfrecords 和 test.tfrecords。你可以尝试自己运行程序，或者直接下载和使用预处理后的数据。

### 6.2. 创建输入函数

为了使用 TensoFlow内置 的训练和评测模块，我们需要创建一个输入函数：这个函数返回输入数据的 batch。

> 因为训练数据和测试数据的格式不同，我们需要创建不同的输入函数。
>
> 输入函数需要返回批量(**batch**)的特征和标签值(如果有的话)。类似于如下：

```python
def input_fn():
  # TODO Load and preprocess data here
  return batched_features, labels
```

因为我们需要在模型训练和评测过程中使用不同的输入函数，为了防止重复书写代码，我们创建一个包装器(wrapper)，名称为create_input_fn，针对不同的mode使用相应的code，如下：

```python
def create_input_fn(mode, input_files, batch_size, num_epochs=None):
    def input_fn():
	 # TODO Load and preprocess data here
        return batched_features, labels
    return input_fn
```

完整的code见[udc_inputs.py][udc18]。整体上，这个函数做了如下的事情：

(1) 定义了示例文件中的 feature字段；
(2) 使用 tf.TFRecordReader 来读取 input_files 中的数据；
(3) 根据 feature字段 的定义对数据进行解析；
(4) 提取训练数据的标签；
(5) 产生批量化的训练数据；
(6) 返回批量的特征数据及对应标签；

### 6.3. 定义评测指标

之前已经提到用 **recall@k** 这个指标来评测模型，TensorFlow 中已经实现了许多标准指标（包括 **recall@k**）。为了使用这些指标，需要创建一个字典，key 为指标名称，value 为对应的计算函数。如下

```python
def create_evaluation_metrics():
    eval_metrics = {}
    for k in [1, 2, 5, 10]:
        eval_metrics["recall_at_%d" % k] = functools.partial(
            tf.contrib.metrics.streaming_sparse_recall_at_k,
            k=k
    )
    return eval_metrics
```

如上，我们使用了 [functools.partial](https://docs.python.org/2/library/functools.html#functools.partial) 函数，这个函数的输入参数有两个。不要被 streaming_sparse_recall_at_k 所困惑，其中的 streaming 的含义是表示指标的计算是增量式的。

训练和测试所使用的评测方式是不一样的，训练过程中我们对 每个case 可能作为正确回复的概率进行预测，而测试过程中我们对每组数据（包含10个case，其中1个是正确的，另外9个是生成的负例/噪音数据）中的case进行逐条概率预测，得到例如 [0.34, 0.11, 0.22, 0.45, 0.01, 0.02, 0.03, 0.08, 0.33, 0.11] 这样格式的输出，这些输出值的和并不要求为 1（因为是逐条预测的，有单独的预测概率值，在 0 到 1 之间）； 而对于这组数据而言，因为数据 index=0 对应的为正确答案，这里 recall@1 为 0，因为 0.34 是其中第二大的值，所以 recall@2 是 1（表示这组数据中预测概率值在前二的中有一个是正确的）。

### 6.4. 训练程序样例

首先，给一个模型训练和测试的程序样例，这之后你可以参照程序中所用到的标准函数，来快速切换和使用其他的网络模型。假设我们有一个函数 `model_fn`，函数的输入参数有 `batched features`，`label` 和 `mode`(train/evaluation)，函数的输出为预测值。程序样例如下：

```python
estimator = tf.contrib.learn.Estimator(
    model_fn=model_fn,
    model_dir=MODEL_DIR,
    config=tf.contrib.learn.RunConfig()
)

input_fn_train = udc_inputs.create_input_fn(
    mode=tf.contrib.learn.ModeKeys.TRAIN,
    input_files=[TRAIN_FILE],
    batch_size=hparams.batch_size
)

input_fn_eval = udc_inputs.create_input_fn(
    mode=tf.contrib.learn.ModeKeys.EVAL,
    input_files=[VALIDATION_FILE],
    batch_size=hparams.eval_batch_size,
    num_epochs=1
)

eval_metrics = udc_metrics.create_evaluation_metrics()

# We need to subclass theis manually for now. The next TF version will
# have support ValidationMonitors with metrics built-in.
# It's already on the master branch.
class EvaluationMonitor(tf.contrib.learn.monitors.EveryN):
    def every_n_step_end(self, step, outputs):
        self._estimator.evaluate(
        input_fn=input_fn_eval,
        metrics=eval_metrics,
        steps=None)

eval_monitor = EvaluationMonitor(every_n_steps=FLAGS.eval_every)

estimator.fit(input_fn=input_fn_train, steps=None, monitors=[eval_monitor])
```

这里创建了一个 **model_fn** 的 **estimator**(评估函数)；

两个输入函数，**input_fn_train** 和 **input_fn_eval**，以及计算评测指标的函数；

### 6.5. 创建模型

到目前为止，我们创建了模型的 输入、解析、评测和训练 的样例程序。现在我们来写 LSTM 的程序，create_model_fn函数 用以处理不同格式的训练和测试数据；它的输入参数为 model_impl，这个函数表示实际作出预测的模型，这里就是用的LSTM，当然你可以替换成任意的其他模型。程序如下：

```python
def dual_encoder_model(
    hparams,
    mode,
    context,
    context_len,
    utterance,
    utterance_len,
    targets):

  # Initialize embedidngs randomly or with pre-trained vectors if available
  embeddings_W = get_embeddings(hparams)

  # Embed the context and the utterance
  context_embedded = tf.nn.embedding_lookup(
      embeddings_W, context, name="embed_context")
  utterance_embedded = tf.nn.embedding_lookup(
      embeddings_W, utterance, name="embed_utterance")


  # Build the RNN
  with tf.variable_scope("rnn") as vs:
    # We use an LSTM Cell
    cell = tf.nn.rnn_cell.LSTMCell(
        hparams.rnn_dim,
        forget_bias=2.0,
        use_peepholes=True,
        state_is_tuple=True)

    # Run the utterance and context through the RNN
    rnn_outputs, rnn_states = tf.nn.dynamic_rnn(
        cell,
        tf.concat(0, [context_embedded, utterance_embedded]),
        sequence_length=tf.concat(0, [context_len, utterance_len]),
        dtype=tf.float32)
    encoding_context, encoding_utterance = tf.split(0, 2, rnn_states.h)

  with tf.variable_scope("prediction") as vs:
    M = tf.get_variable("M",
      shape=[hparams.rnn_dim, hparams.rnn_dim],
      initializer=tf.truncated_normal_initializer())

    # "Predict" a  response: c * M
    generated_response = tf.matmul(encoding_context, M)
    generated_response = tf.expand_dims(generated_response, 2)
    encoding_utterance = tf.expand_dims(encoding_utterance, 2)

    # Dot product between generated response and actual response
    # (c * M) * r
    logits = tf.batch_matmul(generated_response, encoding_utterance, True)
    logits = tf.squeeze(logits, [2])

    # Apply sigmoid to convert logits to probabilities
    probs = tf.sigmoid(logits)

    # Calculate the binary cross-entropy loss
    losses = tf.nn.sigmoid_cross_entropy_with_logits(logits, tf.to_float(targets))

  # Mean loss across the batch of examples
  mean_loss = tf.reduce_mean(losses, name="mean_loss")
  return probs, mean_loss
```

完整的程序见 [dual_encoder.py](https://github.com/dennybritz/chatbot-retrieval/blob/master/models/dual_encoder.py)。基于这个，我们能够实例化 model函数 在我们之前定义的 [udc_train.py](https://github.com/dennybritz/chatbot-retrieval/blob/master/udc_train.py)，如下：

```python
model_fn = udc_model.create_model_fn(
  hparams=hparams,
  model_impl=dual_encoder_model)
```

这样我们就可以直接运行 udc_train.py文件，来开始模型的训练和评测了，你可以设定--eval_every参数 来控制模型在验证集上的评测频率。更多的命令行参数信息可见 tf.flags 和 hparams，你也可以运行 python udc_train.py --help 来查看。

运行程序的效果如下：

```bash
INFO:tensorflow:training step 20200, loss = 0.36895 (0.330 sec/batch).
INFO:tensorflow:Step 20201: mean_loss:0 = 0.385877
INFO:tensorflow:training step 20300, loss = 0.25251 (0.338 sec/batch).
INFO:tensorflow:Step 20301: mean_loss:0 = 0.405653
...
INFO:tensorflow:Results after 270 steps (0.248 sec/batch): recall_at_1 = 0.507581018519, recall_at_2 = 0.689699074074, recall_at_5 = 0.913020833333, recall_at_10 = 1.0, loss = 0.5383
...
```

### 6.6. 模型的评测

在训练完模型后，你可以将其应用在 **测试集** 上，使用：

```python
python udc_test.py --model_dir=$MODEL_DIR_FROM_TRAINING   
```

例如：

```python
python udc_test.py --model_dir=~/github/chatbot-retrieval/runs/1467389151
```

这将得到模型在 **测试集** 上的 recall@k 的结果，注意在使用 udc_test.py文件 时，需要使用与训练时相同的参数。

在训练模型的次数大约 **2w** 次时(在GPU上大约花费1小时)，模型在测试集上得到如下的结果：

```bash
recall_at_1 = 0.507581018519
recall_at_2 = 0.689699074074
recall_at_5 = 0.913020833333
```

其中，recall@1的值与tfidf模型的差不多，但是recall@2和recall@5的值则比tfidf模型的结果好太多。原论文中的结果依次是0.55,0.72和0.92，可能通过模型调参或者预处理能够达到这个结果。

### 6.7. 使用模型进行预测

对于新的数据，你可以使用 [udc_predict.py](https://github.com/dennybritz/chatbot-retrieval/blob/master/udc_predict.py) 来进行预测；例如：

```python
python udc_predict.py --model_dir=./runs/1467576365/
```

结果如下：

```bash
Context: Example context
Response 1: 0.44806
Response 2: 0.481638
```

你可以从候选的回复中，选择预测分值最高的那个作为回复。

### 6.8. 总结

这篇博文中，我们实现了一个基于检索的 NN模型，它能够对候选的回复进行预测和打分，通过输出分值最高（或者满足一定阈值）的候选回复已完成聊天的过程。后续可以尝试其他更好的模型，或者通过调参来取得更好的实验结果。

## Reference

- [About ChatterBot][1]
- [2016 Google Brain deep-learning-for-chatbots-part-1-introduction, wildml blog][2_1]
- [2016 Google Brain deep-learning-for-chatbots-2-retrieval-based-model-tensorflow, wildml blog][2_2]
- [聊天机器人中的深度学习技术之二：基于检索模型的实现][3]
- [聊天机器人中的深度学习技术之一：导读][4]
- [Tensorflow搞一个聊天机器人][10]
- [Eric，基于多搜索引擎的自动问答机器人][11]
- [测试人机问答系统智能性的3760个问题][12]
- [中国版的聊天机器人地图 Chatbots Landscape][13]
- [条件随机场简介][14]
- [知识图谱学习系列之二：命名实体识别1（技术及代码）][15]

[1]: https://chatterbot.readthedocs.io/en/stable/
[2_1]: http://www.wildml.com/2016/04/deep-learning-for-chatbots-part-1-introduction/
[2_2]: http://www.wildml.com/2016/07/deep-learning-for-chatbots-2-retrieval-based-model-tensorflow/
[3]: http://www.jeyzhang.com/deep-learning-for-chatbots-2.html
[4]: http://www.jeyzhang.com/deep-learning-for-chatbots-1.html
[5]: https://arxiv.org/abs/1606.04870
[6]: http://www.nltk.org/
[6_1]: http://www.nltk.org/api/nltk.tokenize.html#module-nltk.tokenize
[6_2]: http://www.nltk.org/api/nltk.stem.html#module-nltk.stem.snowball
[6_3]: http://www.nltk.org/api/nltk.stem.html#module-nltk.stem.wordnet
[6_4]: https://github.com/dennybritz/chatbot-retrieval/blob/master/notebooks/Data%20Exploration.ipynb

[7]: https://www.tensorflow.org/versions/r0.9/tutorials/seq2seq/index.html
[8]: https://arxiv.org/abs/1510.03753
[9]: https://arxiv.org/abs/1506.08909

[10]: http://www.cnblogs.com/LittleHann/p/6426610.html
[11]: https://zhuanlan.zhihu.com/p/27285330
[12]: https://my.oschina.net/apdplat/blog/401622
[13]: https://zhuanlan.zhihu.com/p/25749274

[14]: https://blog.csdn.net/SunJW_2017/article/details/82494360
[15]: https://blog.csdn.net/SunJW_2017/article/details/82460284

[16]: https://github.com/chatbot-tube/ubuntu-ranking-dataset-creator
[17]: https://github.com/dennybritz/chatbot-retrieval/blob/master/scripts/prepare_data.py

[udc18]: https://github.com/dennybritz/chatbot-retrieval/blob/master/udc_inputs.py

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