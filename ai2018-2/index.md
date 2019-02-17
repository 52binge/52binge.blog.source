---
date: 2018-10-17 21:19:48
---

## 细粒度用户评论情感分析

有20个粒度的评价指标，每个粒度又有4种情感状态，从官方baseline来看，分别训练了20个（4标签）分类器。

### 项目结构

```py
src/config.py 项目配置信息模块，主要包括文件读取或存储路径信息
src/util.py 数据处理模块，主要包括数据的读取以及处理等功能
src/main_train.py 模型训练模块，模型训练流程包括 数据读取、分词、特征提取、模型训练、模型验证、模型存储等步骤
src/main_predict.py 模型预测模块，模型预测流程包括 数据和模型的读取、分词、模型预测、预测结果存储等步骤
```

> 1. 数据读取
> 2. 分词
> 3. 特征提取
> 4. 模型训练
> 5. 模型验证
> 6. 模型存储

CPU 4核心8线程，内存是48G, 10分钟出结果，调参之后 15分钟出结果

Trick 调参，learning_rate的影响是比较直接的，epoch=10， min_count设置为2， 去掉停用词和标点符号

> min_count: 可以对字典做截断. 词频少于min_count次数的单词会被丢弃掉, 默认值为5

- [利用skift实现fasttext模型](https://www.codetd.com/article/4534352)

## 1. fastText baseline

要用facebook官方的 fastText 以及自带的 Python fastText 工具包做这件事并不容易，或者说对于20个多标签分类器来说这事很繁琐

> skift：scikit-learn wrappers for Python fastText.

默认配置参数训练fasttext多模型，直接运行“python main_train.py” 即可。这样大概跑了不到10分钟，内存峰值占用不到8G，在验证集上得到一个f1均值约为0.5451的fasttext多分类模型(20个），模型存储位置在 model_path 下：fasttext_model.pkl，大概1.8G，在验证集上详细的F1值大致如下：

```bash
location_traffic_convenience:0.5175700387941342
location_distance_from_business_district:0.427891674259875
location_easy_to_find:0.570805555583767
service_wait_time:0.5052181634999748
service_waiters_attitude:0.6766570408968818
service_parking_convenience:0.5814636947460745
service_serving_speed:0.5701241141533907
price_level:0.6161258412096242
price_cost_effective:0.5679586399625348
price_discount:0.5763345656700684
environment_decoration:0.5554146717297597
environment_noise:0.563452055291662
environment_space:0.5288336794721515
environment_cleaness:0.5511776910510577
dish_portion:0.5527095496220675
dish_taste:0.6114994440656155
dish_look:0.43750894239614163
dish_recommendation:0.41756941548558957
others_overall_experience:0.5322283082904627
others_willing_to_consume_again:0.5404900044311536


2018-10-02 14:32:18,927 [INFO]  (MainThread) f1_score: 0.5450516545305993
```

调参：

```py
python main_train.py -mn fasttext_wn2_model.pkl -wn 2
```

这次大约跑了15分钟，内存峰值最大到37G，存储的模型大约在17G，验证集F1值结果如下：

```bash
location_traffic_convenience:0.5482785384602362
location_distance_from_business_district:0.4310319720574882
location_easy_to_find:0.6140713866422334
service_wait_time:0.5247890022873511
service_waiters_attitude:0.6881098513108542
service_parking_convenience:0.5828935095474249
service_serving_speed:0.6168828054420539
price_level:0.6615100420842464
price_cost_effective:0.5954569043369508
price_discount:0.5744529736585073
environment_decoration:0.5743996877298929
environment_noise:0.6186211367923496
environment_space:0.5981761036053918
environment_cleaness:0.6002515744280692
dish_portion:0.5733503000134572
dish_taste:0.6075507493398153
dish_look:0.4424685719881029
dish_recommendation:0.5936671419596734
others_overall_experience:0.5325664419580063
others_willing_to_consume_again:0.5875683298630815

2018-10-02 14:53:00,701 [INFO]  (MainThread) f1_score: 0.5783048511752592
```

这个结果看起来还不错，我们可以基于这个fasttext多分类模型进行测试集的预测：

```py
python main_predict.py -mn fasttext_wn2_model.pkl
```

大约运行不到3分钟，预测结果就出炉了，可以在 test_data_predict_output_path 找到这个预测输出文件: testa_predict.csv ，然后就可以去官网提交了，在线提交的结果和验证集F1值大致相差0.01~0.02。这里还可以做一些事情来优化结果，譬如去停用词，不过我试了去停用词和去一些标点符号，结果还有一些降低；**调参，learning_rate的影响是比较直接的**，min_count设置为2貌似也有一些负向影响，有兴趣的同学可以多试试，寻找一个最优组合。

## 2. Seq2Seq Attention

- jieba 分词
- 建立词典时，过滤掉出现次数小于 5 的词
- 训练集、验证集 以及 测试集A组成的语料，词典大小为 66347
- 预测和训练时，词典没有出现的词 用 `<UNK>` 代替

> 模型：Attention-RCNN、Attention-RNN

直接使用的是char模型，不需要分词，用到的停用词也不多。粗暴但实测效果比 word level 好。

### 2.1 预处理数据 data

- trainsets lines：  501132， 合法例子 ： 105000
- validationset lines：  70935, 合法例子 ： 15000
- testsets lines：  72028， 合法例子 ： 15000

**word2vec：** 维度 100， 窗口 10， 过滤掉次数小于 1 的词

```
3.1M chars.vector
```

数据预处理，在 preprocess 文件夹下生成了 train_char.csv、test_char.csv、test_char.csv 三个文件。

```bash
-rw-r--r--  1 blair 10:36 test_char.csv
-rw-r--r--  1 blair 10:09 train_char.csv
-rw-r--r--  1 blair 10:32 validation_char.csv
```

### 2.2 Attention Model

- 参考自 Kaggle 的 [Attention Model](https://www.kaggle.com/qqgeogor/keras-lstm-attention-glove840b-lb-0-043)

## Reference

- [比赛官网 https://challenger.ai][2_1]
- [AI-Challenger Baseline 细粒度用户评论情感分析 (0.70201) 前篇][2_1]

[2_1]: https://challenger.ai/competition/fsauor2018
[2_2]: https://zhuanlan.zhihu.com/p/47207009
