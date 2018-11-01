---
title: TensorFlow - tf.contrib.learn 构建输入函数
toc: true
date: 2020-11-01 16:10:21
categories: python
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

## Reference

- [使用tf.contrib.learn构建输入函数][1]

[1]: http://cwiki.apachecn.org/pages/viewpage.action?pageId=10029487