---
title: Spark Functions 
date: 2021-01-07 20:07:21
categories: [spark]
tags: [spark]
---


{% image "/images/spark/spark-3.0-rdd-logo.png", width="550px", alt="Spark RDD Feature" %}

<!--more-->

spark 学习笔记 sample 算子


```python
有放回取样0.001%
data.sample(true,0.00001).collect().foreach(println)
```




## Reference

