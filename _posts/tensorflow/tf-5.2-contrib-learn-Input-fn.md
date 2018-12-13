---
title: TensorFlow - tf.contrib.learn 构建输入函数
toc: true
date: 2018-11-01 16:10:21
categories: tensorflow
tags: tensorflow
---

介绍如何在tf.contrib.learn中创建输入函数。了解如何构建input_fn去预处理和将数据输到模型中的概述。

实现利用input_fn将训练，评估和预测数据提供给神经网络回归器，用于预测房价中位数。

<!-- more --> 

## 1. 利用input_fn自定义输入Pipelines

当使用 tf.contrib.learn 训练神经网络，它可以直接通过您的特征和目标数据进行训练，分析或预测操作。这是一个从tf.contrib.learn快速入门教程中获取的示例：

```python
training_set = tf.contrib.learn.datasets.base.load_csv_with_header(
    filename=IRIS_TRAINING, target_dtype=np.int, features_dtype=np.float32)
test_set = tf.contrib.learn.datasets.base.load_csv_with_header(
    filename=IRIS_TEST, target_dtype=np.int, features_dtype=np.float32)
...
 
classifier.fit(x=training_set.data,
               y=training_set.target,
               steps=2000) 
```

当需要对源数据进行少量操作时，这种方法运行良好。但是在需要更多特征工程的情况下， tf.contrib.learn支持使用自定义输入函数（input_fn）将预处理和pipeline数据的逻辑封装到模型中。

### 1.1 解析input_fn

以下代码阐述了输入函数的基本框架：

```py
def my_input_fn():
 
    # Preprocess your data here...
 
    # ...then return 1) a mapping of feature columns to Tensors with
    # the corresponding feature data, and 2) a Tensor containing labels
    return feature_cols, labels
```
    
输入函数部分包含用于预处理输入数据的特定逻辑，例如擦除不良示例或feature scaling。

输入函数必须返回以下两个值，其中包含要馈送到模型中的最终特征和标签数据（如上述代码框架所示）：

> feature_cols
>
> - 将特征列名称映射到相应特征数据的Tensors（或SparseTensors）的keys/values对的字典。
>
> labels
>
> - 包含您的标签（目标）值的张量：您的模型预测的值。

### 1.2 将特征数据转换为张量

如果特征/标签数据存储在pandas 数据架构或numpy数组，你需要将其转换为Tensor在它从input_fn返回之前。

对于连续数据，您可以使用tf.constant创建和填充Tensor：

```py
feature_column_data = [1, 2.4, 0, 9.9, 3, 120]
feature_tensor = tf.constant(feature_column_data) 
```

## 2. 详见代码

- [Blair's Github tf.contrib.learn构建输入函数](https://github.com/blair101/TensorFlowExamples/blob/master/tf.contrib.learn/tf.contrib.learn构建输入函数.ipynb)

```py
import itertools
 
import pandas as pd
import tensorflow as tf
 
tf.logging.set_verbosity(tf.logging.INFO)

# 1. 定义数据集中的列名COLUMNS。 为了区分标签的 feature，还要定义 FEATURES 和 LABEL。

COLUMNS = ["crim", "zn", "indus", "nox", "rm", "age",
           "dis", "tax", "ptratio", "medv"]
FEATURES = ["crim", "zn", "indus", "nox", "rm",
            "age", "dis", "tax", "ptratio"]
LABEL = "medv"
 
training_set = pd.read_csv("boston_train.csv", skipinitialspace=True,
                           skiprows=1, names=COLUMNS)
test_set = pd.read_csv("boston_test.csv", skipinitialspace=True,
                       skiprows=1, names=COLUMNS)
prediction_set = pd.read_csv("boston_predict.csv", skipinitialspace=True,
                             skiprows=1, names=COLUMNS)

# print(training_set.head(2))
# print(test_set.head(2))

# 2. 定义FeatureColumns并创建回归
feature_cols = [tf.contrib.layers.real_valued_column(k) for k in FEATURES]
feature_cols

# 3. 实例化一个DNNRegressor神经网络回归模型
regressor = tf.contrib.learn.DNNRegressor(feature_columns=feature_cols,
                                          hidden_units=[10, 10],
                                          model_dir="/tmp/boston_model")
                                          
# 4. 构建input_fn                                          
def input_fn(data_set):
    feature_cols = {k: tf.constant(data_set[k].values)
                    for k in FEATURES}
    labels = tf.constant(data_set[LABEL].values)
    return feature_cols, labels

# 5. 训练回归器
regressor.fit(input_fn=lambda: input_fn(training_set), steps=5000)

# 6. 评估模型
ev = regressor.evaluate(input_fn=lambda: input_fn(test_set), steps=1)
loss_score = ev["loss"]
print("Loss: {0:f}".format(loss_score))

# 7. 预测
y = regressor.predict_scores(input_fn=lambda: input_fn(prediction_set), batch_size=None)
# .predict() returns an iterator; convert to a list and print predictions
predictions = list(itertools.islice(y, 6))
print("Predictions: {}".format(str(predictions)))
```

## 3. 其他资源

为神经网络回归器创建一个input_fn。要了解有关将input_fn用于其他类型模型的更多信息，请查看以下资源：

- [TensorFlow的大规模线性模型](https://www.tensorflow.org/tutorials/linear)：介绍TensorFlow中线性模型，提供转换输入数据的特征列和技术的高级概述。
- [TensorFlow线性模型教程](https://www.tensorflow.org/tutorials/wide)：FeatureColumns和 input_fn，线性分类模型，据人口财产普查数据预测收入范围。
- [TensorFlow Wide＆Deep Learning教程](https://www.tensorflow.org/tutorials/wide_and_deep)：基于[线性模型教程](https://www.tensorflow.org/tutorials/wide)，本教程涵盖 FeatureColumn 和 input_fn，创建了一个“宽而深”的模型，它融合了一个线性模型和使用 DNNLinearCombinedClassifier 的神经网络 。


## Reference

- [使用tf.contrib.learn构建输入函数][1]
- [高效的 itertools 模块][2]
- [pandas.read_csv参数整理][3]

[1]: http://cwiki.apachecn.org/pages/viewpage.action?pageId=10029487
[2]: http://funhacks.net/2017/02/13/itertools/
[3]: http://www.cnblogs.com/datablog/p/6127000.html
