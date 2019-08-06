---
date: 2018-12-03 13:36:21
---

## 1. chatbot

- [聊天机器人Chatbot的训练质量如何评价？](https://www.zhihu.com/question/60530973/answer/184454797)

> 可以类比语言模型的ppl，在词表几万的情况下，我的经验是100左右就已经能生成流畅的话了，如果远高于100，如200，生成的基本不流畅。如果远小于100，倒不一定非常过拟合。

- [實現基於seq2seq的聊天機器人](https://www.smwenku.com/a/5b7c8a4a2b71770a43db78ed/)

> Cornell Movie-Dialogs Corpus 困惑度降到了二十多

- [小黄鸡-多语言](http://www.simsimi.com/ChatSettings)

- [从产品完整性的角度浅谈chatbot](https://zhuanlan.zhihu.com/p/34927757)

- [对话系统(Chatbot)论文串烧](https://zhuanlan.zhihu.com/p/35317776)

## MMI (Maximum Mutual Information)

11. 对话项目的模型的缺点以及使用MMI的改进方案。
12. Attention机制的计算细节和公式是怎样的，然后我就介绍了一下公式的计算方法，然后说了一下改进的方案等。
13. MMI模型第一个改进目标函数中P(T)是如何计算的？ 我说每个词的联合概率分布乘积，当时他面露疑问，我还没反应过来是什么意思，到后面有说到这个问题才明白，原来他的意思是P(T)应该是单纯语言模型学习出来的结果，而按照我的说法，P(T)是在输入的基础上进行计算的

> 作者： Jiwei Li， Jiwei Li’s Github
> 关于《A Persona-Based Neural Conversation Model》的pre-paper Seq2seq 容易产出”呵呵”，”都可以”，”我不知道”这种 safe 但无意义的回答
> NLG 问题，常使用 MLE （maximum likelihood estimation）作为目标函数，产出的结果通畅，但 diversity 差，可考虑 decoder 产出 n-best, 再 rank
> 提出 Maximum Mutual Information(MMI) 作为目标函数， 有 MMI-antiLM 和MMI-bidi 2种
> 
> 作者通过使用MMI, 最大化输入与输出的互信息，能够有效避免与输入无关的responses，得到更为diverse的responses.

## BahdanauAttention / LuongAttention

- [BahdanauAttention与LuongAttention注意力机制简介](https://blog.csdn.net/u010960155/article/details/82853632)

### 1.1 数据预处理

### 1.2 定义模型

```py
class Seq2SeqModel():
    def __init__(self, rnn_size, num_layers, embedding_size, learning_rate, word_to_idx, mode, use_attention,
                 beam_search, beam_size, max_gradient_norm=5.0):

        self.learing_rate = learning_rate
        self.embedding_size = embedding_size  # 1024

        self.rnn_size = rnn_size
        self.num_layers = num_layers

        self.word_to_idx = word_to_idx
        self.vocab_size = len(self.word_to_idx)  # 词汇表 size

        self.mode = mode  # train
        self.use_attention = use_attention  # True

        self.beam_search = beam_search  # False
        self.beam_size = beam_size

        self.max_gradient_norm = max_gradient_norm
        # 执行模型构建部分的代码
        self.build_model()
        
    def _create_rnn_cell(self):
        ...
    def build_model(self):       
        ...
        # ==== 2, 定义模型的encoder部分 ====
        with tf.variable_scope('encoder'):
            # 创建LSTMCell，两层+dropout
            ...
        # ==== 3, 定义模型的decoder部分 ====
        with tf.variable_scope('decoder'):
            ...
            if self.beam_search:
                ...
            # 定义要使用的attention机制
            ...
            
            if self.mode == 'train':
                ...
            if self.mode == 'decode':
                ...
    def train(self, sess, batch):
        ...
    def eval(self, sess, batch):
        ...
    def infer(self, sess, batch):
        ...
```

### 1.3 设置模型参数

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

### 1.4 构建 batch

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


### 1.5 model

rnn_size', 1024, (隐藏单元的个数)

max\_gradient\_norm=5.0

#### 1.5.1 encoder

```py
with tf.variable_scope('encoder'):
    # 创建LSTMCell，两层+dropout
    encoder_cell = self._create_rnn_cell()
    # 构建embedding矩阵,encoder和decoder公用该词向量矩阵
    embedding = tf.get_variable('embedding', [self.vocab_size, self.embedding_size])
    encoder_inputs_embedded = tf.nn.embedding_lookup(embedding, self.encoder_inputs)
    # encoder_inputs_embedded 输入的训练或测试数据，一般格式为[batch_size, max_time, embed_size]
    
    # 使用dynamic_rnn构建LSTM模型，将输入编码成隐层向量。 
    # 返回值：元组（outputs, states）， outputs：outputs 就是每个cell会有一个输出
    
    # encoder_outputs 用于 attention，batch_size*encoder_inputs_length*rnn_size,
    # encoder_state   encoder 最后一个cell输出的状态, 用于 decoder 的初始化状态，batch_size*rnn_szie
    encoder_outputs, encoder_state = tf.nn.dynamic_rnn(encoder_cell, encoder_inputs_embedded,
                                                       sequence_length=self.encoder_inputs_length,
                                                       dtype=tf.float32)
```

> tf.nn.dynamic_rnn 函数是 tensorflow 封装的用来实现 RNN 的函数

- [tf.nn.embedding_lookup()的用法](https://blog.csdn.net/John_xyz/article/details/60882535)
- [tf.nn.dynamic_rnn 详解](https://zhuanlan.zhihu.com/p/43041436)

#### 1.5.2 decode

```py
# ====== 3, 定义模型的decoder部分 ======
with tf.variable_scope('decoder'):
    encoder_inputs_length = self.encoder_inputs_length
    if self.beam_search:
        # 如果使用beam_search，则需将encoder的输出进行tile_batch，其实就是复制beam_size份。
        print("use beamsearch decoding..")
        encoder_outputs = tf.contrib.seq2seq.tile_batch(encoder_outputs, multiplier=self.beam_size)
        encoder_state = nest.map_structure(lambda s: tf.contrib.seq2seq.tile_batch(s, self.beam_size),
                                           encoder_state)
        encoder_inputs_length = tf.contrib.seq2seq.tile_batch(self.encoder_inputs_length,
                                                              multiplier=self.beam_size)

	# 定义要使用的 attention机制。                                                               
	attention_mechanism = tf.contrib.seq2seq.BahdanauAttention(
				                 num_units=self.rnn_size, 
				                 memory=encoder_outputs, 
				                 memory_sequence_length=encoder_inputs_length)
	
	decoder_cell = self._create_rnn_cell()
	
	# 定义 decoder阶段 要是用的 LSTMCell，然后为其封装 attention wrapper
	decoder_cell = tf.contrib.seq2seq.AttentionWrapper(cell=decoder_cell,
						attention_mechanism=attention_mechanism,
						attention_layer_size=self.rnn_size,
						name='Attention_Wrapper')
	
	# 定义decoder阶段的初始化状态，直接使用encoder阶段的最后一个隐层状态进行赋值
	decoder_initial_state = decoder_cell.zero_state(batch_size=batch_size, dtype=tf.float32).clone(cell_state=encoder_state)
	
	output_layer = tf.layers.Dense(self.vocab_size, ...
```

- [map() 与 nest.map_structure()的区别](https://blog.csdn.net/weixin_41700555/article/details/85011957)
- [seq2seq 全家桶](https://zhuanlan.zhihu.com/p/47929039)
- [Github new_seq2seq_chatbot](https://github.com/blair101/seq2seq_chatbot/blob/master/new_seq2seq_chatbot/model.py)

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

> 上面 train 阶段，Teacher Forcing 上面是默认使用了，可以阻断错误积累，斧正模型训练，加快参数收敛.
> 
> 但是，有个最大的问题：模型训练好了，到了测试test阶段，你是不能用 Teacher Forcing 的，因为测试阶段你是看不到期望的输出序列的，所以必须乖乖等着上一时刻输出一个单词，下一时刻才能确定该输入什么。不能提前把整个 decoder 的输入序列准备好，也就不能用 dynamic_rnn 函数了

dynamic_decode 函数类似于 dynamic_rnn，帮你自动执行 rnn 的循环，返回完整的输出序列:

> 其实简单来讲 dynamic_decode 就是
> 
>  1. 执行 decoder 的初始化函数
>  2. 对解码时刻的 state 等变量进行初始化
>  3. 循环执行 decoder 的 step函数 进行多轮解码
> 
> 常人写可能就一个for循环，但是源码很复杂，为了保证健壮性.

心得： helper 的作用，就是可以控制数据流，比如：是否要 Teacher Forcing 

从这里也可以看到训练时使用 Teacher Forcing 可以提升训练速度与质量，但是也会产生一些过拟合的副作用等等，这里不多说了

[decode self.mode == 'train'](https://github.com/blair101/seq2seq_chatbot/blob/master/new_seq2seq_chatbot/model.py)

<img src="/images/nlp/seq2seq-attention.jpg" width="900" />


### 1.6 train

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

```py

    optimizer = tf.train.AdamOptimizer(self.learing_rate)
    trainable_params = tf.trainable_variables() # 获取需要训练的变量
    gradients = tf.gradients(self.loss, trainable_params) # 计算梯度的函数 tf.gradients(ys, xs)，要注意的是，xs中的x必须要与ys相关

    # 其中 sumsq_diff  global_norm = sqrt(sum([l2norm(t)**2 for t in t_list]))
    # clip_norm = self.max_gradient_norm
    # global_norm 是所有梯度的平方和，如果 clip_norm > global_norm ，就不进行截取
    # clip_norm = self.max_gradient_norm
    # t_list[i] * clip_norm / max(global_norm, clip_norm)
    
    # Gradient Clipping的引入是为了处理gradient explosion或者gradients vanishing的问题
    clip_gradients, _ = tf.clip_by_global_norm(gradients, self.max_gradient_norm)

    # 应用梯度 apply_gradients
    self.train_op = optimizer.apply_gradients(zip(clip_gradients, trainable_params))
```

> [tf.gradients()简单实用教程](https://blog.csdn.net/hustqb/article/details/80260002)
> [tf.clip_by_global_norm](https://blog.csdn.net/u013713117/article/details/56281715)

> 保证了在一次迭代更新中，所有权重的梯度的平方和在一个设定范围以内，这个范围就是clip_gradient.

## Tensorflow

TensorFlow分为图和session两个部分，因为构建和执行在不同的阶段，所以很好的支持了模型的分布式

TensorFlow是声明式开发方式，通过Session真正执行程序

[【Tensorflow】相关面试题](https://blog.csdn.net/weixin_31866177/article/details/87974664)

[二分类、多分类与多标签的基本概念](https://juejin.im/post/5b38971be51d4558b10aad26)

多分类与多标签的损失函数

## Reference

- [2019 11家互联网公司，NLP面经回馈][1]
- [暑期实习NLP算法岗面经总结][2]
- [2019 11家互联网公司，NLP面经回馈][v1]
- [暑期实习NLP算法岗面经总结][v2]
- [呜呜哈做一个有思想的码农][v3]

[1]: https://zhuanlan.zhihu.com/p/46999592
[2]: https://zhuanlan.zhihu.com/p/36387348
[3]: https://www.zhihu.com/question/265357659
[4]: https://blog.csdn.net/liuchonge/article/details/77140719
[5]: https://zhuanlan.zhihu.com/p/25928551
[6]: https://www.zhihu.com/question/59236897
[7]: https://google.github.io/seq2seq/
[8]: https://github.com/google/seq2seq

[1]: /2018/11/08/tensorflow/tf-google-8-rnn-1/
[com1]: https://challenger.ai/competition/fsauor2018

[niu1]: https://zhuanlan.zhihu.com/p/47207009
[niu2]: https://zhuanlan.zhihu.com/p/47207009

[v1]: https://zhuanlan.zhihu.com/p/46999592
[v2]: https://zhuanlan.zhihu.com/p/36387348
[v3]: https://www.zhihu.com/people/liu-he-he-44/posts

