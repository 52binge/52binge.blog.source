
我開始整理 Deep Learning 相關学习笔记，学习算法类知识真的需要下很大很大的功夫，灰常博大精深~~

博主水平灰常灰常有限，期望能與對、Deep Learning 感兴趣的朋友一起学习、交流、探讨与分享~~

## 1. Neural Networks and Deep Learning

Part1 | Neural Networks | <font color="#0085a1">**Neural Networks and Deep Learning**</font>
:-------: | :-------: | :-------:
1 | [Introduction to Deep Learning][c1w1]  | 了解现今深度学习在哪里应用、如何应用
2 | [Neural Networks Basics][c1w2] | logistic 损失函数、导数、计算图、m个样本的梯度下降、向量化
3 | [Shallow Neural Networks][c1w3] | NN Representation、多样本向量化解释、Activation functions、随机初始化
4 | [Deep Neural Networks][c1w4] | 深网的前向传播、核对矩阵维数、深层表示、前向反向传播、参数VS超参数

[c1w1]: /2017/12/01/deeplearning-ai-Neural-Networks-and-Deep-Learning-week1/
[c1w2]: /2018/07/07/deeplearning-ai-Neural-Networks-and-Deep-Learning-week2/
[c1w3]: /2018/07/14/deeplearning-ai-Neural-Networks-and-Deep-Learning-week3/
[c1w4]: /2018/07/15/deeplearning-ai-Neural-Networks-and-Deep-Learning-week4/

## 2. Improving Deep Neural Networks 

No. | Title | Detailed content
:-------: | :-------: | :-------:
1 | [Deep Learning Action][c2w1]  | 训练集划分、偏差/方差、L1 L2 Dropout、梯度消失-梯度爆炸、权重初始化、梯度检验
2 | [Optimization][c2w2] | mini-batch、指数加权平均-偏差修正、Momentum、RMSprop、Adam、学习率衰减、局部优
3 | [超参数调试、Batch][c2w3] | Hyperparameter、Normalizing Activations、Batch Norm [Fitting NN]、Softmax

[c2w1]: /2018/07/19/deeplearning-ai-Improving-Deep-Neural-Networks-week1/
[c2w2]: /2018/07/21/deeplearning-ai-Improving-Deep-Neural-Networks-week2/
[c2w3]: /2018/07/21/deeplearning-ai-Improving-Deep-Neural-Networks-week2/

## 3. Structured Machine Learning Projects 

No. | Title | Detailed content
:-------: | :-------: | :-------:
1 | [ML Strategy 1][c3w1] | 正交化、Satisficing and optimizing metrics、Train/dev/test 改变、可避免偏差、人的表现
2 | [ML Strategy 2][c3w2] | 误差分析、标注错误数据、定位数据不匹配偏差与方差、迁移学习、多任务学习、端到端学习

[c3w1]: /2018/07/24/deeplearning-ai-Structured-Machine-Learning-Projects-week1/
[c3w2]: /2018/07/25/deeplearning-ai-Structured-Machine-Learning-Projects-week2/

## 4. Convolutional Neural Networks

- [4.1 Convolutional Neural Networks (week1)][c4w1]

- [4.2 Convolutional Neural Networks (week2)][c4w2]

- [4.3 Convolutional Neural Networks (week3)][c4w3]

- [4.4 Convolutional Neural Networks (week4)][c4w4]

[c4w1]: /2018/08/21/deeplearning-ai-Convolutional-Neural-Networks-week1/
[c4w2]: /2018/08/24/deeplearning-ai-Convolutional-Neural-Networks-week2/
[c4w3]: 0
[c4w4]: 0

### 第一周 Convolutional Neural Networks

1.1  计算机视觉

1.2  边缘检测示例

1.3  更多边缘检测内容

1.4  Padding

1.5  卷积步长

1.6  卷积为何有效

1.7  单层卷积网络

1.8  简单卷积网络示例

1.9  池化层

1.10  卷积神经网络示例

1.11  为什么使用卷积？

### 第二周  深度卷积网络：实例探究

2.1  为什么要进行实例探究

2.2  经典网络

2.3  残差网络

2.4  残差网络为什么有用？

2.5  网络中的网络以及 1×1 卷积

2.6  谷歌 Inception 网络简介

2.7  Inception 网络

2.8  使用开源的实现方案

2.9  迁移学习

2.10  数据扩充

2.11  计算机视觉现状


### 第三周  目标检测


3.1  目标定位

3.2  特征点检测

3.3  目标检测

3.4  卷积的滑动窗口实现

3.5  Bounding Box预测

3.6  交并比

3.7  非极大值抑制

3.8  Anchor Boxes

3.9  YOLO 算法

3.10  RPN网络

### 第四周  特殊应用：人脸识别和神经风格转换

4.1  什么是人脸识别？

4.2  One-Shot 学习

4.3  Siamese 网络

4.4  Triplet 损失

4.5  面部验证与二分类

4.6  什么是神经风格转换？

4.7  什么是深度卷积网络？

4.8  代价函数

4.9  内容代价函数

4.10  风格代价函数

4.11 一维到三维推广

### 5. Sequence Models

- [5.1 Recurrent Sequence Models - (Notation、RNN、Vanishing gradients、GRU、LSTM、BRNN、Deep RNNs][6]

- [5.2 NLP & Word Embeddings - (Matrix、Word2Vec、Negative Sampling、GloVe、Debiasing Word Embeddings)][7]

- [5.3 Sequence Models & Attention - (Greedy Search、Beam Search、Error analysis on beam search、Attention)][8]

[6]: /2018/07/26/deeplearning-ai-Sequence-Models-week1/
[7]: /2018/08/02/deeplearning-ai-Sequence-Models-week2/
[8]: /2018/08/14/deeplearning-ai-Sequence-Models-week3/

### 第一周  循环序列模型

本周的知识点是循环神经网络。这种类型的模型已经被证明在时间数据上表现非常好，它有几个变体，包括 LSTM、GRU 和双向神经网络，本周的课程中也都包括这些内容。

1.1  为什么选择序列模型

1.2  数学符号

1.3  循环神经网络模型

1.4  通过时间的反向传播

1.5  不同类型的循环神经网络

1.6  语言模型和序列生成

1.7  对新序列采样

1.8  带有神经网络的梯度消失

1.9  GRU 单元

1.10  长短期记忆（LSTM）

1.11  双向神经网络

1.12  深层循环神经网络

### 第二周  自然语言处理与词嵌入

自然语言处理与深度学习是特别重要的组合。使用词向量表示和嵌入层，可以训练在各种行业中表现出色的循环神经网络。应用程序示例包括情绪分析、物体识别和机器翻译。

2.1  词汇表征

2.2  使用词嵌入

2.3  词嵌入的特性

2.4  嵌入矩阵

2.5  学习词嵌入

2.6  Word2Vec

2.7  负采样

2.8  GloVe 词向量

2.9  情绪分类

2.10  词嵌入除偏

### 第三周  序列模型和注意力机制

注意力机制可以增强序列模型。这个算法将帮助你的模型理解，在给出一系列的输入时，它应该把注意力放在什么地方。本周，你还将学习语音识别以及如何处理音频数据。

3.1  基础模型

3.2  选择最可能的句子

3.3  定向搜索

3.4  改进定向搜索

3.5  定向搜索的误差分析

3.6  Bleu 得分（选修）

3.7  注意力模型直观理解

3.8  注意力模型

3.9  语音辨识

3.10  触发字检测

3.11  结论和致谢

### next ⋯⋯

> notes：next ...

[0]: /

### Reference

- [这是一份优美的信息图，吴恩达点赞的][1]
- [Deeplearning.ai课程笔记--汇总][2]
- [完结撒花！吴恩达DeepLearning.ai《深度学习》课程笔记目录总集][3]
- [吴恩达Coursera深度学习课程 DeepLearning.ai 提炼笔记（2-2）-- 优化算法][4]
- [DeepLearning.ai学习笔记 By 互道晚安，王者峡谷见][5]

[1]: https://juejin.im/post/5aa0e3d45188255587231bae
[2]: https://blog.csdn.net/zwqjoy/article/details/80022385
[3]: https://blog.csdn.net/koala_tree/article/details/79913655
[4]: https://blog.csdn.net/koala_tree/article/details/78199611
[5]: http://www.cnblogs.com/marsggbo/p/7625565.html


