### 1. RF & GBDT 区别

GBDT和随机森林的相同点： 

> 1. 都是由多棵树组成 
> 2. 最终的结果都是由多棵树一起决定

GBDT和随机森林的不同点： 

> 1. 组成 RF 的树可以是分类树，也可以是回归树；而GBDT只由回归树组成 
> 2. 组成 RF 的树可以并行生成；而GBDT只能是串行生成 
> 3. 对于最终的输出结果而言，随机森林采用多数投票等；而GBDT则是将所有结果累加起来，或者加权累加起来 
> 4. RF 对异常值不敏感，GBDT对异常值非常敏感 
> 5. RF 对训练集一视同仁，GBDT是基于权值的弱分类器的集成 
> 6. RF 是通过减少模型方差提高性能，GBDT是通过减少模型偏差提高性能

#### [LR和SVM的联系区别](https://zhuanlan.zhihu.com/p/30419036)

### 2. [机器学习常见面试题整理](http://kubicode.me/2015/08/16/Machine%20Learning/Common-Interview/)

### 3. [机器学习面试题总结](https://zhuanlan.zhihu.com/c_129612503)

### 4. [机器学习常见面试题（上）](https://zhuanlan.zhihu.com/p/45091568)

### 5. [BAT机器学习面试1000题系列](https://blog.csdn.net/v_july_v/article/details/78121924)

