<font color=#c7254e>**摘要心得1：**</font>

> 1. Sigmoid 和 Tanh 为什么会导致 Vanishing/Exploding gradients ? 
> 2. Tanh 值域 (-1,1) Sigmoid 值域 (0,1)
> 3. ReLU 的优点，和局限性分别是什么? 
> 4. [谈谈激活函数 Sigmoid,Tanh,ReLu,softplus,softmax](https://zhuanlan.zhihu.com/p/48776056)

<font color=#c7254e>**摘要心得2：**</font>

> 5. softmax函数可以看做是Sigmoid函数的一般化，可以进行多分类。
> 6. 非常适合用于`分类`问题： `Cross Entropy` 交叉熵损失函数
> 7. Square error loss function 与 Cross Entropy Error Function 分别适合什么景？
> 8. [偏差和方差与过拟合欠拟合的关系 ?](https://blog.csdn.net/u012033832/article/details/78401486)

<font color=#c7254e>**摘要心得3：**</font>

> 解决 overfiting 的方法:
> 
> 1. Data augmentation
> 2. Regularization
> 3. Model Ensembel
> 4. Dropout 是 model 集成方法中最高效常用的技巧

> Batch Normalization 可以有效避免复杂参数对网络训练产生的影响，也可提高泛化能力.
> 
> 神经网路的训练过程的本质是学习数据分布，如果训练数据与测试数据分布不同，将大大降低网络泛化能力， BN 是针对每一批数据，在网络的每一层输入之前增加 BN，(均值0，标准差1)。
> 
> Dropout 可以抑制过拟合，作用于每份小批量的训练数据，随机丢弃部分神经元机制. bagging 原理.

<font color=#c7254e>**摘要心得4：**</font>  

**RF & GBDT 区别:**

> 1. 组成 RF 的树可以是分类树，也可以是回归树；而GBDT只由回归树组成 
> 2. 组成 RF 的树可以并行生成；而GBDT只能是串行生成 
> 3. 对于最终的输出结果而言，随机森林采用多数投票等；而GBDT则是将所有结果累加起来，或者加权累加起来 
> 4. RF 对异常值不敏感，GBDT对异常值非常敏感 
> 5. RF 对训练集一视同仁，GBDT是基于权值的弱分类器的集成 
> 6. RF 是通过减少模型方差提高性能，GBDT是通过减少模型偏差提高性能

**LR 和 SVM 区别:**

> 1. LR是参数模型，SVM是非参数模型。
> 2. LR: logistical loss，SVM: hinge loss
>   这两个损失函数的目的都是增加对分类影响较大的数据点的权重，减少与分类关系较小的数据点的权重。
> 3. LR 大规模线性分类时比较方便。而SVM的理解和优化相对来说复杂一些，SVM转化为对偶问题后,分类只需要计算与少数几个支持向量的距离,这个在进行复杂核函数计算时优势很明显,能够大大简化模型和计算。
> 4. SVM 不直接依赖数据分布，而LR则依赖，因为SVM只与支持向量那几个点有关系，而**LR和所有点都有关系**。

一般用线性核和高斯核，也就是Linear核与RBF核需要注意的是需要对数据归一化处理.

一般情况下RBF效果是不会差于Linear但是时间上RBF会耗费更多

吴恩达的见解：

> 1. 如果Feature的数量很大，跟样本数量差不多，这时候选用LR或者是Linear Kernel的SVM
> 2. 如果Feature的数量比较小，样本数量一般，不算大也不算小，选用SVM+Gaussian Kernel
> 3. 如果Feature的数量比较小，而样本数量很多，需要手工添加一些feature变成第一种情况

### 3. [经验风险最小化和结构风险最小化SPM](https://blog.csdn.net/munan2017/article/details/80288090)

### 2. [机器学习常见面试题整理](http://kubicode.me/2015/08/16/Machine%20Learning/Common-Interview/)

### 3. [机器学习面试题总结](https://zhuanlan.zhihu.com/c_129612503)

### 5. [BAT机器学习面试1000题系列](https://blog.csdn.net/v_july_v/article/details/78121924)

## 工程架构

### 1. [47道机器学习常见面试题（上）](https://zhuanlan.zhihu.com/p/45091568)


### 2. [操作系统面试题](https://zhuanlan.zhihu.com/p/23755202)

### 3. [网络面试题](https://zhuanlan.zhihu.com/p/24001696)

### 4. [TCP/IP四层模型](http://www.cnblogs.com/BlueTzar/articles/811160.html)

### 5. [数据库篇](https://zhuanlan.zhihu.com/p/23713529?refer=passer)

### 6. [面试题](http://python.jobbole.com/85231/)