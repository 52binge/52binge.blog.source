---
title: Decision Tree Part1
toc: true
date: 2016-08-16 16:43:21
categories: machine-learning
tags: [decision-tree]
---

决策树（decision tree）是一个树结构（可以是二叉树或非二叉树）。其每个非叶节点表示一个特征属性上的测试，每个分支代表这个特征属性在某个值。

<!-- more -->

## 1. Classification Introduce

> 分类有着广泛的应用，如医学疾病判别、垃圾邮件过滤、垃圾短信拦截、客户分析等等。分类问题可以分为两类

### 1.1 归类 : 离散

归类 是指对`离散数据`的分类，比如对根据一个人的笔迹判别这个是男还是女，这里的 Category 只有两个，类别是离散的集合空间{男，女}的。

### 1.2 预测 : 连续

预测 是指对`连续数据`的分类，比如预测明天8点天气的湿度情况，天气的湿度在随时变化，8点时的天气是一个具体值，它不属于某个有限集合空间。预测也叫回归分析，在金融领域有着广泛应用。

> 虽然对离散数据和连续数据的处理方式有所不同，但其实他们之间相互转化，比如我们可以根据比较的某个特征值判断，如果值大于0.5就认定为男性，小于等于0.5就认为是女性，这样就转化为连续处理方式；将天气湿度值分段处理也就转化为离散数据。

**数据分类** 分两个步骤：

1. 构造模型，利用训练数据集 训练 分类器；
2. 利用建好的分类器模型对测试数据进行分类。

> 好的分类器具有很好的泛化能力，即它不仅在训练数据集上能达到很高的正确率，而且能在未见过得测试数据集也能达到较高的正确率。如果一个分类器只是在训练数据上表现优秀，但在测试数据上表现稀烂，这个分类器就已经过拟合了，它只是把训练数据记下来了，并没有抓到整个数据空间的特征。

## 2. Decision Tree' Classification

代表性的例子说明 :

ID | 阴晴(F)	| 温度(F)	| 湿度(F)	| 刮风(F)	| 是否玩（C）
------- | ------- | ------- | ------- | ------- | -------
1	| sunny |	hot	 |	high |	false | 否
2	| sunny |	hot	 |	high |	true |	否
3	| overcast |	hot	 |	high |	false |	是
4	| rainy |	mild |	high |	false |	是
5	| rainy |	cool |	normal |	false |	是
6	| rainy |	cool |	normal |	true |	否
7	| overcast |	cool |	normal |	true |	是
8	| sunny |	mild |	high |	false | 否
9	| sunny |	cool |	normal | false |	是
10	| rainy |	mild |	normal | false |	是
11	| sunny |	mild |	normal | true |	是
12	| overcast |	mild |	high |	true |	是
13	| overcast |	hot |	normal |false | 是
14	| rainy |	mild |	high |	true |	否

利用ID3算法中的 Info Gain Feature Selection，递归的学习一棵决策树，得到树结构如下

<img src="/images/ml/decision-tree/decision-tree-2.png" width="560" height="400"/img>

> 决策树（decision tree）是一个树结构（可以是二叉树或非二叉树）。其每个非叶节点表示一个Feature属性上的测试，每个分支代表这个Feature属性在某个值域上的输出，而每个叶节点存放一个 Category 。使用 DT 进行决策的过程就是从 root 开始，测试待分类项中相应的 Feature 属性，并按照其值选择输出分支，直到到达叶子节点，将叶子节点存放的 Category 作为决策结果。

Feature Selection，如何量化最优Feature? `->` 导致 DT Algorithm 出现了 ID3、C4.5、C5.0、CART 等。

## 3. Decision Tree' Build

构造 Decision Tree 的关键步骤是分裂属性。所谓分裂属性就是在某个节点处按照某一特征属性的不同划分构造不同的分支，其目标是让各个分裂子集尽可能地“纯”。尽可能“纯”就是尽量让一个分裂子集中待分类项属于同一类别。

> 构造决策树的过程本质上就是根据 **data-feature** 将 数据集(D) 分类的递归过程，我们需要解决的第一个问题就是，**当前 数据集(D) 上哪个 Feature 在划分数据分类时起决定性作用**

### 3.1 构造 DT 流程

训练数据集 $D = \\{ (x^{(1)}，y^{(1)}) ， (x^{(2)}，y^{(2)})， ⋯ ， (x^{(m)}，y^{(m)}) \\}$ (Feature用离散值表示)  
候选特征集 $F = \\{f^1，f^2， ⋯，f^n \\}$

开始建立 Root节点，将所有训练数据都置于根节点（$m$条样本）。从 feature集合 $F$ 中选择一个最优特征 $f^∗$，按照 $f^∗$ 取值将 训练数据集(D) 切分成若干子集，使得各个自己有一个在当前条件下最好的分类。

如果子集中样本类别基本相同，那么构建叶节点，并将数据子集划分给对应的叶节点；如果子集中样本类别差异较大，不能被基本正确分类，需要在剩下的特征集合 $（F−{f^∗}）$ 中选择新的最优特征，继续对数据子集进行切分。如此递归地进行下去，直至所有数据自己都能被基本正确 Category，或者没有合适的最优特征为止。

这样最终结果是每个子集都被分到叶节点上，对应着一个明确的类别。那么，递归生成的层级结构即为一棵 DT。

### 3.2 伪代码构造 DT

  输入 : 训练数据集 $D = \\{ (x^{(1)}，y^{(1)}) ， (x^{(2)}，y^{(2)})， ⋯ ， (x^{(m)}，y^{(m)}) \\}$(Feature用离散值表示)   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;候选特征集 $F = \\{f^1，f^2， ⋯，f^n \\}$

  输出 : T(D, F)

<img src="/images/ml/decision-tree/decision-tree-3.png" width="760" height="400"/img>

决策树学习过程中递归的每一步，在选择最优特征后，根据特征取值切割当前节点的数据集，得到若干数据子集。  
算法的时间复杂度是O(k*|D|*log(|D|))，k为属性个数，|D|为记录集D的记录数。

## 4. Feature Selection

递归地选择最优feature，根据feature取值切割数据集，使得对应的数据子集有一个较好的分类。从伪代码中也可以看出，在决策树学习过程中，最重要的是第07行，即如何选择最优feature？也就是我们常说的feature选择问题。

在这里，希望随着feature选择过程地不断进行，决策树的分支节点所包含的样本尽可能属于同一类别，即希望节点的”纯度（purity）”越来越高。

> 如子集中的样本都属于同一个类别，是最好的结果；如果说大多数的样本类型相同，只有少部分样本不同，也可以接受。

那么如何才能做到选择的特征对应的样本子集纯度最高呢？

Algorithm | Feature 选择方法 | Author
------- | ------- | -------
ID3 | Information gain | Quinlan. 1986
C4.5 | Gain ratio | Quinlan. 1993.
CART | 回归树： 最小二乘<br>分类树： 基尼指数 Gini index | Breiman. 1984<br>(Classification and Regression Tree 分类与回归树)

> ID3 (Iterative Dichotomiser)

### 4.1 Information Gain

信息增益（Information Gain）衡量 Feature 的重要性是根据当前 Feature 为划分带来多少信息量，带来的信息越多，该 Feature 就越重要，此时节点的”纯度”也就越高。

[Infomation Entropy][3]

> 对一个分类系统来说，假设类别 $C$ 可能的取值为 $c_1，c_2，⋯，c_k$（$k$是类别总数），每一个类别出现的概率分别是 $p(c_1)，p(c_2)，⋯，p(c_k)$。此时，分类系统的 Entropy 可以表示为:
>
> $$
info(C) = -  \sum_{i=1}^k p(c\_i) \cdot log\_2 p(c\_i) \qquad (fml.4.1.1)
$$

> 分类系统的作用就是输出一个特征向量（文本特征、ID特征 等）属于哪个 Category 的值，而这个值可能是 $c_1，c_2，⋯，c_k$ ，因此这个值所携带的信息量就是 (fml.4.1.1) 公式这么多

**Condition Entropy**

假设 离散特征 $f$ 的取值有 $I$ 个，$info(C|f=f\_i)$ 表示特征 $f$ 被取值为 $f\_i$ 时的***Condition Entropy***； $info(C|f)$ 是指特征 $f$ 被固定时的 ***Condition Entropy***。二者之间的关系是：

> $$
\begin{align}
info(C|f) & = p\_1 \cdot info(C|f=f\_1) + p\_2 \cdot info(C|f=f\_2) + ... + p\_k \cdot info(C|f=f\_{k}) \\\ & = \sum_{i=1}^{I} p\_i \cdot info(C|f=f\_i) \end{align}  \quad (fml.4.1.2)
$$
> 假设总样本数有 $m$ 条，特征 $f=f\_i$ 时的样本数 $m\_i，p\_i=\frac{m\_i}{m}$.

**如何求 $P(C|f=f\_i)$** ?

> 二分类情况 :
> 
> 以二分类为例（正例为1，负例为0），总样本数为 $m$ 条，特征 $f$ 的取值为 $I$ 个，其中特征 $f=f\_i$ 对应的样本数为 $m\_i$ 条，其中正例 $m\_{i1}$ 条，负例 $m\_{i0}$ 条 $m\_i = m\_{i0} + m\_{i1}$ 。那么有：
> 
> $$
\begin{align} info(C|f=f\_i) & = - \frac{m\_{i1}}{m\_i} \cdot log\_{2} \frac{m\_{i1}}{m\_i} - \frac{m\_{i0}}{m\_i} \cdot log\_{2} \frac{m\_{i0}}{m\_i} \end{align} \qquad (fml.4.1.3)
$$
> 多分类情况:
> 
> $$
\begin{align} info(C|f=f\_i) = -\sum\_{j=0}^{k-1} \frac{m\_{ij}}{m\_i} \cdot log\_{2} \frac{m\_{ij}}{m\_i} \end{align} \qquad (fml.4.1.4)
$$

> 公式$\frac{m\_{ij}}{m\_i}$物理含义是当 $f=f\_i$ 且 $C=c\_j$ 的概率，即条件概率 $p(c\_j|f\_i)$
> 
> 因此，***Condition Entropy*** 计算公式为：
> 
$$
\begin{align} info(C|f) & = \sum\_{i=1}^{I} p(f\_i) \cdot info(C|f=f\_i) \\\ & = - \sum\_{i=1}^{I} p(f\_i) \cdot \underline { \sum\_{j=0}^{k-1} p(c\_j|f\_i) \cdot log\_2 p(c\_j|f\_i) } \qquad (fml.4.1.5)
\end{align}
$$

特征 $f$ 给系统带来的 info gain 等于系统原有的 Entropy 与固定特征 $f$ 的 ***Condition Entropy*** 之差，公式表示如下:

> $$
\begin{align} IG(F) & = E(C) - E(C|F) \\\ & = -\sum\_{i=1}^{k} p(c\_i) \cdot \log\_{2} p(c\_i) + \sum\_{i=1}^{I} p(f\_i) \cdot \underline { \sum\_{j=0}^{k-1} p(c\_j|f\_i) \cdot log\_2 p(c\_j|f\_i) } \end{align}  \qquad (fml.4.1.6)
$$

> $n$ 表示特征 $f$ 取值个数，$k$ 表示类别 $C$ 个数，$\sum\_{j=0}^{n-1} \frac{m\_{ij}}{m\_i} \cdot log\_{2} \frac{m\_{ij}}{m\_i}$ 表示每一个类别对应的 Entropy 。
 
***

**下面以天气数据为例,通过 `Info gain` 选择最优 feature 的过程 :**

> 根据 阴晴、温度、湿度 和 刮风 来决定是否出去玩。样本中总共有 14 条记录，取值为 `是`(9个正样本)、`否`(5个负样本)，用 $S(9+,5−)$ 表示.
> 
> 
>
> (1). 分类系统的 Entropy :
> $$
Entropy(S) = info(9,5) = (-\frac{9}{14} _ llog\_2 (\frac{9}{14})) + (- \frac{5}{14} _ llog\_2 (\frac{5}{14})) = 0.940位   \quad (exp.4.1.1)
$$
> (2). 如果以特征”阴晴”作为根节点。“阴晴”取值为{sunny, overcast, rainy}, 分别对应的正负样本数分别为(2+,3-), (4+,0-), (3+,2-)，那么在这三个节点上的 info Entropy 分别为：
> $$
> \begin{align} & Entropy(S| “阴晴”=sunny) = info(2,3) = 0.971位  \quad(exp.4.1.1) \\\ & Entropy(S| “阴晴”=overcast) = info(4,0) = 0位  \;\;\quad(exp.4.1.2) \\\ & Entropy(S| “阴晴”=rainy) = info(3,2) = 0.971位  \;\quad(exp.4.1.3) \end{align}
> $$
> 
> 以 Feature “阴晴” 为根节点，平均信息值（即 **Condition Entropy**）为：
> $$
Entropy(S|“阴晴”) = \frac{5}{14} \* 0.971 + \frac{4}{14} \* 0 + \frac{5}{14} \* 0.971 = 0.693位 \quad (exp.4.1.4)
$$
> 
> 以 Feature “阴晴” 为条件，计算得到的 **Condition Entropy** 代表了期望的信息总量，即对于一个新样本判定其属于哪个类别所必需的信息量。
> 
> (3). 计算特征“阴晴”“阴晴”对应的信息增益:
> $$
> IG( “阴晴”) = Entropy(S) - Entropy(S| “阴晴”) = 0.247位 \quad\quad(exp.4.1.5)
> $$
> 
> 同样的计算方法，可得每个特征对应的信息增益，即
> $$
IG(“刮风”) = Entropy(S) - Entropy(S|“刮风”) = 0.048位 \qquad\qquad(exp.4.1.6) \\\ IG(“湿度”) = Entropy(S) - Entropy(S|“湿度”) = 0.152位 \qquad\qquad(exp.4.1.7) \\\ IG(“温度”) = Entropy(S) - Entropy(S|“温度”) = 0.029位 \qquad\qquad(exp.4.1.8)
$$
> 
显然，Feature “阴晴” 的 info gain 最大，于是把它作为划分特征。基于“阴晴”对根节点进行划分的结果，如图4.5所示（决策树学习过程部分）。决策树学习算法对子节点进一步划分，重复上面的计算步骤。

<img src="/images/ml/decision-tree/decision-tree-2.png" width="560" height="400"/img>

### 4.2 Gain ratio

与 Info Gain 不同，`Gain ratio` 的计算考虑了 F 分裂数据集后所产生的子节点的数量和规模，而**忽略任何有关类别的信息**。

> 以 info gain 示例为例，按照 特征“阴晴” 将数据集分裂成3个子集，规模分别为5、4和5，因此不考虑子集中所包含的类别，产生一个分裂信息为：

> $$
SplitInfo(“阴晴”) = info(5,4,5) = 1.577位 \qquad (exp.4.2.1)
$$
> **Split Information Entropy** 可简单地理解为表示信息分支所需要的信息量。 

> 那么 Info Gain ratio ：
$$
IG\_{ratio}(F) = \frac {IG(F)} {SplitInfo(F)} \qquad (exp.4.2.2)
$$
> 在这里，特征 “阴晴”的 Gain ratio 为 $IG_{ratio}( “阴晴”)=\frac{0.247}{1.577} = 0.157$。减少信息增益方法对取值数较多的特征的影响。(可以减少过拟合，这等于是对 某特征取值过多的一个惩罚)

```py
>>> -(math.log((5.0/14.0), 2) * (5.0/14.0) * 2 + (4.0/14.0) * (math.log((4.0/14.0), 2)))
1.577406282852345
>>>
```

## Reference article

- [逗比算法工程师][9]、[算法杂货铺][10]、[52caml][11]
- [决策树ID3、C4.5、CART算法：信息熵，区别，剪枝理论总结][c2]
- 《机器学习导论》《统计学习方法》

[c1]: http://blog.csdn.net/blueloveyyt/article/details/45013403
[c2]: http://blog.csdn.net/ljp812184246/article/details/47402639

[1]: /images/ml/decision-tree/decision-tree-1.jpg
[2]: /images/ml/decision-tree/decision-tree-2.png
[3]: /2016/08/18/ml-entropy-base/

[5]: https://en.wikipedia.org/wiki/Heuristic_(computer_science)
[6]: https://en.wikipedia.org/wiki/Greedy_algorithm
[7]: https://en.wikipedia.org/wiki/ID3_algorithm
[8]: https://en.wikipedia.org/wiki/C4.5_algorithm

[9]: http://www.cnblogs.com/fengfenggirl/p/classsify_decision_tree.html
[10]: http://www.52caml.com/
[11]: http://www.cnblogs.com/leoo2sk/archive/2010/09/19/decision-tree.html

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>