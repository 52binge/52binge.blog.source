## 3. 离线分析调度框架

这是一个 shell 等其他语言配合写成的灵活调度框架. 该示例模块架 适用于离线分析调度，特别是每天跑的crontab任务，或者是每周、每月跑的任务. 多用于 hive 语句 或 其他脚本离线运行.

 1. 提供一些 best practice
 2. 提高各模块结构及代码的一致性
 3. 降低开发新模块的成本
 4. 便于离线大数据分析流程控制
 5. 具备报警，日志定位，常用检测依赖库函数 等功能
 6. 当然它也适用于对任何离线Job进行调度

> 不同人负责的模块不同，模块目录结构是一样的，如下所示
> 
> 开发模块的时候，每个人只需要编写自己模块 script 下脚本 和 少量 crontab_job 脚本的改动即可.

目录结构 | 功能 | 详细说明
:--- | :-- | -:-
─ **crontab_job** | crontab 脚本 | 由 linux crontab 触发, 检测整条流水线任务依赖关系, 调用 script 目录脚本等
─ **script** | 主脚本 | shell、python脚本. shell 里主为 hql 或 streaming MR、spark-submit 任务等
─ conf | 配置文件 | default.conf、vars.conf、alert.conf
─ **log** | 日志文件 | 主脚本log (多次运行多个log file)、crontab 脚本log (一个log file)
─ flag | 标记文件 | (标志该模块已运行，或运行完毕， crontab 会轮询检测) <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crontab_label.2017-12-13、ods\_e\_coupon/2017-12-13.all.done
─ util | 工具脚本 | `logging`、`static_functions`、`static_hive_lib`、`crontab_job_env`、`env`
─ alert | 报警封装 | (发送报警邮件的封装 `alert`、`send_mail.py`、`constant_mail.py`)
| |
─ create_table | 建表脚本 | 建里 hive table 的语句
─ jar | jar包 | 如 无 则不需要建立
─ java | udf、udaf | 如 无 则不需要建立

**conf/default.conf**

```sh
#系统环境变量
export HADOOP="${HADOOP_HOME}/bin/hadoop"
export HIVE="${HIVE_HOME}/bin/hive"
export JAVA="${JAVA_HOME}/bin/java"

#hadoop jar
hadoop_jar="${HADOOP_HOME}/share/packages/hadoop2/hadoop-streaming-2.7.2.jar"

#log_util
scheduler_log_script="${util_dir}/logging"

#控制日志运行方式
open_log=true

#运行hadoop任务的用户名
user="data_mining"

#hive表路径
ods_hive_dir="/data_mining/dm/ods/"
mds_hive_dir="/data_mining/dm/mds/"
tmp_hive_dir="/data_mining/dm/tmp/"

## OSS
OSS_URL="oss://your-key:your-value@x-bigdata.oss-cn-hangzhou-internal.aliyuncs.com"
```

crontab_job

```sh
#check crontab_label whether exist
if check_local_crontab_label ${flag_dir} ${d1}
  then
    echo "[INFO] script already run!"
else
  echo "[INFO] check dependention"
 
  check_hive_partitions tablename 2018-04-19
#  check_local_file()
#  check_hdfs_file()
# ...
  
  echo "[INFO] script run!"
# generate crontab_label
  touch_local_crontab_label ${flag_dir} ${d1}
# run main script
  echo "[INFO] start run..."

  sh ods_dm_e_coupon.sh $d1

  check_crontab_success ${flag_dir} ${d1}
  
fi
echo_ex "run $0 end!"
```

[bigdata-offline-demo 更多项目详情请点击...][2]

## next..

[s1]: https://github.com/blair101/language/tree/master/java/springMVC_demo
[c1]: https://blog.csdn.net/robbyo/article/category/1328994/14

[1]: https://github.com/blair101/project/tree/master/cron-lingquan-offline-part
[2]: https://github.com/blair101/bigdata/tree/master/bigdata-offline-demo
[4]: /user_profile_content_interest/
[5]: /deeplearning/
[6]: /project_frame/

[redis_part]: https://github.com/blair101/project/tree/master/redis
[img1]: /images/resume_project/user_interest_img.png
