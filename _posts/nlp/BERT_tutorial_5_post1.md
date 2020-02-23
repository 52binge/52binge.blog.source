---
title: BERT 肩膀上的 NLP 新秀： ERNIE
date: 2020-02-23 18:00:21
categories: nlp
tags: BERT
---

<img src="/images/nlp/bert5/ERNIE_logo.jpg" width="550" alt="bert" />

<!-- more -->

## Preface

去年NLP领域最火的莫过于BERT了，得益于数据规模和计算力的提升。

BERT在大会规模语料上预训练（Masked Language Model + Next Sentence Prediction）

之后可以很好地从训练语料中捕获丰富的语义信息，对各项任务疯狂屠榜。

No. | Name | Full_Name
:----: | :----: | :----: 
1 | ERNIE from Baidu | Enhanced Representation through Knowledge Integration（Baidu/2019） | 
2 | ERNIE from THU | Enhanced Language Representation with Informative Entities（THU/ACL2019）

> - Basic-Level Masking、Phrase-Level Masking、 Entity-Level Masking

<img src="/images/nlp/bert5/bert5-1.webp" width="750" alt="bert" />


**XLNet做了些什么?**

> 其实从另外一个角度更好理解XLNet的初衷和做法，我觉得这个估计是XLNet作者真正的思考出发点，是啥呢？就是说自回归语言模型有个缺点，要么从左到右，要么从右到左，尽管可以类似ELMO两个都做，然后再拼接的方式。但是跟Bert比，效果明显不足够好（这里面有RNN弱于Transformer的因素，也有双向语言模型怎么做的因素）。那么，能不能类似Bert那样，比较充分地在自回归语言模型中，引入双向语言模型呢？因为Bert已经证明了这是非常关键的一点。这一点，想法简单，但是看上去貌似不太好做，因为从左向右的语言模型，如果我们当前根据上文，要预测某个单词Ti，那么看上去它没法看到下文的内容。具体怎么做才能让这个模型：看上去仍然是从左向右的输入和预测模式，但是其实内部已经引入了当前单词的下文信息呢？XLNet在模型方面的主要贡献其实是在这里。



## Reference

- [张俊林: Bert时代的创新：Bert应用模式比较及其它](https://zhuanlan.zhihu.com/p/65470719)
- [张俊林: Bert时代的创新（应用篇）：Bert在NLP各领域的应用进展](https://zhuanlan.zhihu.com/p/68446772)
- [张俊林: XLNet:运行机制及和Bert的异同比较](https://zhuanlan.zhihu.com/p/70257427)
- [站在BERT肩膀上的NLP新秀们（PART I）](https://weixin.sogou.com/link?url=dn9a_-gY295K0Rci_xozVXfdMkSQTLW6cwJThYulHEtVjXrGTiVgSwmMbVnGAdyfWpgqR5nTYTTNRmGegeG1-VqXa8Fplpd98QrRsspqCZmTI26gpTNBsZawn0sNrhxHDJ181mLFwl4WgTnwq8k_ORKPHXMAAIBnLlMSpr4DFlZayTATBNyOhOs-rqhJlL4GL7ZQDLlAv6CEFTKML6seaP4lUnFq3lweR0hcAwK314DX8i0ACs8zq85aBivyL6Sbgzuq-kv_0OwNGbbB75bUeA..&type=2&query=%E7%AB%99%E5%9C%A8BERT%E8%82%A9%E8%86%80%E4%B8%8A%E7%9A%84NLP%E6%96%B0%E7%A7%80%E4%BB%AC&token=empty&k=80&h=s)
- [站在BERT肩膀上的NLP新秀们(PART II)](https://weixin.sogou.com/link?url=dn9a_-gY295K0Rci_xozVXfdMkSQTLW6cwJThYulHEtVjXrGTiVgSwmMbVnGAdyfWpgqR5nTYTTNRmGegeG1-VqXa8Fplpd9NGcTDrYSAXbgISsfQr0Sb9_CKE9ysxzAGaHAyeo9lkT0RPC26F2QSTklSLZ5nrgPSrHnQK7vKrg-R2EmMwyr8Gpe7hI8NXdN1Gjpv49eirDFCUK2wnF3qhKGyEZsHcW1py0vNe-QG79V_QvrMCAY3b6IYNVr5apdUQnP1wEuQY2fxjh3za6jWA..&type=2&query=%E7%AB%99%E5%9C%A8BERT%E8%82%A9%E8%86%80%E4%B8%8A%E7%9A%84NLP%E6%96%B0%E7%A7%80%E4%BB%AC&token=empty&k=63&h=-)


- [从语言模型到Seq2Seq：Transformer如戏，全靠Mask](https://kexue.fm/archives/6933)



