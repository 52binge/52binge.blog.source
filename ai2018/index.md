---
date: 2018-12-03 13:36:21
---

## 文本分类

> 为什么fasttext速度很快，然后问了下如果现在在做会采用什么样的方案；
> 
> 说一说 RNN 和 LSTM 的区别和原理

## 细粒度用户评论情感分析

[数据集介绍2018](https://challenger.ai/dataset/fsaouord2018)

用户评论对于深刻理解商家和用户、挖掘用户情感等方面有至关重要的价值，并且在互联网行业有极其广泛的应用，主要用于个性化推荐、智能搜索、产品反馈、业务安全等。为了促进情感分析技术的发展，我们提供了一个面向餐饮领域的细粒度用户评论情感分析数据集，包含33.5万条自大众点评的真实公开用户评论，依据其粒度不同构建双层标注体系，共包含6大类20个细粒度要素。

> 训练集：105,000条
>
> 验证集：15,000条
>
> 测试集A：15,000条
>
> 测试集B：200,000条
>
>
> 1.5W 跑一次测试集 1~2 分钟.
> 20W, 跑一次测试集 10多分钟 左右

### 1.1 数据情况记录

fastText 时候， 词的粒度

- jieba 分词
- 建立词典时，过滤掉出现次数小于 5 的词
- 训练集、验证集 以及 测试集A组成的语料，词典大小为 66347
- 预测和训练时，词典没有出现的词 用 `<UNK>` 代替


10W+ 数据集，词频前5W的词
（腾讯词向量 800W \* 200 = 5W \* 200 + 自己训练词向 5W \* 128 ） + BiGRU 中层语义 + BiGRU 高层语义

> 超过1000维度，Batch 128， 不超过 1000维度的时候，256 可以放得下.
>
> 机器配置： 32G 内存， i9 CPU， 显卡型号 1080， 显存8G

epoch

> 一次输入一个Batch=128条评论，20个属性都4分类成功， 1 个 epoch， 1200秒=20多分钟
>
> 每个评论一个 epoch 输入1次， 参数共享

### 1.2 预处理数据 data

> 模型：Attention-RCNN (0.669) 、 Attention-RNN (0.637)

直接使用的是char模型，不需要分词，用到的停用词也不多。粗暴但实测效果比 word level 好。

- trainsets lines：  501132， 合法例子 ： 105000
- validationset lines：  70935, 合法例子 ： 15000
- testsets lines：  72028， 合法例子 ： 15000

**word2vec：** 维度 100， 窗口 10， 过滤掉次数小于 1 的字 (说成2)

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

### 1.3 Attention Model

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

### 1.4 RCNN Model

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
 
[sigmoid,softmax,binary/categorical crossentropy的联系？](https://www.zhihu.com/question/36307214)

> **Binary cross-entropy** 常用于二分类问题，当然也可以用于多分类问题，通常需要在网络的最后一层添加sigmoid进行配合使用 
> 
> **Categorical cross-entropy** 适用于多分类问题，并使用softmax作为输出层的激活函数的情况。

### 1.5 Early Stop（提前停止）

这道题目对于使用 keras 的同学，需要注意的是，metric 的设置，如果我们在训练中设置 metric 的话，其实得到是每个 batch 的 f-score 值（非常不靠谱），所以我们需要在每个 epoch 结束之后去计算模型的 f-score 值，这样方便我们去掌握模型的训练情况。

类似这样: 

```py
def getClassification(arr):
    arr = list(arr)
    if arr.index(max(arr)) == 0:
        return -2
    elif arr.index(max(arr)) == 1:
        return -1
    elif arr.index(max(arr)) == 2:
        return 0
    else:
        return 1

class Metrics(Callback):
    def on_train_begin(self, logs={}):
        self.val_f1s = []
        self.val_recalls = []
        self.val_precisions = []

    def on_epoch_end(self, epoch, logs={}):
        val_predict = list(map(getClassification, self.model.predict(self.validation_data[0])))
        val_targ = list(map(getClassification, self.validation_data[1]))
        _val_f1 = f1_score(val_targ, val_predict, average="macro")
        _val_recall = recall_score(val_targ, val_predict, average="macro")
        _val_precision = precision_score(val_targ, val_predict, average="macro")
        self.val_f1s.append(_val_f1)
        self.val_recalls.append(_val_recall)
        self.val_precisions.append(_val_precision)
        print(_val_f1, _val_precision, _val_recall)
        print("max f1")
        print(max(self.val_f1s))
        return
```


> early_stop，顾名思义，就是在训练模型的时候，当在验证集上效果不再提升的时候，就提前停止训练，节约时间。通过设置 patience 来调节。


## 1.6 Class Weight（类别权重）

这个 class weight 是我一直觉得比较玄学的地方，一般而言，当数据集样本不均衡的时候，通过设置正负样本权重，可以提高一些效果，但是在这道题目里面，我对4个类别分别设置了class_weight 之后，我发现效果竟然变得更差了。这里也希望知道原因的同学能留下评论，一起交流学习。

## 1.7 EMA（指数平滑）

> - [http://zangbo.me/2017/07/01/TensorFlow_6/](http://zangbo.me/2017/07/01/TensorFlow_6/)
>
> - [指数滑动平均(ExponentialMovingAverage)EMA](https://blog.csdn.net/qq_14845119/article/details/78767544?utm_source=blogxgwz1)
>
> EMA 它被广泛的应用在深度学习的BN层中，RMSprop，adadelta，adam等梯度下降方法中。
>
> 它添加了训练参数的影子副本，并保持了其影子副本中训练参数的移动平均值操作。在每次训练之后调用此操作，更新移动平均值。
>
> 我个人感觉加了 EMA 之后，能够有效的防止参数更新过快，起到了一种类似 bagging 的作用吧。

### 1.8 Max Length (padding 的最大句子长度)

这个看似不重要，其实确实很重要的点。一开我以为 padding 的最大长度取整个评论平均的长度的2倍差不多就可以啦(对于char level 而言，max_length 取 400左右)，但是会发现效果上不去，当时将 max_length 改为 1000 之后，macro f-score提示明显，我个人认为是在多分类问题中，那些长度很长的评论可能会有部分属于那些样本数很少的类别，padding过短会导致这些长评论无法被正确划分。

### 1.9 训练代码例子

如果要一次性训练20个模型的话，记得加上 python 的 gc 和 keras 的 clear_session。

```py
from keras.backend.tensorflow_backend import set_session
import tensorflow as tf
config = tf.ConfigProto()
config.gpu_options.allow_growth = True
set_session(tf.Session(config=config))
import random
random.seed = 42
import pandas as pd
from tensorflow import set_random_seed
set_random_seed(42)
from keras.preprocessing import text, sequence
from keras.callbacks import ModelCheckpoint, Callback
from sklearn.metrics import f1_score, recall_score, precision_score
from keras.layers import *
from classifier_bigru import TextClassifier
from gensim.models.keyedvectors import KeyedVectors
import pickle
import gc
```

---

---

---

---

### Seq2Seq

1. seq2seq模型，seq2seq的缺点, attention机制
2. attention的公式，怎样计算得分和权重
3. soft attention 和 hard attention的区别
4. tensorflow里面seq2seq的借口， 自己实现的模型里面的一些细节和方法。

- seq2seq时遇到的deepcopy和beam_search两个问题以及解决方案.
- 知名博主WildML给google写了个通用的seq2seq，[文档地址][7] ， [Github地址][8]
- [Tensorflow动态seq2seq使用总结](https://www.jianshu.com/p/c0c5f1bdbb88)
- [荷楠仁 tensorflow sequence_loss](https://www.cnblogs.com/zhouyang209117/p/8338193.html)

### 多标签分类

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


## 1. 细粒度用户评论情感分析-baseline

有20个粒度的评价指标，每个粒度又有4种情感状态，从官方baseline来看，分别训练了20个（4标签）分类器。

### 1.1 fastText baseline

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
