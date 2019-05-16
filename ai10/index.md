> 个人看法要在面试之前按照简历上面的内容自己能够讲一个小故事。主要体现自己的深度学习的基础知识，这一部分要结合项目经验进行拔高，让面试官看到你的能力和特点。

[RNN中为什么要采用tanh而不是ReLu作为激活函数？](https://www.zhihu.com/question/61265076)

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

<font color=#c7254e>**摘要心得1：**</font>

> 1. Sigmoid 和 Tanh 为什么会导致 Vanishing/Exploding gradients ? 
> 2. Tanh 值域 (-1,1) Sigmoid 值域 (0,1)
> 3. ReLU 的优点，和局限性分别是什么? 
> 4. [谈谈激活函数 Sigmoid,Tanh,ReLu,softplus,softmax](https://zhuanlan.zhihu.com/p/48776056)
> 5. softmax函数可以看做是Sigmoid函数的一般化，可以进行多分类。
> 6. 非常适合用于`分类`问题： `Cross Entropy` 交叉熵损失函数
> 7. Square error loss function 与 Cross Entropy Error Function 分别适合什么景？
> 8. [偏差和方差与过拟合欠拟合的关系](https://blog.csdn.net/u012033832/article/details/78401486)

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

> 我们发现，MSE能够判断出来模型2优于模型1，那为什么不采用这种损失函数呢？主要原因是逻辑回归配合MSE损失函数时，采用梯度下降法进行学习时，会出现模型一开始训练时，学习速率非常慢的情况
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

<font color=#c7254e>**摘要心得2：**</font>

> 1. Square error loss function 与 Cross Entropy Error Function 分别适合什么景？
> 2. [偏差和方差与过拟合欠拟合的关系](https://blog.csdn.net/u012033832/article/details/78401486)


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

<font color=#c7254e>**摘要心得3：**</font>

> 解决 overfiting 的方法:
> 
> 1. Data augmentation
> 2. Regularization
> 3. Model Ensembel
> 4. Dropout 是 model 集成方法中最高效常用的技巧

> Batch Normalization 可以有效避免复杂参数对网络训练产生的影响，也可提高泛化能力.
> 
> 神经网路的训练过程的本质是学习数据分布，如果训练数据与测试数据分布不同，将大大降低网络泛化能力， BN 是针对每一批数据，在网络的每一层输入之前增加 BN，(均值0，标准差1)。
> 
> Dropout 可以抑制过拟合，作用于每份小批量的训练数据，随机丢弃部分神经元机制. bagging 原理.

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

### 7.1 PPL 评价方法

常用指标 perplexity， perplexity 越低，说明建模效果越好. 

计算perplexity的公式如下：

<img src="/images/tensorflow/tf-google-9.1.2_1-equation.svg" width="600" />

简单来说，perplexity刻画的是语言模型预测一个语言样本的能力.

在语言模型的训练中，通常采用perplexity的对数表达形式：

<img src="/images/tensorflow/tf-google-9.1.2_2-equation.svg" width="600" />

相比较乘积求平方根的方式，采用加法的形式可以加速计算，同时避免概率乘积数值过小而导致浮点数向下溢出的问题。在数学上，log perplexity 可以看作真实分布与预测分布之间的交叉熵 Cross Entropy, 交叉熵描述了两个概率分布之间的一种距离. log perplexity和交叉熵是等价的

在神经网络模型中，$P(w\_i | w\_{1}, , ..., w\_{i-1})$ 分布通常是由一个softmax层产生的，TensorFlow中提供了两个方便计算交叉熵的函数，可以将logits结果直接放入输入，来帮助计算softmax然后再进行计算交叉熵，在后面我们会详细介绍

```py
cross_entropy = tf.nn.softmax_cross_entropy_with_logits(labels = y, logits = y)
cross_entropy = tf.nn.sparse_softmax_cross_entropy_with_logits(labels = y, logits = y)
```

- [知乎_习翔宇](https://www.zhihu.com/people/xi-xiang-yu-20/posts)

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
>
> 词向量（词的特征向量）既能够降低维度，又能够capture到当前词在本句子中上下文的信息（表现为前后距离关系），那么我们对其用来表示语言句子词语作为NN的输入是非常自信与满意的

### 8.1 NNLM

NNLM,直接从语言模型出发，将模型最优化过程转化为求词向量表示的过程。 
既然离散的表示有辣么多缺点，于是有小伙伴就尝试着用模型最优化的过程去转换词向量了

<img src="/images/nlp/word2vec-nnlm.png" width="600" />

计算复杂度： ($N \* D + N \* D \* H + H \* V$) 相当之高

于是有了 CBOW 和 Skip-Gram .

> 感悟： 技术的发展日新月异

**word2vec：**

word2vec 并不是一个模型， 而是一个 2013年 google 发表的工具. 该工具包含了2个模型： Skip-Gram 和 CBOW. 以及两种高效的训练方法： negative sampling 和 hierarchicam softmax. word2vec 可以很好表达不同词之间的相似度和类比关系.

> word2vec 有两篇 paper.

### 8.2 CBOW

<img src="/images/nlp/word2vec-CBOW_1.png" width="600" />

> 纠错 : 上图”目标函数“的第一个公式，应该是 连乘 公式，不是 连加 运算。
> 
> 理解 : 背景词向量与 中心词向量 内积 等部分，你可考虑 softmax $w \* x+b$ 中 $x$ 和 $w$ 的关系来理解.

### 8.3 Skip-Gram

跳字模型假设基于某个词来生成它在文本序列周围的词。举个例子，假设文本序列是“the”“man”“loves”“his”“son”。以“loves”作为中心词，设背景窗口大小为2。如图10.1所示，跳字模型所关心的是，给定中心词“loves”，生成与它距离不超过2个词的背景词“the”“man”“his”“son”的条件概率，即

$$
P(\textrm{the},\textrm{man},\textrm{his},\textrm{son}\mid\textrm{loves}).
$$

假设给定中心词的情况下，背景词的生成是相互独立的，那么上式可以改写成

$$
P(\textrm{the}\mid\textrm{loves})\cdot P(\textrm{man}\mid\textrm{loves})\cdot P(\textrm{his}\mid\textrm{loves})\cdot P(\textrm{son}\mid\textrm{loves}).
$$

<img src="/images/nlp/word2vec-skip-gram.svg" width="300" />

**训练 Skip-Gram**

跳字模型的参数是每个词所对应的中心词向量和背景词向量。训练中我们通过最大化似然函数来学习模型参数，即最大似然估计。这等价于最小化以下损失函数：

$$ - \sum\_{t=1}^{T} \sum\_{-m \leq j \leq m,\ j \neq 0} \text{log}\, P(w^{(t+j)} \mid w^{(t)}).
$$

如果使用随机梯度下降，那么在每一次迭代里我们随机采样一个较短的子序列来计算有关该子序列的损失，然后计算梯度来更新模型参数。梯度计算的关键是条件概率的对数有关中心词向量和背景词向量的梯度。根据定义，首先看到

$$
\log P(w\_o \mid w\_c) =
\boldsymbol{u}\_o^\top \boldsymbol{v}\_c - \log\left(\sum\_{i \in \mathcal{V}} \text{exp}(\boldsymbol{u}\_i^\top \boldsymbol{v}\_c)\right)
$$

<img src="/images/nlp/word2vec-skip.png" width="700" />

它的计算需要词典中所有词以 $w\_c$ 为中心词的条件概率。有关其他词向量的梯度同理可得。

训练结束后，对于词典中的任一索引为 $i$ 的词，我们均得到该词作为中心词和背景词的两组词向量 $v\_i$ 和 $u\_i$ 。在自然语言处理应用中，一般使用跳字模型的中心词向量作为词的表征向量。

> 两个向量越相似，他们的点乘也就越大.

**Softmax函数:**
 
在Logistic regression二分类问题中，我们可以使用sigmoid函数将输入$Wx + b$映射到$(0,1)$区间中，从而得到属于某个类别的概率。将这个问题进行泛化，推广到多分类问题中，我们可以使用softmax函数，对输出的值归一化为概率值。

这里假设在进入softmax函数之前，已经有模型输出 $C$ 值，其中 $C$ 是要预测的类别数，模型可以是全连接网络的输出 $a$，其输出个数为 $C$，即输出为 $a\_{1}, a\_{2}, ..., a\_{C}$。

所以对每个样本，它属于类别ii的概率为： 

$$
y\_{i} = \frac{e^{a\_i}}{\sum\_{k=1}^{C}e^{a\_k}} \ \ \  \forall i \in 1...C
$$

通过上式可以保证 $\sum\_{i=1}^{C}y\_i = 1$，即属于各个类别的概率和为1。

> [Softmax函数与交叉熵](https://blog.csdn.net/behamcheung/article/details/71911133#softmax函数)

**小结：**

1. 最大似然估计 MLE
2. 最小化损失函数（与第一步等价），损失函数对数联合概率的相反数
3. 描述概率函数，该函数的自变量是词向量（u和v），词向量也是模型参数
4. 对第二步中每一项求梯度。有了梯度就可以优化第二步中的损失函数，从而迭代学习到模型参数，也就是词向量。（优化在第五课和第六课里讲了）

### 8.4 近似训练

- hierarchicam softmax
- negative sampling

## 9. fastText

FastText是一个快速文本分类算法，在使用标准多核CPU的情况下，在10分钟内可以对超过10亿个单词进行训练。 不需要使用预先训练好的词向量，因为FastText会自己训练词向量。

文本分类：

<img src="/images/nlp/fastText-3.webp" width="500" />

情感分类:

<img src="/images/nlp/fastText-4.webp" width="500" />

fastText 能够做到效果好，速度快，主要依靠两个秘密武器：

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


## 10. seq2seq

- [理论 seq2seq+Attention 机制模型详解](/2017/11/17/chatbot/chatbot-research8/)
- [TensorFlow学习笔记(3): tf.gradients计算导数和gradient clipping解决梯度爆炸/消失问题](https://zhuanlan.zhihu.com/p/38005390)


