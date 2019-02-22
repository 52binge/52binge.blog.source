
## 1. 兴趣挖掘

  - 数据量 sina week 10W+, 4W+
  - ABTest 效果评估
  - 什么 tree
  - depth
  - 特征选择，RF 与 GBDT 区别
  - loss

## 2. Chatbot

 - Attention 区别 (hard or soft)
 - 遇到过什么问题 （model_bucket）
 - 流程
 - BeamSearch
 - MMI
 - PPL 的意义

## 3. 评分卡

 - LR 如何处理数据不平衡？
 - GBDT 与Xgboost 区别 ?
 - GBDT 如何判断特征重要度？
 - 如何判断你的模型是否过拟合 ? 以及过拟合的处理方式？
 - 信息增益 与 Gini & 回归树..
 - LR 分析的变量 & GBDT 分析的变量分别是多少？
 - 如何将模型打包为 pmml？
 - 变量如何分箱？ IV 值的计算

**评估指标ks：**

等分 10 份，两条洛伦兹曲线， TPR 与 FPR 的差值. 好坏客户的区程度.

**数据情况：**

> 23W+ 去掉一些灰用户，剩余 
>
> M1标准： 好/坏: 13W+ 坏 4K
>
> 30~50 : 1 都是正常的

**数据预处理：**

1. 缺失值太多
2. 非数值变量多 (emp_title..)
3. id, member_id 等
4. loan_amnt != df.funded_amnt
5. 空值填充为 0
6. 带 % 的浮点，去掉 %

> 好坏比是 34:1 是非常难以处理的样本了 

特征相关度筛选

```py
cor = df.corr()
cor.loc[:,:] = np.tril(cor, k=-1) # below main lower triangle of an array
cor = cor.stack()
cor[(cor > 0.55) | (cor < -0.55)] # 特征相关度筛选
```

**GBDT, GBRT, Xgboost, RF grid search**

```py
param_grid = {
    'learning_rate': [0.1, 0.05, 0.02, 0.01],
    'max_depth': [1,2,3,4],
    'min_samples_split': [50,100,200,400],
    'n_estimators': [100,200,400,800]
}
```

**特征重要度：**

```
# Top Ten， GBRT top 10 的参数有哪些，可以作为参考， GBRT 不仅是一个分类器，还能帮你筛选变量
# 比如 feature_importance = 0 的话，那么下一次 这个特征，你就去掉就可以了
# 重新用模型GBRT重新跑，或者用其他模型LR跑
# 或者其他的 RF 也可以帮助你做特征筛选
```

最后选择出 84 个变量， 然后在放到不同的模型中做训练，在 ensemble 应该效果还是不错的。

> 为什么要用回归，不用分类，其实我们在做分类器的过程中，大部分用回归的算法，效果好一些，具体为什么，我有点忘记了

**特征不稳定的，不可以作为入模变量：**
    
> 挑选变量的时候，开始每个月我一直在看它的均值和方差的变化是否在容忍的范围内，超过50%舍

**模型更新周期：**

> 信贷产品比较长的话，2个月更新一次比较好，贷款周期短的话，周更新都可以， 月更新

## 4. 文本分类

 - FastText 多分类
 - RCNN & RNN 最大池化层
 - RNN 与 LSTM 与 GRU 区别
 - ELMO-Like


