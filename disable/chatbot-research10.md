---
title: Chatbot Research 10 - Chatbot 的第一个版本 (简单实现)
toc: true
date: 2017-11-26 22:00:21
categories: chatbot
tags: Chatbot
mathjax: true
---

<!-- 2018 -->

本篇主要讲述如何调用 tf 提供的 seq2seq 的 API，实现一个chatbot对话系统.

网上很多参考代码都是基于tf的旧版本实现，导致这些代码在新版本的tf中无法正常运行。

<!-- more -->

## 1. 版本兼容

**常见的几个问题主要是**：

- seq2seq API 旧版 tf.contrib.legacy_seq2seq, 新的接口 tf.contrib.seq2seq
- rnn 目前也大都使用 tf.contrib.rnn 下面的 RNNCell；
- embedding_attention_seq2seq 函数中调用deepcopy(cell)这个函数报异常
> deepcopy(cell)这个函数经常会爆出（TypeError: can't pickle _thread.lock objects）的错误

**解决方案**：

1. 切换TF版本 1.4 问题解决。
2. 不切换版本：一种解决方案就是将embedding_attention_seq2seq的传入参数中的cell改成两个，分别是encoder_cell和decoder_cell，然后这两个cell分别使用下面代码进行初始化：

```py
encoCell = tf.contrib.rnn.MultiRNNCell([create_rnn_cell() for _ in range(num_layers)],)
decoCell = tf.contrib.rnn.MultiRNNCell([create_rnn_cell() for _ in range(num_layers)],)
```

这样做不需要调用deepcopy函数对cell进行复制了，问题解决了，但在模型构建的时候速度会比较慢，猜测是因为需要构造两份RNN模型，但是最后训练的时候发现速度也很慢，无奈只能放弃这种做法。

然后分析代码，发现问题并不是单纯的出现在 embedding_attention_seq2seq 这个函数，而是在调用module_with_buckets的时候会构建很多个不同bucket的seq2seq模型，这就导致了embedding_attention_seq2seq会被重复调用很多次，后来发现确实是这里出现的问题。

解决方案的话就是，`不适用buckets构建模型`，而是简单的将所有序列都padding到统一长度，然后直接调用一次embedding_attention_seq2seq 函数构建模型即可，这样是不会抱错的。

## 2. 数据处理

用[DeepQA](https://github.com/Conchylicultor/DeepQA#chatbot)里数据处理的代码，省去从原始本文文件构造对话的过程直接使用其生成的 dataset-cornell-....pkl文件

> dataset-cornell-length10-filter1-vocabSize40000.pkl

主要包括：

1. 读取数据的函数loadDataset()
2. 根据数据创建batches的函数getBatches()和createBatch()
3. 预测时将用户输入的句子转化成batch的函数sentence2enco()

## 3. 模型构建

1. 一些变量的传入和定义
2. OutputProjection层和sampled_softmax_loss函数的定义
3. RNNCell的定义和创建
4. 根据训练或者测试调用相应的embedding_attention_seq2seq函数构建模型
5. step函数定义，主要用于给定一个batch的数据，构造相应的 feed_dict 和 run_opt

```py
import tensorflow as tf
from seq2seq import embedding_attention_seq2seq

class Seq2SeqModel():

    def __init__(self, source_vocab_size, target_vocab_size, en_de_seq_len, hidden_size, num_layers,
                 batch_size, learning_rate, num_samples=1024,
                 forward_only=False, beam_search=True, beam_size=10):
        '''
        初始化并创建模型
        :param source_vocab_size:encoder输入的vocab size
        :param target_vocab_size: decoder输入的vocab size，这里跟上面一样
        :param en_de_seq_len: 源和目的序列最大长度
        :param hidden_size: RNN模型的隐藏层单元个数
        :param num_layers: RNN堆叠的层数
        :param batch_size: batch大小
        :param learning_rate: 学习率
        :param num_samples: 计算loss时做sampled softmax时的采样数
        :param forward_only: 预测时指定为真
        :param beam_search: 预测时是采用greedy search还是beam search
        :param beam_size: beam search的大小
        '''
        self.source_vocab_size = source_vocab_size
        self.target_vocab_size = target_vocab_size
        self.en_de_seq_len = en_de_seq_len
        self.hidden_size = hidden_size
        self.num_layers = num_layers
        self.batch_size = batch_size
        self.learning_rate = tf.Variable(float(learning_rate), trainable=False)
        self.num_samples = num_samples
        self.forward_only = forward_only
        self.beam_search = beam_search
        self.beam_size = beam_size
        self.global_step = tf.Variable(0, trainable=False)

        output_projection = None
        softmax_loss_function = None
        # 定义采样loss函数，传入后面的sequence_loss_by_example函数
        if num_samples > 0 and num_samples < self.target_vocab_size:
            w = tf.get_variable('proj_w', [hidden_size, self.target_vocab_size])
            w_t = tf.transpose(w)
            b = tf.get_variable('proj_b', [self.target_vocab_size])
            output_projection = (w, b)
            #调用sampled_softmax_loss函数计算sample loss，这样可以节省计算时间
            def sample_loss(logits, labels):
                labels = tf.reshape(labels, [-1, 1])
                return tf.nn.sampled_softmax_loss(w_t, b, labels=labels, inputs=logits, num_sampled=num_samples, num_classes=self.target_vocab_size)
            softmax_loss_function = sample_loss

        self.keep_drop = tf.placeholder(tf.float32)
        # 定义encoder和decoder阶段的多层dropout RNNCell
        def create_rnn_cell():
            encoDecoCell = tf.contrib.rnn.BasicLSTMCell(hidden_size)
            encoDecoCell = tf.contrib.rnn.DropoutWrapper(encoDecoCell, input_keep_prob=1.0, output_keep_prob=self.keep_drop)
            return encoDecoCell
        encoCell = tf.contrib.rnn.MultiRNNCell([create_rnn_cell() for _ in range(num_layers)])

        # 定义输入的placeholder，采用了列表的形式
        self.encoder_inputs = []
        self.decoder_inputs = []
        self.decoder_targets = []
        self.target_weights = []
        for i in range(en_de_seq_len[0]):
            self.encoder_inputs.append(tf.placeholder(tf.int32, shape=[None, ], name="encoder{0}".format(i)))
        for i in range(en_de_seq_len[1]):
            self.decoder_inputs.append(tf.placeholder(tf.int32, shape=[None, ], name="decoder{0}".format(i)))
            self.decoder_targets.append(tf.placeholder(tf.int32, shape=[None, ], name="target{0}".format(i)))
            self.target_weights.append(tf.placeholder(tf.float32, shape=[None, ], name="weight{0}".format(i)))

        # test模式，将上一时刻输出当做下一时刻输入传入
        if forward_only:
            if beam_search:#如果是beam_search的话，则调用自己写的embedding_attention_seq2seq函数，而不是legacy_seq2seq下面的
                self.beam_outputs, _, self.beam_path, self.beam_symbol = embedding_attention_seq2seq(
                    self.encoder_inputs, self.decoder_inputs, encoCell, num_encoder_symbols=source_vocab_size,
                    num_decoder_symbols=target_vocab_size, embedding_size=hidden_size,
                    output_projection=output_projection, feed_previous=True)
            else:
                decoder_outputs, _ = tf.contrib.legacy_seq2seq.embedding_attention_seq2seq(
                    self.encoder_inputs, self.decoder_inputs, encoCell, num_encoder_symbols=source_vocab_size,
                    num_decoder_symbols=target_vocab_size, embedding_size=hidden_size,
                    output_projection=output_projection, feed_previous=True)
                # 因为seq2seq模型中未指定output_projection，所以需要在输出之后自己进行output_projection
                if output_projection is not None:
                    self.outputs = tf.matmul(decoder_outputs, output_projection[0]) + output_projection[1]
        else:
            # 因为不需要将output作为下一时刻的输入，所以不用output_projection
            decoder_outputs, _ = tf.contrib.legacy_seq2seq.embedding_attention_seq2seq(
                self.encoder_inputs, self.decoder_inputs, encoCell, num_encoder_symbols=source_vocab_size,
                num_decoder_symbols=target_vocab_size, embedding_size=hidden_size, output_projection=output_projection,
                feed_previous=False)
            self.loss = tf.contrib.legacy_seq2seq.sequence_loss(
                decoder_outputs, self.decoder_targets, self.target_weights, softmax_loss_function=softmax_loss_function)

            # Initialize the optimizer
            opt = tf.train.AdamOptimizer(learning_rate=self.learning_rate, beta1=0.9, beta2=0.999, epsilon=1e-08)
            self.optOp = opt.minimize(self.loss)

        self.saver = tf.train.Saver(tf.all_variables())
```

step 函数定义，主要用于给定一个batch的数据，构造相应的 feed_dict 和 run_opt

```py
    def step(self, session, encoder_inputs, decoder_inputs, decoder_targets, target_weights, go_token_id):
        # 传入一个batch的数据，并训练性对应的模型
        # 构建sess.run时的feed_inpits
        feed_dict = {}
        if not self.forward_only:
            feed_dict[self.keep_drop] = 0.5
            for i in range(self.en_de_seq_len[0]):
                feed_dict[self.encoder_inputs[i].name] = encoder_inputs[i]
            for i in range(self.en_de_seq_len[1]):
                feed_dict[self.decoder_inputs[i].name] = decoder_inputs[i]
                feed_dict[self.decoder_targets[i].name] = decoder_targets[i]
                feed_dict[self.target_weights[i].name] = target_weights[i]
            run_ops = [self.optOp, self.loss]
        else:
            feed_dict[self.keep_drop] = 1.0
            for i in range(self.en_de_seq_len[0]):
                feed_dict[self.encoder_inputs[i].name] = encoder_inputs[i]
            feed_dict[self.decoder_inputs[0].name] = [go_token_id]
            if self.beam_search:
                run_ops = [self.beam_path, self.beam_symbol]
            else:
                run_ops = [self.outputs]

        outputs = session.run(run_ops, feed_dict)
        if not self.forward_only:
            return None, outputs[1]
        else:
            if self.beam_search:
                return outputs[0], outputs[1]

```

## Reference

- [Tensorflow新版Seq2Seq接口使用](https://blog.csdn.net/thriving_fcl/article/details/74165062)
- [tensorflow官网API指导](https://www.tensorflow.org/api_docs/python/tf/contrib/legacy_seq2seq)
- [DeepQA](https://github.com/Conchylicultor/DeepQA#chatbot)
- [Neural_Conversation_Models](https://github.com/pbhatia243/Neural_Conversation_Models)

