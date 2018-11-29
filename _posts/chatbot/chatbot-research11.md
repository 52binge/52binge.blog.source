---
title: Chatbot Research 11 - Chatbot 的第二个版本 (新API实现)
toc: true
date: 3017-11-29 22:00:21
categories: chatbot
tags: Chatbot
mathjax: true
---

<!-- 2018 -->

上期博文我们使用 tf.contrib.legacy_seq2seq 下的 API 构建了一个简单的 chatbot 对话系统. 代码是1.0之前旧版.

这期我们学习新版本灵活的的API，这里先来说一下二者的不同：

<!-- more -->

**新版本API：**

> - 用 dynamic\_rnn 来构造 RNN模型，这样就避免了数据长度不同所带来的困扰，不需要再使用 model\_with\_buckets 这种方法来构建模型，使得我们数据处理和模型代码都简洁很多。
>
> - 新版本将 Attention、 Decoder 等几个主要的功能都分别进行封装，直接调用相应的 Wapper函数 进行封装即可，调用起来更加灵活方便，而且只需要写几个简单的函数既可以自定义的各个模块以满足我们个性化的需求。
>
> - 实现了beam_search功能，可直接调用。

## 数据处理

## 模型构建

代码主要是从 tensorflow官网 给出的nmt例子的代码简化而来，实现了最基本的 **attention** 和 **beam_search** 等功能，同时有将nmt代码中繁杂的代码逻辑进行简化。这里参考nmt中所提到的构建`train`、`eval`、`inference` , 三个图进行模型构建，好处在于 [nmt官方文档 Building Training, Eval, and Inference Graphs ](https://github.com/tensorflow/nmt#building-training-eval-and-inference-graphs)

> - inference图 往往与 train 和 eval结构 存在较大差异，所以往往需要单独进行构建
>.   （没有decoder输入和目标，需要使用 greedy 或 beam_search 进行 decode，batch_size 也不同等等）
> - eval图也会得到简化，因为其不需要进行反向传播，只需要得到一个loss和acc值
> - 数据可以分别进行feed，简化数据操作
> - 变量重用变得简单，因为train、eval存在一些公用变量和代码块，就不需要我们重复定义，使代码简化
> - 只需要在 train 时不断保存模型参数，然后在 eval 和 infer 的时候 restore参数即可

以上，所以我们构建了 train、eval、infer 三个函数来实现上面的功能。在看代码之前我们先来简单说一下新版API几个主要的模块以及相互之间的调用关系。tf.contrib.seq2seq文件夹下面主要有下面6个文件，除了loss文件和之前的sequence_loss函数没有很大区别，这里不介绍之外，其他几个文件都会简单的说一下，这里主要介绍函数和类的功能，源码会放在下篇文章中介绍。

> - decoder
> - basic_decoder
> - helper
> - attention_wrapper
> - beam_search_decoder
> - loss

## BasicDecoder类和dynamic_decode

## Reference

- [Tensorflow新版Seq2Seq接口使用](https://blog.csdn.net/thriving_fcl/article/details/74165062)
- [tensorflow官网API指导](https://www.tensorflow.org/api_docs/python/tf/contrib/legacy_seq2seq)
- [DeepQA](https://github.com/Conchylicultor/DeepQA#chatbot)
- [Neural\_Conversation\_Models](https://github.com/pbhatia243/Neural_Conversation_Models)

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

