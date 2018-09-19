---
title: Improving Deep Neural Networks (week2) - Optimization Algorithm
toc: true
date: 2018-07-21 10:00:21
categories: deeplearning
tags: deeplearning.ai
mathjax: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

Mini-batch、指数加权平均-偏差修正、Momentum、RMSprop、Adam、学习率衰减、局部最优

这节课每一节的知识点都很重要，所以本次笔记几乎涵盖了全部小视频课程的记录

<!-- more -->


## 1. Mini-batch

> 随机梯度下降法的一大缺点是, 你会失去所有向量化带给你的加速，因为一次性只处理了一个样本，这样效率过于低下, 所以实践中最好 选择不大不小 的 Mini-batch 尺寸. 实际上学习率达到最快，你会发现2个好处，你得到了大量向量化，另一方面 你不需要等待整个训练集被处理完，你就可以开始进行后续工作.
> 
> 它不会总朝着最小值靠近，但它比随机梯度下降要更持续地靠近最小值的方向. 它也不一定在很小的范围内收敛，如出现这个问题，你可以减小 学习率.
> 
> 样本集比较小，就没必要使用 mini-batch.
> 
> **经验值** ： 如果 m <= 2000, 可以使用 batch， 不然样本数目 m 较大，一般 mini-batch 大小设置为 64 or 128 or.. or 512..

**算法初步**

> 对整个训练集进行梯度下降法的时候，我们必须处理整个训练数据集，然后才能进行一步梯度下降，即每一步梯度下降法需要对整个训练集进行一次处理，如果训练数据集很大的时候，如有 500万 或 5000万 的训练数据，处理速度就会比较慢。
>
> 但是如果每次处理训练数据的一部分即进行梯度下降法，则我们的算法速度会执行的更快。而处理的这些一小部分训练子集即称为 Mini-batch。

<img src="/images/deeplearning/C2W2-1_1.png" width="700" />

> 如图，以 1000 为单位，将数据划分，令 $x^{\\{1\\}}=\\{x^{(1)},x^{(2)}……x^{(1000)}\\}$, 一般用 $x^{ \\{ t \\} }$, $y^{ \\{t\\} }$ 表示划分后的 mini-batch.
> 
> 注意区分该系列教学视频的符号标记：
> - 小括号() 表示具体的某一个元素，指一个具体的值，例如 $x^{(i)}$
> - 中括号[] 表示神经网络中的某一层, 例如 $Z^{[l]}$
> - 大括号{} 表示将数据细分后的一个集合, 例如 $x^{\\{1\\}} = \\{x^{(1)},x^{(2)}……x^{(1000)}\\}$

**算法核心**

<img src="/images/deeplearning/C2W2-2_1.png" width="700" />

> 假设我们有 5,000,000 个数据，每 1000 作为一个集合，计入上面所提到的 $x^{\\{1\\}}=\\{x^{(1)},x^{(2)}……x^{(5000)}\\},……$

> 1. 需要迭代运行 5000次 神经网络运算.
> 2. 每一次迭代其实与之前笔记中所提到的计算过程一样，首先是前向传播，但是每次计算的数量是 1000.
> 3. 计算损失函数，如果有 Regularization ，则记得加上 Regularization Item
> 4. Backward propagation
> 
> 注意，mini-batch 相比于之前一次性计算所有数据不仅速度快，而且反向传播需要计算 5000次，所以效果也更好.

epoch

> - 对于普通的梯度下降法，一个 epoch 只能进行一次梯度下降；
> - 对于 Mini-batch 梯度下降法，一个 epoch 可以进行 Mini-batch 的个数次梯度下降;

> **epoch** : 当一个`完整的数据集`通过了神经网络一次并且返回了一次，这个过程称为一个 epoch。
> 
> 比如对于一个有 2000 个训练样本的数据集。将 2000 个样本分成大小为 500 的 batch，那么完成一个 epoch 需要 4 个 iteration。

### 不同 size 大小的比较

普通的 batch 梯度下降法 和 Mini-batch梯度下降法 代价函数的变化趋势，如下图所示：

<img src="/images/deeplearning/C2W2-3_1.png" width="700" />

**Batch梯度下降** （如下图中蓝色）:

> - 对所有 m 个训练样本执行一次梯度下降，每一次迭代时间较长；
> - Cost function 总是向减小的方向下降。

> 说明: mini-batch size = m，此时即为 Batch gradient descent $(x^{\{t\}},y^{\{t\}})=(X,Y)$

**随机梯度下降** （如下图中紫色）:

> -对每一个训练样本执行一次梯度下降，但是丢失了向量化带来的计算加速；
> - Cost function 总体的趋势向最小值的方向下降，但是无法到达全局最小值点，呈现波动的形式.

> 说明: mini-batch size = 1，此时即为 Stochastic gradient descent $(x^{\\{t\\}},y^{\\{t\\}})=(x^{(i)},y^{(i)})$

**Mini-batch梯度下降** （如下图中绿色）:

> - 选一个 $1<size<m$ 的合适的 size 进行 Mini-batch 梯度下降，可实现快速学习，也应用了向量化带来的好处
> - Cost function 的下降处于前两者之间

<img src="/images/deeplearning/C2W2-4_1.png" width="700" />

### Mini-batch 大小的选择

> - 如果训练样本的大小比较小时，如 $m⩽2000$ 时 — 选择 batch 梯度下降法；
> - 如果训练样本的大小比较大时，典型的大小为：$2^{6}、2^{7}、\cdots、2^{10}$
> - Mini-batch 的大小要符合 CPU/GPU 内存， 运算起来会更快一些.

## 2. Exponentially weighted averages

为了理解后面会提到的各种优化算法，我们需要用到指数加权平均，在统计学中也叫做指数加权移动平均.

指数加权平均的关键函数： 

$$
v\_{t} = \beta v\_{t-1}+(1-\beta)\theta\_{t}
$$

首先我们假设有一年的温度数据，如下图所示

<img src="/images/deeplearning/C2W2-5_0.jpg" width="500" />

我们现在需要计算出一个温度趋势曲线，计算方法(`指数加权平均实现`)如下：

$$
v\_{0} =0 \\\\
v\_{1}= \beta v\_{0}+(1-\beta)\theta\_{1} \\\\
v\_{2}= \beta v\_{1}+(1-\beta)\theta\_{2} \\\\
v\_{3}= \beta v\_{2}+(1-\beta)\theta\_{3} \\\\
\ldots
$$

> 上面的 $θ\_t$ 表示第 $t$ 天的温度，β 是可调节的参数，$V\_t$ 表示 $\frac{1}{1-β}$ 天的每日温度

<!--下图是一个关于天数和温度的散点图：
<img src="/images/deeplearning/C2W2-5_1.png" width="600" />
-->

### 当 β=0.9、0.98、0.5 的情况

当 β=0.9 时，指数加权平均最后的结果如下图中**红色**线所示；

<img src="/images/deeplearning/C2W2-5_2.jpg" width="600" />

当 β=0.98 时，指数加权平均最后的结果如下图中**绿色**线所示, 绿线相比较红线要平滑一些，是因为对过去温度的权重更大，所以当天天气温度的影响降低，在温度变化时，适应得更缓慢一些；

<img src="/images/deeplearning/C2W2-5_3.jpg" width="600" />

当 β=0.5 时，指数加权平均最后的结果如下图中**黄色**线所示；

<img src="/images/deeplearning/C2W2-5_4.jpg" width="600" />

<!--<img src="/images/deeplearning/C2W2-6_1.png" width="700" />
-->
>  Notes: The most common value for $\beta$ is 0.9.

### 理解指数加权平均

例子，当 β=0.9 时： 

$$
v\_{100} = 0.9v\_{99}+0.1\theta\_{100} \\\\ v\_{99} = 0.9v\_{98}+0.1\theta\_{99} \\\\ v\_{98} = 0.9v\_{97}+0.1\theta\_{98} \\\\
\ldots
$$

展开：

$$
v\_{100}=0.1\theta\_{100}+0.9(0.1\theta\_{99}+0.9(0.1\theta\_{98}+0.9v\_{97})) \\\\ v\_{100}=0.1\theta\_{100}+0.1\times0.9\theta\_{99}+0.1\times(0.9)^{2}\theta\_{98}+0.1\times(0.9)^{3}\theta\_{97}+\cdots
$$

上式中所有 $θ$ 前面的系数相加起来为 1 或者 接近于 1，称之为偏差修正.

> 总体来说存在，$(1-\varepsilon)^{1/\varepsilon}=\dfrac{1}{e}$, 在我们的例子中，$1-\varepsilon=\beta=0.9$, 即 $0.9^{10}\approx 0.35\approx\dfrac{1}{e}$ . 相当于大约10天后，系数的峰值（这里是0.1）下降到原来的 $\dfrac{1}{e}$，只关注了过去10天的天气.

### 指数加权平均的偏差修正 Bias correction

在我们执行指数加权平均的公式时，当 β=0.98 时，得到的并不是图中的**绿色**曲线，而是下图中的**紫色**曲线，其起点比较低。

<img src="/images/deeplearning/C2W2-7.png" width="650" />

**原因**： 

> $$
v\_{0}=0\\\\v\_{1}=0.98v\_{0}+0.02\theta\_{1}=0.02\theta\_{1}\\\\v\_{2}=0.98v\_{1}+0.02\theta\_{2}=0.98\times0.02\theta\_{1}+0.02\theta\_{2}=0.0196\theta\_{1}+0.02\theta\_{2}
$$

> 如果第一天的值为如40，则得到的 v1=0.02×40=0.8，则得到的值要远小于实际值，后面几天的情况也会由于初值引起的影响，均低于实际均值.

**偏差修正**： 

> 使用 $\dfrac{v\_{t}}{1-\beta^{t}}$

> - 当 t=2 时：

> $$
1-\beta^{t}=1-(0.98)^{2}=0.0396
$$

> $$
\dfrac{v\_{2}}{0.0396}=\dfrac{0.0196\theta\_{1}+0.02\theta\_{2}}{0.0396}
$$
> 
> 偏差修正得到了绿色的曲线，在开始的时候，能够得到比紫色曲线更好的计算平均的效果。随着 t 逐渐增大，$\beta^{t}$ 接近于 0，所以后面绿色的曲线和紫色的曲线逐渐重合了.
>
> 虽然存在这种问题，但是在实际过程中，一般会忽略前期均值偏差的影响

**偏差修正 举个🌰, 以便于大家理解:**

> 首先我们假设的是 $β=0.98, V\_0=0$, 然后由 $V\_t=βV\_{t-1}+(1-β)θ\_t$ 可知
>
> - $V\_1=0.98V\_0+0.02θ\_1=0.02θ\_1$
>
> - $V\_2=0.98V\_1+0.02θ\_2=0.0196θ\_1+0.02θ\_2$
>
> 当进行指数加权平均计算时，第一个值 $v\_0$ 被初始化为 0，这样将在前期的运算用产生一定的偏差。为了矫正偏差，需要在每一次迭代后进行偏差修正（Bias Correction）
> 
> 假设 $θ\_1=40℃$,那么 $V\_1=0.02*40=0.8℃$，这显然相差太大，同理对于后面的温度的计算也只会是变差越来越大. 所以我们需要进行偏差修正，具体方法如下：
>
> $$
V\_t=\frac{βV\_{t-1}+(1-β)θ\_t}{1-β^t}
$$
>
> 注意 ：！！！上面公式中的 $V\_{t-1}$ 是未修正的值.
> 
> 为方便说明，令 $β=0.98,θ\_1=40℃,θ\_2=39℃$, 则
> 
> - 当 $t=1,θ\_1=40℃$ 时，$V\_1=\frac{0.02*40}{1-0.98}=40$ ,哇哦, 有没有很巧的感觉，再看
> - 当 $t=2,θ\_2=39℃$ 时，$V\_2 = \frac{0.98\*V\_{t-1} + 0.02\*θ\_2}{1-0.98^2}$ $=\frac{0.98\*(0 + 0.02\*θ\_1)+0.02\*39}{1-0.98^2}=39.49$
> 
> `注意点` : 所以，**记住你如果直接用修正后的 $V\_{t−1}$ 值代入计算就大错特错了**.

## 3. Momentum

动量梯度下降的基本思想就是`计算梯度的指数加权平均数`，并利用该梯度来更新权重

### Momentum 解释版

通常情况我们在训练深度神经网络的时候把数据拆解成一小批一小批地进行训练，这就是我们常用的 mini-batch SGD 训练算法，然而虽然这种算法能够带来很好的训练速度，但是在到达最优点的时候并不能够总是真正到达最优点，而是在最优点附近徘徊。另一个缺点就是这种算法需要我们挑选一个合适的学习率，当我们采用小的学习率的时候，会导致网络在训练的时候收敛太慢；当我们采用大的学习率的时候，会导致在训练过程中优化的幅度跳过函数的范围，也就是可能跳过最优点。我们所希望的仅仅是网络在优化的时候网络的损失函数有一个很好的收敛速度同时又不至于摆动幅度太大。

所以 Momentum 优化器 刚好可以解决我们所面临的问题，它主要是基于梯度的移动指数加权平均。假设在当前的迭代步骤第 t 步中，那么基于 Momentum 优化算法 可以写成下面的公式： 

$$
{v\_\{dw\}} = \beta {v\_\{dw\}} + (1 - \beta )dW \\\\ {v\_{db}} = \beta {v\_{db}} + (1 - \beta )db \\\\ W = W - \alpha {v\_{dw}} \\\\ b = b - \alpha {v\_{db}}
$$

> [引用知乎机器学习小菜鸟的流水账][7] ：
>
> 动量梯度下降与梯度下降相比，就是对梯度使用指数加权平均，其他的都保存一致。
> 
> dw 与 db 表示本次迭代的梯度，Vdw 和 Vdb 表示指数加权平均的梯度。
> 
> 如果不用指数加权平均的话，每次迭代更新使用的梯度都只与本次迭代的样本有关，每次迭代的样本有好有坏，会使迭代接近最小值的不断波动，导致下降速度慢。加入指数加权平均后，本次梯度影响减少，波动情况也就会减小，直观上面理解就是左右波动抵消，那么下降速度也就自然更快。动量梯度下降比梯度下降收敛速度要快。
> 
> 物理意义理解：在下降的过程中， $(1 - \beta )dW$ 相当于加速度， $\beta {v\_\{dw\}}$ 相当于摩擦，加速度可以是下降加快，而摩擦不会让加速一直进行下去。（不是很理解）


---

> 在上面的公式中 ${v\_{dw}}$ 和 ${v\_{db}}$ 分别是损失函数在前 $t−1$ 轮迭代过程中累积的梯度梯度动量，$\beta$ 是梯度累积的一个指数，这里我们一般设置值为 0.9。所以 Momentum 优化器 的主要思想就是利用了类似与移动指数加权平均的方法来对网络的参数进行平滑处理的，让梯度的摆动幅度变得更小。 
>
> dW 和 db 分别是损失函数反向传播时候所求得的梯度，下面两个公式是网络权重向量和偏置向量的更新公式，α 是网络的学习率。当我们使用 Momentum优化算法的时候，可以解决 mini-batch SGD 优化算法更新幅度摆动大的问题，同时可以使得网络的收敛速度更快。

### Momentum 详细版

在我们优化 Cost function 的时候，以下图所示的函数图为例：

首先介绍一下一般的梯度算法收敛情况是这样的

<img src="/images/deeplearning/C2W2-8_1.png" width="750" />

> 可以看到，在前进的道路上十分曲折，走了不少弯路，在纵向我们希望走得慢一点，横向则希望走得快一点，所以才有了动量梯度下降算法.

**Momentum算法的第 t 次迭代：**

> - 计算出 dw, db
> - 这个计算式子与上一届提到的指数加权平均有点类似，即
> $ V\_{dw}=βV\_{dw}+(1-β)dw \\\\ V\_{db}=βV\_{db}+(1-β)db $
> - $W=W-αV\_{dw},b=b-αV\_{db}$

<img src="/images/deeplearning/C2W2-10_1.png" width="600" />

最终得到收敛的效果如下图的红色曲线所示.

<img src="/images/deeplearning/C2W2-9_1.png" width="750" />

在利用梯度下降法来最小化该函数的时候，每一次迭代所更新的代价函数值如图中蓝色线所示在上下波动，而这种幅度比较大波动，减缓了梯度下降的速度，而且我们只能使用一个较小的学习率来进行迭代.

如果用较大的学习率，结果可能会如紫色线一样偏离函数的范围，所以为了避免这种情况，只能用较小的学习率.

> 该算法中涉及到的超参数有两个，分别是 α，β，其中一般 β=0.9 是比较常取的值
>
> - 一般将参数设为 0.5, 0.9，或者 0.99，分别表示最大速度 2倍，10倍，100倍 于 SGD 的算法;
> - 通过速度v，来积累了之间梯度指数级衰减的平均，并且继续延该方向移动;

再看看算法： 

<img src="/images/deeplearning/C2W2-11.png" width="700" />

## 4. RMSprop (Root Mean Square Prop)

RMSProp 算法的全称叫 Root Mean Square Prop，是 Geoffrey E. Hinton 在 Coursera 课程中提出的一种优化算法，在上面的 Momentum 优化算法中，虽然初步解决了优化中摆动幅度大的问题。所谓的摆动幅度就是在优化中经过更新之后参数的变化范围，如下图所示，**蓝色的为 Momentum 优化算法所走的路线**，**绿色的为 RMSProp 优化算法所走的路线**。

<img src="/images/deeplearning/C2W2-12_1.png" width="700" />

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

> 这样做，能给保留微分平方的加权平均数
>
> 算法的主要思想就用上面的公式表达完毕了。在上面的公式中 ${s\_{dw}}$ 和 ${s\_{db}}$ 分别是损失函数在前 t−1 轮迭代过程中累积的梯度梯度动量，β 是梯度累积的一个指数。所不同的是，RMSProp 算法对梯度计算了**微分平方加权平均数**。这种做法有利于消除了摆动幅度大的方向，用来修正摆动幅度，使得各个维度的摆动幅度都较小。另一方面也使得网络函数收敛更快。（比如当 dW 或者 db 中有一个值比较大的时候，那么我们在更新权重或者偏置的时候除以它之前累积的梯度的平方根，这样就可以使得更新幅度变小）。为了防止分母为零，使用了一个很小的数值 $\epsilon$ 来进行平滑，一般取值为 $10^{-8}$。

## 5. Adam (Adaptive Moment Estimation)

有了上面两种优化算法，一种可以使用类似于物理中的动量来累积梯度，另一种可以使得收敛速度更快同时使得波动的幅度更小。那么讲两种算法结合起来所取得的表现一定会更好。Adam（Adaptive Moment Estimation）算法是将Momentum算法和RMSProp算法结合起来使用的一种算法，我们所使用的参数基本和上面讲的一致，在训练的最开始我们需要初始化梯度的累积量和平方累积量。 

$$
{v\_{dw}} = 0,{v\_{db}} = 0;{s\_{dw}} = 0,{s\_{db}} = 0
$$

假设在训练的第 $t$ 轮训练中，我们首先可以计算得到 Momentum 和 RMSProp 的参数更新： 

$$
{v\_{dw}} = {\beta \_1}{v\_{dw}} + (1 - {\beta \_1})dW \\\\
{v\_{db}} = {\beta \_1}{v\_{db}} + (1 - {\beta \_1})db \\\\
{s\_{dw}} = {\beta \_2}{s\_{dw}} + (1 - {\beta \_2})d{W^2} \\\\
{s\_{db}} = {\beta \_2}{s\_{db}} + (1 - {\beta \_2})d{b^2} \\\\
$$

由于移动指数平均在迭代开始的初期会导致和开始的值有较大的差异，所以我们需要对上面求得的几个值做偏差修正

$$
v\_{dw}^c = \frac {v\_{dw}} {1 - \beta \_1^t} \\\\
v\_{db}^c = \frac {v\_{db}} {1 - \beta \_1^t} \\\\
s\_{dw}^c = \frac {s\_{dw}} {1 - \beta \_2^t} \\\\
s\_{db}^c = \frac {s\_{db}} {1 - \beta \_2^t}
$$

通过上面的公式，我们就可以求得在第 $t$ 轮迭代过程中，参数梯度累积量的修正值，从而接下来就可以根据 Momentum 和 RMSProp 算法的结合来对权重和偏置进行更新.

$$
W = W - \alpha \frac {v\_{dw}^c} {\sqrt {s\_{dw}^c}  + \varepsilon } \\\\
b = b - \alpha \frac {v\_{db}^c} {\sqrt {s\_{db}^c}  + \varepsilon }
$$

上面的所有步骤就是Momentum算法和RMSProp算法结合起来从而形成Adam算法。在Adam算法中，参数 ${\beta\_1}$ 所对应的就是Momentum算法中的 ${\beta}$ 值，一般取0.9，参数 ${\beta\_2}$ 所对应的就是RMSProp算法中的 ${\beta}$ 值，一般我们取0.999，而 $\epsilon$ 是一个平滑项，我们一般取值为 ${10^{ - 8}}$，而学习率 $\alpha$ 则需要我们在训练的时候进行微调。

> 通过上面的三个算法基本讲述了神经网络中的优化器，理解了这三个算法其他的算法也就引刃而解了.
> 
> Adam 优化算法 我会毫不犹豫的推荐给你， 它是 Momentum 和 RMSprop 的结合. 事实证明，它其实解决了很多问题. 
> 
> Adam 中的超参数 ${\beta\_1}$ 、${\beta\_2}$  一般不需要调整，业内经常很少有人会调整他们.  $\epsilon$ 是一个平滑项，一般取值为 ${10^{ - 8}}$, 基本更不需要调整.

Adaptive Moment Estimation

> ${\beta\_1}$ 用于计算这个微分 (computing the mean of the derivatives, this is called the first moment).
> 
> ${\beta\_2}$ 用于计算平方数的指数加权平均数 (compute exponentially weighted average of the squares. this is called the second moment)
> 
> So that gives rise to the name `Adaptive Moment Estimation`.

## 6. Learning rate decay

之前算法中提到的学习率α都是一个常数，这样有可能会一个问题，就是刚开始收敛速度刚刚好，可是在后面收敛过程中学习率偏大，导致不能完全收敛，而是在最低点来回波动。所以为了解决这个问题，需要让学习率能够随着迭代次数的增加进行衰减，常见的计算公式有如下几种:

$$
α = \frac {1} {1+decay\_rate*epoch\_num} α_0
$$

> 对我而言，学习率衰减并不是我尝试的要点, 设置一个固定的 α， 然后好好调整，会有很大影响， 学习率衰减的确大有裨益, 有时候它可以加快训练, 但这并不是我会率先尝试的内容. 下周我们会重点介绍 如何管理和高效搜索 超参数.
> 
> For me，I would say that learning rate decay usually lower down on the list of things I try. learning rate decay does help. Sometimes it can really help speed up training. it is a little bit lower down my list in terms of the thingsI would try.

## Reference

- [网易云课堂 - deeplearning][1]
- [深度学习笔记：优化方法总结(BGD,SGD,Momentum,AdaGrad,RMSProp,Adam)][2]
- [Deep Learning 之 最优化方法][3]
- [深度学习优化算法解析(Momentum, RMSProp, Adam)][4]
- [机器之心 - 神经网络训练中，傻傻分不清Epoch、Batch Size和迭代][6]

[1]: https://study.163.com/my#/smarts
[2]: https://blog.csdn.net/u014595019/article/details/52989301
[3]: https://blog.csdn.net/BVL10101111/article/details/72614711
[4]: https://blog.csdn.net/willduan1/article/details/78070086
[5]: http://www.cnblogs.com/marsggbo/
[6]: https://www.jiqizhixin.com/articles/2017-09-25-3
[7]: https://zhuanlan.zhihu.com/p/30743067


