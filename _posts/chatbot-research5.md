---
title: Chatbot Research 5 - 基于深度学习的检索聊天机器人
toc: true
date: 2019-08-15 14:00:21
categories: deeplearning
tags: deeplearning.ai
mathjax: true
---

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

介绍基于检索式机器人。检索式架构有预定好的语料答复库。

检索式模型的输入是上下文潜在的答复。模型输出对这些答复的打分，可以选择最高分的答案作为回复。

<!-- more -->

> 既然生成式的模型更弹性，也不需要预定义的语料，为何不选择它呢？
>
> 生成式模型的问题就是实际使用起来并不能好好工作，至少现在是。因为答复比较自由，容易犯语法错误和不相关、不合逻辑的答案，并且需要大量的数据且很难做优化。
>
> 大量的生产系统上还是采用检索模型或者检索模型和生成模型结合的方式。
> 
> - 例如 google 的 [smart reply][5]。
> 
> 生成模型是研究的热门领域，但是我们还没到应用它的程度。如果你想要做一个聊天机器人，最好还是选用检索式模型

更聪明的聊天机器人

1. 生成式模型 VS 检索匹配模型 
2. Chatterbot的进化: 深度学习提高智能度

模型构建 

1. 问题的分析与转化
2. 数据集与样本构造方法 
3. 网络结构的构建 
4. 模型的评估 
5. 代码实现与解析

## 1. 聊天机器人

<img src="/images/chatbot/chatbot-5_1.jpg" width="700" />

### 1.1 基于检索的 chatbot

- 根据 input 和 context，结合知识库的算法得到合适回复    
- 从一个固定的数据集中找到合适的内容作为回复
- 检索和匹配的方式有很多种
- 数据和匹配方法对质量有很大影响

### 1.2 基于生成模型的chatbot

- 典型的是 seq2seq 的方法
- 生成的结果需要考虑通畅度和准确度

> 以前者为主(可控度高)，后者为辅

## 2. 回顾 chatterbot

<img src="/images/chatbot/chatbot-5_2.png" width="600" />

### 2.1 chatterbot 的问题

**应答模式的匹配方式太粗暴**
  
> - 编辑距离无法捕获深层语义信息   
> - 核心词 + word2vec 无法捕获整句话语义   
> - LSTM 等 RNN模型 能捕获序列信息
>  ...
> 用深度学习来提高匹配阶段准确率!!

心得 :
  
> Open Domain 的 chatbot 很难做，话题太广，因为无法预知用户会问到什么问题. 
> 
> 你想吃什么 ： 随便
> 你感觉怎么样 : 还好
> 
> 没问题其实
> 
> 所以针对一个 Closed Domain + 检索 + 知识库，还应该可以做一个可以用的机器人.
  
### 2.2 应该怎么做

**匹配本身是一个模糊的场景**

> 转成排序问题
  
**排序问题怎么处理?**  

> 转成能输出概率的01分类问题
> 
> **Q1 -> { A1: 0.8, A2: 0.1, A3: 0.05, A4: 0.2 }**

**数据构建?**

> 我们需要正样本(正确的回答) 和 负样本(不对的回答)
> 
> **{ 正样本 : Q1-A1 1 }, { 负样本 : Q1-A3 0 }**

**Loss function?**

> 回忆一下 logistic regression

**心得 :**

> 定义问题 和 解决问题 很重要
> 
> 有一个问题，可以转换为 机器学习 或 深度学习 可以解决的问题，这非常重要。

## 3. 用深度学习来完成

<img src="/images/chatbot/chatbot-5_3.png" width="700" />
  
> [2016 Google Brain deep-learning-for-chatbots-2-retrieval-based-model-tensorflow, wildml blog][2]

## 4. 数据 - Ubuntu 对话语料库

ubuntu 语料库（UDC），它是目前公开的最大的数据集。

### 4.1 Train sets

<img src="/images/chatbot/chatbot-5_4.png" width="900" />

> 注意: 
>
> - 上面的数据集生成脚本已经使用 [NLTK][6] 做了一系列的语料处理包括（[分词][6_1]，[提取词干][6_2]，[词意恢复][6_3]）
> - 脚本也做了把 名字、地点、组织、URL。系统路径等实体信息用特殊的 token 来替代。
> 
> 这些预处理不是严格必要的，但是能改善一些系统的表现。
> 
> 语料的上下文平均有86个词语，答复平均有17个词语长。有人做了语料的统计分析：[data analysis][6_4]

### 4.2 Test / Validation sets

- 每个样本，有一个正例和九个负例数据 (也称为干扰数据)。
- 建模的目标在于给正例的得分尽可能的高，而给负例的得分尽可能的低。(有点类似分类任务)
- 语料做过分词、stemmed、lemmatized 等文本预处理。 
- 用 NER(命名实体识别) 将文本中的 **实体**，如姓名、地点、组织、URL等 替换成特殊字符

<img src="/images/chatbot/chatbot-5_5.png" width="900" />

## 5. 评估准则

**Recall@K**

> - 常见的 Kaggle 比赛评判准则
> - 经模型对候选的 response 排序后，前 k 个候选中 存在正例数据(正确的那个)的占比。
>    让 K=10，这就得到一个 100% 的召回率，因最多就 10 个备选。如果 K=1，模型只一次机会选中正确答案。
> - K 值 越大，指标值越高，对模型性能的要求越松。

**9个干扰项目怎么选出来**

> 这个数据集里是随机的方法选择的。
> 
> 但是现实世界里你可能数百万的可能答复，并且你并不知道答复是否合理正确。你没能力从数百万的可能的答复里去挑选一个得分最高的正确答复。成本太高了！ google 的 smart reply 用分布式集群技术计算一系列的可能答复去挑选,.
> 
> 可能你只有百来个备选答案，可以去评估每一个。



## Reference

- [About ChatterBot][1]
- [2016 Google Brain deep-learning-for-chatbots-2-retrieval-based-model-tensorflow, wildml blog][2]
- [聊天机器人深度学习应用-part2：基于tensorflow实现检索架构模型][3]
- [聊天机器人深度学习应用-part1：引言][4]

[1]: https://chatterbot.readthedocs.io/en/stable/
[2]: http://www.wildml.com/2016/07/deep-learning-for-chatbots-2-retrieval-based-model-tensorflow/
[3]: https://www.jianshu.com/p/412bcfa67770
[4]: https://www.jianshu.com/p/4fb194d143cf
[5]: https://arxiv.org/abs/1606.04870
[6]: http://www.nltk.org/
[6_1]: http://www.nltk.org/api/nltk.tokenize.html#module-nltk.tokenize
[6_2]: http://www.nltk.org/api/nltk.stem.html#module-nltk.stem.snowball
[6_3]: http://www.nltk.org/api/nltk.stem.html#module-nltk.stem.wordnet
[6_4]: https://github.com/dennybritz/chatbot-retrieval/blob/master/notebooks/Data%20Exploration.ipynb