---
title: SparkSQL Multidimensional Analysis - Group by
date: 2021-02-10 15:28:21
categories: [spark]
tags: [sparkSQL]
---

<img src="/images/spark/SparkSql-logo-2.png" width="500" alt="" />

<!-- more -->

## 1. DataFrame From Row

<details><summary>SparkSQL - 创建 DataFrame (Row)</summary>

```python
from pyspark.sql import Row
sc = spark.sparkContext

rdd1 = sc.parallelize([(1, 'dog'), (2, 'cat'), (3, 'dog'), (4, 'pig')], 2)      
pet = rdd1.map(lambda p: Row(id=p[0], name=p[1]))

df1 = spark.createDataFrame(pet)
df1.show()
# +---+----+
# | id|name|
# +---+----+
# |  1| dog|
# |  2| cat|
# |  3| dog|
# |  4| pig|
# +---+----+

df1.createOrReplaceTempView("pet")

# SQL can be run over DataFrames that have been registered as a table.
pets = spark.sql("SELECT id, name FROM pet")

# The results of SQL queries are Dataframe objects.
# rdd returns the content as an :class:`pyspark.RDD` of :class:`Row`.
petNames = pets.rdd.map(lambda p: "Name: " + p.name).collect()
for name in petNames:
    print(name)
```

</details>

<img src="/images/spark/sparksql-catalyst.webp" width="680" alt="Spark SQL / Catalyst 内部原理 与 RBO)
" />

[datasets-and-dataframes](https://spark.apache.org/docs/2.1.0/sql-programming-guide.html#datasets-and-dataframes)


## 2. count distinct

### 2.1 Hive

```sql
--优化前
select count(distinct id) from table_a 
```

[Hive SQL count(distinct) - optimization](https://article.itxueyuan.com/a93Dg)

```sql
--优化后
select 
  count(id)
from
(
    select 
        id
    from table_a group by id
) tmp
```

<details><summary>principle of hiveql-select-group-by</summary>

[hiveql-select-group-by multi-reduce](https://www.wikitechy.com/tutorials/hive/hiveql-select-group-by)

> <img src="/images/hive/hive-group-by-map-reduce-program.png" width="670" alt="" />
</details>

### 2.2 SparkSql

<details><summary>SparkSql: sc.parallelize([]), StructType([]), LongType, createDataFrame, createOrReplaceTempView</summary> 

```python
# Import types
from pyspark.sql.types import *

# Generate comma delimited data
stringCSVRDD = sc.parallelize(
  [
    (123, 'Katie', 19, 'brown'), 
    (234, 'Michael', 22, 'green'), 
    (345, 'Simone', 23, 'blue')
  ]
)
# Specify schema
schema = StructType(
  [
    StructField("id", LongType(), True),    
    StructField("name", StringType(), True),
    StructField("age", LongType(), True),
    StructField("eyeColor", StringType(), True)
  ]
)
# Apply the schema to the RDD and Create DataFrame
swimmers = spark.createDataFrame(stringCSVRDD, schema)
# Creates a temporary view using the DataFrame
swimmers.createOrReplaceTempView("swimmers")
```

</details>

count(distinct id) - expand

```python
spark.sql("SELECT count(distinct id), count(distinct name) FROM pet").explain()

== Physical Plan ==
*(3) HashAggregate(keys=[], functions=[count(if ((gid#245 = 1)) pet.`id`#246L else null), count(if ((gid#245 = 2)) pet.`name`#247 else null)])
+- Exchange SinglePartition, true, [id=#510]
   +- *(2) HashAggregate(keys=[], functions=[partial_count(if ((gid#245 = 1)) pet.`id`#246L else null), partial_count(if ((gid#245 = 2)) pet.`name`#247 else null)])
      +- *(2) HashAggregate(keys=[pet.`id`#246L, pet.`name`#247, gid#245], functions=[])
         +- Exchange hashpartitioning(pet.`id`#246L, pet.`name`#247, gid#245, 200), true, [id=#505]
            +- *(1) HashAggregate(keys=[pet.`id`#246L, pet.`name`#247, gid#245], functions=[])
               +- *(1) Expand [List(id#222L, null, 1), List(null, name#223, 2)], [pet.`id`#246L, pet.`name`#247, gid#245]
                  +- *(1) Scan ExistingRDD[id#222L,name#223]
```

As see from the execution plan, when dealing with `count distinct`, the `Expand` method is used.

<img src="/images/spark/spark-expand-null.jpg" width="700" alt="" />

After expand, use `id` and `name` (not id,name) as keys to perform `HashAggregate`, which is `group by`, so that it is equivalent to **de-duplication**. then Calculate count (id) and count (name) directly later, divide and conquer the data. the data skew is alleviated.

> expand 方式适合维度小的多维分析，这是因为 expand 方式读取数据的次数只有一次，但数据会膨胀n倍

## 3. GROUP BY

### 3.1 ROLLUP

<img src="/images/sparkSQL/rollup-source-1.jpg" width="450" alt="" />

```sql
SELECT
	factory,
	SUM( quantity ) 
FROM
	production 
GROUP BY ROLLUP ( factory ) 
ORDER BY factory
```

<br>

<img src="/images/sparkSQL/rollup-action-2.jpg" width="450" alt="ROLL UP 搭配 GROUP BY 使用，可以为每一个分组返回一个小计行，为所有分组返回一个总计行" />

```sql
SELECT factory, department, SUM(quantity)
FROM production
GROUP BY ROLLUP(factory, department)
ORDER BY factory
```
<br>
<img src="/images/sparkSQL/rollup-action-3.jpg" width="450" alt="如果 ROLLUP(A,B)则先对 A,B进行 GROUP BY，之后对 A 进行 GROUP BY,最后对全表 GROUP BY" />

> 如果 ROLLUP(A,B,C)则先对 A,B,C进行 GROUP BY ，然后对 A,B进行GROUP BY,再对 A 进行GROUP BY,最后对全表进行 GROUP BY.

### 3.2 CUBE


```sql
SELECT 
  factory, department,
  SUM(quantity)
FROM production
GROUP BY CUBE(factory, department)
ORDER BY factory,department;
```

<br>
<img src="/images/sparkSQL/rollup-action-3.jpg" width="450" alt="CUBE(A,B)则先对 A,B 进行 GROUP BY，之后对 A 进行 GROUP BY,然后对 B 进行 GROUP BY，最后对全表进行 GROUP BY" />

> 如果 CUBE(A,B,C)则先对 A,B,C 进行 GROUP BY,之后对 A,B ，之后对A,C ，之后对 B,C 之后对 A,之后对 B，之后对 C，最后对全表GROUP BY

### 3.3 GROUPPING

The `GROUPING()` function can only be used with `ROLLUP` and `CUBE`. 

GROUPING() receives a column, and returns 0 if this column is not empty, and returns 1 if it is empty.

```sql
SELECT 
  GROUPING(factory),
  factory,
  department,
  SUM(quantity)
FROM production
GROUP BY ROLLUP(factory, department)
ORDER BY factory, department;
```
<br>
<img src="/images/sparkSQL/GROUPING.jpg" width="450" alt="最后一行的 FACTORY 为空，所以 GROUPING()返回 1.也可以与CUBE结合使用" />


### 3.4 GROUPING SETS

```sql
SELECT 
    factory,
    department,
    SUM(quantity)
FROM production
GROUP BY GROUPING SETS(factory, department)
ORDER BY factory, department
```

<br>
<img src="/images/sparkSQL/GROUPING-SETS.jpg" width="550" alt="GROUPING SETS则对每个参数分别进行分组，GROUPING SETS(A,B)就代表先按照 A 分组，再按照 B分组" />

### 3.5 GROUPING_ID()

```sql
SELECT 
    factory,
    department,
    GROUPING(factory),
    GROUPING(department),
    GROUPING_ID(factory,department),
    SUM(quantity)
FROM production
    GROUP BY CUBE(factory, department)
    ORDER BY factory, department;
```

<br>
<img src="/images/sparkSQL/GROUPING_ID.jpg" width="450" alt="If you select GROUPING_ID=0, it means that the FACTORY and DEPARTMENT columns are not empty" />

With the GROUPING_ID column, we can use the `HAVING` clause to filter the query results. If you select GROUPING_ID=0, it means that the FACTORY and DEPARTMENT columns are not empty.

## Reference

- [Hive SQL grouping sets 用法](https://www.cnblogs.com/Allen-rg/p/10648231.html)
- [Spark的分区》、《通过spark.default.parallelism谈Spark并行度》、重要 | Spark分区并行度决定机制](https://cloud.tencent.com/developer/article/1676544)
- [spark的groupping set的优化](https://zhuanlan.zhihu.com/p/124245519)
- [Spark SQL / Catalyst 内部原理 与 RBO](https://www.jianshu.com/p/83a70a160607)
- [Spark权威指南—— DataFrame API笔记](https://zhuanlan.zhihu.com/p/150963974)
- [GROUP BY都不会！ROLLUP，CUBE，GROUPPING详解](https://zhuanlan.zhihu.com/p/58639733)
