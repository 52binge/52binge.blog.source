---
date: 2018-12-03 13:36:21
---

## 1. deep learning

[请点击链接][dl1]

- L1 L2 Dropout、梯度爆炸和梯度弥散、Weight init、Gradient checking

- mini-batch、指数加权平均-偏差修正、Momentum、RMSprop、Adam、α decay、局部优

- word2vec (Negative Sampling、 Hierarchical Softmax、 [fastText 联系][dl2])

[dl1]: /deeplearning/
[dl2]: /2018/12/19/nlp/fastText/

## 2. machine learning 

- woe、IV、卡方、p-value
- RF、GBDT、Xgboost

## 3. chatbot project

- [聊天机器人Chatbot的训练质量如何评价？](https://www.zhihu.com/question/60530973/answer/184454797)

> 可以类比语言模型的ppl，在词表几万的情况下，我的经验是100左右就已经能生成流畅的话了，如果远高于100，如200，生成的基本不流畅。如果远小于100，倒不一定非常过拟合。

- [實現基於seq2seq的聊天機器人](https://www.smwenku.com/a/5b7c8a4a2b71770a43db78ed/)

> Cornell Movie-Dialogs Corpus 困惑度降到了二十多

- [小黄鸡-多语言](http://www.simsimi.com/ChatSettings)

- [从产品完整性的角度浅谈chatbot](https://zhuanlan.zhihu.com/p/34927757)

**MMI：**

11. 对话项目的模型的缺点以及使用MMI的改进方案。
12. Attention机制的计算细节和公式是怎样的，然后我就介绍了一下公式的计算方法，然后说了一下改进的方案等。
13. MMI模型第一个改进目标函数中P(T)是如何计算的？ 我说每个词的联合概率分布乘积，当时他面露疑问，我还没反应过来是什么意思，到后面有说到这个问题才明白，原来他的意思是P(T)应该是单纯语言模型学习出来的结果，而按照我的说法，P(T)是在输入的基础上进行计算的

### 3.1 数据预处理

### 3.2 定义模型

### 3.3 设置模型参数

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

### 3.4 构建 batch

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


### 3.5 model

rnn_size', 1024, (隐藏单元的个数)

max\_gradient\_norm=5.0

#### 3.5.1 encoder

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

#### 3.5.2 decode

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


### 3.6 train

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

### 5.4 Attention Model

- 参考自 Kaggle 的 [Attention Model](https://www.kaggle.com/qqgeogor/keras-lstm-attention-glove840b-lb-0-043)

## 6. 写代码

 1. 剑指offer
 2. 现场写tf代码 简单的
 3. 用tensorflow实现一个

> 个人定位： 是深度学习与NLP， 不断地展现自己在深度学习上的造诣


## 7. 信用评分 project

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
- [AI-Challenger Baseline 细粒度用户评论情感分析 (0.70201) 前篇][2_1]
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
[2_1]: https://challenger.ai/competition/fsauor2018
[2_2]: https://zhuanlan.zhihu.com/p/47207009

[v1]: https://zhuanlan.zhihu.com/p/46999592
[v2]: https://zhuanlan.zhihu.com/p/36387348
[v3]: https://www.zhihu.com/people/liu-he-he-44/posts
