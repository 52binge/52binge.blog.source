---
title: TensorFlow - tf.contrib.learn 基础的记录和监控教程
toc: true
date: 2018-11-04 09:10:21
categories: tensorflow
tags: tensorflow
---

训练模型时，实时跟踪和评估进度通常很有价值。

学习使用TensorFlow的日志记录功能和MonitorAPI来监督正在用神经网络分类器分类irises的训练情况。

<!-- more --> 

**完整代码：**

```py
# -*- coding: UTF-8 -*-
import os
import urllib

import numpy as np
import tensorflow as tf

# Data sets
IRIS_TRAINING = "iris_training.csv"
IRIS_TEST = "iris_test.csv"

tf.logging.set_verbosity(tf.logging.INFO)

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
    # [_RealValuedColumn(column_name='', dimension=4, default_value=None, dtype=tf.float32, normalizer=None)]

    validation_monitor = tf.contrib.learn.monitors.ValidationMonitor(
        test_set.data,
        test_set.target,
        every_n_steps=50)

    # Build 3 layer DNN with 10, 20, 10 units respectively.
    classifier = tf.contrib.learn.DNNClassifier(
        feature_columns=feature_columns,
        hidden_units=[10, 20, 10],
        n_classes=3,
        model_dir="/tmp/iris_model",
        config=tf.contrib.learn.RunConfig(save_checkpoints_secs=1))


    # Fit model.
    classifier.fit(x=training_set.data,
                   y=training_set.target,
                   steps=2000,
                   monitors=[validation_monitor])


if __name__ == "__main__":
    main()
```

> - [代码参见 Blair‘s Github - tf.contrib.learn 基础的记录和监控教程](https://github.com/blair101/TensorFlowExamples/tree/master/tf.contrib.learn/tf-5.3-validationMonitor-Iris)
> - [教程参见 cwiki.apachecn.org tf.contrib.learn 基础的记录和监控教程][1]

## 1. 使用TensorFlow启用日志记录

默认情况下，TensorFlow被配置在WARN日志级别，但是当跟踪模型训练时，您需要将级别调整为INFO。

代码的开头（在import导入之后）：

```bash
tf.logging.set_verbosity(tf.logging.INFO)
```

运行代码时，会看到如下所示的其他日志输出：

```bash
INFO:tensorflow:loss = 1.18812, step = 1
INFO:tensorflow:loss = 0.210323, step = 101
INFO:tensorflow:loss = 0.109025, step = 201
```

使用INFO级别日志记录，tf.contrib.learn会在每100步之后自动将training-loss metrics输出到stderr。

## 2. 配置验证监视器进行流评估

记录训练损失有助于了解您的模型是否收敛，但如果您想进一步了解训练中发生的情况怎么办？tf.contrib.learn提供了几个高级别Monitor，您可以附加到您的fit操作，以进一步跟踪metrics/调试模型训练期间的更低级别TensorFlow操作

### 2.1 每隔N步评估

对于iris神经网络分类器，在记录训练损失时，您可能还需要同时对测试数据进行评估，以了解该模型的泛化程度。

```py
validation_monitor = tf.contrib.learn.monitors.ValidationMonitor(
    test_set.data,
    test_set.target,
    every_n_steps=50)
```

将此代码放在实例化classifier那行之前。

ValidationMonitor依靠保存的checkpoints执行评估操作，因此您需要添加包含save_checkpoints_secs的[tf.contrib.learn.RunConfig](https://www.tensorflow.org/api_docs/python/tf/contrib/learn/RunConfig)去修改classifier的实例化，该参数指定在训练期间经过多少秒保存checkpoint。

由于iris数据集相当小，因此训练速度很快，设置save_checkpoints_secs为1（每1秒保存checkpoint）：

```py
classifier = tf.contrib.learn.DNNClassifier(
    feature_columns=feature_columns,
    hidden_units=[10, 20, 10],
    n_classes=3,
    model_dir="/tmp/iris_model",
    config=tf.contrib.learn.RunConfig(save_checkpoints_secs=1))
```

validation_monitor，更新包快调用monitors参数的fit，该参数在模型训练期间生成包含所有monitors的list：

```py
classifier.fit(x=training_set.data,
               y=training_set.target,
               steps=2000,
               monitors=[validation_monitor])
```

重新运行代码时，您应该在日志输出中看到验证metrics，例如： (但是我这里试验的时候，并没有出现)

```py
INFO:tensorflow:Validation (step 50): loss = 1.71139, global_step = 0, accuracy = 0.266667
...
INFO:tensorflow:Validation (step 300): loss = 0.0714158, global_step = 268, accuracy = 0.966667
...
INFO:tensorflow:Validation (step 1750): loss = 0.0574449, global_step = 1729, accuracy = 0.966667
```

### 2.2 使用MetricSpec定义Evaluation Metrics

- [详情参见 cwiki.apachecn.org tf.contrib.learn 基础的记录和监控教程][1]

### 2.3 通过ValidationMonitor提前停止训练

- [详情参见 cwiki.apachecn.org tf.contrib.learn 基础的记录和监控教程][1]

## 3. 用TensorBoard可视化日志数据

读取通过ValidationMonitor在训练期间产生大量关于模型性能的原始数据的日志，此数据的可视化，对进一步了解趋势可能会有帮助，例如准确性如何随着步数而变化。

```bash
$ tensorboard --logdir=/tmp/iris_model/
Starting TensorBoard 39 on port 6006 
```

## Reference

- [tf.contrib.learn基础的记录和监控教程][1]

[1]: http://cwiki.apachecn.org/pages/viewpage.action?pageId=10029489
