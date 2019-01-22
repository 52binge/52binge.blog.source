## my dream

> 个人看法要在面试之前按照简历上面的内容自己能够讲一个小故事。主要体现自己的深度学习的基础知识，这一部分要结合项目经验进行拔高，让面试官看到你的能力和特点。

## 1. DNN 

- ReLu、Tanh、Sigmod 激活函数
- 交叉熵损失函数 (Cross Entropy Error Function)
- softmax求导
- 过拟合
- 梯度爆炸和梯度弥散
- Optimization (Mini-batch、指数加权平均-偏差修正、Momentum、RMSprop、Adam、学习率衰减)

### 1.1 Deep Neural Networks

Tanh 数据平均值为 0，具有数据中心化的效果，几乎在任何场合都优于 Sigmoid

<img src="/images/deeplearning/C1W3-9_1.png" width="700" />

> 对于中间层来说, 往往是 ReLU 的效果最好.
>
> 虽然 z < 0 时，斜率为0， 但在实践中，有足够多的隐藏单元 令 z > 0, 对大多数训练样本来说是很快的.

### 1.2 Cross Entropy

Cross Entropy损失函数常用于分类问题中，但是为什么它会在分类问题中这么有效呢？我们先从一个简单的分类例子来入手。

- [Cross Entropy 交叉熵损失函数](https://zhuanlan.zhihu.com/p/35709485)

> 预测政治倾向例子
> - Classification Error（分类错误率）
> - Mean Squared Error (均方方差)
> - Cross Entropy Error Function（交叉熵损失函数）

**模型1：**

![](https://pic3.zhimg.com/80/v2-0c49d6159fc8a5676637668683d41762_hd.jpg)

**模型2：**

![](https://pic3.zhimg.com/80/v2-6d31cf03185b408d5e93fa3e3c05096e_hd.jpg)

**Classification Error: **

![](https://www.zhihu.com/equation?tex=classification%5C+error%3D%5Cfrac%7Bcount%5C+of%5C+error%5C+items%7D%7Bcount%5C+of+%5C+all%5C+items%7D)

**Mean Squared Error:**

![](https://www.zhihu.com/equation?tex=MSE%3D%5Cfrac%7B1%7D%7Bn%7D%5Csum_%7Bi%7D%5En%28%5Chat%7By_i%7D-y_i%29%5E2)

> 我们发现，MSE能够判断出来模型2优于模型1，那为什么不采样这种损失函数呢？主要原因是逻辑回归配合MSE损失函数时，采用梯度下降法进行学习时，会出现模型一开始训练时，学习速率非常慢的情况
> 
> 结论： 对于分类问题的损失函数来说，分类错误率和平方和损失都不是很好的损失函数

**Cross Entropy Error Function（交叉熵损失函数）**

二分类

![](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7DJ+%3D+%E2%88%92%5By%5Ccdot+log%28p%29%2B%281%E2%88%92y%29%5Ccdot+log%281%E2%88%92p%29%5D%5Cend%7Balign%7D+%5C%5C)

多分类

![](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7DJ+%3D+-%5Csum_%7Bc%3D1%7D%5EMy_%7Bc%7D%5Clog%28p_%7Bc%7D%29%5Cend%7Balign%7D+%5C%5C)

> 函数性质: 该函数是凸函数，求导时能够得到全局最优值
> 
> 交叉熵损失函数经常用于分类问题中，特别是在神经网络做分类问题时，也经常使用交叉熵作为损失函数，此外，由于交叉熵涉及到计算每个类别的概率，所以交叉熵几乎每次都和softmax函数一起出现。
> 
> 使用交叉熵损失函数，不仅可以很好的衡量模型的效果，又可以很容易的的进行求导计算

在用梯度下降法做参数更新的时候，模型学习的速度取决于两个值：

> 1. 学习率
> 2. 偏导值

### 1.3 Improving Deep Neural Networks

> - 能够高效地使用神经网络**通用**的技巧，包括 `初始化、L2和dropout正则化、Batch归一化、梯度检验`。
> - 能够实现并应用各种**优化**算法，例如 `Mini-batch、Momentum、RMSprop、Adam，并检查它们的收敛程度`。
> - 理解深度学习时代关于如何 **构建训练/开发/测试集** 以及 **偏差/方差分析** 最新最有效的方法.

本周主要内容包括:
 
 > 1. Data set partition
 > 2. Bias / Variance
 > 3. Regularization
 > 4. Normalization
 > 5. Gradient Checking
 
#### Data set partition
 
> 在以往传统的机器学习中, 我们通常按照 70/30 来数据集分为 `Train set`/`Validation set`, 或者按照 60/20/20 的比例分为 `Train/Validation/Test`. 
> 
> 但在今天机器学习问题中, 我们可用的**数据集的量级非常大** (例如有 100W 个样本). 这时我们就**不需要给验证集和测试集太大的比例, 例如 98/1/1**.

#### Regularization

- L1 regularization 
- L2 regularization 

> 当我们的 λ 比较大的时候, 模型就会加大对 w 的惩罚, 这样有些 w 就会变得很小 (L2 Regularization 也叫权重衰减, weights decay). 从下图左边的神经网络来看, 效果就是整个神经网络变得简单了(一些隐藏层甚至 w 趋向于 0), 从而降低了过拟合的风险.
>
> 那些 隐藏层 并没有被消除，只是影响变得更小了，神经网络变得简单了.
> 
> L2 正则化 的缺点是，要用大量精力搜索合适的 λ .

#### dropout

> dropout 将产生收缩权重的平方范数的效果, 和 L2 类似，实施 dropout 的结果是它会压缩权重，并完成一些预防过拟合的外层正则化，事实证明 dropout 被正式地作为一种正则化的替代形式
>
> L2 对不同权重的衰减是不同的，它取决于倍增的激活函数的大小.
>
> dropout 的功能类似于 L2 正则化. 甚至 dropout 更适用于不同的输入范围.

#### Normalization

#### Vanishing/Exploding gradients

一个可以减小这种情况发生的方法, 就是用有效的参数初始化 (该方法并不能完全解决这个问题). 但是也是有意义的

设置合理的权重，希望你设置的权重矩阵，既不会增长过快，也不会下降过快到 0.

想更加了解如何初始化权重可以看下这篇文章 [神经网络权重初始化问题](http://www.cnblogs.com/marsggbo/p/7462682.html)，其中很详细的介绍了权重初始化问题。

> 我们不应该做的事情（即初始化为0）, 如果权重初始化为同一个值，网络就不可能不对称(即是对称的)。
>
> 警告：并不是数字越小就会表现的越好。比如，如果一个神经网络层的权重非常小，那么在反向传播算法就会计算出很小的梯度(因为梯度gradient是与权重成正比的)。在网络不断的反向传播过程中将极大地减少“梯度信号”，并可能成为深层网络的一个需要注意的问题

**实际操作：**

> 通常的建议是使用ReLU单元以及 Kaiming He 等人 推荐的公式
>
> $$
w = np.random.randn(n) * sqrt(2.0/n)
$$
> np.random.randn 是从标准正态分布中返回一个或多个样本值

## 2. RNN

在介绍 RNN 之前，首先解释一下为什么之前的标准网络不再适用了。

因为它有两个缺点：

- 输入和输出的长度不尽相同
- 无法共享从其他位置学来的特征

> DNN 标准网络，输入层，比如每个 $x^{<1>}$ 都是一个 1000 维的向量，这样输入层很庞大, 那么第一层的权重矩阵就有着巨大的参数. 而 RNN 可以共享参数
> 
> DNN 传统网络存在的问题，即单词之间没有联系
> 
> RNN 为了将单词之间关联起来，所以将前一层的结果也作为下一层的输入数据。
> 
> RNN 在正向传播的过程中可以看到 a 的值随着时间的推移被传播了出去，也就一定程度上保存了单词之间的特性
> 
> RNN 要开始整个流程, 需要编造一个激活值, 这通常是 0向量, 有些研究人员会用其他方法随机初始化 $a^{<0>}=\vec{0}$. 不过使用 0向量，作为 0时刻 的伪激活值 是最常见的选择. 因此我们把它输入神经网络.

<img src="/images/deeplearning/C5W1-10_1.png" width="750" />

> $a^{<0>}=\vec{0}$
> 
> $a^{<1>}=g\_1(W\_{aa}a^{<0>}+W\_{ax}x^{<1>}+b\_a)$
> 
> $y^{<1>}=g\_2(W\_{ya}a^{<1>}+b\_y)$
> 
> $a^{<{t}>}=g\_1(W\_{aa}a^{<{t-1}>}+W\_{ax}x^{<{t}>}+b\_a)$
> 
> $y^{<{t}>}=g\_2(W\_{ya}a^{<{t}>}+b\_y)$
>
> 激活函数：**$g\_1$** 一般为 **`tanh`函数** (或者是 **`Relu`函数**)，**$g\_2$** 一般是 **`Sigmod`函数**.
>
> 注意: 参数的下标是有顺序含义的，如 $W\_{ax}$ 下标的第一个参数表示要计算的量的类型，即要计算 $a$ 矢量，第二个参数表示要进行乘法运算的数据类型，即需要与 $x$ 矢量做运算。如 $W\_{ax} x^{t}\rightarrow{a}$

**Simplified RNN notation：**

<img src="/images/deeplearning/C5W1-11_1.png" width="400" />

$$
\begin{align}
a^{<{t}>}&= g(W\_{aa}a^{<{t-1}>}+W\_{ax}x^{<{t}>}+b\_a) \notag \\\\
&= g(W\_a [a^{<{t-1}>},x^{<{t}>}]^{T}+b\_a) \notag
\end{align}
$$

[TensorFlow： 第8章 RNN 循环神经网络 1][1]

#### Vanishing gradients with RNNs

> 现在你已经学会了 基本的 RNN 如何应用在 比如 语言模型 还有 如何用反向传播来训练你的 RNN 模型, 但是还有一个问题就是 梯度消失 与 梯度爆炸 问题.
>
> 目前这种基本的 RNN 也不擅长捕获这种长期依赖效应.
>
> 梯度爆炸可以用梯度消减解决、梯度消失就有点麻烦了，需要用 **GRU** 来解决.

**RNN 的梯度消失、爆炸问题:**

但梯度值过小的解决方案要稍微复杂一点，比如下面两句话：

> “The **cat**，which already ate apple，yogurt，banana，…, **was** full.”

所以为了 解决梯度消失 问题，提出了

1. GRU单元
2. LSTM

> - [人人都能看懂的GRU](https://zhuanlan.zhihu.com/p/32481747)
> - [一文了解LSTM和GRU背后的秘密（绝对没有公式）](https://zhuanlan.zhihu.com/p/46327831)
>
> 识别偏见方向

- [理论 seq2seq+Attention 机制模型详解](/2017/11/17/chatbot/chatbot-research8/)
- [Tensorflow 实现 seq2seq+Attention 详解](https://github.com/blair101/seq2seq_chatbot)


## 3. NLP

- word2vec
- fasttext
- seq2seq
- soft attention和hard attention的区别
- transformer

### 1. 数据预处理

### 2. 定义模型

### 3. 设置模型参数

```py
tf.app.flags.DEFINE_integer('rnn_size', 1024, 'Number of hidden units in each layer')
tf.app.flags.DEFINE_integer('num_layers', 2, 'Number of layers in each encoder and decoder')
tf.app.flags.DEFINE_integer('embedding_size', 1024, 'Embedding dimensions of encoder and decoder inputs')

tf.app.flags.DEFINE_float('learning_rate', 0.0001, 'Learning rate')
tf.app.flags.DEFINE_integer('batch_size', 128, 'Batch size')
tf.app.flags.DEFINE_integer('numEpochs', 30, 'Maximum # of training epochs')
tf.app.flags.DEFINE_integer('steps_per_checkpoint', 100, 'Save model checkpoint every this iteration')
tf.app.flags.DEFINE_string('model_dir', 'model/', 'Path to save model checkpoints')
tf.app.flags.DEFINE_string('model_name', 'chatbot.ckpt', 'File name used for model checkpoints')
```

### 4. 构建 batch

padToken, goToken, eosToken, unknownToken = 0, 1, 2, 3

每个epoch之前都要进行样本的shuffle

```py
max_source_length = max(batch.encoder_inputs_length)
max_target_length = max(batch.decoder_targets_length)
```

将source进行反序并PAD值本batch的最大长度

样本的shuffle

```py
class Batch:
    # batch类，里面包含了encoder输入，decoder输入，各自最大长度
    def __init__(self):
        self.encoder_inputs = []
        self.encoder_inputs_length = []
        self.decoder_targets = []
        self.decoder_targets_length = []
```


self.encoder_inputs = [[source1], [source2], [source3], ..., [source_n]]

self.decoder_targets = [[target1], [target2], [target3], ..., [target_n]]

> source 是 pad + reversed(source) 的结果
> target 是 target + pad


### 5. model

rnn_size', 1024, (隐藏单元的个数)

max\_gradient\_norm=5.0

#### 5.1 encoder

```py
with tf.variable_scope('encoder'):
    # 创建LSTMCell，两层+dropout
    encoder_cell = self._create_rnn_cell()
    # 构建embedding矩阵,encoder和decoder公用该词向量矩阵
    embedding = tf.get_variable('embedding', [self.vocab_size, self.embedding_size])
    encoder_inputs_embedded = tf.nn.embedding_lookup(embedding, self.encoder_inputs)
    # 使用dynamic_rnn构建LSTM模型，将输入编码成隐层向量。
    # encoder_outputs 用于 attention，batch_size*encoder_inputs_length*rnn_size,
    # encoder_state   用于 decoder 的初始化状态，batch_size*rnn_szie
    encoder_outputs, encoder_state = tf.nn.dynamic_rnn(encoder_cell, encoder_inputs_embedded,
                                                       sequence_length=self.encoder_inputs_length,
                                                       dtype=tf.float32)
```

- [tf.nn.embedding_lookup()的用法](https://blog.csdn.net/John_xyz/article/details/60882535)
- [tf.nn.dynamic_rnn 详解](https://zhuanlan.zhihu.com/p/43041436)

### 5.2 decode

```py
attention_mechanism = tf.contrib.seq2seq.BahdanauAttention...

decoder_cell = self._create_rnn_cell()

decoder_cell = tf.contrib.seq2seq.AttentionWrapper...

# 定义decoder阶段的初始化状态，直接使用encoder阶段的最后一个隐层状态进行赋值
decoder_initial_state = decoder_cell.zero_state(batch_size=batch_size, dtype=tf.float32).clone(cell_state=encoder_state)

output_layer = tf.layers.Dense(self.vocab_size, ...
```

训练阶段， 使用 TrainingHelper+BasicDecoder 的组合：

```py
training_helper = tf.contrib.seq2seq.TrainingHelper(inputs=decoder_inputs_embedded, sequence_length=self.decoder_targets_length,time_major=False, name='training_helper')

training_decoder = tf.contrib.seq2seq.BasicDecoder(cell=decoder_cell, helper=training_helper, initial_state=decoder_initial_state,output_layer=output_layer)
```


```py
            if self.mode == 'train':

                # 定义decoder阶段的输入，其实就是在decoder的target开始处添加一个<go>,并删除结尾处的<end>,并进行embedding。
                # decoder_inputs_embedded的shape为[batch_size, decoder_targets_length, embedding_size]
                ending = tf.strided_slice(self.decoder_targets, [0, 0], [self.batch_size, -1], [1, 1])
                decoder_input = tf.concat([tf.fill([self.batch_size, 1], self.word_to_idx['<go>']), ending], 1)

                decoder_inputs_embedded = tf.nn.embedding_lookup(embedding, decoder_input)

                # 训练阶段，使用TrainingHelper+BasicDecoder的组合，这一般是固定的，当然也可以自己定义Helper类，实现自己的功能
                training_helper = tf.contrib.seq2seq.TrainingHelper(inputs=decoder_inputs_embedded,
                                                                    sequence_length=self.decoder_targets_length,
                                                                    time_major=False, name='training_helper')

                training_decoder = tf.contrib.seq2seq.BasicDecoder(cell=decoder_cell, helper=training_helper,
                                                                   initial_state=decoder_initial_state,
                                                                   output_layer=output_layer)

                # 调用dynamic_decode进行解码，decoder_outputs是一个namedtuple，里面包含两项(rnn_outputs, sample_id)
                # rnn_output: [batch_size, decoder_targets_length, vocab_size]，保存decode每个时刻每个单词的概率，可以用来计算loss
                # sample_id: [batch_size], tf.int32，保存最终的编码结果。可以表示最后的答案
                
                decoder_outputs, _, _ = tf.contrib.seq2seq.dynamic_decode(decoder=training_decoder,
                                                                          impute_finished=True,
                                                                          maximum_iterations=self.max_target_sequence_length)
```

> 其实简单来讲dynamic_decode就是
> 
>  1. 执行decoder的初始化函数
>  2. 对解码时刻的state等变量进行初始化
>  3. 循环执行 decoder 的 step函数 进行多轮解码
> 
> 常人写可能就一个for循环，但是源码很复杂，为了保证健壮性.


[decode self.mode == 'train'](https://github.com/blair101/seq2seq_chatbot/blob/master/new_seq2seq_chatbot/model.py)


### 6. train

训练时，优化梯度求解计算

```py
optimizer = tf.train.AdamOptimizer(self.learing_rate)
trainable_params = tf.trainable_variables()
gradients = tf.gradients(self.loss, trainable_params)

# 其中 global_norm = sqrt(sum([l2norm(t)**2 for t in t_list]))
# global_norm 是所有梯度的平方和，如果 clip_norm > global_norm ，就不进行截取
# clip_norm = self.max_gradient_norm
# t_list[i] * clip_norm / max(global_norm, clip_norm)
clip_gradients, _ = tf.clip_by_global_norm(gradients, self.max_gradient_norm)

# 应用梯度 apply_gradients
self.train_op = optimizer.apply_gradients(zip(clip_gradients, trainable_params))
```

loss

```py
perplexity = math.exp(float(loss)) if loss < 300 else float('inf')
```

## 文本分类

1. fasttext
2. 调参数
3. 优化
4. RCNN
5. seq2seq
6. TextCNN，TextRNN的模型

> fasttext TextCNN RCNN HAN DMN EntityNetwork charCNN charRNN）。需要在总结一下各个模型的优缺点
> fasttext、CNN、RNN的优缺点各是什么等等
> 为什么fasttext速度很快，然后问了下如果现在在做会采用什么样的方案；
> 说一说 RNN 和 LSTM 的区别和原理

---
date: 2018-10-17 21:19:48
---

## 细粒度用户评论情感分析

有20个粒度的评价指标，每个粒度又有4种情感状态，从官方baseline来看，分别训练了20个（4标签）分类器。

## 1. fastText baseline

要用facebook官方的 fastText 以及自带的 Python fastText 工具包做这件事并不容易，或者说对于20个多标签分类器来说这事很繁琐

> skift：scikit-learn wrappers for Python fastText.

默认配置参数训练fasttext多模型，直接运行“python main_train.py” 即可。这样大概跑了不到10分钟，内存峰值占用不到8G，在验证集上得到一个f1均值约为0.5451的fasttext多分类模型(20个），模型存储位置在 model_path 下：fasttext_model.pkl，大概1.8G，在验证集上详细的F1值大致如下：

```bash
location_traffic_convenience:0.5175700387941342
location_distance_from_business_district:0.427891674259875
location_easy_to_find:0.570805555583767
service_wait_time:0.5052181634999748
service_waiters_attitude:0.6766570408968818
service_parking_convenience:0.5814636947460745
service_serving_speed:0.5701241141533907
price_level:0.6161258412096242
price_cost_effective:0.5679586399625348
price_discount:0.5763345656700684
environment_decoration:0.5554146717297597
environment_noise:0.563452055291662
environment_space:0.5288336794721515
environment_cleaness:0.5511776910510577
dish_portion:0.5527095496220675
dish_taste:0.6114994440656155
dish_look:0.43750894239614163
dish_recommendation:0.41756941548558957
others_overall_experience:0.5322283082904627
others_willing_to_consume_again:0.5404900044311536


2018-10-02 14:32:18,927 [INFO]  (MainThread) f1_score: 0.5450516545305993
```

调参：

```py
python main_train.py -mn fasttext_wn2_model.pkl -wn 2
```

这次大约跑了15分钟，内存峰值最大到37G，存储的模型大约在17G，验证集F1值结果如下：

```bash
location_traffic_convenience:0.5482785384602362
location_distance_from_business_district:0.4310319720574882
location_easy_to_find:0.6140713866422334
service_wait_time:0.5247890022873511
service_waiters_attitude:0.6881098513108542
service_parking_convenience:0.5828935095474249
service_serving_speed:0.6168828054420539
price_level:0.6615100420842464
price_cost_effective:0.5954569043369508
price_discount:0.5744529736585073
environment_decoration:0.5743996877298929
environment_noise:0.6186211367923496
environment_space:0.5981761036053918
environment_cleaness:0.6002515744280692
dish_portion:0.5733503000134572
dish_taste:0.6075507493398153
dish_look:0.4424685719881029
dish_recommendation:0.5936671419596734
others_overall_experience:0.5325664419580063
others_willing_to_consume_again:0.5875683298630815

2018-10-02 14:53:00,701 [INFO]  (MainThread) f1_score: 0.5783048511752592
```

这个结果看起来还不错，我们可以基于这个fasttext多分类模型进行测试集的预测：

```py
python main_predict.py -mn fasttext_wn2_model.pkl
```

大约运行不到3分钟，预测结果就出炉了，可以在 test_data_predict_output_path 找到这个预测输出文件: testa_predict.csv ，然后就可以去官网提交了，在线提交的结果和验证集F1值大致相差0.01~0.02。这里还可以做一些事情来优化结果，譬如去停用词，不过我试了去停用词和去一些标点符号，结果还有一些降低；**调参，learning_rate的影响是比较直接的**，min_count设置为2貌似也有一些负向影响，有兴趣的同学可以多试试，寻找一个最优组合。

## 2. Seq2Seq Attention

- jieba 分词
- 建立词典时，过滤掉出现次数小于 5 的词
- 训练集、验证集 以及 测试集A组成的语料，词典大小为 66347
- 预测和训练时，词典没有出现的词 用 `<UNK>` 代替

> 模型：Attention-RCNN、Attention-RNN

直接使用的是char模型，不需要分词，用到的停用词也不多。粗暴但实测效果比 word level 好。

### 2.1 预处理数据 data

- trainsets lines：  501132， 合法例子 ： 105000
- validationset lines：  70935, 合法例子 ： 15000
- testsets lines：  72028， 合法例子 ： 15000

**word2vec：** 维度 100， 窗口 10， 过滤掉次数小于 1 的词

```
3.1M chars.vector
```

数据预处理，在 preprocess 文件夹下生成了 train_char.csv、test_char.csv、test_char.csv 三个文件。

```bash
-rw-r--r--  1 blair 10:36 test_char.csv
-rw-r--r--  1 blair 10:09 train_char.csv
-rw-r--r--  1 blair 10:32 validation_char.csv
```

### 2.2 Attention Model

- 参考自 Kaggle 的 [Attention Model](https://www.kaggle.com/qqgeogor/keras-lstm-attention-glove840b-lb-0-043)

## Reference

- [比赛官网 https://challenger.ai][2_1]
- [AI-Challenger Baseline 细粒度用户评论情感分析 (0.70201) 前篇][2_1]

[2_1]: https://challenger.ai/competition/fsauor2018
[2_2]: https://zhuanlan.zhihu.com/p/47207009


## 写代码

 1. 剑指offer
 2. 现场写tf代码 简单的
 3. 用tensorflow实现一个

> 个人定位： 是深度学习与NLP， 不断地展现自己在深度学习上的造诣

## Reference

[1]: /2018/11/08/tensorflow/tf-google-8-rnn-1/

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






