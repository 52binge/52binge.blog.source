---
date: 2018-07-16 16:59:48
---

## NLP for tensorFlow

利用 RNN 来搭建 NLP 方面的一些经典应用，如 ： Language model、Machine translation

### 1. 语言模型的背景知识

语言模型是自然语言处理问题中一类最基本的问题，它有着非常广泛的应用。

- [1.1 Language model 介绍 / 评价方法 perplexity][0]

### 2. NNLM (神经语言模型)

- [2.1 PTB 数据集的预处理][0]

- [2.2 PTB 数据的 batching 方法][0]

- [2.3 RNN 的语言模型 TensorFlow 实现][0]

### 3. 神经网络机器翻译

- [3.1 机器翻译背景 与 Seq2Seq 模型介绍][0]

- [3.2 机器翻译文本数据的预处理][0]

- [3.3 Seq2Seq 模型 TF 实现][0]

## TensorFlow

TensorFlow 最初由 Google brain 的研究员和工程师开发出来，用于机器学习和神经网络方面的研究，2015.10 宣布开源.

TensorFlow 是一款神经网络的 Python 外部的结构包, 也是一个采用**数据流图**来进行数值计算的开源软件库.

### 1. TensorFlow 简介

- [1.1 TensorFlow Why ?][t1]

- [1.2 神经网络在干嘛 ?][t2]  

[t1]: /2018/01/22/tensorflow-1-1-why/
[t2]: /2018/08/24/tensorflow-1-2-NN-what-do/

### 2. Tensorflow 基础构架

- [2.1 处理结构][t2.1]

- [2.2 例子2][t2.2]

- [2.3 Session 会话控制][t2.3]

- [2.4 Variable 变量][t2.4]

- [2.5 Placeholder 传入值][t2.5]

- [2.6 什么是激励函数 (Activation Function)][t2.6]

- [2.7 激励函数 Activation Function][t2.7]

- [2.8 TensorFlow 基本用法总结][t2.8]

[t2.1]: /2018/08/24/tensorflow-2-1-structure/
[t2.2]: /2018/08/24/tensorflow-2-2-example2/
[t2.3]: /2018/09/06/tensorflow-2-3-session/
[t2.4]: /2018/09/07/tensorflow-2-4-variable/
[t2.5]: /2018/09/07/tensorflow-2-5-placeholde/
[t2.6]: /2018/09/07/tensorflow-2-6-A-activation-function/
[t2.7]: /2018/09/07/tensorflow-2-6-B-activation-function/
[t2.8]: /2018/09/08/tensorflow-2-8-tensorflow-basic-summary/

### 3. 建造我们第一个神经网络

- [3.1 例子3 添加层 def add_layer()][t3.1]

- [3.2 例子3 建造神经网络][t3.2]

- [3.3 例子3 结果可视化][t3.3]

- [3.4 加速神经网络训练 (Speed Up Training & Optimizer)][t3.4]

[t3.1]: /2018/09/09/tensorflow-3-1-add-layer/
[t3.2]: /2018/09/11/tensorflow-3-2-create-NN/
[t3.3]: /2018/09/11/tensorflow-3-3-visualize-result/
[t3.4]: /2018/09/12/tensorflow-3-4-A-speed-up-learning/

### 4. 可视化好助手 Tensorboard

- [4.1 Tensorboard 可视化好帮手 1][t4.1]

- [4.2 Tensorboard 可视化好帮手 2][t4.2]

[t4.1]: /2018/09/12/tensorflow-4-1-tensorboard1/
[t4.2]: /2018/09/12/tensorflow-4-2-tensorboard2/

## Keras

You have just found [Keras][k1]

[Keras][k1] 是一个用 Python 编写的高级神经网络 API，它能够以 `TensorFlow`, `CNTK`, 或者 `Theano` 作为后端运行。

[Keras][k2] 开发重点是支持快速的实验。能够以最小的时延把你的想法转换为实验结果，是做好研究的关键。 

[0]: /tensorflow
[k1]: https://keras.io/zh/
[k2]: https://keras.io/zh/models/about-keras-models/

## Python

Python 哲学就是简单优雅，尽量写容易看明白的代码，尽量写少的代码.

Python 数据分析模块: Numpy & Pandas, 及强大的画图工具 Matplotlib

- [Python](/python_language)

- [Numpy & Pandas](/python_numpy_pandas)

- [Matplotlib](/python_matplotlib)

## Scikit-Learn

Sklearn 机器学习领域当中最知名的 Python 模块之一 [why][sklearn0] 

- [1.1 : Sklearn Choosing The Right Estimator][sklearn1]

- [1.2 : Sklearn General Learning Model][sklearn2]

- [1.3 : Sklearn DataSets][sklearn3]

- [1.4 : Sklearn Common Attributes and Functions][sklearn4]

- [1.5 : Normalization][sklearn5]

- [1.6 : Cross-validation 1][sklearn6]

- [1.7 : Cross-validation 2][sklearn7]

- [1.8 : Cross-validation 3][sklearn8]

- [1.9 : Sklearn Save Model][sklearn9]

[sklearn0]: /2018/01/03/py-sklearn-0-why/
[sklearn1]: /2018/01/03/py-sklearn-1-choosing-estimator/
[sklearn2]: /2018/01/05/py-sklearn-2-general-learning-model/
[sklearn3]: /2018/01/03/py-sklearn-3-database/
[sklearn4]: /2018/01/05/py-sklearn-4-common-attributes/
[sklearn5]: /2018/01/06/py-sklearn-5-normalization/
[sklearn6]: /2018/01/08/py-sklearn-6-cross-validation-1/
[sklearn7]: /2018/01/09/py-sklearn-6-cross-validation-2/
[sklearn8]: /2018/01/09/py-sklearn-6-cross-validation-3/
[sklearn9]: /2018/01/10/py-sklearn-7-save-model/
