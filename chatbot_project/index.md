### 1. RNN

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






