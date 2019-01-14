
第一部分

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


[decode self.mode == 'train'](https://github.com/blair101/seq2seq_chatbot/blob/master/new_seq2seq_chatbot/model.py)

使用 TrainingHelper+BasicDecoder 的组合

```py
training_helper = tf.contrib.seq2seq.TrainingHelper(inputs=decoder_inputs_embedded, sequence_length=self.decoder_targets_length,time_major=False, name='training_helper')

training_decoder = tf.contrib.seq2seq.BasicDecoder(cell=decoder_cell, helper=training_helper, initial_state=decoder_initial_state,output_layer=output_layer)
```

### 6. train

perplexity = math.exp(float(loss)) if loss < 300 else float('inf')















