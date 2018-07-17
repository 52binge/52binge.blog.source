---
title: Neural Networks and Deep Learning (week2)
toc: true
date: 2018-07-07 09:55:21
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

本周我们将要学习 Logistic Regression, 它是神经网络的基础. 

Logistic Regression 可以看成是一种只有输入层和输出层(没有隐藏层)的神经网络. 

我们将使用 **Python** 来实现一个这样的模型, 并将其应用在 **cat** 和 **non-cat** 的图像识别上.

<!-- more -->

<!--## Binary Classification
-->
<!--<img src="/images/deeplearning/C1W2-1.jpg" width="750" />

<img src="/images/deeplearning/C1W2-2.jpg" width="750" />
-->
## 一. 基本概念回顾

这次Andrew出的系列课程在符号上有所改动(和机器学习课程中的行列有所区别, 主要是为了后面代码实现方便), 如下图所示.

<img src="/images/deeplearning/C1W2-3_1.jpg" width="700" />

更多关于本系列课程的符号点[这里][2]同样地, 参数也有所变化(bias 单独拿出来作为$b$, 而不是添加 $\theta\_0$)

<!-- more -->

## 1. Notation

更多关于本系列课程的符号点[这里][1]同样地, 参数也有所变化($bias$ 单独拿出来作为$b$, 而不是添加 $\theta\_0$

## 2. Logistic Regression

<img src="/images/deeplearning/C1W2-4_1.jpg" width="750" />

 - 一个是 **Loss function**, 即损失函数, 它代表了对于一个样本估计值与真实值之间的误差; 
 - 一个是 **Cost function**, 它代表了所有样本loss的平均值.

<img src="/images/deeplearning/C1W2-6_1.jpg" width="750" />

## 3. Logistic Regression Cost Function

<img src="/images/deeplearning/C1W2-8_1.jpg" width="750" />

## 4. Gradient Descent

<img src="/images/deeplearning/C1W2-9_1.jpg" width="750" />

<img src="/images/deeplearning/C1W2-10_1.jpg" width="750" />

## 5. Derivatives

<img src="/images/deeplearning/C1W2-11_1.png" width="750" />

<img src="/images/deeplearning/C1W2-12_1.png" width="750" />

## 7. Computation Graph

神经网络中, forward propagation 用来计算输出, backward propagation 用来计算梯度, 得到梯度后就可更新对应的参数了. 

<img src="/images/deeplearning/C1W2-13_1.jpg" width="750" />

如上图所示通过前向传播, 我们得到 $J = 33$. 

> 这里说明一下, 在后面代码实现中, 这些导数都可以用 $dvar$ 来表示, 例如 dw1, db1 等等.

## 8. Computation Graph Derivatives

反向传播本质上就是通过链式法则不断求出前面各个变量的导数的过程.

<img src="/images/deeplearning/C1W2-14_1.png" width="750" />

## 9. Logistic regression recap

有了计算图的概念之后, 我们将其运用到 Logistic Regression 上. 

<img src="/images/deeplearning/C1W2-16_1.png" width="700" />

上面的式子可以用下面的计算图来表达:

<img src="/images/deeplearning/C1W2-16_2.png" width="700" />

有了上面的图之后, 我们现在来计算反向传播.

首先我们来计算 $\frac{dL}{da}$:

$$
\begin{align} \frac{dL}{da} & = - (\frac{y}{a} - \frac{(1-y)}{(1-a)}) \end{align}
$$

通过链式法则, 计算 $\frac{dL}{dz}$:

$$
\begin{align} \frac{dL}{dz} & = \frac{dL}{da}\frac{da}{dz} \\\\ \\\\ & = - (\frac{y}{a} - \frac{(1-y)}{(1-a)})\sigma(z)(1-\sigma(z)) \\\\ \\\\ & = - (\frac{y}{a} - \frac{(1-y)}{(1-a)})a(1-a)) \\\\ \\\\ & = -y(1-a) + (1-y)a \\\\ \\\\ & = a - y \end{align}
$$

最后计算 $\frac{dL}{dw1}, \frac{dL}{dw2}, \frac{dL}{db}$:

$$
\frac{dL}{dw\_1} = \frac{dL}{dz}\frac{dz}{dw\_1} = (a - y)x\_1
$$

$$
\frac{dL}{dw\_2} = \frac{dL}{dz}\frac{dz}{dw\_2} = (a - y)x\_2
$$

$$
\frac{dL}{db} = \frac{dL}{dz}\frac{dz}{db} = a - y
$$

怎么样? 是不是很简单呢? 这里我们所有的计算都是针对一个训练样本的. 当然我们不可能只有一个样本, 那么对于整个训练集, 我们应该怎么做呢? 其实很简单, 我们只需要将 $J(w, b)$ 拆开来写就很清晰.

$$
J(w, b) = \frac{1}{m}(L(a^{(1)}, y^{(1)}) + L(a^{(2)}, y^{(2)}) + … + L(a^{(m)}, y^{m)}))
$$

<img src="/images/deeplearning/C1W2-17_1.jpg" width="750" />

对于每一个样本都有一个对应的 $dz^{(i)}$, 而对于 $dw, db$ 来说是对于所有求平均.

<img src="/images/deeplearning/C1W2-18_1.png" width="750" />

> 如果用以上节的伪代码来实现梯度计算的话, 效率会非常低. 需要两个显式的 for 循环.
> 下一节介绍 向量化. 向量化就是用来解决计算效率问题. 

## 11. Vectorization

这次的深度学习系列课程作业, 一律要求使用向量化来实现代码. 配合强大的Numpy, 向量化其实很简单. 来看一个例子:

```python
import numpy as np
import time

x = 1000000
#x = 10

a = np.random.rand(x)
b = np.random.rand(x)

tic = time.time() # Python time time() 返回当前时间的时间戳（1970纪元后经过的浮点秒数）

c = np.dot(a, b)
toc = time.time()

print('Vectorized version:{}ms'.format(1000*(toc-tic)))

c = 0
tic = time.time()
for i in range(x):
    c += a[i] * b[i]
toc = time.time()

print('For loop:{}ms'.format(1000*(toc-tic)))
```

输出:

```python
Vectorized version:0.881195068359375ms
For loop:363.94405364990234ms
```

> 两个版本效率上差了400多倍. 神经网络本身计算就比较复杂, 加之深度学习训练样本往往都很大, 效率尤为重要. 任何时候都要尽可能避免使用for循环.

首先我们进行第一步优化, 将 $w$ 写成向量的形式 $dw=np.zeros((n\_x, 1))$, 这样就省去了内层关于 $w$ 的循环.

<img src="/images/deeplearning/C1W2-19_1.png" width="750" />

接下来我们来看看如何优化关于$m$个训练样本的循环. 回顾下第一节中所说的$X$:

<img src="/images/deeplearning/C1W2-3_1.jpg" width="600" />

> 将$X$用如上的矩阵表达后, 通过 $W^T+b$ 也就得到了 $z$ 的向量化表达. $a$ 的向量化表达也就是 $z$ 每个元素进行 $\sigma$操作了.
简单吧. 想要把握住向量化一定要清楚每个变量的维度(即python代码里ndarray的shape), 那些是**矩阵操作**, 那些是**element-wise**操作等等. 

> 把握住上面的之后, 在代码实现里还要注意哪里会产生 `broadcasting`. 例如这里的 $b$ 实际上是一个scalar, 但在进行 $W^T+b$ 操作的时候, $b$ 被numpy自动`broadcasting` 成和 $W^T$ 维度一样的横向量.

<img src="/images/deeplearning/C1W2-20_1.png" width="750" />

> 接下来我们看一下梯度的向量化. 前面我们知道 $dz^{(1)}, dz^{(2)}, …, dz^{(m)}$, 这样得到 $dZ$ .

> $A$、$Y$ 的向量化前面已知了，这样关于 $z$ 的梯度如下所示. 有了 $dZ$之后 $db$ 就很简单了, 它是所有 $dZ$ 中元素的均值. 在python中的代码表示为 `np.mean(dZ)` 或者 `1/m * np.sum(a)`. $dW$ 通过观察向量的维度得到. $X$ 为 $(n, m)$, $dZ$ 为 $(1, m)$, 而 $dW$ 的维度和 $W$ 的维度一样为 $(n,1)$, 这样就得到了 $dW=\frac{1}{m}XdZ^T$.
>
> db 是一个均值？

<img src="/images/deeplearning/C1W2-21_1.png" width="750" />

通过上面的努力, 我们将之前for循环的版本改成了完全向量化的表示, 这样向量化实现的代码效率会大大提高. 

> (注意: ppt里的for iter in range(1000) 是迭代次数, 这个循环是不可避免的)

<img src="/images/deeplearning/C1W2-22_1.png" width="750" />

## 使用Python实现Logistic Regression进行猫咪识别

LogisticRegression.py:

```python
def sigmoid(z):
    return 1. / (1.+np.exp(-z))

class LogisticRegression():
    def __init__(self):
        pass

    def __parameters_initializer(self, input_size):
        # initial parameters with zeros
        w = np.zeros((input_size, 1), dtype=float)
        b = 0.0
        return w, b

    def __forward_propagation(self, X):
        m = X.shape[1]
        A = sigmoid(np.dot(self.w.T, X) + self.b)
        return A

    def __compute_cost(self, A, Y):
        m = A.shape[1]
        cost = -np.sum(Y*np.log(A) + (1-Y)*(np.log(1-A))) / m
        return cost

    def cost_function(self, X, Y):
        # use the result from forward propagation and the label Y to compute cost
        A = self.__forward_propagation(X)
        cost = self.__compute_cost(A, Y)
        return cost

    def __backward_propagation(self, A, X, Y):
        m = X.shape[1]
        # backward propagation computes gradients
        dw = np.dot(X, (A-Y).T) / m
        db = np.sum(A-Y) / m
        grads = {"dw": dw, "db": db}
        return grads

    def __update_parameters(self, grads, learning_rate):
        self.w -= learning_rate * grads['dw']
        self.b -= learning_rate * grads['db']

    def fit(self, X, Y, num_iterations, learning_rate, print_cost=False, print_num=100):
        self.w, self.b = self.__parameters_initializer(X.shape[0])
        for i in range(num_iterations):
            # forward_propagation
            A = self.__forward_propagation(X)
            # compute cost
            cost = self.__compute_cost(A, Y)
            # backward_propagation
            grads = self.__backward_propagation(A, X, Y)
            dw = grads["dw"]
            db = grads["db"]
            # update parameters
            self.__update_parameters(grads, learning_rate)
            # print cost
            if i % print_num == 0 and print_cost:
                print ("Cost after iteration {}: {:.6f}".format(i, cost))
        return self

    def predict_prob(self, X):
        # result of forward_propagation is the probability
        A = self.__forward_propagation(X)
        return A

    def predict(self, X, threshold=0.5):
        pred_prob = self.predict_prob(X)
        threshold_func = np.vectorize(lambda x: 1 if x > threshold else 0)
        Y_prediction = threshold_func(pred_prob)
        return Y_prediction
	
     // 分类准确率分数是指所有分类正确的百分比, 分类准确率这一衡量分类器的标准比较容易理解
    def accuracy_score(self, X, Y):
        pred = self.predict(X)
        return len(Y[pred == Y]) / Y.shape[1]
```


本周课程剩下部分四个视频分别讲解Broadcasting, Numpy Vector, Jupyter Notebook以及Logistic Regression的概率解释. 如果对于Numpy以及Jupyter Notebook不熟悉的同学需要好好看看这三个视频

**Python Broadcasting example:**

<img src="/images/deeplearning/C1W2-23_1.png" width="500" />

> Notes: 多使用 reshape 来保证你用的向量或矩阵是正确的，不要害怕使用 reshape.

<img src="/images/deeplearning/C1W2-24_1.png" width="400" />

> Notes: 多使用 assert(a.shape == (5,1)) 
> 
## 本周内容回顾

- 了解了深度学习系列课程中使用到的各种符号.
- 回顾了Logistic Regression.
- 掌握了loss和cost的区别与联系.
- 重新认识了前向反向传播, 即计算图.
- 学习了深度学习中必要的求导知识.
- 熟悉了Numpy, Jupyter Notebook的使用
- 掌握了使用Python以神经网络的方式实现Logistic Regression模型, 并使用强大的Numpy来向量化.

## Reference

- [网易云课堂 - deeplearning][3]
- [deeplearning.ai 专项课程一第二周][2]
- [向量点乘（内积）和叉乘（外积、向量积）概念及几何意义解读][4]
- [CPU会被GPU替代吗？SIMD和SIMT谁更好？][6]
- [刘建平Pinard - 梯度下降（Gradient Descent）小结][7]
- [Github 01-Neural-Networks-and-Deep-Learning/week2][5]

[1]: http://7xrrje.com1.z0.glb.clouddn.com/deeplearningnotation.pdf
[2]: http://daniellaah.github.io/2017/deeplearning-ai-Neural-Networks-and-Deep-Learning-week2.html
[3]: https://study.163.com/my#/smarts
[4]: https://blog.csdn.net/dcrmg/article/details/52416832
[5]: https://github.com/daniellaah/deeplearning.ai-step-by-step-guide/tree/master/01-Neural-Networks-and-Deep-Learning/week2
[6]: https://zhuanlan.zhihu.com/p/31914064
[7]: https://www.cnblogs.com/pinard/p/5970503.html
