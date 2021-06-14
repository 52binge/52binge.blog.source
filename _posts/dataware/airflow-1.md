---
title: Airflow Review 1
toc: true
date: 2021-01-24 09:07:21
categories: [data-warehouse]
tags: [Airflow]
---

<img src="/images/airflow/AirflowLogo.png" width="450" alt="" />

<!-- more -->


## hello world

```python
# -*- coding: utf-8 -*-

import airflow
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from datetime import timedelta

#-------------------------------------------------------------------------------
# these args will get passed on to each operator
# you can override them on a per-task basis during operator initialization

default_args = {
    'owner': 'jifeng.si',
    'depends_on_past': False,
    'start_date': airflow.utils.dates.days_ago(2),
    'email': ['779844881@qq.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    # 'queue': 'bash_queue',
    # 'pool': 'backfill',
    # 'priority_weight': 10,
    # 'end_date': datetime(2016, 1, 1),
    # 'wait_for_downstream': False,
    # 'dag': dag,
    # 'adhoc':False,
    # 'sla': timedelta(hours=2),
    # 'execution_timeout': timedelta(seconds=300),
    # 'on_failure_callback': some_function,
    # 'on_success_callback': some_other_function,
    # 'on_retry_callback': another_function,
    # 'trigger_rule': u'all_success'
}

#-------------------------------------------------------------------------------
# dag

dag = DAG(
    'example_hello_world_dag',
    default_args=default_args,
    description='my first DAG',
    schedule_interval=timedelta(days=1))

#-------------------------------------------------------------------------------
# first operator

date_operator = BashOperator(
    task_id='date_task',
    bash_command='date',
    dag=dag)

#-------------------------------------------------------------------------------
# second operator

sleep_operator = BashOperator(
    task_id='sleep_task',
    depends_on_past=False,
    bash_command='sleep 5',
    dag=dag)

#-------------------------------------------------------------------------------
# third operator

def print_hello():
    return 'Hello world!'

hello_operator = PythonOperator(
    task_id='hello_task',
    python_callable=print_hello,
    dag=dag)

#-------------------------------------------------------------------------------
# dependencies

sleep_operator.set_upstream(date_operator)
hello_operator.set_upstream(date_operator)

```

```bash
# ~/airflow/dags [19:59:51]
➜ python hello_world.py
```

airflow tasks list example_hello_world_dag

```bash
airflow tasks list example_hello_world_dag
```


```
➜ airflow tasks list example_hello_world_dag
[2021-01-24 20:00:02,162] {dagbag.py:440} INFO - Filling up the DagBag from /Users/blair/airflow/dags
[2021-01-24 20:00:02,200] {example_kubernetes_executor_config.py:174} WARNING - Could not import DAGs in example_kubernetes_executor_config.py: No module named 'kubernetes'
[2021-01-24 20:00:02,200] {example_kubernetes_executor_config.py:175} WARNING - Install kubernetes dependencies with: pip install apache-airflow['cncf.kubernetes']

date_task
hello_task
sleep_task
```

### 2.1 测试 date_task

```
➜ airflow tasks test example_hello_world_dag date_task 20210124
```

### 2.2 测试 hello_task

```bash
AIRFLOW_CTX_DAG_EMAIL=779844881@qq.com
AIRFLOW_CTX_DAG_OWNER=blair.chan
AIRFLOW_CTX_DAG_ID=example_hello_world_dag
AIRFLOW_CTX_TASK_ID=hello_task
AIRFLOW_CTX_EXECUTION_DATE=2021-01-24T00:00:00+00:00
[2021-01-24 20:05:03,473] {python.py:118} INFO - Done. Returned value was: Hello world!
[2021-01-24 20:05:03,480] {taskinstance.py:1142} INFO - Marking task as SUCCESS. dag_id=example_hello_world_dag, task_id=hello_task, execution_date=20210124T000000, start_date=20210124T120503, end_date=20210124T120503
```

### 2.3 测试 sleep_task

```bash
 /var/folders/58/kj1q13hs3j52hwvj3t2g2plh0000gp/T
[2021-01-24 20:04:30,923] {bash.py:158} INFO - Running command: sleep 5
[2021-01-24 20:04:30,929] {bash.py:169} INFO - Output:
[2021-01-24 20:04:35,942] {bash.py:177} INFO - Command exited with return code 0
[2021-01-24 20:04:35,972] {taskinstance.py:1142} INFO - Marking task as SUCCESS. dag_id=example_hello_world_dag, task_id=sleep_task, execution_date=20210124T000000, start_date=20210124T120430, end_date=20210124T120435
```

#### airflow如何设置Dag和Dag之间的依赖啊？

1. 可以自己写一个脚本来检测父dag的状态，来达到dag之间的依赖
2. ExternalTaskSensor 高级特性，监工

## Reference

- [AirFlow高阶，两个启动时间不同DAG中的任务依赖关联demo](https://blog.csdn.net/qq_37714755/article/details/110134616)
- [【 airflow 实战系列】 基于 python 的调度和监控工作流的平台](https://cloud.tencent.com/developer/article/1004927?from=information.detail.airflow%20dag%E4%B9%8B%E9%97%B4%E4%BE%9D%E8%B5%96)
- [用户画像—Airflow作业调度(ETL)](https://zhuanlan.zhihu.com/p/78847089)
- [闲聊调度系统 Apache Airflow](https://zhuanlan.zhihu.com/p/100526494)
- [十三、回填任务--BackfillJob](https://zhuanlan.zhihu.com/p/128672715)
- [ETL principles](https://zhuanlan.zhihu.com/p/264805569)
- [Airflow 使用及原理分析](https://zhuanlan.zhihu.com/p/90282578)
- [data engineer 使用luigi 还是 airflow比较好？](https://www.zhihu.com/question/46573431)
- [airflow官方教程——一个简单案例](https://zhuanlan.zhihu.com/p/74339976)
- [Airflow 中文文档](https://airflow.apachecn.org/#/zh/tutorial)
- [AirFlow常用命令](https://www.cnblogs.com/cord/p/9437556.html)
- [[AirFlow]AirFlow使用指南三 第一个DAG示例](https://developer.aliyun.com/article/632137)