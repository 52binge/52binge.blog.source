---
title: Chatbot Research 9 - Chatbot 的第二个版本 (新API实现)
toc: true
date: 3017-11-29 22:00:21
categories: chatbot
tags: Chatbot
mathjax: true
---

<!-- 2018 -->

新版本都是用 dynamic\_rnn 来构造 RNN模型，这样就避免了数据长度不同所带来的困扰，不需要再使用 model\_with\_buckets 这种方法来构建模型，使得我们数据处理和模型代码都简洁很多。

新版本将 Attention、 Decoder 等几个主要的功能都分别进行封装，直接调用相应的 Wapper函数 进行封装即可，调用起来更加灵活方便，而且只需要写几个简单的函数既可以自定义的各个模块以满足我们个性化的需求。
实现了beam_search功能，可直接调用。

<!-- more -->



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

