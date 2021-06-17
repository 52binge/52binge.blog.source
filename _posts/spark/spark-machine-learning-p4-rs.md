---
title: Spark Machine Learning p4 - Build Recommendation System
date: 2016-11-23 15:28:21
categories: [spark]
tags: [spark, recommendation-system]
---

Spark build Recommendation System, 推荐引擎试图对用户与某类物品之间的联系建模

<!-- more -->

- 推荐引擎的类型；
- 用用户偏好数据来建立一个推荐模型；
- 为用户进行推荐和求指定物品的类似物品；
- 评估该模型的预测能力。

## 1. 推荐模型分类

- 内容过滤
- 协同过滤
- 矩阵分解

### 1.1 内容过滤 - (类似物品)

利用物品相似度定义，来求出与该物品类似的物品。

> 对用户的推荐可以根据用户的属性或描述得出，之后再通过相同的相似度定义来与物品属性做匹配。

### 1.2 协同过滤 - (估计未触)

协同过滤是一种利用大量已有的用户偏好来估计用户对其`未接触过`的物品的喜好程度。其内在思想是**相似度的定义**。

- 基于用户
> 如果两个用户表现出相似的偏好，认为他们的兴趣类似。要对他们中的一个用户推荐一个未知物品，便可选取若干与其类似的用户并根据他们的喜好计算出对各个物品的综合得分。

- 基于物品
> 据现有用户对物品的偏好或是评级情况，来计算物品之间的某种相似度。已有物品相似的物品被用来生成一个综合得分，而该得分用于评估未知物品的相似度。

基于**用户**或**物品**的方法得分取决于若干用户或是物品之间依据相似度所构成的集合（即邻居），故它们也常被称为KNN。

对“用户-物品”`偏好建模`

### 1.3 矩阵分解

Spark推荐模型库 包含基于矩阵分解（matrix factorization）的实现，该模型在协同过滤中的表现十分出色。

#### 1.3.1 显式矩阵分解

显式自身偏好数据

> 这类数据包括如物品评级、赞、喜欢等用户对物品的评价。转换为以用户为行、物品为列的二维矩阵。

> 大部分情况下单个用户只会和少部分物品接触，所以该矩阵很稀疏。

```
Tom, Star Wars, 5
Jane, Titanic,　4
Bill, Batman,　3
Jane, Star Wars, 2
Bill, Titanic, 3
```

![一个简单的电影评级矩阵][1]

用户-物品 矩阵的维度为 U × I

![图4-2 一个稀疏的评级矩阵][2] 

**为了降维**

- 表示用户的 U × k 维矩阵
- 表征物品的 I × k 维矩阵

> 这两个矩阵也称作因子矩阵, 乘积是原始评级矩阵的一个近似.

> 原始评级矩阵通常很稀疏，但因子矩阵却是稠密的

![图4-3 用户因子矩阵和物品因子矩阵][3]

> 因子可能表示了某些含义，比如对电影的某个导演、种类、风格或某些演员的偏好。

`要计算给定用户对某个物品的预计评级` = 行（用户因子向量） 与 列（物品因子向量），两者点积

![图4-4 用用户因子矩阵和物品因子矩阵计算推荐][4]

> 物品之间相似度的计算，转换为对两物品因子向量之间相似度的计算

![图4-5 用物品因子矩阵计算相似度][5]

优点 | 缺点
------- | -------
因子分解类模型建立，求解容易 | 物品或是用户的因子向量可能达到数以百万计。在存储和计算能力有挑战。

#### 1.3.2. 隐式矩阵分解

隐含在用户与物品的交互之中。二元数据（比如用户是否观看了某个电影或是否购买了某个商品）和计数数据（比如用户观看某电影的次数）便是这类数据。

MLlib 处理隐式数据：
 
 1. 一个二元偏好矩阵 P 
 2. 一个信心权重矩阵 C

![图4-6 用物品因子矩阵计算相似度][6]

隐式模型仍然会创建一个用户因子矩阵和一个物品因子矩阵。但是，模型所求解的是偏好矩阵而非评级矩阵的近似。

**3. 最小二乘法**

最小二乘法（Alternating Least Squares，ALS）是一种求解矩阵分解问题的最优化方法。且相对容易并行化。

> ALS的实现原理是迭代式求解一系列最小二乘回归问题。在每一次迭代时，固定用户因子矩阵或是物品因子矩阵中的一个，然后用固定的这个矩阵以及评级数据来更新另一个矩阵。之后，被更新的矩阵被固定住，再更新另外一个矩阵。如此迭代，直到模型收敛（或是迭代了预设好的次数）。

## 2. 提取有效特征

```scala
>./bin/spark-shell –-driver-memory 2g
val rawData = sc.textFile("/Users/hp/ghome/github/Recommendation/spark-ml/ml-100k/u.data")
rawData.first()
val rawRatings = rawData.map(_.split("\t").take(3))
import org.apache.spark.mllib.recommendation.ALS

ALS.
asInstanceOf    isInstanceOf   main   toString        train           trainImplicit
ALS.train
```

ALS模型需要一个由Rating记录构成的RDD，而Rating类则是对用户ID、影片ID（这里是通称product）和实际星级这些参数的封装。
我们可以调用map方法将原来的各ID和星级的数组转换为对应的Rating对象，从而创建所需的评级数据集。

```scala
scala> import org.apache.spark.mllib.recommendation.Rating
import org.apache.spark.mllib.recommendation.Rating

scala> val ratings = rawRatings.map { case Array(user, movie, rating) =>
     | Rating(user.toInt, movie.toInt, rating.toDouble) }
ratings: org.apache.spark.rdd.RDD[org.apache.spark.mllib.recommendation.Rating] = MapPartitionsRDD[3] at map at <console>:27

scala> ratings.first()
res3: org.apache.spark.mllib.recommendation.Rating = Rating(196,242,3.0)

scala> ratings.take(10)
res4: Array[org.apache.spark.mllib.recommendation.Rating] = Array(Rating(196,242,3.0), Rating(186,302,3.0), Rating(22,377,1.0), Rating(244,51,2.0), Rating(166,346,1.0), Rating(298,474,4.0), Rating(115,265,2.0), Rating(253,465,5.0), Rating(305,451,3.0), Rating(6,86,3.0))
```

## 3. 训练推荐模型

从原始数据提取出这些简单特征后，便可训练模型。MLlib已实现模型训练的细节，这不需要我们担心。我们只需提供上述指定类型的新RDD以及其他所需参数来作为训练的输入即可。

### 3.1 Movie-100k train model

现在开始训练模型了，所需的其他参数有以下几个

- ``rank``：对应ALS模型中的因子个数，也就是在低阶近似矩阵中的隐含特征个数。因子个数一般越多越好。但它也会直接影响模型训练和保存时所需的内存开销，尤其是在用户和物品很多的时候。因此实践中该参数常作为训练效果与系统开销之间的调节参数。通常，其合理取值为10到200。
- ``iterations``：对应运行时的迭代次数。ALS能确保每次迭代都能降低评级矩阵的重建误差，但一般经少数次迭代后ALS模型便已能收敛为一个比较合理的好模型。这样，大部分情况下都没必要迭代太多次（10次左右一般就挺好）。
- ``lambda``：该参数控制模型的正则化过程，从而控制模型的过拟合情况。其值越高，正则化越严厉。该参数的赋值与实际数据的大小、特征和稀疏程度有关。和其他的机器学习模型一样，正则参数应该通过用非样本的测试数据进行交叉验证来调整。

```scala
scala> val model = ALS.train(ratings, 50, 10, 0.01)
model: org.apache.spark.mllib.recommendation.MatrixFactorizationModel = org.apache.spark.mllib.recommendation.MatrixFactorizationModel@2e835760

scala> model.userFeatures
res5: org.apache.spark.rdd.RDD[(Int, Array[Double])] = users MapPartitionsRDD[209] at mapValues at ALS.scala:255

scala> model.userFeatures.count
res6: Long = 943
```

> `MatrixFactorizationModel` 对象将 用户因子和物品因子分别保存在一个 `(id,factor)` 对类型的RDD中。
> 它们分别称作`userFeatures` 和 `productFeatures`。

### 3.2 隐式反馈数据训练模型

MLlib中标准的矩阵分解模型用于显式评级数据的处理。若要处理隐式数据，则可使用`trainImplicit`函数。其调用方式和标准的`train`模式类似，但多了一个可设置的`alpha`参数（也是一个正则化参数，`lambda`应通过测试和交叉验证法来设置）。

alpha参数指定了信心权重所应达到的基准线。该值越高则所训练出的模型越认为用户与他所没评级过的电影之间没有相关性。

## 4. 使用推荐模型

预测通常有两种：为某个用户推荐物品，或找出与某个物品相关或相似的其他物品。

### 4.1 用户推荐

通过模型求出用户可能喜好程度最高的前K个商品。

 1. 基于**用户的模型**，则会利用相似用户的评级来计算对某个用户的推荐。
 2. 基于**物品的模型**，则会依靠用户接触过的物品与候选物品之间的相似度来获得推荐。

利用矩阵分解方法时，是直接对评级数据进行建模，所以预计得分可视作相应用户因子向量和物品因子向量的点积。

**1. 从MovieLens 100k数据集生成电影推荐**

MLlib的推荐模型基于矩阵分解，因此可用模型所求得的因子矩阵来计算用户对物品的预计评级。下面只针对利用MovieLens中显式数据做推荐的情形，使用隐式模型时的方法与之相同。

`MatrixFactorizationModel`类 提供了一个`predict`函数，以方便地计算给定用户对给定物品的预期得分：

```scala
scala> val predictedRating = model.predict(789, 123)
16/05/04 16:13:08 WARN BLAS: Failed to load implementation from: com.github.fommil.netlib.NativeSystemBLAS
16/05/04 16:13:08 WARN BLAS: Failed to load implementation from: com.github.fommil.netlib.NativeRefBLAS
predictedRating: Double = 1.8390368814083764

scala> val predictedRating = model.predict(789, 123)
predictedRating: Double = 1.8390368814083764

scala> val userId = 789
userId: Int = 789

scala> val K = 10
K: Int = 10

scala> val topKRecs = model.recommendProducts(userId, K)
topKRecs: Array[org.apache.spark.mllib.recommendation.Rating] = Array(Rating(789,180,5.352418839062572), Rating(789,887,5.289455638310055), Rating(789,484,5.0301818688410025), Rating(789,475,5.011219778604191), Rating(789,150,5.003965038415291), Rating(789,663,4.991126084946501), Rating(789,56,4.974685008959871), Rating(789,48,4.965402351329832), Rating(789,9,4.963265626841469), Rating(789,127,4.963069165947614))

scala> println(topKRecs.mkString("\n"))
Rating(789,180,5.352418839062572)
Rating(789,887,5.289455638310055)
Rating(789,484,5.0301818688410025)
Rating(789,475,5.011219778604191)
Rating(789,150,5.003965038415291)
Rating(789,663,4.991126084946501)
Rating(789,56,4.974685008959871)
Rating(789,48,4.965402351329832)
Rating(789,9,4.963265626841469)
Rating(789,127,4.963069165947614)
```

[1]: /images/spark/spark-ml-4.1.png
[2]: /images/spark/spark-ml-4.2.jpg
[3]: /images/spark/spark-ml-4.3.jpg
[4]: /images/spark/spark-ml-4.4.jpg
[5]: /images/spark/spark-ml-4.5.jpg
[6]: /images/spark/spark-ml-4.6.png
