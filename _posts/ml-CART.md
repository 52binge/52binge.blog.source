---
title: CART (not finish)
toc: true
date: 2016-08-24 11:43:21
categories: machine-learning
tags: [decision-tree]
description: classification and regression tree
mathjax: true
list_number: true
---

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

**Data Mining**

- 挖掘目标
- 数据取样
- 数据探索
- 数据预处理
- `挖掘建模`
- 模型评价

## 1. CART Introduce

在数据挖掘中，决策树主要有两种类型:

- 分类树 的输出是样本的类标。
- 回归树 的输出是一个实数 (例如房子的价格，病人呆在医院的时间等)。

> 术语 分类回归树(CART,Classification And Regression Tree) **CART** 包含了上述两种决策树, 最先由 Breiman 等提出.分类树和回归树有些共同点和不同点 — 例如处理在何处分裂的问题。

分类 — 划分离散变量  
回归 — 划分连续变量

### 1.1 CART What?

***CART*** 一种二分递归分割的技术，将当前的样本集分为两个子样本集，使得生成的决策树的每个非叶子节点都有两个分支，左分支对应取值为 `是` 的分支，右分支对应为 `否` 的分支.

***CART*** 学习过程等价于递归地二分每个特征，将输入空间（在这里等价特征空间）划分为有限个子空间（单元），并在这些子空间上确定预测的概率分布，也就是在输入给定的条件下输出对应的条件概率分布。

### 1.2 CART 纯度度量

CART中用于选择变量的不纯性度量是 **Gini index**；如果目标变量是标称的，并且是具有两个以上的类别，则CART可能考虑将目标类别合并成两个超类别（双化）；如果目标变量是连续的，则 CART 算法 找出一组基于树的回归方程来预测目标变量。

Algorithm | Feature Selection | Author
------- | ------- | -------
CART | 回归树： 最小二乘<br>分类树： 基尼指数 Gini index | Breiman. 1984<br>(Classification and Regression Tree 分类与回归树)

由于`分类树`与`回归树`在递归地构建二叉决策树的过程中，选择特征划分的准则不同。二叉分类树构建过程中采用 **Gini Index** 为特征选择标准；二叉回归树采用**平方误差最小化** 作为特征选择标准。

### 1.3 CART 步骤

`build decision tree`时通常采用自上而下的方法，在每一步选择一个最好的属性来分裂。 "最好" 的定义是使得子节点中的训练集尽量的纯。不同的算法使用不同的指标来定义"最好"。

***CART*** 是在给定输入随机变量 $X$ 条件下求得输出随机变量 $Y$ 的条件概率分布的学习方法。

> 可以看出CART算法在叶节点表示上不同于ID3、C4.5方法，后二者叶节点对应数据子集通过“多数表决”的方式来确定一个类别（固定一个值）；而CART算法的叶节点对应类别的概率分布。

CART算法也主要由两步组成：

- 决策树的生成：基于训练数据集生成一棵二分决策树；
- 决策树的剪枝：用验证集对已生成的二叉决策树进行剪枝，剪枝的标准为损失函数最小化。


## 2. 二叉分类树

二叉分类树中用基尼指数（Gini Index）作为最优特征选择的度量标准。

**GINI Index :**

1. 是一种不等性度量；
2. 通常用来度量收入不平衡，可以用来度量任何不均匀分布；
3. 是介于0~1之间的数，0-完全相等，1-完全不相等；
4. 总体内包含的类别越杂乱，GINI指数就越大（跟熵的概念很相似）

### 2.1 Gini Index

同样以分类系统为例，数据集 $D$ 中类别 $C$ 可能的取值为$c\_1, c\_2, \cdots, c\_k$ （$k$是类别数），一个样本属于类别 $c\_i$ 的概率为$p(i)$。那么概率分布的 Gini index 公式表示为：

$$ 
Gini(D) = 1 - \sum_{i=1}^{k} {p\_i}^2    \qquad(fmt.2.1.1)
$$

> 其中$p\_i = \frac{类别属于c\_i的样本数}{总样本数}$。如果所有的样本 Category 相同，则 $p_1 = 1, p_2 = p_3 = \cdots = p_k = 0$，则有$p_1 = 1, p_2 = p_3 = \cdots = p_k = 0$，此时数据不纯度最低。$Gini(D)$ 的物理含义是表示数据集 $D$ 的不确定性。数值越大，表明其不确定性越大（这一点与 [Info Entropy][5] 相似）。
如果 $k=2$（二分类问题，类别命名为正类和负类），若样本属于正类的概率是 $p$，那么对应基尼指数为：

> $$
\begin{align} Gini(D) & = 1 - [p^2 + {(1-p)}^2] \\\ & = \underline {2p (1-p)} \qquad\qquad (fmt.2.1.2)
\end{align}
$$

如果数据集 $D$ 根据特征 $f$ 是否取某一可能值 $f\_∗$，将 $D$ 划分为 $D\_1=\{(x, y) \in D | f(x) = f\_{\ast}\}, D\_2=D-D\_1$。那么特征 $f$ 在数据集 $D$ 上的 Gini index 定义为：

$$
Gini(D, f=f\_{\ast}) = \frac{\vert D_1 \vert}{\vert D \vert} Gini(D\_1) + \frac{\vert D\_2 \vert}{\vert D \vert} Gini(D_2) \qquad\qquad (fmt.2.1.3)
$$

### 2.2 Gini Example

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

在实际操作中，通过遍历所有特征（如果是连续值，需做离散化）及其取值，选择 $Min_{gini-index}$ 所对应的特征和特征值。

这里仍然以天气数据为例，给出特征**阴晴**的 Gini index 计算过程。

> (1). 当特征“阴晴”取值为”sunny”时，$D\_1 = \{1,2,8,9,11\}, |D\_1|=5$；$D\_2=\{3,4,5,6,7,10,12,13,14\}, |D\_2|=9$. 数据自己对应的类别数分别为 $(+2,-3)、(+7,-2)$。因此 $Gini(D\_1) = 2 \cdot \frac{3}{5} \cdot \frac{2}{5} = \frac{12}{25}$；$Gini(D_2) = 2 \cdot \frac{7}{9} \cdot \frac{2}{9} = \frac{28}{81}$. 对应的基尼指数为：
$$
Gini(C, “阴晴”=”sunny”) = \frac{5}{14} Gini(D_1) + \frac{9}{14} Gini(D_2) = \frac{5}{14} \frac{12}{25} + \frac{9}{14} \frac{28}{81} = 0.394 \quad(exp.2.2.1)
$$
> (2). 当特征“阴晴”取值为”overcast”时，$D\_1 = \{2,7,12,13\}, |D\_1|=4$；$D\_2=\{1,2,4,5,6,8,9,10,11,14\}, |D\_2|=10$。$D\_1$、$D\_2$ 数据自己对应的类别数分别为 $(+4,-0)、(+5,-5)$。因此 $Gini(D\_1) = 2 \cdot 1 \cdot 0 = 0；Gini(D\_2) = 2 \cdot \frac{5}{10} \cdot \frac{5}{10} = \frac{1}{2}$ 对应的基尼指数为：
$$
Gini(C, “阴晴”=”overcast”) = \frac{4}{14} Gini(D_1) + \frac{10}{14} Gini(D_2) = 0 + \frac{10}{14} \cdot \frac{1}{2} = \frac{5}{14} = 0.357 \quad(exp.2.2.2)
$$

> (3). 当特征“阴晴”取值为”rainy”时，$D\_1 = \{4,5,6,10,14\}, |D\_1|=5$; $D_2=\{1,2,3,7,8,9,11,12,13\}, |D_2|=9$。 $D\_1$、$D\_2$ 数据自己对应的类别数分别为 $(+3,−2)、(+6,−3)$。因此 $Gini(D\_1) = 2 \cdot \frac{3}{5} \cdot \frac{2}{5} = \frac{12}{25}$；$Gini(D\_2) = 2 \cdot \frac{6}{9} \cdot \frac{3}{9} = \frac{4}{9}$。 对应的基尼指数为：
$$
Gini(C, “阴晴”=”rainy”) = \frac{5}{14} Gini(D_1) + \frac{9}{14} Gini(D_2) = \frac{5}{14} \frac{12}{25} + \frac{9}{14} \frac{4}{9} = \frac{4}{7} = 0.457 \quad(exp.2.2.3)
$$

如果特征”阴晴”是最优特征的话，那么特征取值为”overcast”应作为划分节点。

## 3. 二叉回归树 (not finish)

**二叉回归树** 采用 `平方误差最小化作为特征选择` 和 切分点选择的依据。一棵回归树对应着特征空间的若干个划分及其在划分单元上的输出值。假设将特征空间划分为 $J$ 个单元（子空间），分别是 ${R\_1,R\_2,⋯,R\_J}$，在每个单元 $R\_j$（对应回归树的一个叶子节点）上有一个固定的输出值 $v\_j$（连续变量）。给定训练数据集$D=\{(x^{(1)}, y^{(1)}), (x^{(2)}, y^{(2)}), \cdots, (x^{(m)}, y^{(m)})\}$，二叉回归树模型可表示为：

$$
f(x) = \sum_{j=1}^{J} v_j \cdot I(x \in R_j) \qquad (exp.3.1.1)
$$

## Reference article

- [CART-文库PPT][6]
- [CART-Veyron][7]
- [52caml][8]

[0]: /images/ml-cart-00.png
[1]: /images/ml-cart-01.png
[2]: /images/ml-cart-02.png
[3]: /images/ml-cart-03.png
[4]: /images/ml-cart-04.png
[5]: /2016/08/18/ml-entropy-base/

[6]: http://wenku.baidu.com/link?url=aHNTy791blu36AysYKLXxRLkU4XlzxPNoyOEpZaRtCOM83C8mAUmNKWktm_lKF65WuCAUvyBKZnG_Jw91NzYhD8EfmDCpXEkX-PjwVqSKYC
[7]: http://wenku.baidu.com/link?url=aHNTy791blu36AysYKLXxRLkU4XlzxPNoyOEpZaRtCOM83C8mAUmNKWktm_lKF65WuCAUvyBKZnG_Jw91NzYhD8EfmDCpXEkX-PjwVqSKYC
[8]: http://www.52caml.com/