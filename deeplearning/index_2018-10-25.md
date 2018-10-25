# deep learning

我开始整理 Algorithm 相关学习笔记，学习算法类知识真的需要下很大很大的功夫，灰常博大精深~~

博主水平灰常有限，期望能与對、Deep Learning 感兴趣的朋友一起学习、交流、探讨与分享~~

## 1. Neural Networks / Deep Learning

No. | <font color="#0085a1">**Neural Networks**</font> | <font color="#0085a1">**Neural Networks and Deep Learning**</font>
:-------: | :-------: | :-------:
1 | [Introduction to Deep Learning][c1w1]  | 了解现今深度学习在哪里应用、如何应用
2 | [Neural Networks Basics][c1w2] | logistic 损失函数、导数、计算图、m个样本的梯度下降、向量化
3 | [Shallow Neural Networks][c1w3] | NN Representation、向量化、[Activation functions][in1]、**Random init**、Python 实现 NN 
4 | [Deep Neural Networks][c1w4] | 深网的前向传播、核对矩阵维数、反向传播、参数VS超参数、Python 实现 NN

> 对于中间层来说, 往往是 ReLU 的效果最好. 
> 虽然 z < 0, 的时候，斜率为0， 但在实践中，有足够多的隐藏单元 令 z > 0, 对大多数训练样本来说是很快的.
> 
> so the one place you might use as linear activation function others usually in the output layer.

[in1]: /2018/07/14/deeplearning-ai-Neural-Networks-and-Deep-Learning-week3/#3-神经网络中的激活函数

[c1w1]: /2017/12/01/deeplearning-ai-Neural-Networks-and-Deep-Learning-week1/
[c1w2]: /2018/07/07/deeplearning-ai-Neural-Networks-and-Deep-Learning-week2/
[c1w3]: /2018/07/14/deeplearning-ai-Neural-Networks-and-Deep-Learning-week3/
[c1w4]: /2018/07/15/deeplearning-ai-Neural-Networks-and-Deep-Learning-week4/

## 2. Improving Deep Neural Networks 

No. | <font color="#0085a1">**Improving**</font> | <font color="#0085a1">**Improving Deep Neural Networks**</font> 
:-------: | :-------: | :-------:
5 | [Deep Learning Action][c2w1]  | Train/Dev/Test、Bias/Variance、L1 L2 Dropout、梯度消失\爆炸、Weight init、Gradient checking
6 | [Optimization][c2w2] | mini-batch、指数加权平均-偏差修正、Momentum、RMSprop、Adam、α decay、局部优
7 | [超参数调试、Batch][c2w3] | Hyperparameter、Normalizing Activations、Batch Norm [Fitting NN]、Softmax

[c2w1]: /2018/07/19/deeplearning-ai-Improving-Deep-Neural-Networks-week1/
[c2w2]: /2018/07/21/deeplearning-ai-Improving-Deep-Neural-Networks-week2/
[c2w3]: /2018/07/23/deeplearning-ai-Improving-Deep-Neural-Networks-week3/

## 3. Structured Machine Learning 

No. | <font color="#0085a1">**Structured**</font> | <font color="#0085a1">**Structured Machine Learning Projects**</font> 
:-------: | :-------: | :-------:
8 | [ML Strategy 1][c3w1] | 正交化、Satisficing and optimizing metrics、Train/dev/test 改变、可避免偏差、人的表现
9 | [ML Strategy 2][c3w2] | 误差分析、标注错误数据、定位数据不匹配偏差与方差、迁移学习、多任务学习、端到端学习

[c3w1]: /2018/07/24/deeplearning-ai-Structured-Machine-Learning-Projects-week1/
[c3w2]: /2018/07/25/deeplearning-ai-Structured-Machine-Learning-Projects-week2/

## 4. Convolutional Neural Networks

No. | <font color="#0085a1">**CNN**</font> | <font color="#0085a1">**Convolutional Neural Networks**</font>
:-------: | :-------: | :-------:
10 | [Convolutional Neural Networks][c4w1] | Edge detection、Padding、Strided convolutions、Convolutions Over Volumes、Pooling
11 | [&nbsp;&nbsp;Deep CNN&nbsp;&nbsp;][c4w2] | Classic Nets、ResNets、1×1 convolutions、Inception、Transfer Learning、Data augmentation
12 | [Object detection][c4w3] | Object Localization、Landmark Detection、Sliding Windows、Bounding Box Predictions、Intersection Over Union、Non-max Suppression、Anchor Boxes、YOLO
13 | [Face recognition][c4w4] | One-Shot、Siamese、Triplet Loss、Face Verification、deep ConvNets learning?

> LeNet-5、AlexNet、VGG、ResNet (有152层)、Inception。 目标定位、特征点检测、Bounding Box预测、Anchor Boxes

[c4w1]: /2018/08/21/deeplearning-ai-Convolutional-Neural-Networks-week1/
[c4w2]: /2018/08/24/deeplearning-ai-Convolutional-Neural-Networks-week2/
[c4w3]: /2018/09/01/deeplearning-ai-Convolutional-Neural-Networks-week3/
[c4w4]: /2018/09/08/deeplearning-ai-Convolutional-Neural-Networks-week4/

## 5. Sequence Models

No. | <font color="#0085a1">**Sequence Models**</font> | <font color="#0085a1">**Sequence Models**</font>
:-------: | :-------: | :-------:
14 | [Recurrent Sequence Models][c5w1] | Notation、RNN、Vanishing gradients、GRU、LSTM、BRNN、Deep RNNs
15 | [NLP & Word Embeddings][c5w2] | Matrix、Word2Vec、Negative Sampling、GloVe、Debiasing Word Embeddings
16 | [Sequence Models & Attention][c5w3] | Greedy Search、Beam Search、Error analysis on beam search、Attention

[c5w1]: /2018/07/26/deeplearning-ai-Sequence-Models-week1/
[c5w2]: /2018/08/02/deeplearning-ai-Sequence-Models-week2/
[c5w3]: /2018/08/14/deeplearning-ai-Sequence-Models-week3/

[0]: / 

## Friends link

- [深度学习与自然语言处理 CS244d Notes][h1]
- [怎样找到一份深度学习的工作][h2]

[h1]: https://blog.csdn.net/column/details/dl-nlp.html
[h2]: https://blog.csdn.net/han_xiaoyang/article/details/52777661

## Machine learning Coursera

No. | <font color="#0085a1">**Machine Learning Coursera**</font> | <font color="#0085a1">**Machine Learning Toc Content**</font>
:-------: | :-------: | :-------:
1. | [Machine Learning Introduce][1.1] | Supervised learning、Regression & Classification、Unsupervised learning
2. | [Linear Regression Cost Function <br> Gradient descent][1.2] | Linear Regression、Cost Function、Gradient Descent (Batch)
3. | [Linear Algebra Matrices And Vectors][1.3] |  Linear Algebra Matrices And Vectors
4. | [Linear Regression with Multiple Variables][2] | Multiple Features、Gradient Desc、Polynomial Regression、Normal Equation
5. | [Logistic Regression][3] | Classification、Cost Function & Gradient Desc、Optimization、Regularization
6. | [Advice for Applying Machine Learning][6.1] | Model Selection、Bias and Variance -> Regularization、Learning Curves
8. | [Large Scale Machine Learning * not][0] |

## Machine learning roc auc

No. | <font color="#0085a1">**Machine Learning Title**</font> | <font color="#0085a1">**Machine Learning Toc Content**</font>
:-------: | :-------: | :-------:
11. | [L1、L2 正则化小记][11] | 奥卡姆剃刀、贝叶斯估计、结构风险最小化、L1、L2 范数 
12. | [模型评估总结][12] | Precision、Recall、ROC、AUC
 | |
13. | [Native Bayes 1][14.1] | 条件独立假设、垃圾邮件识别、多项式/伯努利/混合 模型、平滑
14. | [Native Bayes 2][14.2] | 独立假设、贝叶斯分类器

## Machine learning tree model

No. | <font color="#0085a1">**Machine Learning Tree Model**</font> | <font color="#0085a1">**Machine Learning Decision Tree & Ensemble**</font>
:-------: | :-------: | :-------:
15. | [Decision Tree 1][15.1] | ID3 Information gain & C4.5 Gain ratio
16. | [Decision Tree 2][15.2] | **CART** : 回归树： 最小二乘 & 分类树： 基尼指数 Gini index
17. | [Gradient Boosting][17] | 三个臭皮匠，顶个诸葛亮
18. | [Xgboost][18] [@陈天奇怪][18.1] | 提供了 Graident Boosting 算法框架，给出了GBDT，GBRT，GBM 具体实现
19. | [Ensemble 1][19.1] | Bootstraping、Bagging (Random Forest)
19. | [Ensemble 2][19.2] | 概率可学习性 (PAC)、Boosting算法代表 ：Adaboost(Adaptive Boosting)
19. | [Ensumble 集成学习小记][19] | Bagging、Boosting、Stacking、Blending

### NLP 基础知识

- [1.1 文字和语言 vs 数字和信息][n1]
 
- [1.2 Python 字符串处理-正则表达式][n2]

- [1.3 NLP 简介 & 统计语言模型][n3]

- [1.4 Jieba 分词中文处理][n4]

- [1.5 Naive Bayes * 垃圾邮件分类][n5_1]、[Naive Bayes * 文本分类][n5_2]

- [1.6 Word2vec 基础][n6]

[n1]: /2017/11/08/nlp-pre-word-language-number-info-history/
[n2]: /2017/07/30/nlp-01-string-operation-re/
[n3]: /2017/11/13/nlp-pre-statistics-language-model/
[n4]: /2017/07/29/nlp-01-jieba/
[n5_1]: /2017/08/10/ml-4-naive-bayes-1/
[n5_2]: /2017/08/23/ml-4-naive-bayes-2/
[n6]: /2017/07/12/nlp-word-vector-basic/
[n7]: /2017/11/14/nlp-pre-hidden-markov-model/

[1.1]: /2016/09/20/ml-coursera-ng-w1-01-introduce/
[1.2]: /2016/09/28/ml-coursera-ng-w1-02-cost-function-gradient-descent/
[1.3]: /2016/09/30/ml-coursera-ng-w1-03-Linear-Algebra/

[2]: /2016/10/08/ml-coursera-ng-w2-01-Linear-Regression/
[3]: /2016/10/24/ml-coursera-ng-w3-LR/

[4]: /2017/02/07/ml-coursera-ng-w4-NN-02/
[5]: /2017/02/13/ml-coursera-ng-w4-NN-03/

[6.1]: /2017/05/24/ml-coursera-ng-w6-Advice-for-Applying-Machine-Learning/
[6.2]: /2017/05/29/ml-coursera-ng-w6-Machine-Learning-System-Design/

[7]: /2017/10/13/ml-coursera-ng-w7-svm/
[8]: /2018/01/24/ml-coursera-ng-w8-clustering-1/

[11]: /2018/07/11/ml-1-L1-L2/
[12]: /2018/07/05/ml-1-roc-auc-summary/

[14.1]: /2017/08/10/ml-4-naive-bayes-1/
[14.2]: /2017/08/23/ml-4-naive-bayes-2/

[15.1]: /2016/08/16/ml-5-decisionTree-part1/
[15.2]: /2018/06/27/ml-5-decisionTree-part2/

[17]: /2018/06/29/ml-8-gradient-boosting-part1/
[18]: /2018/07/03/ml-8-xgboost/
[18.1]: https://weibo.com/u/2397265244?is_all=1

[19.1]: /2018/04/07/ml-9-ensumble-boosting-1/
[19.2]: /2018/04/11/ml-9-ensumble-boosting-2/
[19]: /2018/07/03/ml-9-ensumble-part1/

<!--## Internet Finance

No. | <font color="#0085a1">**Internet Finance Title**</font> | <font color="#0085a1">**Internet Finance Part**</font>
:-------: | :-------: | :-------:
1. | [金融科技企业面临的欺诈⻛险][if1] | 互联网金融风控中的数据科学 (part1) 
2. | [模型策略][if2] | 互联网金融风控中的数据科学 (part2) 
3. | [Lending Club 的数据试验][if3] | 互联网金融风控中的数据科学 (part3)

[if3]: /2018/04/23/data-science-internet-finance-3/
[if2]: /2018/04/21/data-science-internet-finance-2/
[if1]: /2018/04/20/data-science-internet-finance-1/-->
