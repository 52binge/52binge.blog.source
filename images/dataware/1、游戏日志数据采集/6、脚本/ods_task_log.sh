#!/bin/bash


DBNAME=game_center

hive_home=/kkb/install/hive-1.1.0-cdh5.14.2/bin/hive


sql="
create database if not exists  game_center;
use game_center;

CREATE TABLE if not exists ods_task_log(
plat_id            string     comment '平台id',
server_id          int        comment '服务器ID       ',
channel_id         string     comment '渠道ID         ',
user_id            string     comment '用户ID         ',
role_id            string     comment '角色ID         ',
role_name          string     comment '角色名称       ',
event_time         int        comment '事件时间       ',
task_type          int        comment '任务类型  ',
task_id            int        comment '任务ID    ',
cost_time          int        comment '任务耗时  ',
op_type            int        comment '操作类型  ',
level_limit        int        comment '等级约束  ',
award_exp          bigint     comment '奖励经验  ',
award_monetary     string     comment '奖励货币  ',
award_item         string     comment '奖励道具  ',
death_count        int        comment '死亡次数  ',
award_attribute    string     comment '奖励属性  '
)
comment '任务日志'
PARTITIONED BY(part_date date)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;


CREATE TABLE if not exists tmp_ods_task_log(
plat_id            string     comment '平台id',
server_id          int        comment '服务器ID       ',
channel_id         string     comment '渠道ID         ',
user_id            string     comment '用户ID         ',
role_id            string     comment '角色ID         ',
role_name          string     comment '角色名称       ',
event_time         int        comment '事件时间       ',
task_type          int        comment '任务类型  ',
task_id            int        comment '任务ID    ',
cost_time          int        comment '任务耗时  ',
op_type            int        comment '操作类型  ',
level_limit        int        comment '等级约束  ',
award_exp          bigint     comment '奖励经验  ',
award_monetary     string     comment '奖励货币  ',
award_item         string     comment '奖励道具  ',
death_count        int        comment '死亡次数  ',
award_attribute    string     comment '奖励属性  '
)
comment '任务日志-临时表，用于将数据通过动态分区载入ods_task_log中'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

load data local inpath '/kkb/datas/gamecenter/ods_task_log.txt' overwrite into table tmp_ods_task_log;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nostrict;
set hive.exec.max.dynamic.partitions.pernode=1000;

insert overwrite table ods_task_log partition(part_date)
select plat_id,server_id,channel_id,user_id,role_id,role_name,event_time,task_type,task_id,cost_time,op_type,level_limit,award_exp,award_monetary,award_item,death_count,award_attribute,
from_unixtime(event_time,'yyyy-MM-dd') as part_date from tmp_ods_task_log;

"

$hive_home -e "$sql"

