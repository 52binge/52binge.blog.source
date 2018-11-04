---
title: TensorFlow - tf.contrib.learn 创建 Estimator
toc: true
date: 2020-11-04 10:10:21
categories: python
tags: tensorflow
---

tf.contrib.learn 框架可以通过其高级别的 Estimator API 轻松构建和训练机器学习模型.

Estimator 提供您可以实例化的类以快速配置常见的模型类型，如 regressors 和 classifiers：

<!-- more --> 

- [tf.contrib.learn.LinearClassifier](https://www.tensorflow.org/api_docs/python/tf/contrib/learn/LinearClassifier)
- [tf.contrib.learn.LinearRegressor](https://www.tensorflow.org/api_docs/python/tf/contrib/learn/LinearRegressor)
- [tf.contrib.learn.DNNClassifier](https://www.tensorflow.org/api_docs/python/tf/contrib/learn/DNNClassifier)
- [tf.contrib.learn.DNNRegressor](https://www.tensorflow.org/api_docs/python/tf/contrib/learn/DNNRegressor)
- [tf.contrib.learn......](https://www.tensorflow.org/api_docs/python/tf/contrib/learn)

**完整代码**：

- [Github 鲍鱼年龄预测器 r1.11 Abalone Age Predictor][3]
 
## Reference

- [在tf.contrib.learn中创建估算器][1]

[1]: http://cwiki.apachecn.org/pages/viewpage.action?pageId=10029584
[2]: https://github.com/tensorflow/tensorflow/blob/r1.11/tensorflow/examples/tutorials/estimators/abalone.py
[3]: https://github.com/blair101/TensorFlowExamples/tree/master/tf.contrib.learn/tf-5.4-Estimator