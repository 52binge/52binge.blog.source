---
title: PTB 数据的 batching 方法
date: 2018-10-01 11:00:21
categories: data-science
tags: tensorflow
---

`PTB` 数据集 batching 介绍, 如何对 `PTB` 数据集进行 连接、切割 成多个 batch。

重点了解 **batch_size**、**num_batch**、**num_step** 这三个概念。

<!-- more -->

## batching

先看下面这段，摘取自 [知乎 作者：dalida][1]

画图很弱，直接就徒手画了。以朱自清的《背影》中的节选段落为例。字有点难看，请忽略～(￣▽￣～)~

这是单个字符级别的 RNN，换成词语也一样。

num_batch 其实就是 batch 的数量，这里只画了三个，可以一直接下去....这样一次完成 6个字符 (num_step=6) 的处理，而且能保证 batch 之间的连续性。但是行与行之间的连续性确实是丢失了。

{% image "/images/tensorflow/tf-nlp-9.2.2_2.jpg", width="700px" %}

**结论 :**

 - batch_size = 3 
 - num_batch = 3
 - num_step = 6
 
> batch_size 也是一次输入的句子数
 
## 朱自清《背影》

我们过了江，进了车站。我买票，他忙着照看行李。行李太多了，得向脚夫行些小费，才可过去。他便又忙着和他们讲价钱。我那时真是聪明过分，总觉他说话不大漂亮，非自己插嘴不可。但他终于讲定了价钱；就送我上车。他给我拣定了靠车门的一张椅子；我将他给我做的紫毛大衣铺好坐位。他嘱我路上小心，夜里警醒些，不要受凉。又嘱托茶房好好照应我。我心里暗笑他的迂；他们只认得钱，托他们直是白托！而且我这样大年纪的人，难道还不能料理自己么？唉，我现在想想，那时真是太聪明了！

我说道，“爸爸，你走吧。”他望车外看了看，说，“我买几个橘子去。你就在此地，不要走动。”我看那边月台的栅栏外有几个卖东西的等着顾客。走到那边月台，须穿过铁道，须跳下去又爬上去。父亲是一个胖子，走过去自然要费事些。我本来要去的，他不肯，只好让他去。我看见他戴着黑布小帽，穿着黑布大马褂，深青布棉袍，蹒跚地走到铁道边，慢慢探身下去，尚不大难。可是他穿过铁道，要爬上那边月台，就不容易了。他用两手攀着上面，两脚再向上缩；他肥胖的身子向左微倾，显出努力的样子。这时我看见他的背影，我的泪很快地流下来了。我赶紧拭干了泪，怕他看见，也怕别人看见。我再向外看时，他已抱了朱红的橘子望回走了。过铁道时，他先将橘子散放在地上，自己慢慢爬下，再抱起橘子走。到这边时，我赶紧去搀他。他和我走到车上，将橘子一股脑儿放在我的皮大衣上。于是扑扑衣上的泥土，心里很轻松似的，过一会说，“我走了；到那边来信！”我望着他走出去。他走了几步，回过头看见我，说，“进去吧，里边没人。”等他的背影混入来来往往的人里，再找不着了，我便进来坐下，我的眼泪又来了。

近几年来，父亲和我都是东奔西走，家中光景是一日不如一日。他少年出外谋生，独力支持，做了许多大事。那知老境却如此颓唐！他触目伤怀，自然情不能自已。情郁于中，自然要发之于外；家庭琐屑便往往触他之怒。他待我渐渐不同往日。但最近两年的不见，他终于忘却我的不好，只是惦记着我，惦记着我的儿子。我北来后，他写了一信给我，信中说道，“我身体平安，惟膀子疼痛利害，举箸提笔，诸多不便，大约大去之期不远矣。”我读到此处，在晶莹的泪光中，又看见那肥胖的，青布棉袍，黑布马褂的背影。唉！我不知何时再能与他相见！

**再看这个图**：

{% image "/images/tensorflow/tf-nlp-9.2.2_1.jpg", width="700px" %}

## Reference

- [关于batching多句子切割batch疑问？][1]
- [[L2]使用LSTM实现语言模型-数据batching][2]
- [TensorFlow入门（五）多层 LSTM 通俗易懂版][3]

[1]: https://www.zhihu.com/question/278485204/answer/402066718
[2]: https://zhuanlan.zhihu.com/p/40809517
[3]: https://blog.csdn.net/jerr__y/article/details/61195257