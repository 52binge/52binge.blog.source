---
title: Hive 中 udf、udaf 和 udtf 的使用
toc: true
date: 2015-02-01 10:07:21
categories: hadoop
tags: hive
---

Hive 是基于 Hadoop 中的 MapReduce，提供 HQL 查询的数据仓库. 

Hive 是一个很开放的系统，很多内容都支持用户定制. 如 : 文件格式、MR脚本、自定义函数、自定义聚合函数 等.

<!-- more -->

## UDF

编写 UDF函数 的时候需要注意一下几点：

1. 自定义 UDF 需要继承 org.apache.hadoop.hive.ql.UDF
2. 需要实现 `evaluate` 函数

以下是两个数求和函数的UDF。evaluate函数代表两个整型数据相加

```java
package hive.connect;  
  
import org.apache.hadoop.hive.ql.exec.UDF;  
  
public final class Add extends UDF {

    public Integer evaluate(Integer a, Integer b) {  
        if (null == a || null == b) {  
            return null;  
        } 
        return a + b;  
    }  
}  
```

## UDAF

函数类需要继承 **UDAF** 类，内部类 **Evaluator** 需要实现 **UDAFEvaluator** 接口.

Evaluator 需要实现 init、iterate、terminatePartial、merge、terminate 这几个函数.

1. `init`函数实现接口 UDAFEvaluator 的 init 函数.
2. `iterate`接收传入的参数，并进行内部的轮转。其返回类型为 boolean.
3. `terminatePartial`无参数，其为 iterate 函数轮转结束后，返回轮转数据.
4. `merge` 接收 terminatePartial 的返回结果，进行数据 merge 操作，其返回类型为boolean.
5. `terminate` 返回最终的聚集函数结果.

[下面是一个简单的 UDAF 的 demo][2]

```java
package com.x.user_bhv;

import com.google.common.collect.Maps;
import org.apache.hadoop.hive.ql.exec.UDAF;
import org.apache.hadoop.hive.ql.exec.UDAFEvaluator;

import java.util.HashMap;
import java.util.Map;

public class UDAFMergeIntToIntMap extends UDAF {

    public static class PartialResult {
        Map<Integer, Integer> attributes;

        PartialResult() {
            attributes = Maps.newHashMap();
        }
    }

    public static class UnitIdUDAFEvaluator implements UDAFEvaluator {
        private PartialResult partialResult;

        public UnitIdUDAFEvaluator() {
            super();
            init();
        }

        public void init() {
            System.out.println("map init");
            partialResult = new PartialResult();
        }

        public boolean iterate(Map<Integer, Integer> attributes_args) {

            if (attributes_args == null || attributes_args.isEmpty()) {
                return true;
            }

            for (Map.Entry<Integer, Integer> entry : attributes_args.entrySet()) {
                this.partialResult.attributes.put(entry.getKey(), entry.getValue());
            }
            return true;
        }

        public PartialResult terminatePartial() {
            return this.partialResult;
        }

        public boolean merge(PartialResult other) { // 参数不可能为 null

            for (Map.Entry<Integer, Integer> entry : other.attributes.entrySet()) {
                this.partialResult.attributes.put(entry.getKey(), entry.getValue());
            }

            return true;
        }

        public Map<Integer, Integer> terminate() {
            if (partialResult == null) {
                return new HashMap<Integer, Integer>();
            } else {
                return this.partialResult.attributes;
            }
        }
    }

    public static void main(String[] args) {
    }
}
```

在 Hive 脚本中的使用示例 :

```bash
hql="ADD jar ${jar_dir}/user_bhv_for_hive.jar;
    CREATE TEMPORARY FUNCTION merge_int_to_int_map AS 'com.x.user_bhv.UDAFMergeIntToIntMap';
    INSERT OVERWRITE TABLE ${table_user_buy_category}
    SELECT
        mobile_number,
        merge_int_to_int_map (level1_id_count_map)
    FROM 
        ods_dm_e_coupon
    GROUP BY mobile_number
```

## Summary

1. 重载 evaluate 函数.
2. UDF 函数中参数类型可以为Writable，也可为java中的基本数据对象.
3. UDF 支持变长的参数.
4. Hive 支持隐式类型转换.
5. 客户端退出时，创建的临时函数自动销毁.
6. evaluate函数必须要返回类型值，空的话返回null，不能为void类型.
7. UDF 和 UDAF 都可以重载.
8. 查看函数 SHOW FUNCTIONS.

> UDAF: User Defined Aggregation Function

## Reference

- [Hive 中 UDF、UDAF 和 UDTF 使用][1]
- [bliar's github hive udaf demo][2]

[1]: http://blog.csdn.net/liuj2511981/article/details/8523084
[2]: https://github.com/blair101/bigdata/tree/master/hadoop/hive_udf_udaf
