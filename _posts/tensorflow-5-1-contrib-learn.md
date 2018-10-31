---
title: TensorFlow - tf.contrib.learn 快速入门
toc: true
date: 2020-10-31 16:10:21
categories: python
tags: tensorflow
---

TensorFlow 的高级机器学习API（tf.contrib.learn）可以轻松配置，训练和评估各种机器学习模型。

使用tf.contrib.learn构建 神经网络 分类器并在**Iris**数据集上进行训练. 基于花萼/花瓣几何形状来预测花种。

<!-- more --> 

依照以下五个步骤编写代码：

1. 将包含Iris训练/测试数据的CSV加载到TensorFlow数据集中
2. 构建神经网络分类器
3. 使用训练数据拟合模型
4. 评估模型的准确性
5. 分类新样本

## 1. 完整的神经网络源代码

```python
# -*- coding: UTF-8 -*-
import os
import urllib

import numpy as np
import tensorflow as tf

# Data sets
IRIS_TRAINING = "iris_training.csv"
IRIS_TRAINING_URL = "http://download.tensorflow.org/data/iris_training.csv"

IRIS_TEST = "iris_test.csv"
IRIS_TEST_URL = "http://download.tensorflow.org/data/iris_test.csv"

def main():
    # First download iris_training.csv and iris_test.csv

    # Load datasets.
    training_set = tf.contrib.learn.datasets.base.load_csv_with_header(
        filename=IRIS_TRAINING,
        target_dtype=np.int,
        features_dtype=np.float32)

    test_set = tf.contrib.learn.datasets.base.load_csv_with_header(
        filename=IRIS_TEST,
        target_dtype=np.int,
        features_dtype=np.float32)

    # Specify that all features have real-value data
    feature_columns = [tf.contrib.layers.real_valued_column("", dimension=4)]

    # Build 3 layer DNN with 10, 20, 10 units respectively.
    classifier = tf.contrib.learn.DNNClassifier(feature_columns=feature_columns,
                                                hidden_units=[10, 20, 10],
                                                n_classes=3,
                                                model_dir="/tmp/iris_model")

    # Define the training inputs
    def get_train_inputs():
        x = tf.constant(training_set.data)
        y = tf.constant(training_set.target)

        return x, y

    # Fit model.
    classifier.fit(input_fn=get_train_inputs, steps=2000)

    # Define the test inputs
    def get_test_inputs():
        x = tf.constant(test_set.data)
        y = tf.constant(test_set.target)

        return x, y

    '''Evaluate accuracy''' 
    # {'loss': 0.098150678, 'accuracy': 0.96666664, 'global_step': 4000}
    accuracy_score = classifier.evaluate(input_fn=get_test_inputs,
                                         steps=1)["accuracy"]

    print("\nTest Accuracy: {0:f}\n".format(accuracy_score))

    # Classify two new flower samples.
    def new_samples():
        return np.array(
            [[6.4, 3.2, 4.5, 1.5],
             [5.8, 3.1, 5.0, 1.7]], dtype=np.float32)

    predictions = list(classifier.predict(input_fn=new_samples))

    print(
        "New Samples, Class Predictions:    {}\n"
            .format(predictions))


if __name__ == "__main__":
    main()
```

## 2. 将Iris CSV数据加载到TF中

该[Iris data set](https://en.wikipedia.org/wiki/Iris_flower_data_set)包含150行数据，包括来自每三个相关Iris种类的50个样品： ris setosa, Iris virginica, 以及 Iris versicolor。

<img src="/images/tensorflow/tf-5.1-Iris-data_1.jpg" width="700" />

> 从左到右， Iris setosa（ Radomil，CC BY-SA 3.0）， Iris versicolor（Dlanglois，CC BY-SA 3.0）和Iris virginica（Frank Mayfield，CC BY-SA 2.0））。
>
> 每行包含每个花样品的以下数据： 花萼长度，花萼宽度， 花瓣长度，花瓣宽度和花种。花种以整数表示，0表示Iris setosa，1表示Iris versicolor，2表示Iris virginica。

<img src="/images/tensorflow/tf-5.1-Iris-data_2.jpg" width="400" />

> Iris数据已被随机分为两个独立的CSV：
>
> - 含120个样本的训练集（iris_training.csv）
> - 含30个样本的测试集（iris_test.csv）。

接下来，使用learn.datasets.base中的[load_csv_with_header()](https://www.github.com/tensorflow/tensorflow/blob/r1.1/tensorflow/contrib/learn/python/learn/datasets/base.py) 方法将训练集和测试集加载到datasets中。该load_csv_with_header()方法需要三个必不可少的参数：

- filename，带有文件路径的CSV文件。
- target_dtype，数据集的形式为numpy 数据类型。
- features_dtype，数据特征集的形式为numpy 数据类型。

在这里，目标（你正在训练预测模型的值）是花种，它是0-2的整数，所以适当的numpy数据类型是np.int：

```python
# Load datasets.
training_set = tf.contrib.learn.datasets.base.load_csv_with_header(
    filename=IRIS_TRAINING,
    target_dtype=np.int,
    features_dtype=np.float32)
    
test_set = tf.contrib.learn.datasets.base.load_csv_with_header(
    filename=IRIS_TEST,
    target_dtype=np.int,
    features_dtype=np.float32)
```

test_set 数据形式

```py
Dataset(
       data=array([
          [ 5.9000001 ,  3. ,  4.19999981,  1.5],
          [ 6.9000001 ,  3.0999999 ,  5.4000001 ,  2.0999999 ],
          ......
          [ 6.69999981,  3.29999995,  5.69999981,  2.5       ],
          [ 6.4000001 ,  2.9000001 ,  4.30000019,  1.29999995]
       ], dtype=float32), 
   		
       target=array(
          [1, 2, 0, 1, 1, 1, 0, 2, 1, 2, 2, 0, 2, 1, 1, 0, 1, 0, 0, 2, 0, 1, 2,1, 1, 1, 0, 1, 2, 1])
)
```

test_set.data 数据形式

```
[[ 5.9000001   3.          4.19999981  1.5       ]
 [ 6.9000001   3.0999999   5.4000001   2.0999999 ]
 ......
 [ 6.4000001   2.9000001   4.30000019  1.29999995]]
```

test_set.target 数据形式

```
[1 2 0 1 1 1 0 2 1 2 2 0 2 1 1 0 1 0 0 2 0 1 2 1 1 1 0 1 2 1]
```

tf.contrib.learn中的datasets被命名为 tuples ; 您可以通过data和target 属性访问特征数据和目标值。这里的training_set.data，training_set.target包含训练集的特征数据和目标值，test_set.data ，test_set.target包含测试集的特征数据和目标值。

在 “在Iris训练数据中拟合DNNC分类器”， 您将使用training_set.data和 training_set.target训练您的模型，在 “评估模型精度” 时，您将使用test_set.data和 test_set.target。

## 3. 构建深层神经网络分类器

tf.contrib.learn提供了各种预定义的模型，称为 [Estimators](https://www.tensorflow.org/api_guides/python/contrib.learn#estimators)，您可以使用“out of the box”方式对数据进行训练和评估操作。

在这里，您将配置深层神经网络分类器模型以拟合Iris数据。利用tf.contrib.learn，您可以使用几行代码实例化[tf.contrib.learn.DNNClassifier](https://www.tensorflow.org/api_docs/python/tf/contrib/learn/DNNClassifier)：

```python
# Specify that all features have real-value data
feature_columns = [tf.contrib.layers.real_valued_column("", dimension=4)]
 
# Build 3 layer DNN with 10, 20, 10 units respectively.
classifier = tf.contrib.learn.DNNClassifier(feature_columns=feature_columns,
                                            hidden_units=[10, 20, 10],
                                            n_classes=3,
                                            model_dir="/tmp/iris_model")
```

### 3.1 feature_columns 形式

```bash
[_RealValuedColumn(column_name='', dimension=4, default_value=None, dtype=tf.float32, normalizer=None)]
```

上面的代码首先定义了模型的特征列，它们指定数据集中的特征数据类型。所有的特征数据是连续的，所以tf.contrib.layers.real_valued_column使用相应的函数来构造特征列。数据集中有四个特征（花萼宽度，花萼高度，花瓣宽度和花瓣高度），因此dimension 必须设置为4保存所有数据。


### 3.2 classifier 形式

```bash
DNNClassifier(params={
'head': <tensorflow.contrib.learn.python.learn.estimators.head._MultiClassHead object at 0x1089c0c18>, 
'hidden_units': [10, 20, 10], 
'feature_columns': (_RealValuedColumn(column_name='', dimension=4, default_value=None, dtype=tf.float32, normalizer=None),), 
'optimizer': None, 
'activation_fn': <function relu at 0x11590ad08>, 
'dropout': None, 
'gradient_clip_norm': None, 
'embedding_lr_multipliers': None, 
'input_layer_min_slice_size': None})
```

然后，代码使用以下参数创建一个DNNClassifier模型：

- feature_columns=feature_columns。上面定义的特征列集合。
- hidden_units=[10, 20, 10]。三个隐含层，分别含有10,20和10个神经元。
- n_classes=3。三个目标类别，代表三种Iris物种。
- model_dir=/tmp/iris_model。TensorFlow将在模型训练期间保存检查点数据的目录。有关使用TensorFlow进行日志记录和监视的更多信息，请参阅Logging and Monitoring Basics with tf.contrib.learn.。
 
## 4. 训练的输入流

tf.contrib.learnAPI使用输入函数，创建为模型生成数据的TensorFlow操作。本例中，数据足够小，可以TensorFlow constants 存储。以下代码生成最简单的输入：

```py
# Define the test inputs
def get_train_inputs():
  x = tf.constant(training_set.data)
  y = tf.constant(training_set.target)
 
  return x, y
```

## 5. 在Iris训练数据上拟合DNN分类器

现在您已经配置了DNN classifier模型，您可以使用该[fit](https://www.tensorflow.org/api_docs/python/tf/contrib/learn/BaseEstimator#fit)方法将其拟合Iris训练数据。将get_train_inputs传递给input_fn，指定训练的步骤（这里取2000）：

```py
# Fit model.
classifier.fit(input_fn=get_train_inputs, steps=2000)
```

模型的状态保留在classifier，这意味着如果你喜欢，你可以分布训练。例如，以上代码相当于：

```py
classifier.fit(x=training_set.data, y=training_set.target, steps=1000)
classifier.fit(x=training_set.data, y=training_set.target, steps=1000)
```

但是，如果您希望在训练时跟踪模型，则可能需要使用TensorFlow [monitor](https://www.tensorflow.org/api_docs/python/tf/contrib/learn/monitors) 来执行日志记录操作。有关此主题的更多信息，请参阅
“Logging and Monitoring Basics with tf.contrib.learn”教程 。

## 6. 评估模型精度

您已经在Iris训练数据上拟合DNNClassifier模型; 现在，您可以使用该[evaluate](https://www.tensorflow.org/api_docs/python/tf/contrib/learn/BaseEstimator#evaluate)方法检查其对Iris测试数据的准确性 。正如fit， evaluate需要一个构建其输入渠道的输入函数。evaluate 返回一个评估结果dict。下面的代码通过Iris测试数据- test_set.data和test_set.target进行evaluate并打印结果的精度：

```py
# Define the test inputs
def get_test_inputs():
  x = tf.constant(test_set.data)
  y = tf.constant(test_set.target)
 
  return x, y
 
'''Evaluate accuracy.''' 
# {'loss': 0.098150678, 'accuracy': 0.96666664, 'global_step': 4000}
accuracy_score = classifier.evaluate(input_fn=get_test_inputs,
                                     steps=1)["accuracy"]
 
print("\nTest Accuracy: {0:f}\n".format(accuracy_score))
```

注意：这里的steps参数对evaluate很重要。 evaluate直到它到达输入的末尾才停止运行。

## 7. 分类新样本

使用estimator的predict()方法对新样本进行分类。例如，说你有这两个新的花朵样例：

```py

# Classify two new flower samples.
def new_samples():
  return np.array(
    [[6.4, 3.2, 4.5, 1.5],
     [5.8, 3.1, 5.0, 1.7]], dtype=np.float32)
 
predictions = list(classifier.predict(input_fn=new_samples))
 
print(
    "New Samples, Class Predictions:    {}\n"
    .format(predictions))
```

您可以使用该predict()方法预测其物种。predict返回一个生成器，可以很容易地转换成一个列表。以下代码取得并打印分类的预测结果：

```
New Samples, Class Predictions:    [1 2]
```

## 8. 其他资源

- 其他资源有关tf.contrib.learn的更多参考资料，请参阅官方 [API文档][t1]。
- 有关使用tf.contrib.learn创建线性模型的更多信息，请参阅 [Large-scale Linear Models with TensorFlow.][t2]
- 要使用tf.contrib.learn API构建自己的Estimator，请查看在 [tf.contrib.learn中创建估计器][t3]。
- 要在浏览器中实验神经网络建模和可视化，请查看[Deep Playground][t4]。
- 有关神经网络的更多高级教程，请参阅 [卷积神经网络][t5]和[循环神经网络][t6]。

[t1]: https://www.tensorflow.org/api_guides/python/contrib.learn
[t2]: https://www.tensorflow.org/tutorials/linear
[t3]: https://www.tensorflow.org/extend/estimators
[t4]: http://playground.tensorflow.org/
[t5]: https://www.tensorflow.org/tutorials/images/deep_cnn
[t6]: https://www.tensorflow.org/tutorials/sequences/recurrent

## Reference

- [GPU集群折腾手记——2015][1]
- [TensorFlow R1.2 中文文档][2]

[1]: http://mli.github.io/gpu/2016/01/17/build-gpu-clusters/
[2]: http://cwiki.apachecn.org/pages/viewpage.action?pageId=10029485
