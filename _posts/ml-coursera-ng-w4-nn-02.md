---
title: Coursera Week 4 - Neural Networks I
toc: true
date: 2017-02-07 10:28:21
categories: machine-learning
tags: Neural Networks
mathjax: true
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

coursera week 4 - neural networks representation

<!-- more -->

![NN][2]

neuron is a computational unit that gets a number of inputs through it input wires and does some computation and then it says outputs via its axon to other nodes or to other neurons in the brain.

## 1. Model Representation I

Let's examine how we will represent a hypothesis function using neural networks. At a very simple level, neurons are basically computational units that take inputs (**dendrites**) as electrical inputs (called "spikes") that are channeled to outputs (**axons**). In our model, **our dendrites are like the input features** $x_1\cdots x_n$, and the **output is the result of our hypothesis function**. In this model our $x\_0$ input node is sometimes called the "bias unit." It is always equal to 1. In neural networks, we use the same logistic function as in classification, $\frac{1}{1 + e^{-\theta^Tx}}$, yet we sometimes call it a sigmoid (logistic) **activation** function. In this situation, our "theta" parameters are sometimes called "weights".

Visually, a simplistic representation looks like:

$$
\begin{bmatrix}x\_0 \newline x\_1 \newline x\_2 \newline \end{bmatrix}\rightarrow\begin{bmatrix}\ \ \ \newline \end{bmatrix}\rightarrow h\_\theta(x)
$$

![NN][3]

Our input nodes (layer 1), also known as the "input layer", go into another node (layer 2), which finally outputs the hypothesis function, known as the "output layer".

We can have intermediate layers of nodes between the input and output layers called the "hidden layers."

In this example, we label these intermediate or "hidden" layer nodes $a^2\_0 \cdots a^2\_n$ and call them "activation units."

$$
\begin{align} & a\_i^{(j)} = \text{"activation" of unit $i$ in layer $j$} \newline& \Theta^{(j)} = \text{matrix of weights controlling function mapping from layer $j$ to layer $j+1$} \end{align}
$$

If we had one hidden layer, it would [look like][4]:

$$
\begin{bmatrix}x\_0 \newline x\_1 \newline x\_2 \newline x\_3\end{bmatrix}\rightarrow\begin{bmatrix}a\_1^{(2)} \newline a\_2^{(2)} \newline a\_3^{(2)} \newline \end{bmatrix}\rightarrow h\_\theta(x)
$$

The values for each of the "activation" nodes is obtained as follows:

$$
\begin{align} a\_1^{(2)} = g(\Theta\_{10}^{(1)}x\_0 + \Theta\_{11}^{(1)}x\_1 + \Theta\_{12}^{(1)}x\_2 + \Theta\_{13}^{(1)}x\_3) \newline a\_2^{(2)} = g(\Theta\_{20}^{(1)}x\_0 + \Theta\_{21}^{(1)}x\_1 + \Theta\_{22}^{(1)}x\_2 + \Theta\_{23}^{(1)}x\_3) \newline a\_3^{(2)} = g(\Theta\_{30}^{(1)}x\_0 + \Theta\_{31}^{(1)}x\_1 + \Theta\_{32}^{(1)}x\_2 + \Theta\_{33}^{(1)}x\_3) \newline h\_\Theta(x) = a\_1^{(3)} = g(\Theta\_{10}^{(2)}a\_0^{(2)} + \Theta\_{11}^{(2)}a\_1^{(2)} + \Theta\_{12}^{(2)}a\_2^{(2)} + \Theta\_{13}^{(2)}a\_3^{(2)}) \newline \end{align}
$$

This is saying that we compute our activation nodes by using a 3×4 matrix of parameters. We apply each row of the parameters to our inputs to obtain the value for one activation node. Our hypothesis output is the logistic function applied to the sum of the values of our activation nodes, which have been multiplied by yet another parameter matrix $\Theta^{(2)}$ containing the weights for our second layer of nodes.

Each layer gets its own matrix of weights, $\Theta^{(j)}$

The dimensions of these matrices of weights is determined as follows:

If network has $s\_j$ units in layer $j$ and $s\_{j+1}$ units in layer $j+1$, then $\Theta^{(j)}$ will be of dimension $s\_{j+1} \times (s\_j + 1)$

The +1 comes from the addition in $\Theta^{(j)}$ of the "bias nodes," $x\_0$ and $\Theta\_0^{(j)}$. In other words the output nodes will not include the bias nodes while the inputs will. 

## 2. Model Representation II

To re-iterate, the following is an example of a neural network:

$$
\begin{align} a\_1^{(2)} = g(\Theta\_{10}^{(1)}x\_0 + \Theta\_{11}^{(1)}x\_1 + \Theta\_{12}^{(1)}x\_2 + \Theta\_{13}^{(1)}x\_3) \newline a\_2^{(2)} = g(\Theta\_{20}^{(1)}x\_0 + \Theta\_{21}^{(1)}x\_1 + \Theta\_{22}^{(1)}x\_2 + \Theta\_{23}^{(1)}x\_3) \newline a\_3^{(2)} = g(\Theta\_{30}^{(1)}x\_0 + \Theta\_{31}^{(1)}x\_1 + \Theta\_{32}^{(1)}x\_2 + \Theta\_{33}^{(1)}x\_3) \newline h\_\Theta(x) = a\_1^{(3)} = g(\Theta\_{10}^{(2)}a\_0^{(2)} + \Theta\_{11}^{(2)}a\_1^{(2)} + \Theta\_{12}^{(2)}a\_2^{(2)} + \Theta\_{13}^{(2)}a\_3^{(2)}) \newline \end{align}
$$

In this section we'll do a vectorized implementation of the above functions. We're going to define a new variable $z\_k^{(j)}$ that encompasses the parameters inside our g function. In our previous example if we replaced by the variable z for all the parameters we would get:

$$
\begin{align}a\_1^{(2)} = g(z\_1^{(2)}) \newline a\_2^{(2)} = g(z\_2^{(2)}) \newline a\_3^{(2)} = g(z\_3^{(2)}) \newline \end{align}
$$

In other words, for layer $j=2$ and node $k$, the variable $z$ will be:

$$
z\_k^{(2)} = \Theta\_{k,0}^{(1)}x\_0 + \Theta\_{k,1}^{(1)}x\_1 + \cdots + \Theta\_{k,n}^{(1)}x\_n
$$

The vector representation of $x$ and $z^{j}$ is:

$$
\begin{align}x = \begin{bmatrix}x\_0 \newline x\_1 \newline\cdots \newline x\_n\end{bmatrix} &z^{(j)} = \begin{bmatrix}z\_1^{(j)} \newline z\_2^{(j)} \newline\cdots \newline z\_n^{(j)}\end{bmatrix}\end{align}
$$

Setting $x = a^{(1)}$, we can rewrite the equation as:

$$
z^{(j)} = \Theta^{(j-1)}a^{(j-1)}
$$

We are multiplying our matrix $\Theta^{(j-1)}$ with dimensions $s\_j\times (n+1)$ (where $s\_j$ is the number of our activation nodes) by our vector $a^{(j-1)}$ with height (n+1). This gives us our vector $z^{(j)}$ with height $s\_j$. Now we can get a vector of our activation nodes for layer $j$ as follows:

$$
a^{(j)} = g(z^{(j)})
$$

Where our function $g$ can be applied element-wise to our vector $z^{(j)}$.

We can then add a bias unit (equal to 1) to layer j after we have computed $a^{(j)}$. This will be element $a\_0^{(j)}$ and will be equal to 1. To compute our final hypothesis, let's first compute another $z$ vector:

$$
z^{(j+1)} = \Theta^{(j)}a^{(j)}
$$

We get this final z vector by multiplying the next theta matrix after $\Theta^{(j-1)}$ with the values of all the activation nodes we just got. This last theta matrix $\Theta^{(j)}$ will have only one row which is multiplied by one column $a^{(j)}$ so that our result is a single number. We then get our final result with:

$$
h\_\Theta(x) = a^{(j+1)} = g(z^{(j+1)})
$$

## 3. Simple Example

![NN][6]

### 3.1 $x\_1$ AND $x\_2$

A simple example of applying neural networks is by predicting $x\_1$ AND $x\_2$

$$
\begin{align} \begin{bmatrix}x\_0 \newline x\_1 \newline x\_2\end{bmatrix} \rightarrow\begin{bmatrix}g(z^{(2)})\end{bmatrix} \rightarrow h\_\Theta(x) \end{align}
$$

Let's set our first theta matrix as:

$$
\Theta^{(1)} =\begin{bmatrix}-30 & 20 & 20\end{bmatrix}
$$

This will cause the output of our hypothesis to only be positive if both $x\_1$ and $x\_2$ are 1. In other words:

$$
\begin{align}& h\_\Theta(x) = g(-30 + 20x\_1 + 20x\_2) \newline \newline & x\_1 = 0 \ \ and \ \ x\_2 = 0 \ \ then \ \ g(-30) \approx 0 \newline & x\_1 = 0 \ \ and \ \ x\_2 = 1 \ \ then \ \ g(-10) \approx 0 \newline & x\_1 = 1 \ \ and \ \ x\_2 = 0 \ \ then \ \ g(-10) \approx 0 \newline & x\_1 = 1 \ \ and \ \ x\_2 = 1 \ \ then \ \ g(10) \approx 1\end{align}
$$

![NN][7]

### 3.2 $x\_1$ XNOR $x\_2$

The $Θ^{(1)}$ matrices for AND, NOR, and OR are:

$$
\begin{align}AND:\newline\Theta^{(1)} &=\begin{bmatrix}-30 & 20 & 20\end{bmatrix} \newline NOR:\newline\Theta^{(1)} &= \begin{bmatrix}10 & -20 & -20\end{bmatrix} \newline OR:\newline\Theta^{(1)} &= \begin{bmatrix}-10 & 20 & 20\end{bmatrix} \newline\end{align}
$$

We can combine these to get the XNOR logical operator (which gives 1 if $x\_1$ and $x\_2$ are both 0 or both 1).

$$
\begin{align} \begin{bmatrix}x\_0 \newline x\_1 \newline x\_2\end{bmatrix} \rightarrow\begin{bmatrix}a\_1^{(2)} \newline a\_2^{(2)} \end{bmatrix} \rightarrow\begin{bmatrix}a^{(3)}\end{bmatrix} \rightarrow h\_\Theta(x) \end{align}
$$

For the transition between the first and second layer, we'll use a $Θ^{(1)}$ matrix that combines the values for AND and NOR:

$$
\Theta^{(1)} =\begin{bmatrix}-30 & 20 & 20 \newline 10 & -20 & -20\end{bmatrix}
$$

Let's write out the values for all our nodes:

$$
\begin{align}& a^{(2)} = g(\Theta^{(1)} \cdot x) \newline& a^{(3)} = g(\Theta^{(2)} \cdot a^{(2)}) \newline& h\_\Theta(x) = a^{(3)}\end{align}
$$

And there we have the XNOR operator using one hidden layers! The following summarizes the above algorithm:

![][8]

## 4. Multiclass Classification

To classify data into multiple classes, we let our hypothesis function return a vector of values.

![][9]

We can define our set of resulting classes as y:

![][10]

Each $y^{(i)}$ represents a different image corresponding to either a car, pedestrian, truck, or motorcycle. 

![][11]

Our resulting hypothesis for one set of inputs may look like:

$$
h\_\Theta(x) =\begin{bmatrix}0 \newline 0 \newline 1 \newline 0 \newline\end{bmatrix}
$$

In which case our resulting class is the third one down, or $h\_\Theta(x)\_3$, which represents the motorcycle.

## Reference article



[1]: /images/ml/ml-ng-w4-02-01.jpg
[2]: /images/ml/ml-ng-w4-02-02.png
[3]: /images/ml/ml-ng-w4-02-03.png
[4]: /images/ml/ml-ng-w4-02-04-2.png
[5]: /images/ml/ml-ng-w4-02-05-1.png
[6]: /images/ml/ml-ng-w4-02-06.png
[7]: /images/ml/ml-ng-w4-02-07.png
[8]: /images/ml/ml-ng-w4-02-08.png
[9]: /images/ml/ml-ng-w4-02-09.png
[10]: /images/ml/ml-ng-w4-02-10.png
[11]: /images/ml/ml-ng-w4-02-11.png

