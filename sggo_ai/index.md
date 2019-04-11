
## 一、AI算法基础

**1.** 防止 overfiting 的 8 条迭代方向

> 1). get more data
> 2). Data augmentation
> 3). Regularization（权值衰减）. (L1 拉普拉斯先验, L2 高斯先验)
> 4). Dropout (类似 RF bagging 作用，最后以投票的方式降低过拟合；)
> 5). Choosing Right Network Structure
> 6). Early stopping
> 7). Model Ensumble
> 8). Batch Normalization

> Batch Normalization 可以有效避免复杂参数对网络训练产生的影响，也可提高泛化能力.
>
> 神经网路的训练过程的本质是学习数据分布，如果训练数据与测试数据分布不同，将大大降低网络泛化能力， BN 是针对每一批数据，在网络的每一层输入之前增加 BN，(均值0，标准差1)。
>
> Dropout 可以抑制过拟合，作用于每份小批量的训练数据，随机丢弃部分神经元机制. bagging 原理.
>
> [ML算法： 关于防止过拟合，整理了 8 条迭代方向](https://posts.careerengine.us/p/5cae13b2d401440a7fe047af)

**2.** 样本不平衡的 4 个解决方法？

> 1）上采样和子采样；
> 2）修改权重（修改损失函数）；
> 3）集成方法：bagging，类似随机森林、自助采样；
> 4）多任务联合学习；

**3.** CrossEntropy 系列问题？与最大似然函数的关系和区别？

> 1）CrossEntropy lossFunction ![](https://www.zhihu.com/equation?tex=L%3D-%5Bylog%5C+%5Chat+y%2B%281-y%29log%5C+%281-%5Chat+y%29%5D)
> 
> 二分类: ![](https://www.zhihu.com/equation?tex=g%28s%29%3D%5Cfrac%7B1%7D%7B1%2Be%5E%7B-s%7D%7D)
> 
> 意义：能表征 真实样本标签 和 预测概率 之间的差值
>
> 2）最小化交叉熵的本质就是对数似然函数的最大化；
>
> 3）对数似然函数的本质就是衡量在某个参数下，整体的估计和真实情况一样的概率，越大代表越相近；
> 
> 4）损失函数的本质就是衡量预测值和真实值之间的差距，越大代表越不相近。

Reference Article

> [知乎： 简单的交叉熵损失函数，你真的懂了吗？][1.1]
> 
> 我们希望 log P(y|x) 越大越好，反过来，只要 log P(y|x) 的负值 -log P(y|x) 越小就行了。那我们就可以引入损失函数，且令 Loss = -log P(y|x)即可。则得到损失函数为：
> 
> ![](https://www.zhihu.com/equation?tex=L%3D-%5Bylog%5C+%5Chat+y%2B%281-y%29log%5C+%281-%5Chat+y%29%5D)
> 
> 图可以帮助我们对 CrossEntropy lossFunction 有更直观的理解。无论真实样本标签 y 是 0 还是 1，L 都表征了预测输出与 y 的差距。
> 
> **重点一提：**
> 
> 预测输出与 y 差得越多，L 的值越大，也就是说对当前模型的 “ 惩罚 ” 越大，而且是非线性增大，是一种类似指数增长的级别。这是由 log 函数本身的特性所决定的。这样的好处是 模型会倾向于让预测输出更接近真实样本标签 y。
> 
> [知乎：一文搞懂极大似然估计][1.2]
> [CSDN：详解最大似然估计（MLE）、最大后验概率估计（MAP），以及贝叶斯公式的理解][1.3]
> 
> 就是利用已知的样本结果信息，反推最具有可能（最大概率）导致这些样本结果出现的 <font color=#c7254e>**模型参数值**！</font>
> 
> 对于这个函数： $P(x|θ)$
> 
> 输入有两个：$x$ 表示某一个具体的数据；$θ$ 表示模型的参数。
>
> 如果 $θ$ 是已知确定的，$x$ 是变量，这个函数叫做概率函数 (probability function)，它描述对于不同的样本点 $x$，其出现概率是多少。
>
> 如果 $x$ 是已知确定的，$θ$ 是变量，这个函数叫做似然函数(likelihood function), 它描述对于不同的模型参数，出现 $x$ 这个样本点的概率是多少。
>
> MLE 提供了一种 **给定观察数据来评估模型参数** 的方法，即：“模型已定，参数未知”。
> 
> MLE 中 **采样** 需满足一个重要的假设，就是所有的采样都是 **独立同分布** 的.
> 
> 一句话总结：概率是已知模型和参数，推数据。统计是已知数据，推模型和参数。

[1.1]: https://zhuanlan.zhihu.com/p/38241764
[1.2]: https://zhuanlan.zhihu.com/p/26614750
[1.3]: https://blog.csdn.net/u011508640/article/details/72815981

**4.** SVM 和 LR 的区别与联系？

> 1). 对非线性表达上，LR 只能通过人工的特征组合来实现，而 SVM 可以很容易引入非线性核函数来实现非线性表达，当然也可以通过特征组合。
> 
> 2). LR 产出的是概率值，而SVM只能产出是正类还是负类，不能产出概率。LR 的损失函数是 log loss，而 SVM 使用的是 hinge loss。
> 
> 3). SVM 不直接依赖数据分布，而LR则依赖, SVM 主要关注的是“支持向量”，也就是和分类最相关的少数点，即关注局部关键信息；而 LR 是在全局进行优化的。这导致 SVM 天然比 LR 有**更好的泛化能力**，防止过拟合。
> 
> 4). 损失函数的优化方法不同，LR 是使用 GD 来求解 **对数似然函数** 的最优解；SVM 使用 (Sequnential Minimal Optimal) 顺序最小优化，来求解条件约束损失函数的对偶形式。
>
> ---
>
> 一般用线性核和高斯核，也就是Linear核与RBF核需要注意的是需要对 **数据归一化处理**.
>
> 一般情况下RBF效果是不会差于Linear但是时间上RBF会耗费更多

**Andrew Ng 的见解：**

> 1. 如果Feature的数量很大，跟样本数量差不多，这时候选用LR或者是Linear Kernel的SVM
> 2. 如果Feature的数量比较小，样本数量一般，不算大也不算小，选用SVM+Gaussian Kernel
> 3. 如果Feature的数量比较小，而样本数量很多，需要手工添加一些feature变成第一种情况

**如何量化 feature number 和 sample number：**

> n 是feature的数量, m是样本数   

> 1). feature number >> sample number，则使用LR算法或者不带核函数的SVM（线性分类）
>   &nbsp;&nbsp;&nbsp;&nbsp; feature number = 1W， sample number = 1K
>     
> 2). **fn** 小， sample number **一般**1W，使用带有 **kernel函数** 的 SVM算法.  
>    
> 3). **fn** 小， sample number **很大**5W+（n=1-1000，m=50000+）
> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 增加更多的 feature 然后使用LR 算法或者 not have kernel 的 SVM

**5.** GBDT vs Xgboost

**6.** 评估指标 F1 和 auc 的区别是哪些?

**7.** sigmoid 用作激活函数时，分类为什么要用 crossentry loss，而不用均方损失？

**8.** 神经网络中的激活函数的对比？

## 二、NLP高频问题

1、word2vec和tf-idf 相似度计算时的区别？
2、word2vec和NNLM对比有什么区别？（word2vec vs NNLM）
3、 word2vec负采样有什么作用？
4、word2vec和fastText对比有什么区别？（word2vec vs fastText）
5、glove和word2vec、 LSA对比有什么区别？（word2vec vs glove vs LSA）
6、 elmo、GPT、bert三者之间有什么区别？（elmo vs GPT vs bert）
7、LSTM和GRU的区别？

## 三、其他算法问题

1、怎么进行单个样本的学习？
2、 决策树 bagging boosting adaboost 区别？RF的特征随机目的是什么？
3、transformer各部分怎么用？Q K V怎么计算；Attention怎么用？
4、HMM 假设是什么？CRF解决了什么问题？CRF做过特征工程吗？HMM中的矩阵意义？5、说以一下空洞卷积？膨胀卷积怎么理解？什么是Piece-CNN？
6、怎么解决beam-search局部最优问题？global embedding 怎么做？
7、数学题：什么是半正定矩阵？机器学习中有什么应用？
8、卷积的物理意义是什么？傅里叶变换懂吗？
9、说一下Bert？
10、推导word2vec？
11、怎么理解传统的统计语言模型？现在的神经网络语言模型有什么不同？
12、神经网络优化的难点是什么？这个问题要展开来谈。
13、attention你知道哪些？
14、自动文章摘要抽取时，怎么对一篇文章进行分割？（从序列标注、无监督等角度思考）
15、在做NER任务时，lstm后面可以不用加CRF吗？
16、通过画图描述TextRank？
17、LDA和pLSA有什么区别？
18、Transformer在实际应用中都会有哪些做法？
19、讲出过拟合的解决方案？
20、说一下transforemr、LSTM、CNN间的区别？从多个角度进行讲解？
21、梯度消失的原因和解决办法有哪些？
22、数学题：贝叶斯计算概率？
23、数学题：25只兔子赛跑问题，共5个赛道，最少几次比赛可以选出前5名？
24、数学题：100盏灯问题？

## Reference

- [【NLP/AI算法面试必备-2】NLP/AI面试全记录（持续更新）][1]
- [【NLP/AI算法面试必备-1】学习NLP/AI，必须深入理解“神经网络及其优化问题”][2]
- [JayLouNLP算法工程师][2]

[1]: https://zhuanlan.zhihu.com/p/57153934
[2]: https://www.zhihu.com/people/lou-jie-9/posts
[3]: https://zhuanlan.zhihu.com/p/56633392