---
date: 2018-07-16 16:59:48
---

[0]: /tensorflow

## TensorFlow

TensorFlow 最初由 Google brain 的研究员和工程师开发出来，用于机器学习和神经网络方面的研究，2015.10 宣布开源.

TensorFlow 是一款神经网络的 Python 外部的结构包, 也是一个采用**数据流图**来进行数值计算的开源软件库.

### 5. TensorFlow Estimator

- [5.1 tf.contrib.learn 快速入门][t5.1]

- [5.2 tf.contrib.learn 构建输入函数][t5.2]

- [5.3 tf.contrib.learn 基础的记录和监控教程][t5.3]

- [5.4 tf.contrib.learn 创建 Estimator][t5.4]

[t5.1]: /2017/10/31/tensorflow/tf-5-1-contrib-learn-Quickstart/
[t5.2]: /2017/11/01/tensorflow/tf-5-2-contrib-learn-Input-fn/
[t5.3]: /2017/11/04/tensorflow/tf-5-3-contrib-learn-MonitorAPI/
[t5.4]: /2017/11/04/tensorflow/tf-5-4-contrib-learn-Estimator/

### 1. TensorFlow 简介

- [1.1 TensorFlow Why ?][t1] / [What does neural network do ?][t2]  

- [1.2 TensorFlow 快速学习 & 文档][t3]  

[t1]: /2018/01/22/tensorflow/tf-1-1-why/
[t2]: /2018/08/24/tensorflow/tf-1-2-NN-what-do/
[t3]: /2018/10/23/tensorflow/tf-doc/

### 2. Tensorflow 基础构架

- [2.1 处理结构: 计算图][t2.1]

- [2.2 完整步骤 例子2 🌰（创建数据、搭建模型、计算误差、传播误差、训练）][t2.2]

- [2.3 Session 会话控制][t2.3]

- [2.4 Variable 变量][t2.4]

- [2.5 Placeholder 传入值][t2.5]

- [2.6 什么是激励函数 (Activation Function)][t2.6]

- [2.7 激励函数 Activation Function][t2.7]

- [2.8 TensorFlow 基本用法总结 🌰🌰🌰][t2.8]

[t2.1]: /2018/08/24/tensorflow/tf-2-1-structure/
[t2.2]: /2018/08/24/tensorflow/tf-2-2-example2/
[t2.3]: /2018/09/06/tensorflow/tf-2-3-session/
[t2.4]: /2018/09/07/tensorflow/tf-2-4-variable/
[t2.5]: /2018/09/07/tensorflow/tf-2-5-placeholde/
[t2.6]: /2018/09/07/tensorflow/tf-2-6-A-activation-function/
[t2.7]: /2018/09/07/tensorflow/tf-2-6-B-activation-function/
[t2.8]: /2018/09/08/tensorflow/tf-2-8-tensorflow/tf-basic-summary/

### 3. 建造我们第一个神经网络

- [3.1 添加层 def add_layer()][t3.1]

- [3.2 建造神经网络 🌰🌰🌰][t3.2]

- [3.3 demo 结果可视化][t3.3]

- [3.4 Speed Up Training & Optimizer (转载自莫烦)][t3.4]

[t3.1]: /2018/09/09/tensorflow/tf-3-1-add-layer/
[t3.2]: /2018/09/11/tensorflow/tf-3-2-create-NN/
[t3.3]: /2018/09/11/tensorflow/tf-3-3-visualize-result/
[t3.4]: /2018/09/12/tensorflow/tf-3-4-A-speed-up-learning/

### 4. 可视化好助手 Tensorboard

- [4.1 Tensorboard 可视化好帮手 1][t4.1]

[t4.1]: /2018/09/12/tensorflow/tf-4-1-tensorboard1/

### 5. TensorFlow other link

- [5.1 TF 保存和加载模型][t5.1]

[t5.1]: https://www.jianshu.com/p/8850127ed25d

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

## Tensorflow NLP 基础知识

### 1. 语言模型的背景知识

语言模型是自然语言处理问题中一类最基本的问题，它有着非常广泛的应用。

- [1.1 Language model 介绍 / 评价方法 perplexity *not][0]

### 2. NNLM (神经语言模型)

- [2.1 PTB 数据集的预处理 *not][0]

- [2.2 PTB 数据的 batching 方法][9.2.2]

- [2.3 RNN 的语言模型 TensorFlow 实现][9.2.3]

[9.2.2]: /2018/10/01/tensorflow/tf-nlp-9.2.2/
[9.2.3]: /2018/10/02/tensorflow/tf-nlp-9.2.3/

### 3. 神经网络机器翻译

- [3.1 机器翻译背景 与 Seq2Seq 模型介绍][0]

- [3.2 机器翻译文本数据的预处理][0]

- [3.3 Seq2Seq 模型 TF 实现][0]

### 4. MNIST 数字识别问题

- [4.1 简单前馈网络实现 mnist 分类][minst1]

- [4.2 多层 CNNs 实现 mnist 分类][0]

- [4.3 name / variable_scope][minst3]

- [4.4 多层 LSTM 通俗易懂版][minst4]

[minst1]: /2018/09/12/tensorflow/tf-mnist-1-beginners/
[minst2]: 0
[minst3]: /2018/10/05/tensorflow/tf-name-variable_scope/
[minst4]: /2018/10/07/tensorflow/tf-simple-lstms/
