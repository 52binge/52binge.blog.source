---
title: Spark Practice
toc: true
date: 2021-01-06 07:07:21
categories: [spark]
tags: [spark]
---

<!--<img src="/images/spark/spark-summary-logo.jpg" width="500" alt="" />
-->

[good - Spark会把数据都载入到内存么？](https://www.jianshu.com/p/b70fe63a77a8)

<!-- more -->

## 1. Spark Functions

### 1.1 count, first

```python
lines.= sc.textFile("file:///home/blair/../input.txt")


lines.count()
lines.first()
lines.take(3)
```

### 1.2 filter

```python
pythonLines = lines.filter(lambda line: "Python" in line)

# 另一种写法

def hasPython(line):
    return "Python" in line
pythonLines = lines.filter(hasPython)
```

### 1.3 sc init

```python
from pyspark import SparkConf, SparkContext
#conf = SparkConf().setMaster("local").setAppName("My App")
#sc = SparkContext(conf = conf)

# sc 默认就有了

sc.stop()
```

### 1.4 avg, 

```python
data = [1,5,7,10,23,20,6,5,10,7,10]

rdd_data = sc.parallelize(data)
s = rdd_data.reduce(lambda x,y: x+y+0.0)

n = rdd_data.count()

avg = s/n

print("average:",avg)
```

### 1.5 求众数

```python
data =  [1,5,7,10,23,20,7,5,10,7,10]

rdd_data = sc.parallelize(data)

rdd_count = rdd_data.map(lambda x:(x,1)).reduceByKey(lambda x,y:x+y)

max_count = rdd_count.map(lambda x:x[1]).reduce(lambda x,y: x if x>=y else y)
print(max_count)

rdd_mode = rdd_count.filter(lambda x:x[1]==max_count).map(lambda x:x[0])

mode = rdd_mode.reduce(lambda x,y:x+y+0.0)/rdd_mode.count()

print("mode:",mode)
```

### 1.6 TopN

```python
#任务：有一批学生信息表格，包括name,age,score, 找出score排名前3的学生, score相同可以任取
students = [("LiLei",18,87),("HanMeiMei",16,77),("DaChui",16,66),("Jim",18,77),("RuHua",18,50)]
n = 3

rdd_students = sc.parallelize(students)
rdd_sorted = rdd_students.sortBy(lambda x:x[2],ascending = False)

students_topn = rdd_sorted.take(n)
print(students_topn)
```

> [('LiLei', 18, 87), ('HanMeiMei', 16, 77), ('Jim', 18, 77)]

### 1.7 排序并返回序号

```python
#任务：按从小到大排序并返回序号, 大小相同的序号可以不同
data = [1,7,8,5,3,18,34,9,0,12,8]

rdd_data = sc.parallelize(data)

rdd_sorted = rdd_data.map(lambda x:(x,1)).sortByKey().map(lambda x:x[0]) 
# [0, 1, 3, 5, 7, 8, 8, 9, 12, 18, 34]

rdd_sorted_index = rdd_sorted.zipWithIndex()

print(rdd_sorted_index.collect())
```

output:

```python
[(0, 0),
 (1, 1),
 (3, 2),
 (5, 3),
 (7, 4),
 (8, 5),
 (8, 6),
 (9, 7),
 (12, 8),
 (18, 9),
 (34, 10)]
```

### 1.8 二次排序

```
#任务：有一批学生信息表格，包括name,age,score
#首先根据学生的score从大到小排序，如果score相同，根据age从大到小

students = [("LiLei",18,87),("HanMeiMei",16,77),("DaChui",16,66),("Jim",18,77),("RuHua",18,50)]
rdd_students = sc.parallelize(students)
```

```python
%%writefile student.py
#为了在RDD中使用自定义类，需要将类的创建代码其写入到一个文件中，否则会有序列化错误
class Student:
    def __init__(self,name,age,score):
        self.name = name
        self.age = age
        self.score = score
    def __gt__(self,other):
        if self.score > other.score:
            return True
        elif self.score==other.score and self.age>other.age:
            return True
        else:
            return False
```

```python
from student import Student

rdd_sorted = rdd_students \
    .map(lambda t:Student(t[0],t[1],t[2]))\
    .sortBy(lambda x:x,ascending = False)\
    .map(lambda student:(student.name,student.age,student.score))

#参考方案：此处巧妙地对score和age进行编码来表达其排序优先级关系，除非age超过100000，以下逻辑无错误。
#rdd_sorted = rdd_students.sortBy(lambda x:100000*x[2]+x[1],ascending=False)

rdd_sorted.collect()
```

> ```
[('LiLei', 18, 87),
 ('Jim', 18, 77),
 ('HanMeiMei', 16, 77),
 ('DaChui', 16, 66),
 ('RuHua', 18, 50)]
```

### 1.9 连接操作

```python
#任务：已知班级信息表和成绩表，找出班级平均分在75分以上的班级
#班级信息表包括class,name,成绩表包括name,score

classes = [("class1","LiLei"), ("class1","HanMeiMei"),("class2","DaChui"),("class2","RuHua")]
scores = [("LiLei",76),("HanMeiMei",80),("DaChui",70),("RuHua",60)]

rdd_classes = sc.parallelize(classes).map(lambda x:(x[1],x[0]))
rdd_scores = sc.parallelize(scores)
rdd_join = rdd_scores.join(rdd_classes).map(lambda t:(t[1][1],t[1][0]))

def average(iterator):
    data = list(iterator)
    s = 0.0
    for x in data:
        s = s + x
    return s/len(data)

rdd_result = rdd_join.groupByKey().map(lambda t:(t[0],average(t[1]))).filter(lambda t:t[1]>75)
print(rdd_result.collect())
```

> [('class1', 78.0)]

### 1.10 分组求众数

```python
#任务：有一批学生信息表格，包括class和age。求每个班级学生年龄的众数。

students = [
  ("class1",15),("class1",15),("class2",16),
  ("class2",16),("class1",17),("class2",19)
]
```

run

```python
def mode(arr):
    dict_cnt = {}
    for x in arr:
        dict_cnt[x] = dict_cnt.get(x,0)+1
    max_cnt = max(dict_cnt.values())
    most_values = [k for k,v in dict_cnt.items() if v==max_cnt]
    s = 0.0
    for x in most_values:
        s = s + x
    return s/len(most_values)

rdd_students = sc.parallelize(students)
rdd_classes = rdd_students.aggregateByKey([],lambda arr,x:arr+[x],lambda arr1,arr2:arr1+arr2)
rdd_mode = rdd_classes.map(lambda t:(t[0],mode(t[1])))

print(rdd_mode.collect())
```

> [('class1', 15.0), ('class2', 16.0)]

## Reference

- [spark python 练习（一）](https://blog.csdn.net/Anne999/article/details/70157538)
- [7道RDD编程练习题](https://my.oschina.net/u/4592076/blog/4869988)
