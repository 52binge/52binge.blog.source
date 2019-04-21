## Machine Learning / NLP

### ML / 逻辑编程LP

> 1. 逻辑编程是什么 （X + 2 = 5 询问 X 的值，回答： X=3）类比 **forward pass + back propagation**
> 2. **ML框架** 其实是一种 **程序语言** : differentiable programming language
> 
> &nbsp;&nbsp; Pytorch 和 TensorFlow 的动态计算图和静态计算图. 对应动态静态语言。
> 
> **简单表达 & 递归：**
> 
> 1. Feed-forward 网络，比如 CNN 一类的，对应了最简单的表达式，它只能处理图像一类具有固定长度的数据。
> 2. RNN（LSTM）对应的是单个递归（循环）的函数。这就是为什么 RNN 可以处理文本这类线性“链表”数据。

> [machine learning and logic programming 机器学习与逻辑编程](http://www.yinwang.org/blog-cn/2019/01/30/machine-learning)

### NLP Research

未来十年将是 NLP 发展的黄金档：

> 1. 来自各个行业的文本大数据将会更好地采集、加工、入库。
> 2. 来自 搜索引擎、客服、商业智能、语音助手、翻译、教育 等领域对 NLP 的需求会大幅度上升。
> 3. 文本数据和语音、图像数据的多模态融合成为未来机器人的刚需。

因此，NLP 研究将会向如下几个方面倾斜：

> 1. 将知识和常识引入目前基于数据的学习系统中。
> 2. 低资源的NLP任务的学习方法。
> 3. 上下文建模、多轮语义理解。
> 4. 基于语义分析、知识和常识的可解释 NLP。

![趋势热点：值得关注的NLP技术](https://pic4.zhimg.com/80/v2-c79815588a512fc8a9256bc7582b02e3_hd.jpg)

除了备受关注的 NN Pre-Train 外，知识和常识的引入将大幅推动NLP技术的发展：

> - [2019：迈向高能NLP之路！](https://zhuanlan.zhihu.com/p/53794989)
> - [高能NLP之路的专栏](https://zhuanlan.zhihu.com/c_1064159241216102400)
> - [NLP将迎来黄金十年 from MSRA](https://www.msra.cn/zh-cn/news/executivebylines/tech-bylines-nlp) 通篇似乎都在强调知识和常识引入对NLP乃至整个AI的重要性。

**2018 美团技术团队发表两篇重磅级文章：**

- [美团餐饮娱乐知识图谱——美团大脑揭秘](https://tech.meituan.com/2018/11/22/meituan-brain-nlp-01.html)
- [美团大脑：知识图谱的建模方法及其应用](https://tech.meituan.com/2018/11/01/meituan-ai-nlp.html)

> 人工智能背后两大技术驱动力：**深度学习和知识图谱**，知识图谱就是人工智能的基础。

## 1. AI 算法基础

**1.1 防止 overfiting 的 8 条**

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

**1.2 机器学习之类别不平衡问题**

机器学习之类别不平衡问题 (1) —— 各种评估指标

> 1）过采样和欠采样；（1. 随机过采样(不太使用了，重采样往往会导致严重的过拟合)， 2. **Border-line SMOTE**）
> 2）修改权重（修改损失函数）；
> 3）集成方法：bagging，类似随机森林、自助采样；
> 4）多任务联合学习；

> - [机器学习之类别不平衡问题 (1) —— 各种评估指标][2.1]
> - [机器学习之类别不平衡问题 (2) —— ROC和PR曲线][2.2]
> - [机器学习之类别不平衡问题 (3) —— 采样方法][2.3]

[2.1]: https://zhuanlan.zhihu.com/p/34473430
[2.2]: https://zhuanlan.zhihu.com/p/34655990
[2.3]: https://zhuanlan.zhihu.com/p/41237940

**1.3 CrossEntropy 与 最大似然？**

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

**1.4 SVM 和 LR 的区别与联系？**

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

**1.5 ERM / SRM**

Supervised Learning Obj

$$
w^*=argmin_w\sum_iL(y_i,f(x_i;w))+\lambda\Omega(w)
$$

> 1. 第一项对应模型的训练损失函数 (Square Loss、Hinge loss、Exp loss、Log loss)
> 2. 第二项对应模型的正则化项 （模型参数向量的范数）

> 经验风险最小化 empirical risk minimization, 结构风险最小化 structural risk minimization

李沐曾经说过：
 
> model是用离散特征还是连续特征，其实是“**海量离散特征+简单模型**” 同 “**少量连续特征+复杂模型**”的权衡。
> 
> 既可以离散化用线性模型，也可以用连续特征加深度学习。就看是喜欢折腾 **feature** 还是折腾 **model** 了。通常来说，前者容易，而且可以n个人一起并行做，有成功经验；后者目前看很赞，能走多远还须拭目以待。

**1.6 Linear vs Nonlinear classifier**

> 线性和非线性是针对，模型参数和输入特征来讲的；
>
> 比如输入x，模型 y=ax+ax^2 那么就是 nonlinear model 如果输入是x和X^2则模型是线性的。
>
> 1. Linear classifier 可解释性好，计算复杂度较低，不足之处是模型的拟合效果相对弱些。
> 2. nonlinear classifier 拟合能力较强，不足之处是数据量不足容易 **overfiting** 、计算复杂度高、解释性不好。
> 
> Linear classifier ：LR,贝叶斯分类，单层感知机、线性回归
> 
> nonlinear classifier：决策树、RF、GBDT、多层感知机
> 
> SVM 两种都有（看线性核还是高斯核）

**1.7 Random Forest**

> - [RF、bagging、boosting、GBDT、xgboost算法总结][7.1]

> RF 是一个典型的多个决策树的组合分类器。
> 
> 1). 数据的随机性选取
> 2). 待选特征的随机选取

Sample Random： 

![](https://pic1.zhimg.com/80/v2-a1c3ce43528dbc274be8952c06d2b9b4_hd.jpg)

Feature Random：

> 与数据集的随机选取类似，随机森林中的子树的每一个分裂过程并未用到所有的待选特征，而是从所有的待选特征中随机选取一定的特征，之后再在随机选取的特征中选取最优的特征。这样能够使得随机森林中的决策树都能够彼此不同，提升系统的多样性，从而提升分类性能。

![](https://pic1.zhimg.com/80/v2-569009cc3ccd3e9922b77c1e4cbf4ca0_hd.jpg)

[7.1]: https://zhuanlan.zhihu.com/p/34534004

**1.8 GBDT**

GBDT 是以决策树（CART）为基学习器的 GB算法，是迭代树，而不是分类树。

一般 Boosting 算法都是一个迭代的过程，每一次新的训练都是为了改进上一次的结果。

![](https://pic2.zhimg.com/80/v2-4713a5b63da71ef5afba3fcd3a65299d_hd.jpg)

GBDT 的核心就在于：**每一棵树学的是之前所有树结论和的残差**，这个残差就是一个加预测值后能得真实值的累加量。

![](https://pic3.zhimg.com/80/v2-a384924b89b1bdd581cef7d75b56e226_hd.jpg)

**1.9 RF vs GBDT 区别**

> 1. 组成 RF 的树可以是分类树，也可以是回归树；而GBDT只由回归树组成 
> 2. 组成 RF 的树可以并行生成；而GBDT只能是串行生成 
> 3. 对于最终的输出结果而言，随机森林采用多数投票等；而GBDT则是将所有结果累加起来，或者加权累加起来 
> 4. RF 对异常值不敏感，GBDT对异常值非常敏感 
> 5. RF 对训练集一视同仁，GBDT是基于权值的弱分类器的集成 
> 6. RF 是通过减少模型方差提高性能，GBDT是通过减少模型偏差提高性能

**1.10 GBDT vs Xgboost**

Xgboost相比于GBDT来说，更加有效应用了数值优化，最重要是**对损失函数**（预测值和真实值的误差）**变得更复杂**。目标函数依然是所有树的预测值相加等于预测值。

> 1. 二阶泰勒展开，同时用到了一阶和二阶导数
> 2. xgboost在代价函数里加入了正则项，用于控制模型的复杂度
> 3. Shrinkage（缩减），相当于学习速率（xgboost中的eta）
> 4. 列抽样（column subsampling）。xgboost借鉴RF做法，支持列抽样（即每次的输入特征不是全部特征)
> 5. 并行化处理： 预先对每个特征内部进行了排序找出候选切割点.各个**feature**的增益计算就可以开多线程进行.

<!--![](https://pic2.zhimg.com/80/v2-1c0706e463f78b6036b3923048ac9149_hd.jpg)-->

> 好的模型需要具备两个基本要素：
>
> 1. 是要有好的精度（即好的拟合程度）
> 2. 是模型要尽可能的简单（复杂的模型容易出现过拟合，并且更加不稳定）
>
> 因此，我们构建的目标函数右边第一项是模型的误差项，第二项是正则化项（也就是模型复杂度的惩罚项）

> 常用的误差项有平方误差和逻辑斯蒂误差，常见的惩罚项有l1，l2正则，l1正则是将模型各个元素进行求和，l2正则是对元素求平方。

> [ID3、C4.5、CART、随机森林、bagging、boosting、Adaboost、GBDT、xgboost算法总结](https://zhuanlan.zhihu.com/p/34534004)

<font color=#c7254e>Bagging & Boosting</font> 的理念：

Bagging 的思想比较简单，即每一次从原始数据中根据 **均匀概率分布有放回的抽取和原始数据大小相同的样本集合**，样本点可能出现重复，然后对每一次产生的训练集构造一个分类器，再对分类器进行组合。

boosting 的每一次抽样的 **样本分布都是不一样** 的。每一次迭代，都根据上一次迭代的结果，**增加被错误分类的样本的权重**，使得模型能在之后的迭代中更加注意到 **难以分类的样本**，这是一个 **不断学习的过程，也是一个不断提升** 的过程，这也就是boosting思想的本质所在。 迭代之后，将每次迭代的基分类器进行集成。那么如何进行样本权重的调整和分类器的集成是我们需要考虑的关键问题。

![](https://pic4.zhimg.com/80/v2-aca3644ddd56abe1e47c0f45601587c3_hd.jpg)

**1.11 Evaluation Metric 对比 ?**

Confusion Matrix

**1). accuracy** (正反比例严重失衡，则没意义，存在 accuracy paradox 现象)

![](https://pic1.zhimg.com/80/v2-492ac29bbed274a282eee069c0b63c93_hd.jpg)

> accuracy 准确率 = (TP+TN)/(TP+TN+FP+FN), **准确率可以判断总的正确率**

**2). precision** 查准率 (80% = 你一共预测了100个正例，80个是对的正例)

![](https://pic2.zhimg.com/80/v2-3ee1faa3a371c7667fdca01e960dd294_hd.jpg)

> Precision = TP/(TP+FP)

**3). recall** (样本中的正例有多少被预测正确 TPR = TP/(TP+FN))

![](https://pic1.zhimg.com/80/v2-5c649d8fbb03dae0703a1b70413ae82d_hd.jpg)

**4). F1-score** （precision 和 recall 的 metric）

> 2\*precision\*recall / (precision + recall)

**5). P-R（precision-recall）PRC**

> 依靠 LR 举例:
>
> 这条曲线是根据什么变化的？为什么是这个形状的曲线？
>
> 这个阈值是我们随便定义的，我们并不知道这个阈值是否符合我们的要求
>
> 遍历 0 到 1 之间所有的阈值, 得到了这条曲线

**5). ROC curve** （TPR 纵轴，FPR 横轴，TP（真正率）和 FP（假正率），设一个阈值）

> ROC（Receiver Operating Characteristic）曲线。 ROC 曲线 是基于混淆矩阵得出的。 
>
> TPR = recall = 灵敏度 = P（X=1 | Y=1）
> FPR = 特异度 = P（X=0 | Y=0）
 
![](https://pic3.zhimg.com/80/v2-947f270aaae4164a14c9093859cf0cce_hd.jpg)

**ROC曲线的阈值问题:**

> 与前面的P-R曲线类似，ROC曲线也是通过遍历所有阈值来绘制整条曲线的。 

![](https://pic4.zhimg.com/50/v2-296b158ebb205a2b90d05f5d2074bbe9_hd.gif)

**ROC曲线无视样本不平衡**

> - [精确率、召回率、F1 值、ROC、AUC 各自的优缺点是什么？](https://www.zhihu.com/question/30643044)
> - [机器学习之类别不平衡问题 (2) —— ROC和PR曲线](https://zhuanlan.zhihu.com/p/34655990)

 
**6). AUC**  (AUC = 0.5，跟随机猜测一样， ROC 纵轴 TPR 越大， 横轴 FPR 越小 模型越好）

> 0.5 - 0.7：效果较低，但用于预测股票已经很不错了
> 0.7 - 0.85：效果一般
> 0.85 - 0.95：效果很好
>
> real world data 经常会面临 class imbalance 问题，即正负样本比例失衡。
> 
> 根据计算公式可以推知，在 testing set 出现 imbalance 时 ROC曲线 能保持不变，而 PR 则会出现大变化。

**7). multi-class classification** 如果非要用一个综合考量的 metric 的话，

> 1. macro-average（宏平均）- 分布计算每个类别的F1，然后做平均（各类别F1的权重相同）
> 2. micro-average（微平均）- 通过先计算总体的TP，FN和FP的数量，再计算F1
>  
> macro-average（宏平均） 会比 micro-average（微平均）好一些哦，因为 macro 会受 minority class 影响更大，也就是说更能体现在 small class 上的 performance.
> 
> [sklearn中 F1-micro 与 F1-macro 区别和计算原理](https://www.cnblogs.com/techengin/p/8962024.html)

precision & recall

> precision 是相对你自己的模型预测而言
> recall 是相对真实的答案而言

**1.12 Bias-Variance Tradeoff**

<img src="https://charlesliuyx.github.io/2017/09/12/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0%E5%88%86%E7%B1%BB%E5%99%A8%E6%80%A7%E8%83%BD%E6%8C%87%E6%A0%87%E8%AF%A6%E8%A7%A3/BV-Tradeoff.png" width="450" />

> - [Bias-Variance Tradeoff](https://charlesliuyx.github.io)

**1.13 激活函数的对比？**

> 1. Sigmoid 和 Tanh 为什么会导致 Vanishing/Exploding gradients ? 
> 2. Tanh 值域 (-1,1) Sigmoid 值域 (0,1)
> 3. ReLU 的优点，和局限性分别是什么? 
> 4. [谈谈激活函数 Sigmoid,Tanh,ReLu,softplus,softmax](https://zhuanlan.zhihu.com/p/48776056)

**1.14 sigmoid 用作激活函数时，分类为什么要用 crossentropy loss，而不用均方损失？**

> 5. softmax函数可以看做是Sigmoid函数的一般化，可以进行多分类。
> 6. 非常适合用于`分类`问题： `Cross Entropy` 交叉熵损失函数
> 7. Square error loss function 与 Cross Entropy Error Function 分别适合什么景？

**1.15 InfoEntropy vs Crossentropy**

> InfoEntropy，代表的是随机变量或整个系统的不确定性，熵越大，随机变量或系统的不确定性就越大。

> Crossentropy，用来衡量在给定的真实分布下，使用非真实分布所指定的策略消除系统的不确定性所需要付出的努力值。

## 2. NLP高频问题

### 2.1 word2vec vs NNLM

> 1）其本质都可以看作是 Language Model；

> 2）词向量只不过 NNLM 一个产物， word2vec 虽然其本质也是 Language Model，但是其专注于**词向量本身**，因此做了许多优化来提高计算效率：

> 与 NNLM 相比，词向量直接sum，不再拼接，并舍弃隐层；
> 考虑到 sofmax归一化 需要遍历整个词汇表，采用 hierarchical softmax 和 negative sampling 进行优化

> 1. hierarchical softmax 实质上生成一颗带权路径最小的哈夫曼树，让高频词搜索路劲变小；
> 2. negative sampling 更为直接，实质上对每一个样本中每一个词都进行负例采样；

### 2.2 negative sampling

负采样这个点引入 word2vec 非常巧妙，两个作用，

> 1. 加速了模型计算
> 2. 保证了模型训练的效果
> 
> 第一，model 每次只需要更新采样的词的权重，不用更新所有的权重，那样会很慢。
> 
> 第二，中心词其实只跟它周围的词有关系，位置离着很远的词没有关系，也没必要同时训练更新，作者这点聪明.

- [word2vec Negative Sampling 刘建平Pinard](https://www.cnblogs.com/pinard/p/7249903.html)

### 2.3 word2vec vs fastText

> 1. 都可以无监督学习词向量， fastText 训练词向量时会考虑 subword；
> 2. fastText 还可以进行有监督学习进行文本分类

其主要特点：

> - 结构与CBOW类似，但学习目标是人工标注的分类结果；
> - 采用 hierarchical softmax 对输出的分类标签建立哈夫曼树，样本中标签多的类别被分配短的搜寻路径；
> - 引入 N-gram，考虑词序特征；
> - 引入 subword 来处理长词，处理未登陆词问题；

### 2.4 word2vec vs glove

> - word2vec 是局部语料库训练的，其特征提取是基于滑窗的；而glove的滑窗是为了构建co-occurance matrix，是基于全局语料的，可见glove需要事先统计共现概率；因此，word2vec可以进行在线学习，glove则需要统计固定语料信息。
>
>
> - word2vec 是无监督学习，同样由于不需要人工标注；glove通常被认为是无监督学习，但实际上glove还是有label的，即共现次数log(X_{ij})。
>
>
> - word2vec 损失函数实质上是带权重的**crossentrpy**，权重固定；glove的损失函数是最小**平方损失函数**，权重可以做映射变换。
> 
>
> - 总体来看，glove 可以被看作是更换了目标函数和权重函数的全局 word2vec。

### 2.5 ELMO vs GPT vs BERT

![](https://pic1.zhimg.com/80/v2-004df09bcc2f085c72cc0938c08b1910_hd.jpg)

之前介绍词向量均是静态的词向量，无法解决一次多义等问题。下面介绍三种elmo、GPT、bert词向量，它们都是基于语言模型的动态词向量。下面从几个方面对这三者进行对比：

（1）**特征提取器**：elmo采用LSTM进行提取，GPT和bert则采用Transformer进行提取。很多任务表明Transformer特征提取能力强于LSTM，elmo采用1层静态向量+2层LSTM，多层提取能力有限，而GPT和bert中的Transformer可采用多层，并行计算能力强。

（2）**单/双向语言模型**：

GPT采用单向语言模型，elmo和bert采用双向语言模型。但是elmo实际上是两个单向语言模型（方向相反）的拼接，这种融合特征的能力比bert一体化融合特征方式弱。
GPT和bert都采用Transformer，Transformer是encoder-decoder结构，GPT的单向语言模型采用decoder部分，decoder的部分见到的都是不完整的句子；bert的双向语言模型则采用encoder部分，采用了完整句子。

### 2.6 RNN vs LSTM vs GRU

- GRU 和 LSTM 的性能在很多任务上不分伯仲。

- GRU 参数更少因此更容易收敛，但是数据集很大的情况下，LSTM表达性能更好。

> 从结构上来说：
>
> - GRU 只有两个门（update和reset），LSTM 有三个门（forget，input，output）
> - GRU 直接将 hidden state 传给下一个单元，而 LSTM 则用 memory cell 把hidden state 包装起来。

### 2.7 RNN vs CNN

> 1. RNN 优点： 最大程度捕捉上下文信息，这可能有利于捕获长文本的语义。
> 2. RNN 缺点： 是一个有偏倚的模型，在这个模型中，后面的单词比先前的单词更具优势。因此，当它被用于捕获整个文档的语义时，它可能会降低效率，因为关键组件可能出现在文档中的任何地方，而不是最后。
> 3. CNN 优点： 提取数据中的局部位置的特征，然后再拼接池化层。 CNN可以更好地捕捉文本的语义。是O(n)
> 4. CNN 优点： 一个可以自动判断哪些特性在文本分类中扮演关键角色的池化层，以捕获文本中的关键组件。

### 2.8 Attention

除此之外模型为了取得比较好的效果还是用了下面三个小技巧来改善性能：

> 深层次的LSTM：作者使用了4层LSTM作为encoder和decoder模型，并且表示深层次的模型比shallow的模型效果要好（单层，神经元个数多）。
>
> 将source进行反序输入：输入的时候将“ABC”变成“CBA”，这样做的好处是解决了长序列的long-term依赖，使得模型可以学习到更多的对应关系，从而达到比较好的效果。
> 
> Beam Search：这是在test时的技巧，也就是在训练过程中不会使用。
>
> 一般来讲我们会采用greedy贪婪式的序列生成方法，也就是每一步都取概率最大的元素作为当前输出，但是这样的缺点就是一旦某一个输出选错了，可能就会导致最终结果出错，所以使用beam search的方法来改善。也就是每一步都取概率最大的k个序列（beam size），并作为下一次的输入。更详细的解释和例子可以参考下面这个链接：https://zhuanlan.zhihu.com/p/28048246

### 2.9 文本分类任务 tricks

在文本分类任务中，有哪些论文中很少提及却对性能有重要影响的tricks？

> 1. 数据预处理时vocab的选取（前N个高频词或者过滤掉出现次数小于3的词等等）
> 2. 词向量的选择，可以使用预训练好的词向量如谷歌、facebook开源出来的，当训练集比较大的时候也可以进行微调或者随机初始化与训练同时进行。训练集较小时就别微调了
> 3. 结合要使用的模型，这里可以把数据处理成char、word或者都用等
> 4. 有时将词性标注信息也加入训练数据会收到比较好的效果
> 5. 至于PAD的话，取均值或者一个稍微比较大的数，但是别取最大值那种应该都还好
> 6. 神经网络结构的话到没有什么要说的，可以多试几种比如fastText、TextCNN、RCNN、char-CNN/RNN、HAN等等。哦，对了，加上dropout和BN可能会有意外收获。反正模型这块还是要具体问题具体分析吧，根据自己的需求对模型进行修改（比如之前参加知乎竞赛的时候，最终的分类标签也有文本描述，所以就可以把这部分信息也加到模型之中等等）
> 7. 超参数的话，推荐看看之前TextCNN的一篇论文，个人感觉足够了“A Sensitivity Analysis of (and Practitioners’ Guide to) Convolutional Neural Networks for Sentence Classification”
> 8. 之前还见别人在文本领域用过数据增强的方法，就是对文本进行随机的shuffle和drop等操作来增加数据量

这个看似不重要，其实确实很重要的点。一开我以为 padding 的最大长度取整个评论平均的长度的2倍差不多就可以啦(对于char level 而言，max_length 取 400左右)，但是会发现效果上不去，当时将 max_length 改为 1000 之后，macro f-score提示明显，我个人认为是在多分类问题中，那些长度很长的评论可能会有部分属于那些样本数很少的类别，padding过短会导致这些长评论无法被正确划分。

## 3. 其他算法问题

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