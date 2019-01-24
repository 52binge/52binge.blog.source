> 个人看法要在面试之前按照简历上面的内容自己能够讲一个小故事。主要体现自己的深度学习的基础知识，这一部分要结合项目经验进行拔高，让面试官看到你的能力和特点。

## 1. DNN 

- ReLu、Tanh、Sigmod 激活函数
- 交叉熵损失函数 (Cross Entropy Error Function)
- softmax求导
- 过拟合
- 梯度爆炸和梯度弥散
- Optimization (Mini-batch、指数加权平均-偏差修正、Momentum、RMSprop、Adam、学习率衰减)

### 1.1 Deep Neural Networks

Tanh 数据平均值为 0，具有数据中心化的效果，几乎在任何场合都优于 Sigmoid

<img src="/images/deeplearning/C1W3-9_1.png" width="700" />

> 对于中间层来说, 往往是 ReLU 的效果最好.
>
> 虽然 z < 0 时，斜率为0， 但在实践中，有足够多的隐藏单元 令 z > 0, 对大多数训练样本来说是很快的.

### 1.2 Cross Entropy

Cross Entropy损失函数常用于分类问题中，但是为什么它会在分类问题中这么有效呢？我们先从一个简单的分类例子来入手。

- [Cross Entropy 交叉熵损失函数](https://zhuanlan.zhihu.com/p/35709485)

> 预测政治倾向例子
> - Classification Error（分类错误率）
> - Mean Squared Error (均方方差)
> - Cross Entropy Error Function（交叉熵损失函数）

**模型1：**

![](https://pic3.zhimg.com/80/v2-0c49d6159fc8a5676637668683d41762_hd.jpg)

**模型2：**

![](https://pic3.zhimg.com/80/v2-6d31cf03185b408d5e93fa3e3c05096e_hd.jpg)

**Classification Error: **

![](https://www.zhihu.com/equation?tex=classification%5C+error%3D%5Cfrac%7Bcount%5C+of%5C+error%5C+items%7D%7Bcount%5C+of+%5C+all%5C+items%7D)

**Mean Squared Error:**

![](https://www.zhihu.com/equation?tex=MSE%3D%5Cfrac%7B1%7D%7Bn%7D%5Csum_%7Bi%7D%5En%28%5Chat%7By_i%7D-y_i%29%5E2)

> 我们发现，MSE能够判断出来模型2优于模型1，那为什么不采样这种损失函数呢？主要原因是逻辑回归配合MSE损失函数时，采用梯度下降法进行学习时，会出现模型一开始训练时，学习速率非常慢的情况
> 
> 结论： 对于分类问题的损失函数来说，分类错误率和平方和损失都不是很好的损失函数

**Cross Entropy Error Function（交叉熵损失函数）**

二分类

![](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7DJ+%3D+%E2%88%92%5By%5Ccdot+log%28p%29%2B%281%E2%88%92y%29%5Ccdot+log%281%E2%88%92p%29%5D%5Cend%7Balign%7D+%5C%5C)

多分类

![](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7DJ+%3D+-%5Csum_%7Bc%3D1%7D%5EMy_%7Bc%7D%5Clog%28p_%7Bc%7D%29%5Cend%7Balign%7D+%5C%5C)

> 函数性质: 该函数是凸函数，求导时能够得到全局最优值
> 
> 交叉熵损失函数经常用于分类问题中，特别是在神经网络做分类问题时，也经常使用交叉熵作为损失函数，此外，由于交叉熵涉及到计算每个类别的概率，所以交叉熵几乎每次都和softmax函数一起出现。
> 
> 使用交叉熵损失函数，不仅可以很好的衡量模型的效果，又可以很容易的的进行求导计算

在用梯度下降法做参数更新的时候，模型学习的速度取决于两个值：

> 1. 学习率
> 2. 偏导值

### 1.3 Improving Neural Networks

> - 能够高效地使用神经网络**通用**的技巧，包括 `初始化、L2和dropout正则化、Batch归一化、梯度检验`。
> - 能够实现并应用各种**优化**算法，例如 `Mini-batch、Momentum、RMSprop、Adam，并检查它们的收敛程度`。
> - 理解深度学习时代关于如何 **构建训练/开发/测试集** 以及 **偏差/方差分析** 最新最有效的方法.

本周主要内容包括:
 
 > 1. Data set partition
 > 2. Bias / Variance
 > 3. Regularization
 > 4. Normalization
 > 5. Gradient Checking
 
#### 1.3.1 Data set partition
 
> 在以往传统的机器学习中, 我们通常按照 70/30 来数据集分为 `Train set`/`Validation set`, 或者按照 60/20/20 的比例分为 `Train/Validation/Test`. 
> 
> 但在今天机器学习问题中, 我们可用的**数据集的量级非常大** (例如有 100W 个样本). 这时我们就**不需要给验证集和测试集太大的比例, 例如 98/1/1**.

#### 1.3.2 Regularization

- L1 regularization 
- L2 regularization 

> 当我们的 λ 比较大的时候, 模型就会加大对 w 的惩罚, 这样有些 w 就会变得很小 (L2 Regularization 也叫权重衰减, weights decay). 从下图左边的神经网络来看, 效果就是整个神经网络变得简单了(一些隐藏层甚至 w 趋向于 0), 从而降低了过拟合的风险.
>
> 那些 隐藏层 并没有被消除，只是影响变得更小了，神经网络变得简单了.
> 
> L2 正则化 的缺点是，要用大量精力搜索合适的 λ .

#### 1.3.3 dropout

> dropout 将产生收缩权重的平方范数的效果, 和 L2 类似，实施 dropout 的结果是它会压缩权重，并完成一些预防过拟合的外层正则化，事实证明 dropout 被正式地作为一种正则化的替代形式
>
> L2 对不同权重的衰减是不同的，它取决于倍增的激活函数的大小.
>
> dropout 的功能类似于 L2 正则化. 甚至 dropout 更适用于不同的输入范围.

#### 1.3.4 Normalization

#### 1.3.5 Vanish/Explod gradients

一个可以减小这种情况发生的方法, 就是用有效的参数初始化 (该方法并不能完全解决这个问题). 但是也是有意义的

设置合理的权重，希望你设置的权重矩阵，既不会增长过快，也不会下降过快到 0.

想更加了解如何初始化权重可以看下这篇文章 [神经网络权重初始化问题](http://www.cnblogs.com/marsggbo/p/7462682.html)，其中很详细的介绍了权重初始化问题。

> 我们不应该做的事情（即初始化为0）, 如果权重初始化为同一个值，网络就不可能不对称(即是对称的)。
>
> 警告：并不是数字越小就会表现的越好。比如，如果一个神经网络层的权重非常小，那么在反向传播算法就会计算出很小的梯度(因为梯度gradient是与权重成正比的)。在网络不断的反向传播过程中将极大地减少“梯度信号”，并可能成为深层网络的一个需要注意的问题

**实际操作：**

> 通常的建议是使用ReLU单元以及 Kaiming He 等人 推荐的公式
>
> $$
w = np.random.randn(n) * sqrt(2.0/n)
$$
> np.random.randn 是从标准正态分布中返回一个或多个样本值

## 2. Optimization 

### 2.1 Mini-batch

**算法核心**

> 假设我们有 5,000,000 个数据，每 1000 作为一个集合，计入上面所提到的 $x^{\\{1\\}}=\\{x^{(1)},x^{(2)}……x^{(5000)}\\},……$

> 1. 需要迭代运行 5000次 神经网络运算.
> 2. 每一次迭代其实与之前笔记中所提到的计算过程一样，首先是前向传播，但是每次计算的数量是 1000.
> 3. 计算损失函数，如果有 Regularization ，则记得加上 Regularization Item
> 4. Backward propagation
> 
> 注意，mini-batch 相比于之前一次性计算所有数据不仅速度快，而且反向传播需要计算 5000次，所以效果也更好.

epoch

> - 对于普通的梯度下降法，一个 epoch 只能进行一次梯度下降；
> - 对于 Mini-batch 梯度下降法，一个 epoch 可以进行 numbers of mini-batch 次梯度下降;

> **epoch** : 当一个`完整的数据集`通过了神经网络一次并且返回了一次，这个过程称为一个 epoch。
> 
> 比如对于一个有 2000 个训练样本的数据集。将 2000 个样本分成大小为 500 的 batch，那么完成一个 epoch 需要 4 个 iteration。

**mini-batch 大小的选择**

> - 如果训练样本的大小比较小时，如 $m⩽2000$ 时 — 选择 batch 梯度下降法；
> - 如果训练样本的大小比较大时，典型的大小为：$2^{6}、2^{7}、\cdots、2^{10}$
> - Mini-batch 的大小要符合 CPU/GPU 内存， 运算起来会更快一些.

### 2.2 指数加权平均

指数加权平均 (Exponentially weighted averages) 的关键函数： 

$$
v\_{t} = \beta v\_{t-1}+(1-\beta)\theta\_{t}
$$

我们现在需要计算出一个温度趋势曲线，计算方法(`指数加权平均实现`)如下：

$$
v\_{0} =0 \\\\
v\_{1}= \beta v\_{0}+(1-\beta)\theta\_{1} \\\\
v\_{2}= \beta v\_{1}+(1-\beta)\theta\_{2} \\\\
v\_{3}= \beta v\_{2}+(1-\beta)\theta\_{3} \\\\
\ldots
$$

展开：

$$
v\_{100}=0.1\theta\_{100}+0.9(0.1\theta\_{99}+0.9(0.1\theta\_{98}+0.9v\_{97})) \\\\ v\_{100}=0.1\theta\_{100}+0.1\times0.9\theta\_{99}+0.1\times(0.9)^{2}\theta\_{98}+0.1\times(0.9)^{3}\theta\_{97}+\cdots
$$

上式中所有 $θ$ 前面的系数相加起来为 1 或者 接近于 1，称之为偏差修正.

**原因**： 

> $$
v\_{0}=0\\\\v\_{1}=0.98v\_{0}+0.02\theta\_{1}=0.02\theta\_{1}\\\\v\_{2}=0.98v\_{1}+0.02\theta\_{2}=0.98\times0.02\theta\_{1}+0.02\theta\_{2}=0.0196\theta\_{1}+0.02\theta\_{2}
$$

> 如果第一天的值为如40，则得到的 v1=0.02×40=0.8，则得到的值要远小于实际值，后面几天的情况也会由于初值引起的影响，均低于实际均值.

> 注意 ：！！！上面公式中的 $V\_{t-1}$ 是未修正的值.
> 
> 为方便说明，令 $β=0.98,θ\_1=40℃,θ\_2=39℃$, 则
> 
> - 当 $t=1,θ\_1=40℃$ 时，$V\_1=\frac{0.02*40}{1-0.98}=40$ ,哇哦, 有没有很巧的感觉，再看
> - 当 $t=2,θ\_2=39℃$ 时，$V\_2 = \frac{0.98\*V\_{t-1} + 0.02\*θ\_2}{1-0.98^2}$ $=\frac{0.98\*(0 + 0.02\*θ\_1)+0.02\*39}{1-0.98^2}=39.49$
> 
> `注意点` : 所以，**记住你如果直接用修正后的 $V\_{t−1}$ 值代入计算就大错特错了**.

### 2.3 Momentum 解释版

Momentum 优化器 刚好可以解决我们所面临的问题，它主要是基于梯度的移动指数加权平均

**RMSProp** (Root Mean Square Prop)

为了进一步优化损失函数在更新中存在摆动幅度过大的问题，并且进一步加快函数的收敛速度，RMSProp 算法对权重 W 和偏置 b 的梯度使用了微分平方加权平均数。

其中，假设在第 t 轮迭代过程中，各个公式如下所示：

$$
{s\_{dw}} = \beta {s\_{dw}} + (1 - \beta )d{W^2} \\\\
{s\_{db}} = \beta {s\_{db}} + (1 - \beta )d{b^2}
$$

$$
W = W - \alpha \frac {dW} { \sqrt {s\_{dw}} + \varepsilon } \\\\
b = b - \alpha \frac {db} { \sqrt{s\_{db}}  + \varepsilon }
$$

> 当 dW 或者 db 中有一个值比较大的时候，那么我们在更新权重或者偏置的时候除以它之前累积的梯度的平方根，这样就可以使得更新幅度变小

### 2.4 Adam (Adaptive Moment..)

Adam（Adaptive Moment Estimation）算法是将 Momentum算法 和 RMSProp算法 结合起来使用的一种算法

上面的所有步骤就是Momentum算法和RMSProp算法结合起来从而形成Adam算法。在Adam算法中，参数 ${\beta\_1}$ 所对应的就是Momentum算法中的 ${\beta}$ 值，一般取0.9，参数 ${\beta\_2}$ 所对应的就是RMSProp算法中的 ${\beta}$ 值，一般我们取0.999，而 $\epsilon$ 是一个平滑项，我们一般取值为 ${10^{ - 8}}$，而学习率 $\alpha$ 则需要我们在训练的时候进行微调。

Adaptive Moment Estimation

> ${\beta\_1}$ 用于计算这个微分 (computing the mean of the derivatives, this is called the first moment).
> 
> ${\beta\_2}$ 用于计算平方数的指数加权平均数 (compute exponentially weighted average of the squares. this is called the second moment)
> 
> So that gives rise to the name `Adaptive Moment Estimation`.

- [Optimization](/2018/07/21/deeplearning/Improving-Deep-Neural-Networks-week2/)

## 3. Batch Regularization

Hyperparameter 和 Batch Regularization

> Normalizing Activations in a network
>
> Fitting Batch Norm into a neural network
>
> Why does Batch Norm work?

1. 归一化数据可以减弱前层参数的作用与后层参数的作用之间的联系，它使得网络每层都可以自己学习
2. batch norm 奏效的另一个原因则是它具有正则化的效果。其与dropout有异曲同工之妙

batch norm 奏效的另一个原因则是它具有正则化的效果。其与dropout有异曲同工之妙，我们知道dropout会随机的丢掉一些节点，即数据，这样使得模型训练不会过分依赖某一个节点或某一层数据。batch norm也是如此，通过归一化使得各层之间的依赖性降低，并且会给每层都加入一些噪声，从而达到正则化的目的

> 它减弱了前层参数的作用，与后层参数的作用之间的联系

## 4. Residual Network (ResNets)

> AlexNet->VGG->LeNet

ResNets 发明者是 何恺明、张翔宇、任少卿、孙剑

吴大师表示 “非常深的网络是很难训练的，因为存在梯度消失和梯度爆炸的问题”，为了解决这个问题，引入了 **Skip Connection** (跳远链接)，残差网络正是使用了这个方法。

残差网络每两层网络节点组成一个残差块，这也就是其与普通网络(Plain Network)的差别。

## 5. RNN

在介绍 RNN 之前，首先解释一下为什么之前的标准网络不再适用了。

因为它有两个缺点：

- 输入和输出的长度不尽相同
- 无法共享从其他位置学来的特征

> DNN 标准网络，输入层，比如每个 $x^{<1>}$ 都是一个 1000 维的向量，这样输入层很庞大, 那么第一层的权重矩阵就有着巨大的参数. 而 RNN 可以共享参数
> 
> DNN 传统网络存在的问题，即单词之间没有联系
> 
> RNN 为了将单词之间关联起来，所以将前一层的结果也作为下一层的输入数据。
> 
> RNN 在正向传播的过程中可以看到 a 的值随着时间的推移被传播了出去，也就一定程度上保存了单词之间的特性
> 
> RNN 要开始整个流程, 需要编造一个激活值, 这通常是 0向量, 有些研究人员会用其他方法随机初始化 $a^{<0>}=\vec{0}$. 不过使用 0向量，作为 0时刻 的伪激活值 是最常见的选择. 因此我们把它输入神经网络.

<img src="/images/deeplearning/C5W1-10_1.png" width="750" />

> $a^{<0>}=\vec{0}$
> 
> $a^{<1>}=g\_1(W\_{aa}a^{<0>}+W\_{ax}x^{<1>}+b\_a)$
> 
> $y^{<1>}=g\_2(W\_{ya}a^{<1>}+b\_y)$
> 
> $a^{<{t}>}=g\_1(W\_{aa}a^{<{t-1}>}+W\_{ax}x^{<{t}>}+b\_a)$
> 
> $y^{<{t}>}=g\_2(W\_{ya}a^{<{t}>}+b\_y)$
>
> 激活函数：**$g\_1$** 一般为 **`tanh`函数** (或者是 **`Relu`函数**)，**$g\_2$** 一般是 **`Sigmod`函数**.
>
> 注意: 参数的下标是有顺序含义的，如 $W\_{ax}$ 下标的第一个参数表示要计算的量的类型，即要计算 $a$ 矢量，第二个参数表示要进行乘法运算的数据类型，即需要与 $x$ 矢量做运算。如 $W\_{ax} x^{t}\rightarrow{a}$

**Simplified RNN notation：**

<img src="/images/deeplearning/C5W1-11_1.png" width="400" />

$$
\begin{align}
a^{<{t}>}&= g(W\_{aa}a^{<{t-1}>}+W\_{ax}x^{<{t}>}+b\_a) \notag \\\\
&= g(W\_a [a^{<{t-1}>},x^{<{t}>}]^{T}+b\_a) \notag
\end{align}
$$

[TensorFlow： 第8章 RNN 循环神经网络 1][1]

**Vanishing gradients with RNNs**

> 现在你已经学会了 基本的 RNN 如何应用在 比如 语言模型 还有 如何用反向传播来训练你的 RNN 模型, 但是还有一个问题就是 梯度消失 与 梯度爆炸 问题.
>
> 目前这种基本的 RNN 也不擅长捕获这种长期依赖效应.
>
> 梯度爆炸可以用梯度消减解决、梯度消失就有点麻烦了，需要用 **GRU** 来解决.

**RNN 的梯度消失、爆炸问题:**

但梯度值过小的解决方案要稍微复杂一点，比如下面两句话：

> “The **cat**，which already ate apple，yogurt，banana，…, **was** full.”

所以为了 解决梯度消失 问题，提出了

1. GRU单元
2. LSTM

> - [人人都能看懂的GRU](https://zhuanlan.zhihu.com/p/32481747)
> - [一文了解LSTM和GRU背后的秘密（绝对没有公式）](https://zhuanlan.zhihu.com/p/46327831)
>
> 识别偏见方向

- [理论 seq2seq+Attention 机制模型详解](/2017/11/17/chatbot/chatbot-research8/)
- [Tensorflow 实现 seq2seq+Attention 详解](https://github.com/blair101/seq2seq_chatbot)

## 6. LSTM

<!--<img src="/images/tensorflow/tf-google-8-8_0.jpg" width="600" />
-->

- 输入门 、 遗忘门 、 输出门
- 记忆细胞 memory cell

<img src="/images/tensorflow/tf-google-8-8_1.jpg" width="800" />

## 7. language model

如果 S 表示一连串特定顺序排列的词 $w\_1$， $w\_2$，…， $w\_n$ ，换句话说，S 表示的是一个有意义的句子。机器对语言的识别从某种角度来说，就是想知道S在文本中出现的可能性，也就是数学上所说的S 的概率用 P(S) 来表示。利用条件概率的公式，S 这个序列出现的概率等于每一个词出现的概率相乘，于是P(S) 可展开为：

$$
P(S) = P(w\_1)P(w\_2|w\_1)P(w\_3| w\_1 w\_2)…P(w\_n|w\_1 w\_2…w\_{n-1})
$$

马尔可夫假设

$$
P(S) = P(w\_1)P(w\_2|w\_1)P(w\_3|w\_2)…P(w\_i|w\_{i-1})…
$$

接下来如何估计 $P (w\_i|w\_{i-1})$。只要机器数一数这对词 $(w\_{i-1}, w\_i)$ 在统计的文本中出现了多少次，以及 $w\_{i-1}$ 本身在同样的文本中前后相邻出现了多少次，然后用两个数一除就可以了,

$$
P(w\_i|w\_{i-1}) = \frac {P(w\_{i-1}, w\_i)} {P(w\_{i-1})}
$$

因此，

$$
P(w\_{i}|w\_{1}, w\_{2}, ..., w\_{i-1}) = P(w\_i | w\_{i-N+1}, w\_{i-N+2}, ..., w\_{i-1})
$$

> N元模型， N=2 时，为二元模型。 在实际中应用最多的是 N=3 的三元模型

[word2vec language model](/2017/07/12/nlp/word2vector-basic/#3-4-语言模型-词组合出现的概率)

## 8. word2vec

- NNLM
- Skip-Gram
- CBOW (Continuous Bagof-Words)

[Word2Vec](https://blog.csdn.net/u012052268/article/details/77170517/#63个人对word-embedding的理解)
[Word2Vec词嵌入矩阵](https://blog.csdn.net/sinat_33761963/article/details/54631367)

> 分布式词向量并不是word2vec的作者发明的，他只是提出了一种更快更好的方式来训练语言模型罢了。
>
> 分别是： 
>
> 1. CBOW  Continous Bag of Words Model 连续词袋模型
> 2. Skip-Gram Model

## 9. fastText

## 10. seq2seq


