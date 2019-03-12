---
date: 2018-07-16 16:59:48
---

TensorFlow 用于机器学习和神经网络方面的研究，采用**数据流图**来进行数值计算的开源软件库.

[Keras][k2] 开发重点是支持快速的实验。能够以最小的时延把你的想法转换为实验结果，是做好研究的关键。 

[0]: /tensorflow
[k1]: https://keras.io/zh/
[k2]: https://keras.io/zh/models/about-keras-models/

### 1. TensorFlow 简介

- [1.1 TensorFlow Why ?][t1]

- [1.2 TensorFlow 快速学习 & 文档][t2]  

[t1]: /2017/08/22/tensorflow/tf-1.1-why/
[t2]: /2017/10/23/tensorflow/tf-doc/

### 2. Tensorflow 基础构架

- [2.1 处理结构: 计算图][t2.1]

- [2.2 完整步骤 例子2 🌰（创建数据、搭建模型、计算误差、传播误差、训练）][t2.2]

- [2.3 Session 会话控制][t2.3]

- [2.4 Variable 变量][t2.4]

- [2.5 Placeholder 传入值][t2.5]

- [2.6 什么是激励函数 (Activation Function)][t2.6]

- [2.7 激励函数 Activation Function][t2.7]

- [2.8 TensorFlow 基本用法总结 🌰🌰🌰][t2.8]

[t2.1]: /2017/08/25/tensorflow/tf-2.1-structure/
[t2.2]: /2017/08/27/tensorflow/tf-2.2-example/
[t2.3]: /2017/08/28/tensorflow/tf-2.3-session/
[t2.4]: /2017/08/29/tensorflow/tf-2.4-variable/
[t2.5]: /2017/08/30/tensorflow/tf-2.5-placeholde/
[t2.6]: /2017/09/07/tensorflow/tf-2.6-A-activation-function/
[t2.7]: /2017/09/07/tensorflow/tf-2.6-B-activation-function/
[t2.8]: /2017/09/08/tensorflow/tf-2.8-tensorflow-basic-summary/

### 3. 建造我们第一个神经网络

- [3.1 添加层 def add_layer()][t3.1]

- [3.2 建造神经网络 🌰🌰🌰][t3.2]

- [3.3 Speed Up Training & Optimizer (转载自莫烦)][t3.3]

[t3.1]: /2017/09/09/tensorflow/tf-3.1-add-layer/
[t3.2]: /2017/09/11/tensorflow/tf-3.2-create-NN/
[t3.3]: /2017/09/12/tensorflow/tf-3.3-A-speed-up-learning/

### 4. Tensorboard

- [4.1 Tensorboard 可视化好帮手 1][t4.1]

[t4.1]: /2017/09/12/tensorflow/tf-4.1-tensorboard1/

### 5. Estimator

- [5.1 tf.contrib.learn 快速入门][t5.1]

- [5.2 tf.contrib.learn 构建输入函数][t5.2]

- [5.3 tf.contrib.learn 基础的记录和监控教程][t5.3]

- [5.4 tf.contrib.learn 创建 Estimator][t5.4]

- [5.5 TF 保存和加载模型 - 简书][t5.5]

[t5.1]: /2018/10/31/tensorflow/tf-5.1-contrib-learn-Quickstart/
[t5.2]: /2018/11/01/tensorflow/tf-5.2-contrib-learn-Input-fn/
[t5.3]: /2018/11/04/tensorflow/tf-5.3-contrib-learn-MonitorAPI/
[t5.4]: /2018/11/04/tensorflow/tf-5.4-contrib-learn-Estimator/
[t5.5]: https://www.jianshu.com/p/8850127ed25d

### 1. Language model 介绍 

语言模型是自然语言处理问题中一类最基本的问题，它有着非常广泛的应用。

- [1.1 RNN 循环神经网络 简介][8.1]

- [1.2 LSTM & Bi-RNN & Deep RNN][8.2]

- [1.3 Language model 介绍 / 评价方法 perplexity (not finish)][0]

[8.1]: /2018/11/08/tensorflow/tf-google-8-rnn-1/
[8.2]: /2018/11/10/tensorflow/tf-google-8-rnn-2/

### 2. NNLM (神经语言模型)

- [2.2 PTB 数据的 batching 方法][9.2.2]

- [2.3 RNN 的语言模型 TensorFlow 实现][9.2.3]

[9.2.2]: /2018/10/01/tensorflow/tf-nlp-9.2.2/
[9.2.3]: /2018/10/02/tensorflow/tf-nlp-9.2.3/

### 3. MNIST 数字识别问题

- [3.1 简单前馈网络实现 mnist 分类][minst1]

- [3.2 多层 CNNs 实现 mnist 分类, not finish][0]

- [3.3 name / variable_scope][minst3]

- [3.4 多层 LSTM 通俗易懂版][minst4]

[minst1]: /2018/10/04/tensorflow/tf-mnist-1-beginners/
[minst3]: /2017/10/05/tensorflow/tf-4.3-name-variable_scope/
[minst4]: /2017/10/07/tensorflow/tf-simple-lstms/

[0]: /tensorflow

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

[sklearn0]: /2018/01/03/python/py-sklearn-0-why/
[sklearn1]: /2018/01/03/python/py-sklearn-1-choosing-estimator/
[sklearn2]: /2018/01/05/python/py-sklearn-2-general-learning-model/
[sklearn3]: /2018/01/03/python/py-sklearn-3-database/
[sklearn4]: /2018/01/05/python/py-sklearn-4-common-attributes/
[sklearn5]: /2018/01/06/python/py-sklearn-5-normalization/
[sklearn6]: /2018/01/08/python/py-sklearn-6-cross-validation-1/
[sklearn7]: /2018/01/09/python/py-sklearn-6-cross-validation-2/
[sklearn8]: /2018/01/09/python/py-sklearn-6-cross-validation-3/
[sklearn9]: /2018/01/10/python/py-sklearn-7-save-model/
