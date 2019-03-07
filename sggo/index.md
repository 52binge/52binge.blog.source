
## 1. 兴趣挖掘

  - 数据量 sina week 10W+, 4W+
  - ABTest 效果评估
  - 什么 tree
  - depth
  - 特征选择，RF 与 GBDT 区别
  - loss

## 2. Chatbot

 - Attention 区别 (hard or soft)
 - 遇到过什么问题 （model_bucket）
 - 流程
 - BeamSearch
 - MMI
 - PPL 的意义

[seq2seq入门](https://zhuanlan.zhihu.com/p/32035616)

除此之外模型为了取得比较好的效果还是用了下面三个小技巧来改善性能：

> - 深层次的LSTM：作者使用了4层LSTM作为encoder和decoder模型，并且表示深层次的模型比shallow的模型效果要好（单层，神经元个数多）。

> - 将source进行反序输入：输入的时候将“ABC”变成“CBA”，这样做的好处是解决了长序列的long-term依赖，使得模型可以学习到更多的对应关系，从而达到比较好的效果。
> 
> - Beam Search：这是在test时的技巧，也就是在训练过程中不会使用。
> 
> 一般来讲我们会采用greedy贪婪式的序列生成方法，也就是每一步都取概率最大的元素作为当前输出，但是这样的缺点就是一旦某一个输出选错了，可能就会导致最终结果出错，所以使用beam search的方法来改善。也就是每一步都取概率最大的k个序列（beam size），并作为下一次的输入。更详细的解释和例子可以参考下面这个链接：https://zhuanlan.zhihu.com/p/28048246


### 2.1 Seq2Seq

1. seq2seq模型，seq2seq的缺点, attention机制
2. attention的公式，怎样计算得分和权重
3. tensorflow里面seq2seq的借口， 自己实现的模型里面的一些细节和方法。

- seq2seq时遇到的deepcopy和beam_search两个问题以及解决方案.
- 知名博主WildML给google写了个通用的seq2seq，[文档地址][7] ， [Github地址][8]
- [Tensorflow动态seq2seq使用总结](https://www.jianshu.com/p/c0c5f1bdbb88)
- [荷楠仁 tensorflow sequence_loss](https://www.cnblogs.com/zhouyang209117/p/8338193.html)

[Attention是如何利用中间的输出的](https://www.jianshu.com/p/c94909b835d6)

- soft attention 和 hard attention的区别?

> 总结下：最大区别在于hard 方法是采样得到Z，Z作为lstm输入。soft方法是有所有做平均得到Z。这两种在图像里肯定是soft用的多，hard一般用在reinforcement learning 里。hard 不可微，不能后向传播，因为采样梯度为0。

## 3. 评分卡

评分卡主要有三种，申请评分卡、行为评分卡、催收评分卡

申请评分卡要求最为严格，也最为重要，可解释性也要求最强，一般用 LR

**分箱的最大区间数：**

> n = 5

**分箱初始化：**

> 1. 连续值按升序排列，离散值先转化为坏客户的比率，然后再按升序排列；
> 2. 为了减少计算量，对于状态数大于某一阈值 (建议为100) 的变量，利用等频分箱进行粗分箱。
> 3. 若有缺失值，则缺失值单独作为一个分箱。

**合并区间：**

> 1. 将卡方值最小的一对区间合并

**分箱后处理：**

> 1. 对于坏客户比例为 0 或 1 的分箱进行合并 (一个分箱内不能全为好客户或者全为坏客户)。
> 2. 对于分箱后某一箱样本占比超过 95% 的箱子进行删除。
> 3. 检查缺失分箱的坏客户比例是否和非缺失分箱相等，如果相等，进行合并。

**分箱的好处：**

> 列表内容离散化后的特征对异常数据有很强的鲁棒性.
> 
> 离散化后可以进行特征交叉，由 M+N 个变量变为 M\*N 个变量，进一步引入非线性，提升表达能力；
> 
> 列表内容特征离散化后，模型会更稳定，比如如果对用户年龄离散化，20-30作为一个区间，不会因为一个用户年龄长了一岁就变成一个完全不同的人。当然处于区间相邻处的样本会刚好相反，所以怎么划分区间是门学问；
> 
> 将所有变量变换到相似的尺度上。

**总结一下特征分箱的优势**：

> 1. 特征分箱可以有效处理特征中的缺失值和异常值。
> 2. 特征分箱后，数据和模型会更稳定。
> 3. 特征分箱可以简化逻辑回归模型，降低模型过拟合的风险，提高模型的泛化能力。
> 4. 将所有特征统一变换为类别型变量。
> 5. 分箱后变量才可以使用标准的评分卡格式，即对不同的分段进行评分。
> 6. 分箱后降低模型运算复杂度，提升模型运算速度，对后后期生产上线较为友好

 - LR 如何处理数据不平衡 ?   答： 好坏样本34：1， 有时候关注坏用本个数， 好样本欠采样等.
 - GBDT 与Xgboost 区别 ?  答： [RF、GBDT、XGBoost 区别](https://zhuanlan.zhihu.com/p/34679467)
 - GBDT 如何判断特征重要度？ 答： 特征j的全局重要度通过特征j在单颗树中的重要度的平均值来衡量
 - 如何判断你的模型是否过拟合 ? 以及过拟合的处理方式？ 答：[画 learning_curve](https://blog.csdn.net/aliceyangxi1987/article/details/73598857)
 - Info Gain vs Info Gain ratio vs Gini vs CART.. 
 
> Info Gain =Entropy(S) - Entropy(S|“阴晴”) 最大的特征. 
> Info Gain ratio 减少信息增益方法对取值数较多的特征的影响。(可减少过拟合，这对某特征取值过多的一惩罚)
> Gini 是介于0~1之间的数，0-完全相等，1-完全不相等；
 
 - LR 分析的变量 & GBDT 分析的变量分别是多少？  26维，84维
 - 变量如何分箱？ IV 值的计算。 卡方分箱和woe编码进行转换

> 信息熵，代表的是随机变量或整个系统的不确定性，熵越大，随机变量或系统的不确定性就越大。
> 
> 交叉熵，用来衡量在给定的真实分布下，使用非真实分布所指定的策略消除系统的不确定性所需要付出的努力值。

Reference

> [Python三大评分卡之行为评分卡](https://zhuanlan.zhihu.com/p/34370741)
> 
> [玩转逻辑回归之金融评分卡模型](https://zhuanlan.zhihu.com/p/36539125)
> 
> [拍拍贷教你如何用GBDT做评分卡](http://www.sfinst.com/?p=1389)

**评估指标ks：**

等分 10 份，两条洛伦兹曲线， TPR 与 FPR 的差值. 好坏客户的区程度.

### 3.1 数据获取

**数据情况：**

> 23W+ 去掉一些灰用户，剩余 
>
> M1标准： 好/坏: 13W+ 坏 4K
>
> 30~50 : 1 都是正常的

### 3.2 EDA 

> Exploratory Data Analysis,EDA**

> 每个字段的缺失值情况、异常值情况、平均值、中位数、最大值、最小值、分布情况等

### 3.3 数据预处理

> 数据清洗，变量分箱和 WOE 编码三个步骤

1. 缺失值太多
2. 非数值变量多 (emp_title..)
3. id, member_id 等
4. loan_amnt != df.funded_amnt
5. 空值填充为 0
6. 带 % 的浮点，去掉 %

> 好坏比是 34:1 是非常难以处理的样本了 

#### 3.3.1 数据清洗

> 缺失值太多

#### 3.3.2 变量分箱

- 对连续变量进行分段离散化；
- 将多状态的离散变量进行合并，减少离散变量的状态数。

> 分箱方法很多，最常见的方法之一： Merge分箱中的 Chimerge 分箱.

先可以粗分箱，之后在合并。 比如 年龄取值数有 30个，那么分为 30 箱，最后合为 5 箱。
其他变量可能粗分箱为 100 箱，之后合并.

> **Merge 分箱**
>
> Chimerge 其基本思想是如果两个相邻的区间具有类似的类分布，则这两个区间合并；
否则，它们应保持分开。Chimerge通常采用**卡方值**来衡量两相邻区间的类分布情况。
>
> - 连续值按升序排列，离散值先转化为坏客户的比率，然后再按升序排列；
> - 为了减少计算量，对于状态数大于某一阈值 (建议为100) 的变量，利用等频分箱进行粗分箱。
> - 若有缺失值，则缺失值单独作为一个分箱。

**卡方值的意义：**

> 卡方值仅仅只是一个中间过程，通过卡方值计算出p值，p值才是我们最重要需要的。p小于0.05意味着存在显著差异。
> 
> 卡方值是非参数检验中的一个统计量，主要用于非参数统计分析中。它的作用是检验数据的相关性。如果卡方值的显著性（即SIG.）小于0.05，说明两个变量是显著相关的。

> 上一步：数据预处理——缺失值、异常值、重复值处理
>
> 下一步：变量显著性检验——计算 WOE、IV

在LR中，单变量离散化为N个哑变量后，每个哑变量有单独的权重，相当于为模型引入了非线性，能够提升模型表达能力，加大拟合；

[变量分箱实践](https://zhuanlan.zhihu.com/p/52312186)
[One-Hot编码与哑变量](http://www.jiehuozhe.com/article/3)
[方差、标准差和均方根误差的区别总结](https://blog.csdn.net/zengxiantao1994/article/details/77855644)
[基于卡方分箱的评分卡建模](https://www.cnblogs.com/wzdLY/p/9649101.html)

> A箱
> (26.2-19)\*(26.2-19) / 26.2  -> **(26.2 是 正类的期望频数， 19 是真实频数)**
>
> (16.8-24)\*(16.8-24) / 16.8 (16.8 是 负类的期望频数)
>
> B箱
> (26.8-34)\*(26.8-34) / 26.8 (26.8 是 正类的期望频数)
> (17.2-10)\*(17.2-10) / 17.2 (17.2 是 负类的期望频数)
>
> 先建立原假设：A、B两种疗法没有区别。根据卡方值的计算公式，计算：卡方值=10.01。
>
> 方差: 来描述变量与均值的偏离程度

#### 3.3.3 WOE编码 

> WOE: weight of evidence

将离散变量转化为连续变量。WOE编码是评分卡模型常用的编码方式。

> WOE也可以理解为当前分箱中坏客户和好客户的比值，和所有样本中这个比值的差异

> 当分箱中坏客户和好客户的比例等于随机坏客户和好客户的比值时，说明这个分箱没有预测能力，即WOE=0。 (WOE为0，说明该箱出的特征对结果没有区分度)

实际上WOE编码相当于把分箱后的特征**从非线性可分映射到近似线性**可分的空间内。

![](https://pic2.zhimg.com/80/v2-f9641d365b592361e541b4d5458ebf2d_hd.jpg)

总结一下WOE编码的优势：

> 1. 可提升模型的预测效果
> 2. 将自变量规范到同一尺度上
> 3. WOE能反映自变量取值的贡献情况
> 4. 有利于对变量的每个分箱进行评分
> 5. 转化为连续变量之后，便于分析变量与变量之间的相关性
> 6. 与独热向量编码相比，可以保证变量的完整性，同时避免稀疏矩阵和维度灾难


#### 3.3.4 IV 值

IV称为信息价值(information value)，自变量的IV值越大，表示自变量的预测能力越强。

![](https://www.zhihu.com/equation?tex=IV_i+%3D%28%5Cfrac%7B%5C%23B_i%7D%7B%5C%23B_T%7D-%5Cfrac%7B%5C%23G_i%7D%7B%5C%23G_T%7D%29+%2A+log+%28%5Cfrac%7B%5C%23B_i%2F%5C%23B_T%7D%7B%5C%23G_i%2F%5C%23G_T%7D%29%3D%28%5Cfrac%7B%5C%23B_i%7D%7B%5C%23B_T%7D-%5Cfrac%7B%5C%23G_i%7D%7B%5C%23G_T%7D%29+%2A+WOE_i+%5C%5C)

变量对应的IV值为所有分箱对应的 IV 值之和：

![](https://www.zhihu.com/equation?tex=IV+%3D+%5Csum%5Climits_i%5En+IV_i+%5C%5C)

IV排序后，选择IV>0.02的变量，共58个变量IV>0.02

#### 3.3.5 多变量分析

保留相关性低于阈值0.6的变量，剩余27个变量

**为什么要进行相关性分析？**

> 理想状态下，系数权重会有无数种取法，使系数权重变得无法解释，导致变量的每个分段的得分也有无数种取法（后面我们会发现变量中不同分段的评分会用到变量的系数）

**总结一下变量筛选的意义：**

1. 剔除跟目标变量不太相关的特征
2. 消除由于线性相关的变量，避免特征冗余
3. 减轻后期验证、部署、监控的负担
4. 保证变量的可解释性

#### 3.3.6 显著性分析

删除P值不显著的变量，剩余12个变量了。

特征相关度筛选

```py
cor = df.corr()
cor.loc[:,:] = np.tril(cor, k=-1) # below main lower triangle of an array
cor = cor.stack()
cor[(cor > 0.55) | (cor < -0.55)] # 特征相关度筛选
```
#### 3.3.7 转化为评分卡

将 odds 带入可得：

![](https://www.zhihu.com/equation?tex=%5Ctext%7Blog%7D%28+%5Ctext%7Bodds%7D%29+%3D+%5Ctheta%5ETx+%5C%5C)

评分卡的分值可以定义为比率对数的线性表达来，即： 

![](https://www.zhihu.com/equation?tex=Score+%3D+A+-B+%5Ctimes+%5Ctext%7Blog%7D%28+%5Ctext%7Bodds%7D%29+%5C%5C)

最终得到评分卡模型：

![](https://pic2.zhimg.com/80/v2-fec98ff9de65d835a5be217f01f678a5_hd.jpg)

**GBDT, GBRT, Xgboost, RF grid search**

```py
param_grid = {
    'learning_rate': [0.1, 0.05, 0.02, 0.01],
    'max_depth': [1,2,3,4],
    'min_samples_split': [50,100,200,400],
    'n_estimators': [100,200,400,800]
}
```

**特征重要度：**

```
# Top Ten， GBRT top 10 的参数有哪些，可以作为参考， GBRT 不仅是一个分类器，还能帮你筛选变量
# 比如 feature_importance = 0 的话，那么下一次 这个特征，你就去掉就可以了
# 重新用模型GBRT重新跑，或者用其他模型LR跑
# 或者其他的 RF 也可以帮助你做特征筛选
```

最后选择出 84 个变量， 然后在放到不同的模型中做训练，在 ensemble 应该效果还是不错的。

> 为什么要用回归，不用分类，其实我们在做分类器的过程中，大部分用回归的算法，效果好一些，具体为什么，我有点忘记了

**特征不稳定的，不可以作为入模变量：**
    
> 挑选变量的时候，开始每个月我一直在看它的均值和方差的变化是否在容忍的范围内，超过50%舍

**模型更新周期：**

> 信贷产品比较长的话，2个月更新一次比较好，贷款周期短的话，周更新都可以， 月更新

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

===

**fastText 速度快和原理:**

能够做到效果好，速度快，主要依靠两个秘密武器：

> 1. 利用了 词内的n-gram信息 (subword n-gram information)
> 2. 用到了 层次化Softmax回归 (Hierarchical Softmax) 的训练 trick.

**fastText 和 word2vec 的区别:**

**两者表面的不同：**

> **模型的输出层：**
> 
> word2vec的输出层，对应的是每一个term，计算某term的概率最大；而fasttext的输出层对应的是 分类的label。不过不管输出层对应的是什么内容，起对应的vector都不会被保留和使用；
> 
> **模型的输入层：**
> 
> word2vec的输出层，是 context window 内的term；而fasttext对应的整个sentence的内容，包括term，也包括 n-gram的内容；

**两者本质的不同，体现在 h-softmax 的使用：**

> Wordvec的目的是得到词向量，该词向量最终是在输入层得到，输出层对应的 h-softmax也会生成一系列的向量，但最终都被抛弃，不会使用。
>
> fasttext则充分利用了h-softmax的分类功能，遍历分类树的所有叶节点，找到概率最大的label（一个或者N个）

### 4.3 RCNN & RNN

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
> categorical crossentropy 用来做多分类问题
> binary crossentropy 用来做多标签分类问题
 
[sigmoid,softmax,binary/categorical crossentropy的联系？](https://www.zhihu.com/question/36307214)

> **Binary cross-entropy** 常用于二分类问题，当然也可以用于多分类问题，通常需要在网络的最后一层添加sigmoid进行配合使用 
> 
> **Categorical cross-entropy** 适用于多分类问题，并使用softmax作为输出层的激活函数的情况。

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

这个看似不重要，其实确实很重要的点。一开我以为 padding 的最大长度取整个评论平均的长度的2倍差不多就可以啦(对于char level 而言，max_length 取 400左右)，但是会发现效果上不去，当时将 max_length 改为 1000 之后，macro f-score提示明显，我个人认为是在多分类问题中，那些长度很长的评论可能会有部分属于那些样本数很少的类别，padding过短会导致这些长评论无法被正确划分。


===


> 1. RNN 优点： 最大程度捕捉上下文信息，这可能有利于捕获长文本的语义。
> 2. RNN 缺点： 是一个有偏倚的模型，在这个模型中，后面的单词比先前的单词更具优势。因此，当它被用于捕获整个文档的语义时，它可能会降低效率，因为关键组件可能出现在文档中的任何地方，而不是最后。
> 3. CNN 优点： 提取数据中的局部位置的特征，然后再拼接池化层。 CNN可以更好地捕捉文本的语义。是O(n)
> 4. CNN 优点： 一个可以自动判断哪些特性在文本分类中扮演关键角色的池化层，以捕获文本中的关键组件。
