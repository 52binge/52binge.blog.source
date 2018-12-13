---
title: Chatbot Research 9 - 旧版 tf.contrib.legacy_seq2seq API 介绍
toc: true
date: 2017-11-19 14:00:21
categories: chatbot
tags: tf.contrib.legacy_seq2seq
mathjax: true
---

有了对代码的深层次理解，我们之后构建 Chatbot 系统的时候有很大的帮助。

<!-- more -->

> 旧的seq2seq接口也就是tf.contrib.legacy_seq2seq下的那部分，新的接口在tf.contrib.seq2seq下。
>
> 新seq2seq接口与旧的相比最主要的区别是它是动态展开的，而旧的是静态展开的。
>
> 静态展开(static unrolling) ：指的是定义模型创建graph的时候，序列的长度是固定的，之后传入的所有序列都得是定义时指定的长度。这样所有的句子都要padding到指定的长度，很浪费存储空间，计算效率也不高。但想处理变长序列，也是有办法的，需要预先指定一系列的buckets，如

## 函数部分

[旧版legacy_seq2seq代码][2]

首先看一下这个文件的组成，主要包含下面几个函数：

> - def _extract\_argmax\_and\_embed(embedding, ...
> - def rnn\_decoder(decoder\_inputs, initial\_state, ...
> - def basic\_rnn\_seq2seq(encoder\_inputs, ... 
> - def tied\_rnn\_seq2seq(encoder\_inputs, ...
> - def embedding\_rnn\_seq2seq(encoder\_inputs, ...
> - def embedding\_tied\_rnn\_seq2seq(encoder\_inputs, ...
> - def attention\_decoder(decoder_inputs, ...
> - def embedding\_attention\_decoder(decoder\_inputs, ...
> - def embedding\_attention\_seq2seq(encoder\_inputs, ...
> - def one2many\_rnn\_seq2seq(encoder\_inputs, ...
> - def sequence\_loss\_by\_example(logits, ...
> - def sequence\_loss(logits, ...
> - def model\_with\_buckets(encoder\_inputs, ...

**可以看到按照调用关系和功能不同可以分成下面的结构**：

```py
model_with_buckets
│
├── seq2seq函数
│   
│   ├── basic_rnn_seq2seq
│   │   ├── rnn_decoder
│   └── tied_rnn_seq2seq
│   ├── embedding_tied_rnn_seq2seq
│   └── embedding_rnn_seq2seq
│   │   ├── embedding_rnn_decoder
│   ├── embedding_attention_seq2seq
│   │   ├── embedding_attention_decoder
│   │   │   ├── attention_decoder
│   │   │   ├── attention
│   └── one2many_rnn_seq2seq
│   
└── loss函数
    ├── sequence_loss_by_example
    ├── sequence_loss
```

### model_with_buckets()函数

```py
def model_with_buckets(encoder_inputs,
                      decoder_inputs,
                      targets,
                      weights,
                      buckets,
                      seq2seq,
                      softmax_loss_function=None,
                      per_example_loss=False,
                      name=None):
```

这个函数，目的是为了减少计算量和加快模型计算速度，然后由于这部分代码比较古老，你会发现有些地方还在使用static_rnn()这种函数，其实新版的tf中引入dynamic_rnn之后就不需要这么做了。

分析一下，其实思路很简单，就是将输入长度分成不同的间隔，这样数据的在填充时只需要填充到相应的bucket长度即可，不需要都填充到最大长度。

比如 buckets 取 `[(5，10), (10，20),(20，30)...]` 每个 bucket 的

1. 第一个数字表示 source 填充的长度
2. 第二个数字表示 target 填充的长度

举个🌰 eg：**‘我爱你’-->‘I love you’**， 应该会被分配到第一个bucket中

然后‘我爱你’会被pad成长度为5的序列，‘I love you’会被pad成长度为10的序列。其实就是每个bucket表示一个模型的参数配置。这样对每个bucket都构造一个模型，然后训练时取相应长度的序列进行，而这些模型将会共享参数。其实这一部分可以参考现在的dynamic_rnn来进行理解，dynamic_rnn是对每个batch的数据将其pad至本batch中长度最大的样本，而bucket则是在数据预处理环节先对数据长度进行聚类操作。

我们再看一下该函数的参数和内部实现：

```py
   encoder_inputs: encoder的输入，一个tensor的列表。列表中每一项都是encoder时的一个词（batch）。
   decoder_inputs: decoder的输入，同上
   targets:        目标值，与decoder_input只相差一个<EOS>符号，int32型
   weights:        目标序列长度值的mask标志，如果是padding则weight=0，否则weight=1
   buckets:        就是定义的bucket值，是一个列表：[(5，10), (10，20),(20，30)...]
   seq2seq:        定义好的seq2seq模型，可以使用后面介绍的embedding_attention_seq2seq，embedding_rnn_seq2seq，basic_rnn_seq2seq等
   softmax_loss_function: 计算误差的函数，(labels, logits)，默认为sparse_softmax_cross_entropy_with_logits
   per_example_loss: 如果为真，则调用sequence_loss_by_example，返回一个列表，其每个元素就是一个样本的loss值。如果为假，则调用sequence_loss函数，对一个batch的样本只返回一个求和的loss值，具体见后面的分析
   name: Optional name for this operation, defaults to "model_with_buckets".
```

内部代码这里不会全部贴上来，捡关键的说一下：

```py
#保存每个bucket对应的loss和output    
losses = []
outputs = []
with ops.name_scope(name, "model_with_buckets", all_inputs):
#对每个bucket都要选择数据进行构建模型
for j, bucket in enumerate(buckets):
 #buckets之间的参数要进行复用
 with variable_scope.variable_scope(variable_scope.get_variable_scope(), reuse=True if j > 0 else None):

   #调用seq2seq进行解码得到输出，这里需要注意的是，encoder_inputs和decoder_inputs是定义好的placeholder，
   #都是长度为序列最大长度的列表（也就是最大的那个buckets的长度），按上面的例子，这两个placeholder分别是长度为20和30的列表。
   #在构建模型时，对于每个bucket，只取其对应的长度个placeholder即可，如对于（5,10）这个bucket，就取前5/10个placeholder进行构建模型
   bucket_outputs, _ = seq2seq(encoder_inputs[:bucket[0]], decoder_inputs[:bucket[1]])
   outputs.append(bucket_outputs)
   #如果指定per_example_loss则调用sequence_loss_by_example，losses添加的是一个batch_size大小的列表
   if per_example_loss:
     losses.append(
         sequence_loss_by_example(
             outputs[-1],
             targets[:bucket[1]],
             weights[:bucket[1]],
             softmax_loss_function=softmax_loss_function))
   #否则调用sequence_loss，对上面的结果进行求和，losses添加的是一个值
   else:
     losses.append(
         sequence_loss(
             outputs[-1],
             targets[:bucket[1]],
             weights[:bucket[1]],
             softmax_loss_function=softmax_loss_function))
```

函数的输出为outputs和losses，其tensor的shape见上面解释。
                              
## Reference

- [官网代码](https://github.com/tensorflow/tensorflow/blob/r1.4/tensorflow/contrib/legacy_seq2seq/python/ops/seq2seq.py)
- [Tensorflow源码解读（一）：Attention Seq2Seq模型](https://zhuanlan.zhihu.com/p/27769667)
- [Chatbots with Seq2Seq](http://complx.me/2016-06-28-easy-seq2seq/)
- [tensorflow的legacy_seq2seq](https://lan2720.github.io/2017/03/10/tensorflow%E7%9A%84legacy-seq2seq/)
- [Neural Machine Translation (seq2seq) Tutorial](https://github.com/tensorflow/nmt#tips--tricks)
- [Tensorflow新版Seq2Seq接口使用][1]

[1]: https://blog.csdn.net/thriving_fcl/article/details/74165062
[2]: https://github.com/tensorflow/tensorflow/blob/r1.4/tensorflow/contrib/legacy_seq2seq/python/ops/seq2seq.py


