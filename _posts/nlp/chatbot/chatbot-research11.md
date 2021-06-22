---
title: Chatbot Research 11 - Chatbot 的第二个版本 (新API实现)
date: 2018-11-29 22:00:21
categories: [nlp]
tags: Chatbot
---

我们使用 tf.contrib.legacy_seq2seq 下的 API 构建了一个简单的 chatbot 对话系统. 代码是1.0之前旧版.

本篇我们学习新版本灵活的的API，这里先来说一下二者的不同：

<!-- more -->

**新版本API：**

> - 用 dynamic\_rnn 来构造 RNN模型，这样就避免了数据长度不同所带来的困扰，不需要再使用 model\_with\_buckets 这种方法来构建模型，使得我们数据处理和模型代码都简洁很多。
> 
> - 新版本将 Attention、 Decoder 等几个主要的功能都分别进行封装，直接调用相应的 Wapper函数 进行封装即可，更加灵活方便，而且只需要写几个简单的函数既可以自定义的各个模块以满足我们个性化的需求。
>
>
> - 实现了beam_search功能，可直接调用。

> [tensor flow dynamic_rnn 与rnn有啥区别？](https://www.zhihu.com/question/52200883)
>
> dynamic_rnn 只在一个 batch 内部进行自动 padding， 不同 batch padding 长度可以不同

## 1. 数据处理

>  word2id is :  { 'decorations': 12002, 'scraps': 4599, ...}
> 
> id2word is :  { 0: '<pad>', 1: '<go>', 2: '<eos>', 3: '<unknown>', 4: 'can', 5: 'we', 6: 'make', ... }
> 
> trainingSamples is :
>  [
>     [ [793, 138, 65], [35, 209, 110, 9016, 208, 382, 35, 22] ],
>     [ [35, 209, 110, 9016, 208, 382, 35, 22], [26, 92, 1906, 47, 254, 65] ],
>     ...
>  ]

## 2. 模型构建

代码主要是从 tensorflow官网 给出的nmt例子的代码简化而来，实现了最基本的 **attention** 和 **beam_search** 等功能，同时有将nmt代码中繁杂的代码逻辑进行简化。这里参考nmt中所提到的构建`train`、`eval`、`inference` , 三个图进行模型构建，好处在于 [nmt官方文档 Building Training, Eval, and Inference Graphs ](https://github.com/tensorflow/nmt#building-training-eval-and-inference-graphs)

> - inference图 往往与 train 和 eval结构 存在较大差异，所以往往需要单独进行构建
>.   （没有decoder输入和目标，需要使用 greedy 或 beam_search 进行 decode，batch_size 也不同等等）
> - eval图，不需要进行反向传播，只需要得到一个 **loss** 和 **acc**值
> - 数据进行 `feed`，简化数据操作
> - 变量重用变得简单，因为 train、eval 存在一些公用变量和代码块，就不需要我们重复定义
> - 只需要在 train 时不断保存模型参数，然后在 eval 和 infer 的时候 restore参数 即可

以上，所以我们构建了 train、eval、infer 三个函数来实现上面的功能。在看代码之前我们先来简单说一下新版API几个主要的模块以及相互之间的调用关系。tf.contrib.seq2seq文件夹下面主要有下面6个文件，除了loss文件和之前的sequence_loss函数没有很大区别，这里不介绍之外，其他几个文件都会简单的说一下，这里主要介绍函数和类的功能，源码会放在下篇文章中介绍。

> - decoder
> - basic_decoder
> - helper
> - attention_wrapper
> - beam_search_decoder
> - loss

### 2.1 BasicDecoder 类和 dynamic_decode

decoder文件中定义了

- Decoder抽象类
- dynamic_decode函数

> dynamic_decode 可以视为整个解码过程的入口，需要传入的参数就是 Decoder 的一个实例，他会动态的调用 Decoder 的 `step`函数 按步执行 decode，可以理解为Decoder类定义了单步解码（根据输入求出输出，并将该输出当做下一时刻输入），而dynamic_decode则会调用control_flow_ops.while_loop这个函数来循环执行直到输出<eos>结束编码过程.

### 2.2 cell类型（Attention类型）

```py
# 分为3步，
#.  1. 定义attention机制
#.  2. 定义要是用的基础的RNNCell
#.  3. 使用AttentionWrapper进行封装

# 1. 定义要使用的attention机制。
attention_mechanism = tf.contrib.seq2seq.BahdanauAttention(num_units=self.rnn_size, memory=encoder_outputs, memory_sequence_length=encoder_inputs_length)

# 2. 定义decoder阶段要是用的LSTMCell，然后为其封装attention wrapper
decoder_cell = self._create_rnn_cell()

# 3. 使用AttentionWrapper进行封装
decoder_cell = tf.contrib.seq2seq.AttentionWrapper(cell=decoder_cell, attention_mechanism=attention_mechanism, attention_layer_size=self.rnn_size, name='Attention_Wrapper')
```

### 2.3 helper类型

helper其实就是decode阶段如何根据预测结果得到下一时刻的输入，比如train训练过程中应该直接使用上一时刻的真实值作为下一时刻输入，预测过程中可以使用贪婪的方法选择概率最大的那个值作为下一时刻等等。

## Reference

- [Tensorflow新版Seq2Seq接口使用](https://blog.csdn.net/thriving_fcl/article/details/74165062)
- [tensorflow官网API指导](https://www.tensorflow.org/api_docs/python/tf/contrib/legacy_seq2seq)
- [DeepQA](https://github.com/Conchylicultor/DeepQA#chatbot)
- [Neural\_Conversation\_Models](https://github.com/pbhatia243/Neural_Conversation_Models)

