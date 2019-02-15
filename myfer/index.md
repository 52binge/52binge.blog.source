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

## 4. 文本分类

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

## 5. 细粒度用户评论情感分析

有20个粒度的评价指标，每个粒度又有4种情感状态，从官方baseline来看，分别训练了20个（4标签）分类器。

### 5.1 fastText baseline

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

### Reference 情感分类

- [AI Challenger 2018 进行时][w6]
- [AI Challenger 2018 细粒度用户评论情感分析 fastText Baseline][w7]
- [ai-challenger-2018-文本挖掘类竞赛相关解决方案及代码汇总][w8]
- [QA问答系统中的深度学习技术实现][w9]

[w6]: http://www.52nlp.cn/ai-challenger-2018-进行时
[w7]: http://www.52nlp.cn/ai-challenger-2018-细粒度用户评论情感分析-fasttext-baseline
[w8]: http://www.52nlp.cn/ai-challenger-2018-文本挖掘类竞赛相关解决方案及代码汇总
[w9]: http://www.52nlp.cn/qa问答系统中的深度学习技术实现

### 5.2 Seq2Seq Attention

- jieba 分词
- 建立词典时，过滤掉出现次数小于 5 的词
- 训练集、验证集 以及 测试集A组成的语料，词典大小为 66347
- 预测和训练时，词典没有出现的词 用 `<UNK>` 代替

> 模型：Attention-RCNN、Attention-RNN

直接使用的是char模型，不需要分词，用到的停用词也不多。粗暴但实测效果比 word level 好。

### 5.3 预处理数据 data

- trainsets lines：  501132， 合法例子 ： 105000
- validationset lines：  70935, 合法例子 ： 15000
- testsets lines：  72028， 合法例子 ： 15000

**word2vec：** 维度 100， 窗口 10， 过滤掉次数小于 1 的词 (说成2)

word2vec : 7983 100 word2vec/chars.vector

```
3.1M chars.vector
```

过滤掉低频词之后，所以 word2vec 为 7983 \* 100

数据预处理，在 preprocess 文件夹下生成了 train_char.csv、test_char.csv、test_char.csv 三个文件。

```bash
-rw-r--r--  1 blair 10:36 test_char.csv
-rw-r--r--  1 blair 10:09 train_char.csv
-rw-r--r--  1 blair 10:32 validation_char.csv
```

### 5.4 Attention Model

- 参考自 Kaggle 的 [Attention Model](https://www.kaggle.com/qqgeogor/keras-lstm-attention-glove840b-lb-0-043)


为了解决上述模型的局限性，我们提出了一个循环卷积神经网络(RCNN)，并将其应用于文本分类的任务。首先，我们应用一个双向的循环结构，与传统的基于窗口的神经网络相比，它可以大大减少噪声，从而最大程度地捕捉上下文信息。此外，**该模型在学习文本表示时可以保留更大范围的词序**。其次，我们使用了一个可以**自动判断哪些特性在文本分类中扮演关键角色的池化层**，以捕获文本中的关键组件。我们的模型结合了RNN的结构和最大池化层，**利用了循环神经模型和卷积神经模型的优点**。此外，我们的模型显示了O(n)的时间复杂度，它与文本长度的长度是线性相关的。

> 1. RNN 优点： 最大程度捕捉上下文信息，这可能有利于捕获长文本的语义。
> 2. RNN 缺点： 是一个有偏倚的模型，在这个模型中，后面的单词比先前的单词更具优势。因此，当它被用于捕获整个文档的语义时，它可能会降低效率，因为关键组件可能出现在文档中的任何地方，而不是最后。
> 3. CNN 优点： 提取数据中的局部位置的特征，然后再拼接池化层。 CNN可以更好地捕捉文本的语义。是O(n)
> 4. CNN 优点： 一个可以自动判断哪些特性在文本分类中扮演关键角色的池化层，以捕获文本中的关键组件。

word embedding是单词的一种分布式表示，极大地缓解了数据稀疏问题(Bengio et al. 2003)

> [自然语言处理系列（8）：RCNN](https://plushunter.github.io/2018/03/08/自然语言处理系列（8）：RCNN/)
> [Keras之文本分类实现](https://zhuanlan.zhihu.com/p/29201491)
> 首先我们来理解下什么是卷积操作？卷积，你可以把它想象成一个应用在矩阵上的滑动窗口函数。
> 
> 卷积网络也就是对输入样本进行多次卷积操作，提取数据中的局部位置的特征，然后再拼接池化层（图中的Pooling层）做进一步的降维操作
> 
> 我们可以把CNN类比N-gram模型，N-gram也是基于词窗范围这种局部的方式对文本进行特征提取，与CNN的做法很类似

### 5.5 RCNN Model

[用的 Attention Model 参考自 Kaggle](https://zhuanlan.zhihu.com/p/47207009)
[keras lstm attention glove840b,lb 0.043](https://www.kaggle.com/qqgeogor/keras-lstm-attention-glove840b-lb-0-043)

```py
import keras
from keras import Model
from keras.layers import *
from JoinAttLayer import Attention

class TextClassifier():

    def model(self, embeddings_matrix, maxlen, word_index, num_class):
        inp = Input(shape=(maxlen,))
        encode = Bidirectional(CuDNNGRU(128, return_sequences=True))
        encode2 = Bidirectional(CuDNNGRU(128, return_sequences=True))
        attention = Attention(maxlen)
        x_4 = Embedding(len(word_index) + 1, # input_dim
                        embeddings_matrix.shape[1], # outputa_dim
                        weights=[embeddings_matrix],
                        input_length=maxlen, # 当输入序列的长度固定时，该值为其长度。如果要在该层后接Flatten层，然后接Dense层，则必须指定该参数，否则Dense层的输出维度无法自动推断。
                        trainable=True)(inp)
        x_3 = SpatialDropout1D(0.2)(x_4) # SpatialDropout1D ，那么常规的 dropout 将无法使激活正则化，且导致有效的学习速率降低。在这种情况下，SpatialDropout1D 将有助于提高特征图之间的独立性，应该使用它来代替 Dropout。
        x_3 = encode(x_3)
        x_3 = Dropout(0.2)(x_3)
        x_3 = encode2(x_3)
        x_3 = Dropout(0.2)(x_3)
        # 1D 卷积层 (例如时序卷积),该层创建了一个卷积核，该卷积核以 单个空间（或时间）维上的层输入进行卷积， 以生成输出张量。
        # kernel_size 指明 1D 卷积窗口的长度是 3， padding="valid" 表示「不填充」， kernel_initializer权值矩阵的初始化器->Glorot均匀分布初始化方法
        x_3 = Conv1D(64, kernel_size=3, padding="valid", kernel_initializer="glorot_uniform")(x_3) 
        x_3 = Dropout(0.2)(x_3)
        avg_pool_3 = GlobalAveragePooling1D()(x_3)
        max_pool_3 = GlobalMaxPooling1D()(x_3)
        attention_3 = attention(x_3)
        x = keras.layers.concatenate([avg_pool_3, max_pool_3, attention_3])
        x = Dense(num_class, activation="sigmoid")(x)

        adam = keras.optimizers.Adam(lr=0.001, beta_1=0.9, beta_2=0.999, epsilon=1e-08)
        model = Model(inputs=inp, outputs=x)
        model.compile(
            loss='categorical_crossentropy',
            optimizer=adam
            )
        return model
```


[慢慢学NLP-前篇](https://zhuanlan.zhihu.com/p/47207009)
[训练过程-后篇](https://zhuanlan.zhihu.com/p/47278559)

[多分类和多标签分类](https://blog.csdn.net/qinglv1/article/details/85701106)

[gensim训练word2vec及相关函数](https://blog.csdn.net/sinat_26917383/article/details/69803018)


> 多分类：类别数目大于2个，类别之间是互斥的。比如是猫，就不能是狗、猪
> categorical crossentropy 用来做多分类问题
> binary crossentropy 用来做多标签分类问题
 
### 5.6 Early Stop（提前停止）

就是在训练模型的时候，当在验证集上效果不再提升的时候，就提前停止训练，节约时间。通过设置 patience 来调节。


结束当前的TF计算图，并新建一个。有效的避免模型/层的混乱

### 5.7 Max Length (padding 的最大句子长度)

这个看似不重要，其实确实很重要的点。一开我以为 padding 的最大长度取整个评论平均的长度的2倍差不多就可以啦(对于char level 而言，max_length 取 400左右)，但是会发现效果上不去，当时将 max_length 改为 1000 之后，macro f-score提示明显，我个人认为是在多分类问题中，那些长度很长的评论可能会有部分属于那些样本数很少的类别，padding过短会导致这些长评论无法被正确划分。




## 8. 其他 help

### 8.1 Seq2Seq

1. seq2seq模型，seq2seq的缺点, attention机制
2. attention的公式，怎样计算得分和权重
3. soft attention 和 hard attention的区别
4. tensorflow里面seq2seq的借口， 自己实现的模型里面的一些细节和方法。

- seq2seq时遇到的deepcopy和beam_search两个问题以及解决方案.
- 知名博主WildML给google写了个通用的seq2seq，[文档地址][7] ， [Github地址][8]
- [Tensorflow动态seq2seq使用总结](https://www.jianshu.com/p/c0c5f1bdbb88)
- [荷楠仁 tensorflow sequence_loss](https://www.cnblogs.com/zhouyang209117/p/8338193.html)

### 8.2 多标签分类

8. 都用过那些模型实现文本分类？
9. 现在文本分类中还有哪些没有解决的问题，我想了会说样本不平衡问题？
10. 多标签的分类问题，以及损失函数等。
11. FastText，CNN，RNN的区别？

在文本分类任务中，有哪些论文中很少提及却对性能有重要影响的tricks？

> 1. 数据预处理时vocab的选取（前N个高频词或者过滤掉出现次数小于3的词等等）
> 2. 词向量的选择，可以使用预训练好的词向量如谷歌、facebook开源出来的，当训练集比较大的时候也可以进行微调或者随机初始化与训练同时进行。训练集较小时就别微调了
> 3. 结合要使用的模型，这里可以把数据处理成char、word或者都用等
> 4. 有时将词性标注信息也加入训练数据会收到比较好的效果
> 5. 至于PAD的话，取均值或者一个稍微比较大的数，但是别取最大值那种应该都还好
> 6. 神经网络结构的话到没有什么要说的，可以多试几种比如fastText、TextCNN、RCNN、char-CNN/RNN、HAN等等。哦，对了，加上dropout和BN可能会有意外收获。反正模型这块还是要具体问题具体分析吧，根据自己的需求对模型进行修改（比如之前参加知乎竞赛的时候，最终的分类标签也有文本描述，所以就可以把这部分信息也加到模型之中等等）
> 7. 超参数的话，推荐看看之前TextCNN的一篇论文，个人感觉足够了“A Sensitivity Analysis of (and Practitioners’ Guide to) Convolutional Neural Networks for Sentence Classification”
> 8. 之前还见别人在文本领域用过数据增强的方法，就是对文本进行随机的shuffle和drop等操作来增加数据量

### 8.3 深度学习的坑

- [深度学习的坑](https://www.cnblogs.com/rocketfan/p/7482786.html)

- [如何理解互信息公式的含义?](https://www.zhihu.com/question/24059517)

- [简单的交叉熵损失函数，你真的懂了吗？](https://zhuanlan.zhihu.com/p/38241764)


## Reference

- [2019 11家互联网公司，NLP面经回馈][1]
- [暑期实习NLP算法岗面经总结][2]
- [在文本分类任务中，有哪些论文中很少提及却对性能有重要影响的tricks？][3]
- [深度学习与文本分类总结第一篇--常用模型总结][4]
- [用深度学习（CNN RNN Attention）解决大规模文本分类问题 - 综述和实践][5]
- [严重数据倾斜文本分类，比如正反比1:20～100，适合什么model][6]
- [比赛官网 https://challenger.ai][2_1]
- [AI-Challenger Baseline (0.70201) 前篇 总览][niu1]
- [AI-Challenger Baseline (0.70201) 后篇 训练][niu2]
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

