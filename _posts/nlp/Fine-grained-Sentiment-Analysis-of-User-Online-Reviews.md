---
title: Fine-grained Sentiment Analysis of User Online Reviews
toc: true
date: 2019-06-25 10:16:21
categories: chatbot
tags: chatbot
---

<img src="/images/deeplearning/AI-Challenger-11.png" width="550" alt="AI-Challenger"/>

<!-- more -->

[Challenger.AI](https://challenger.ai/)

Online reviews have become the critical factor to make consumption decision in recent years. They not only have a profound impact on the incisive understanding of shops, users, and the implied sentiment, but also have been widely used in Internet and e-commerce industry, such as personalized recommendation, intelligent search, product feedback, and business security. In this challenge, we provide a dataset of user reviews for fine-grained sentiment analysis from the catering industry, containning 335K public user reviews from Dianping.com. The dataset builds a two-layer labeling system according to the granularity, which contains 6 categories and 20 fine-grained elements.

> Training set: 105K
>
> Verification set: 15K
>
> Test set A: 15K
>
> Test set B: 200K

There are four sentimental types for every fine-grained element: Positive, Neutral, Negative and Not mentioned, which are labelled as 1, 0, -1 and-2. The meaning of these four labels are listed below.

<img src="/images/deeplearning/AI-Challenger-14.png" width="650" alt=""/>

An example of one labelled review:

> “味道不错的面馆，性价比也相当之高，分量很足～女生吃小份，胃口小的，可能吃不完呢。环境在面馆来说算是好的，至少看上去堂子很亮，也比较干净，一般苍蝇馆子还是比不上这个卫生状况的。中午饭点的时候，人很多，人行道上也是要坐满的，隔壁的冒菜馆子，据说是一家，有时候也会开放出来坐吃面的人。“

<img src="/images/deeplearning/AI-Challenger-13.png" width="650" alt=""/>

---

「AI Challenger」是面向全球人工智能人才的开源数据集和编程竞赛平台。AI Challenger 2018 由创新工场、搜狗、美团点评、美图公司联合主办。有上万支团队参赛， 覆盖 81 个国家、1100 所高校、990 家公司。

<!--<img src="/images/deeplearning/AI-Challenger-21.webp" width="850" alt=""/>
-->

## 整体流程

- **问题建模**
- **模型基本架构**
- **数据处理**
。。。

<img src="/images/deeplearning/AI-Challenger-22.webp" width="890" alt=""/>

有20个粒度的评价指标，每个粒度又有4种情感状态，从官方baseline来看，分别训练了20个（4标签）分类器。

> FastText（0.573）、Attention-RNN (0.637)、Attention-RCNN (0.669)、ELMO-like（0.68830）

## 1. FastText baseline

> skift：scikit-learn wrappers for Python fastText.

什么是 skift?

> skift 包括几个 scikit-learn兼容包裝器, 封裝了fasttext模型，fasttext原理类似word2vec，主要用于文本快速分类。其优势在于分类速度快，使用n-gram 特别容易获得文本句子局部信息、构造新詞。

fasttext 缺点是随着语料的增长，內存需求也会增长。那么如果解決內存问题呢？

> 1. 过滤掉次数出现少的词；
> 2. 采用word粒度，而非char粒度

例如句子: 

> 我喜歡去中國， 如果採用char粒度，則使用2-gram的話，產生的特徵爲:
> 
> 我喜 喜歡 歡中 中國

如果採用word粒度的話，產生的特徵爲

> 我喜歡 喜歡去 去中國

- [利用skift實現fasttext模型](https://www.twblogs.net/a/5c1215debd9eee5e40bb42fd)
- [FastText文本分类以及生成词向量](https://blog.csdn.net/supinyu/article/details/81136590)
- [极简使用︱Gensim-FastText 词向量训练以及OOV](https://blog.csdn.net/sinat_26917383/article/details/83041424#2_fasttext_21)
- [fastText原理和文本分类实战，看这一篇就够了](https://blog.csdn.net/feilong_csdn/article/details/88655927)

> 默认配置参数训练 fasttext 多模型，f1均值 约为 0.5513 的 fasttext 多分类模型(20个）


### 1.1 数据情况记录

fastText 时候， 词的粒度

- jieba 分词
- 建立词典时，过滤掉出现次数小于 2~5 的词
- 训练集、验证集 以及 测试集A组成的语料，词典大小为 66347
- 预测和训练时，词典没有出现的词 用 `<UNK>` 代替

### 1.2 main code

利用训练集，来训练 **20 个** 4分类 分类器, 训练 15 分钟

```py
sk_clf = FirstColFtClassifier(lr=learning_rate, epoch=epoch,
                              wordNgrams=word_ngrams,
                              minCount=min_count, verbose=2)
sk_clf.fit(train_data_format, train_label)
```

<!--
验证集，计算 macro F1


    for column in columns[2:]:
        true_label = np.asarray(validate_data_df[column])
        classifier = classifier_dict[column]
        pred_label = classifier.predict(validata_data_format).astype(int)
        f1_score = get_f1_score(true_label, pred_label)
        f1_score_dict[column] = f1_score

    f1_score = np.mean(list(f1_score_dict.values()))
-->

> min_count设置为2貌似也有一些负向影响， word_ngrams 2， epoch 10 .

### 1.3 baseline 效果

```bash
service_wait_time:0.5247890022873511
service_waiters_attitude:0.6781093513108542
service_parking_convenience:0.5828932335474249
service_serving_speed:0.6146828053320519
...
...
f1_score: 0.5513
```

调参：

```py
python main_train.py -mn fasttext_model_wn2.pkl -wn 2
```

约跑15分钟左右，存储的模型大约在17G，验证集 macro F1值结果如下：

```bash
service_wait_time:0.5247890022873511
service_waiters_attitude:0.6881098513108542
service_parking_convenience:0.5828935095474249
service_serving_speed:0.6168828054420539

...

f1_score: 0.5783
```

这个结果看起来还不错，我们可以基于这个fasttext多分类模型进行测试集的预测：

```py
python main_predict.py -mn fasttext_wn2_model.pkl
```

优化方法： 去停用词和去一些标点符号，调参，learning_rate的影响是比较直接的，min_count

### 1.4 fastText 速度快

能够做到效果好，速度快，主要依靠两个秘密武器：

> 1. 利用了 词内的n-gram信息 (subword n-gram information)
> 2. 用到了 层次化Softmax回归 (Hierarchical Softmax) 的训练 trick.

## 2. Attention RNN、RCNN

### 2.1 预处理 data

粗暴使用char模型，用到的停用词也不多。

- trainsets lines：  501132， 合法例子 ： 105000
- validationset lines：  70935, 合法例子 ： 15000
- testsets lines：  72028， 合法例子 ： 15000

数据预处理，生成 train_char.csv、test_char.csv、test_char.csv 三个文件:

```bash
-rw-r--r--  1 blair 10:36 test_char.csv
-rw-r--r--  1 blair 10:09 train_char.csv
-rw-r--r--  1 blair 10:32 validation_char.csv
```

**word2vec：** 维度 100， 窗口 10， 过滤掉次数小于 1~2 的字

```
3.1M chars.vector
```

过滤掉低频词之后：

```
word2vec/chars.vector 为 7983 * 100
```

### 2.2 Attention RCNN

> Attention-RNN (0.637)、Attention-RCNN (0.669)

- Attention 参考自 Kaggle 的 [Attention Model](https://www.kaggle.com/qqgeogor/keras-lstm-attention-glove840b-lb-0-043)

Kaggle 常见文本分类结构: 2层GRU 接Attention层，然后和 avgpool、maxpool concat 接起来.

```python
def model(self, embeddings_matrix, maxlen, word_index, num_class):
```

为了之后 summary 看清楚网络结构，所以我们一些参数先写死看一下：

```python
import keras
from keras import Model
from keras.layers import *
# from JoinAttLayer import Attention

maxlen=1200

inp = Input(shape=(maxlen,)) # 当输入序列的长度固定时，该值为其长度 1200 （一个文档doc的最大长度）

encode = Bidirectional(CuDNNGRU(128, return_sequences=True))
encode2 = Bidirectional(CuDNNGRU(128, return_sequences=True))

# attention = Attention(maxlen)

x_4 = Embedding(7555+ 1,#7983+1 # 词汇表大小， 即，最大整数 index + 1, len(word_index) + 1, # input_dim
                100, # output_dim: int >= 0。词向量的维度。
                input_length=maxlen, # maxlen=1200, 一个 doc 最大长度
                trainable=True)(inp)
```

接下来：

```python
x_3 = encode(x_4)
x_3 = encode2(x_3)


# 输入shape， 形如（samples，steps，features）的3D张量
# 输出shape， 形如(samples, features)的2D张量
avg_pool_3 = GlobalAveragePooling1D()(x_3) # GlobalAveragePooling1D 为时域信号施加全局平均值池化
max_pool_3 = GlobalMaxPooling1D()(x_3) # 对于时间信号的全局最大池化

# attention_3 = attention(x_3)

x = keras.layers.concatenate([avg_pool_3, max_pool_3], name="fc")
x = Dense(4, activation="softmax")(x)

adam = keras.optimizers.Adam(lr=0.001, beta_1=0.9, beta_2=0.999, epsilon=1e-08, amsgrad=True)
rmsprop = keras.optimizers.RMSprop(lr=0.001, rho=0.9, epsilon=1e-06)
model = Model(inputs=inp, outputs=x)

model.compile(
    loss='categorical_crossentropy',
    optimizer=adam)

# categorical_crossentropy 用来做多分类问题
# binary_crossentropy 用来做多标签分类问题

model.summary()
```

RNN：

<img src="/images/deeplearning/AI-Challenger-16-1.png" width="900" alt=""/>

RCNN：

```python
x_4 = Embedding(7555+ 1,#7983+1 # 词汇表大小， 即，最大整数 index + 1
                100,
                input_length=maxlen,
                trainable=True)(inp)

x_3 = encode(x_4)
x_3 = encode2(x_3)

x_3 = Conv1D(64, kernel_size=3, padding="valid", kernel_initializer="glorot_uniform")(x_3)

# 输入shape， 形如（samples，steps，features）的3D张量
# 输出shape， 形如(samples, features)的2D张量
avg_pool_3 = GlobalAveragePooling1D()(x_3) # GlobalAveragePooling1D 为时域信号施加全局平均值池化
max_pool_3 = GlobalMaxPooling1D()(x_3) # 对于时间信号的全局最大池化

# attention_3 = attention(x_3)

x = keras.layers.concatenate([avg_pool_3, max_pool_3], name="fc")
x = Dense(4, activation="softmax")(x)

...

model.summary()
```

<img src="/images/deeplearning/AI-Challenger-17-1.png" width="900" alt=""/>

              
> Input 一个网络层次，输入层 在 keras
>
> SpatialDropout1D ，那么常规的 dropout 将无法使激活正则化，且导致有效的学习速率降低。
> SpatialDropout1D ，在这种情况下，SpatialDropout1D 将有助于提高特征图之间的独立性，应该使用它来代替 Dropout。
>
> CuDNNGRU 是 基于CuDNN的快速GRU实现，只能在GPU上运行，只能使用 tensoflow 为后端
> CuDNNLSTM 是 基于CuDNN的快速LSTM实现，只能在GPU上运行，只能使用 tensoflow 为后端
>
> attention = Attention(maxlen)
>
> Embedding嵌入层将正整数（下标）转换为具有固定大小的向量，如[[4], [20]]->[[0.25, 0.1], [0.6, -0.2]]

```py
keras.layers.embeddings.Embedding(
    input_dim, 
    output_dim, 
    embeddings_initializer='uniform', # embeddings_regularizer=None, 
    activity_regularizer=None,  # embeddings_constraint=None,              
    mask_zero=False, 
    input_length=None
)
```

Embedding 的一些参数解释：

> Embedding层只能作为模型的第一层
> 
> input_dim: int > 0。词汇表大小， 即，最大整数 index + 1。
> output_dim: int >= 0。词向量的维度。
> embeddings_initializer: 嵌入矩阵的初始化方法，为预定义初始化方法名的字符串，或用于初始化权重的初始化器。参考initializers
> input_length：当输入序列的长度固定时，该值为其长度。如果要在该层后接Flatten层，然后接Dense层，则必须指定该参数，否则Dense层的输出维度无法自动推断。

[Convolutional Neural Networks (week1) - CNN , 运用 Padding](/2018/08/21/deeplearning/Convolutional-Neural-Networks-week1/#4-1-运用-Padding-的原因)
[TensorFlow中CNN的两种padding方式“SAME”和“VALID”](https://blog.csdn.net/wuzqChom/article/details/74785643)

> word2vec : 7983 100 word2vec/chars.vector 过滤掉低频词

循环卷积神经网络(RCNN)，并将其应用于文本分类的任务。首先，我们应用一个双向的循环结构，与传统的基于窗口的神经网络相比，它可以大大减少噪声，从而最大程度地捕捉上下文信息。此外，**该模型在学习文本表示时可以保留更大范围的词序**。其次，我们使用了一个可以**自动判断哪些特性在文本分类中扮演关键角色的池化层**，以捕获文本中的关键组件。我们的模型结合了RNN的结构和最大池化层，**利用了循环神经模型和卷积神经模型的优点**。此外，我们的模型显示了O(n)的时间复杂度，它与文本长度的长度是线性相关的。

> 1. RNN 优点： 最大程度捕捉上下文信息，这可能有利于捕获长文本的语义。
> 2. RNN 缺点： 是一个有偏倚的模型，在这个模型中，后面的单词比先前的单词更具优势。因此，当它被用于捕获整个文档的语义时，它可能会降低效率，因为关键组件可能出现在文档中的任何地方，而不是最后。
> 3. CNN 优点： 提取数据中的局部位置的特征，然后再拼接池化层。 CNN可以更好地捕捉文本的语义。是O(n)
> 4. CNN 优点： 一个可以自动判断哪些特性在文本分类中扮演关键角色的池化层，以捕获文本中的关键组件。

> 首先我们来理解下什么是卷积操作？卷积，你可以把它想象成一个应用在矩阵上的滑动窗口函数。
> 
> 卷积网络也就是对输入样本进行多次卷积操作，提取数据中的局部位置的特征，然后再拼接池化层（图中的Pooling层）做进一步的降维操作
> 
> 我们可以把CNN类比N-gram模型，N-gram也是基于词窗范围这种局部的方式对文本进行特征提取，与CNN的做法很类似

- [自然语言处理系列（8）：RCNN](https://plushunter.github.io/2018/03/08/自然语言处理系列（8）：RCNN/)
- [Keras之文本分类实现](https://zhuanlan.zhihu.com/p/29201491)

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

### 2.3 loss function

[多分类和多标签分类](https://blog.csdn.net/qinglv1/article/details/85701106), [gensim训练word2vec及相关函数](https://blog.csdn.net/sinat_26917383/article/details/69803018)

> 多分类：类别数目大于2个，类别之间是互斥的。比如是猫，就不能是狗、猪
> categorical crossentropy 用来做多分类问题
> binary crossentropy 用来做多标签分类问题
 
[sigmoid,softmax,binary/categorical crossentropy的联系？](https://www.zhihu.com/question/36307214)

> **Binary cross-entropy** 常用于二分类问题，当然也可以用于多分类问题，通常需要在网络的最后一层添加sigmoid进行配合使用 
> 
> **Categorical cross-entropy** 适用于多分类问题，并使用softmax作为输出层的激活函数的情况。

### 2.4 Early Stop

需要在每个 epoch 结束之后去计算模型的 F1 值，这样可以更好的掌握模型的训练情况。

> Tips 如果我们在训练中设置 metric 的话，得到是每个 batch 的 F1 值, 是不靠谱的.

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
        ...
        return
```


> early_stop，就是在训练模型的时候，当在验证集上效果不再提升的时候，就提前停止训练，节约时间。

<!--

### 2.5 Class Weight (类别权重)

一般而言，当数据集样本不均衡的时候，通过设置正负样本权重，可以提高一些效果，但是在这道题目里面，我对4个类别分别设置了class_weight 之后，我发现效果竟然变得更差了。

-->

### 2.6 Max Length (padding)

> 所有评论平均的长度是 200 左右，max_length 取 2 \* 200，效果一直不给力.
>
> 将 max_length 改为 1200 ，macro f-score 效果明显提升
>
> Tips： 多分类问题中，那些长度很长的评论可能会有部分属于那些样本数很少的类别，padding过短会导致这些长评论无法被正确划分。


## 3. ELMO-Like

<!--<img src="/images/deeplearning/AI-Challenger-23.webp" width="850" alt=""/>
-->

（腾讯词向量 16G， 800W \* 200 = 5W \* 200 + 自训词向 5W \* 128 ） + BiGRU 中层语义 + BiGRU 高层语义

> 10W+ 数据集，词频前5W的词, 每个评论一个 epoch 输入1次， 参数共享
>
> 328 + 256 + 256 近1000维度，Batch 128， 512维度的时候，Batch 256 可以放得下.
>
> 机器配置： 32G 内存， i9 CPU， 显卡型号 1080， 显存8G

**多任务学习**

> - **分别训练20个分类模型的计算复杂度较高**
> - **20个分类模型占用存储空间**
> - **多任务学习可以通过特征共享降低过拟合风险**

epoch

> 一次输入一个Batch=128条评论，20个属性都4分类成功， 1 个 epoch， 1200秒=20多分钟
>
> 每个评论一个 epoch 输入1次， 参数共享
> 
> maxLen 500 左右

--- 

> 1.5W 跑一次测试集 1~2 分钟.
> 20W, 跑一次测试集 10多分钟 左右

## 4. Summary

> 1. RNN 优点： 最大程度捕捉上下文信息，这可能有利于捕获长文本的语义。
> 2. RNN 缺点： 是一个有偏倚的模型，在这个模型中，后面的单词比先前的单词更具优势。因此，当它被用于捕获整个文档的语义时，它可能会降低效率，因为关键组件可能出现在文档中的任何地方，而不是最后。
> 3. CNN 优点： 提取数据中的局部位置的特征，然后再拼接池化层。 CNN可以更好地捕捉文本的语义。是O(n)
> 4. CNN 优点： 一个可以自动判断哪些特性在文本分类中扮演关键角色的池化层，以捕获文本中的关键组件。

---

在文本分类任务中，有哪些对性能有重要影响的tricks？

> 1. 数据预处理时vocab的选取（前N个高频词或者过滤掉出现次数小于3的词等等）
> 2. 词向量的选择，可以使用预训练好的词向量如谷歌、facebook开源出来的，当训练集比较大的时候也可以进行微调或者随机初始化与训练同时进行。训练集较小时就别微调了
> 3. 结合要使用的模型，这里可以把数据处理成char、word或者都用等
> 4. 有时将词性标注信息也加入训练数据会收到比较好的效果
> 5. 至于PAD的话，取均值或者一个稍微比较大的数（比较大的值，费点空间，谨慎使用）
> 6. 神经网络结构的话到没有什么要说的，加上dropout和BN可能会更好。模型这块还是要具体问题具体分析吧.
> 7. 文本领域用过数据增强的方法，就是对文本进行随机的shuffle和drop等操作来增加数据量

## Reference

- [深度学习与文本分类总结第一篇--常用模型总结][4]
- [用深度学习（CNN RNN Attention）解决大规模文本分类问题 - 综述和实践][5]
- [严重数据倾斜文本分类，比如正反比1:20～100，适合什么model][6]
- [第16名解决方案](https://github.com/xueyouluo/fsauor2018)、 [第17名解决方案](https://github.com/BigHeartC/Al_challenger_2018_sentiment_analysis)、 [基于Bert的尝试](https://github.com/brightmart/sentiment_analysis_fine_grain)

<!--

- [AI-Challenger Baseline (0.70201) 前篇 总览][niu1]
- [AI-Challenger Baseline (0.70201) 后篇 训练][niu2]
- [2019 11家互联网公司，NLP面经回馈][v1]
- [暑期实习NLP算法岗面经总结][v2]
- [呜呜哈做一个有思想的码农][v3]
- [AI Challenger 2018 进行时][w6]
- [AI Challenger 2018 细粒度用户评论情感分析 fastText Baseline][w7]

-->

- [ai-challenger-2018-文本挖掘类竞赛相关解决方案及代码汇总][w8]
- [QA问答系统中的深度学习技术实现][w9]
- [深度学习代码复现之减少随机性的影响](https://zhuanlan.zhihu.com/p/42517760)


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

[w6]: http://www.52nlp.cn/ai-challenger-2018-进行时
[w7]: http://www.52nlp.cn/ai-challenger-2018-细粒度用户评论情感分析-fasttext-baseline
[w8]: http://www.52nlp.cn/ai-challenger-2018-文本挖掘类竞赛相关解决方案及代码汇总
[w9]: http://www.52nlp.cn/qa问答系统中的深度学习技术实现
