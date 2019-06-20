---
title: Fine-grained Sentiment Analysis of User Online Reviews
toc: true
date: 2019-06-25 10:16:21
categories: chatbot
tags: chatbot
---

<img src="/images/deeplearning/AI-Challenger-11.png" width="550" alt="AI-Challenger"/>

<!-- more -->

### RCNN & RNN

模型：Attention-RCNN (0.669) 、 Attention-RNN (0.637)

> word2vec : 7983 100 word2vec/chars.vector 过滤掉低频词

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

> 多分类：类别数目大于2个，类别之间是互斥的。比如是猫，就不能是狗、猪


## 4. 文本分类

 - FastText 多分类
 - RCNN & RNN 最大池化层
 - RNN 与 LSTM 与 GRU 区别
 - ELMO-Like

最好的方法：

### 4.1 ELMO-Like 腾讯词向量

腾讯词向量 + 自己\*128 + 自己BiGRU + 2*BiGRU

> 一次输入一个Batch=128条评论，20个属性都4分类成功， 1 个 epoch， 1200秒=20多分钟
> 
> 10W+ 数据集，词频前5W的词, 每个评论一个 epoch 输入1次， 参数共享

### 4.2 Fastext

利用训练集，来训练 **20 个** 4分类 分类器, 训练 15 分钟

```py
sk_clf = FirstColFtClassifier(lr=learning_rate, epoch=epoch,
                              wordNgrams=word_ngrams,
                              minCount=min_count, verbose=2)
sk_clf.fit(train_data_format, train_label)
```

验证集，计算 F1

```
    for column in columns[2:]:
        true_label = np.asarray(validate_data_df[column])
        classifier = classifier_dict[column]
        pred_label = classifier.predict(validata_data_format).astype(int)
        f1_score = get_f1_score(true_label, pred_label)
        f1_score_dict[column] = f1_score

    f1_score = np.mean(list(f1_score_dict.values()))
```

> min_count设置为2貌似也有一些负向影响， word_ngrams 2， epoch 10 .

**fastText 速度快和原理:**

能够做到效果好，速度快，主要依靠两个秘密武器：

> 1. 利用了 词内的n-gram信息 (subword n-gram information)
> 2. 用到了 层次化Softmax回归 (Hierarchical Softmax) 的训练 trick.


> categorical crossentropy 用来做多分类问题
> binary crossentropy 用来做多标签分类问题
 
[sigmoid,softmax,binary/categorical crossentropy的联系？](https://www.zhihu.com/question/36307214)

> **Binary cross-entropy** 常用于二分类问题，当然也可以用于多分类问题，通常需要在网络的最后一层添加sigmoid进行配合使用 
> 
> **Categorical cross-entropy** 适用于多分类问题，并使用softmax作为输出层的激活函数的情况。

### 多标签分类

1. 都用过那些模型实现文本分类？
2. 现在文本分类中还有哪些没有解决的问题，我想了会说样本不平衡问题？
3. 多标签的分类问题，以及损失函数等。
4. FastText，CNN，RNN的区别？

在文本分类任务中，有哪些论文中很少提及却对性能有重要影响的tricks？

> 1. 数据预处理时vocab的选取（前N个高频词或者过滤掉出现次数小于3的词等等）
> 2. 词向量的选择，可以使用预训练好的词向量如谷歌、facebook开源出来的，当训练集比较大的时候也可以进行微调或者随机初始化与训练同时进行。训练集较小时就别微调了
> 3. 结合要使用的模型，这里可以把数据处理成char、word或者都用等
> 4. 有时将词性标注信息也加入训练数据会收到比较好的效果
> 5. 至于PAD的话，取均值或者一个稍微比较大的数，但是别取最大值那种应该都还好
> 6. 神经网络结构的话到没有什么要说的，可以多试几种比如fastText、TextCNN、RCNN、char-CNN/RNN、HAN等等。哦，对了，加上dropout和BN可能会有意外收获。反正模型这块还是要具体问题具体分析吧，根据自己的需求对模型进行修改（比如之前参加知乎竞赛的时候，最终的分类标签也有文本描述，所以就可以把这部分信息也加到模型之中等等）
> 7. 超参数的话，推荐看看之前TextCNN的一篇论文，个人感觉足够了“A Sensitivity Analysis of (and Practitioners’ Guide to) Convolutional Neural Networks for Sentence Classification”
> 8. 之前还见别人在文本领域用过数据增强的方法，就是对文本进行随机的shuffle和drop等操作来增加数据量

这个看似不重要，其实确实很重要的点。一开我以为 padding 的最大长度取整个评论平均的长度的2倍差不多就可以啦(对于char level 而言，max_length 取 400左右)，但是会发现效果上不去，当时将 max_length 改为 1000 之后，macro f-score提示明显，我个人认为是在多分类问题中，那些长度很长的评论可能会有部分属于那些样本数很少的类别，padding过短会导致这些长评论无法被正确划分。

---

> 1. RNN 优点： 最大程度捕捉上下文信息，这可能有利于捕获长文本的语义。
> 2. RNN 缺点： 是一个有偏倚的模型，在这个模型中，后面的单词比先前的单词更具优势。因此，当它被用于捕获整个文档的语义时，它可能会降低效率，因为关键组件可能出现在文档中的任何地方，而不是最后。
> 3. CNN 优点： 提取数据中的局部位置的特征，然后再拼接池化层。 CNN可以更好地捕捉文本的语义。是O(n)
> 4. CNN 优点： 一个可以自动判断哪些特性在文本分类中扮演关键角色的池化层，以捕获文本中的关键组件。
