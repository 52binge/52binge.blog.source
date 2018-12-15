---
title: MapReduce for Python
toc: true
date: 2015-01-30 10:37:21
categories: hadoop
tags: hadoop
mathjax: true
---

我们可以用 hadoop-streaming 的方式，通过 python 等其他语言来编写 MR 程序.

<!--more-->

## Map阶段：mapper.py

```python
#!/usr/bin/env python
import sys
for line in sys.stdin:
    line = line.strip()
    words = line.split()
    for word in words:
        print("%s" % word)
        
# 这里仅仅是一个例子，只输出了第一列
```

> 为了是脚本可执行，增加mapper.py的可执行权限

当然，`Map`阶段， 你也可以不作处理原样输出: 只写一个 `cat`

## Reduce阶段：reducer.py

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright 2013 x Inc. All Rights Reserved

__author__ = 'Blair Chan'

import sys
import constant

from datetime import datetime
from EsHelper import EsHelper

def insert_user_basic_consume_info(items,  esHelper):

    basic_consume_info_doc = get_user_basic_consume_info_doc(items)
    if basic_consume_info_doc is None:
        return
        
    _id = basic_consume_info_doc['mobile_number']
    basic_consume_info_index = "basic_consume_info_index"

    esHelper.index(index=basic_consume_info_index, doc_type=basic_consume_info_index, id=_id, data=basic_consume_info_doc)

def get_user_basic_consume_info_doc(items):
    doc = None
    try:
        doc = {
            "mobile_number": items[0],
            "first_consume_time": items[1]
        }
    except BaseException as e:
        print("Exist Exception : %s About get_user_basic_consume_info_doc, mobile_number: %s" % (str(e), mobile_number))
    finally:
        pass

    return doc

def main():

    esHelper = EsHelper(constant.ES_URL)
    success_sum = 0

    for line in sys.stdin:

        line = line.strip()
        items = line.split('\001')

        if len(items) < 2:
            continue

        insert_user_basic_consume_info(items, esHelper)
        success_sum = success_sum + 1

    print("Success:%d" % success_sum)


if __name__ == '__main__':
    main()
```

## 本地测试

```
cat data.txt | python mapper.py | sort | reducer.py
```

## 提交Hadoop

```bash
#!/bin/bash
cd `dirname $0`/.. && wk_dir=`pwd` && cd -
source ${wk_dir}/util/env

input_file="${OSS_URL}/${mds_hive_dir}/${table_user_basic_consume_info}/*"
output_file="${OSS_URL}/${tmp_hive_dir}/${table_user_basic_consume_info}/dt=${d1}"
reducer="reducer.py"
reducer_depend1="constant.py"
reducer_depend2="EsHelper.py"
archive="${OSS_URL}/share/packages/elasticsearch-5.0.0.tar.gz#elasticsearch-5.0.0" 
## archive 表示的依赖包需要上传到 hdfs 上，#后面表示的是解压后的目录名

${HADOOP} fs -rmr ${output_file}

cmd="${HADOOP} jar ${hadoop_streaming_jar}
     -D mapred.map.tasks=100
     -D mapred.reduce.tasks=100
     -D stream.map.input.ignoreKey=true
     -input ${input_file}
     -output ${output_file}
     -file ${reducer}
     -file ${reducer_depend1}
     -file ${reducer_depend2}
     -mapper cat
     -reducer ${reducer}
     -cacheArchive ${archive}"

echo_ex "$cmd"
$cmd
check_success
```

> hadoop_streaming_jar="/home/data_mining/share/packages/hadoop2/hadoop-streaming-2.7.2.jar"
> 
>
> 以上仅仅是一个例子，虽然插入 ES 出现异常，但本篇仅仅说明如何用 python 写 mapreduce 程序

## Reference

- [用python写MapReduce函数——以WordCount为例][1]

[1]: http://www.cnblogs.com/kaituorensheng/p/3826114.html
