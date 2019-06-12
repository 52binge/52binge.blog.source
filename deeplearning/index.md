
博主水平灰常有限，期望能与對、Deep Learning 感兴趣的朋友一起学习、交流、探讨与分享~~

## 1. Neural Networks / Deep Learning

No. | <font color="#0085a1">**Neural Networks**</font> | <font color="#0085a1">**Neural Networks and Deep Learning**</font>
:-------: | :-------: | :-------:
1 | [Introduction to Deep Learning][c1w1]  | 了解现今深度学习在哪里应用、如何应用
2 | [Neural Networks Basics][c1w2] | logistic 损失函数、导数、计算图、m个样本的梯度下降、向量化
3 | [Shallow Neural Networks][c1w3] | NN Representation、向量化、[Activation functions][in1]、**Random init**、Python 实现 NN 
4 | [Deep Neural Networks][c1w4] | 深网的前向传播、核对矩阵维数、反向传播、参数VS超参数、Python 实现 NN

> 对于中间层来说, 往往是 ReLU 的效果最好. 
> 虽然 z < 0, 的时候，斜率为0， 但在实践中，有足够多的隐藏单元 令 z > 0, 对大多数训练样本来说是很快的.
> 
> so the one place you might use as linear activation function others usually in the output layer.

[in1]: /2018/07/14/deeplearning/Neural-Networks-and-Deep-Learning-week3/#3-神经网络中的激活函数

[c1w1]: /2017/12/01/deeplearning/Neural-Networks-and-Deep-Learning-week1/
[c1w2]: /2018/07/07/deeplearning/Neural-Networks-and-Deep-Learning-week2/
[c1w3]: /2018/07/14/deeplearning/Neural-Networks-and-Deep-Learning-week3/
[c1w4]: /2018/07/15/deeplearning/Neural-Networks-and-Deep-Learning-week4/

## 2. Improving Deep Neural Networks 

No. | <font color="#0085a1">**Improving**</font> | <font color="#0085a1">**Improving Deep Neural Networks**</font> 
:-------: | :-------: | :-------:
5 | [Deep Learning Action][c2w1]  | Train/Dev/Test、Bias/Variance、L1 L2 Dropout、梯度消失\爆炸、Weight init、Gradient checking
6 | [Optimization][c2w2] | mini-batch、指数加权平均-偏差修正、Momentum、RMSprop、Adam、α decay、局部优
7 | [超参数调试、Batch][c2w3] | Hyperparameter、Normalizing Activations、Batch Norm [Fitting NN]、Softmax

[c2w1]: /2018/07/19/deeplearning/Improving-Deep-Neural-Networks-week1/
[c2w2]: /2018/07/21/deeplearning/Improving-Deep-Neural-Networks-week2/
[c2w3]: /2018/07/23/deeplearning/Improving-Deep-Neural-Networks-week3/

## 3. Structured Machine Learning 

No. | <font color="#0085a1">**Structured**</font> | <font color="#0085a1">**Structured Machine Learning Projects**</font> 
:-------: | :-------: | :-------:
8 | [ML Strategy 1][c3w1] | 正交化、Satisficing and optimizing metrics、Train/dev/test 改变、可避免偏差、人的表现
9 | [ML Strategy 2][c3w2] | 误差分析、标注错误数据、定位数据不匹配偏差与方差、迁移学习、多任务学习、端到端学习

[c3w1]: /2018/07/24/deeplearning/Structured-Machine-Learning-Projects-week1/
[c3w2]: /2018/07/25/deeplearning/Structured-Machine-Learning-Projects-week2/

## 4. Convolutional Neural Networks

No. | <font color="#0085a1">**CNN**</font> | <font color="#0085a1">**Convolutional Neural Networks**</font>
:-------: | :-------: | :-------:
10 | [Convolutional Neural Networks][c4w1] | Edge detection、Padding、Strided convolutions、Convolutions Over Volumes、Pooling
11 | [&nbsp;&nbsp;Deep CNN&nbsp;&nbsp;][c4w2] | Classic Nets、ResNets、1×1 convolutions、Inception、Transfer Learning、Data augmentation
12 | [Object detection][c4w3] | Object Localization、Landmark Detection、Sliding Windows、Bounding Box Predictions、Intersection Over Union、Non-max Suppression、Anchor Boxes、YOLO
13 | [Face recognition][c4w4] | One-Shot、Siamese、Triplet Loss、Face Verification、deep ConvNets learning?

> LeNet-5、AlexNet、VGG、ResNet (有152层)、Inception。 目标定位、特征点检测、Bounding Box预测、Anchor Boxes

[c4w1]: /2018/08/21/deeplearning/Convolutional-Neural-Networks-week1/
[c4w2]: /2018/08/24/deeplearning/Convolutional-Neural-Networks-week2/
[c4w3]: /2018/09/01/deeplearning/Convolutional-Neural-Networks-week3/
[c4w4]: /2018/09/08/deeplearning/Convolutional-Neural-Networks-week4/

## 5. Sequence Models

No. | <font color="#0085a1">**Sequence Models**</font> | <font color="#0085a1">**Sequence Models**</font>
:-------: | :-------: | :-------:
14 | [Recurrent Sequence Models][c5w1] | Notation、RNN、Vanishing gradients、GRU、LSTM、BRNN、Deep RNNs
15 | [NLP & Word Embeddings][c5w2] | Matrix、Word2Vec、Negative Sampling、GloVe、Debiasing Word Embeddings
16 | [Sequence Models & Attention][c5w3] | Greedy Search、Beam Search、Error analysis on beam search、Attention

[c5w1]: /2018/07/26/deeplearning/Sequence-Models-week1/
[c5w2]: /2018/08/02/deeplearning/Sequence-Models-week2/
[c5w3]: /2018/08/14/deeplearning/Sequence-Models-week3/

[0]: / 

## Friends link

- [深度学习与自然语言处理 CS244d Notes][h1]
- [怎样找到一份深度学习的工作][h2]

[h1]: https://blog.csdn.net/column/details/dl-nlp.html
[h2]: https://blog.csdn.net/han_xiaoyang/article/details/52777661

