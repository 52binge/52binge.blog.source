#!/bin/bash


DBNAME=game_center

hive_home=/kkb/install/hive-1.1.0-cdh5.14.2/bin/hive


sql="
create database if not exists  game_center;
use game_center;

CREATE TABLE if not exists ods_monetary_consume(
plat_id            string     comment '平台id',
server_id          int        comment '服务器ID ',
channel_id         string     comment '渠道ID ',
user_id            string     comment '用户ID ',
role_id            string     comment '角色ID ',
role_name          string     comment '角色名称',
client_ip          string     comment '客户端IP',
event_time         int        comment '事件时间',
log_id             string     comment '日志id ',
monetary_type      int        comment '货币类型(1:元宝,2:金币,3:礼金 )',
consume_type        int        comment '产出类型ID ',
consume_count       bigint     comment '产出数量 ',
monetary_stock     bigint     comment '货币存量 '
)
comment '虚拟币消费日志'
PARTITIONED BY(part_date date)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

CREATE TABLE if not exists tmp_ods_monetary_consume(
plat_id            string     comment '平台id',
server_id          int        comment '服务器ID ',
channel_id         string     comment '渠道ID ',
user_id            string     comment '用户ID ',
role_id            string     comment '角色ID ',
role_name          string     comment '角色名称',
client_ip          string     comment '客户端IP',
event_time         int        comment '事件时间',
log_id             string     comment '日志id ',
monetary_type      int        comment '货币类型(1:元宝,2:金币,3:礼金 )',
consume_type        int        comment '产出类型ID ',
consume_count       bigint     comment '产出数量 ',
monetary_stock     bigint     comment '货币存量 '
)
comment '虚拟币消费日志-临时表，用于将数据通过动态分区载入ods_monetary_consume中'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

load data local inpath '/kkb/datas/gamecenter/ods_monetary_consume.txt' overwrite into table tmp_ods_monetary_consume;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nostrict;
set hive.exec.max.dynamic.partitions.pernode=1000;

insert overwrite table ods_monetary_consume partition(part_date)
select plat_id,server_id,channel_id,user_id,role_id,role_name,client_ip,event_time,log_id,monetary_type,consume_type,consume_count,monetary_stock,from_unixtime(event_time,'yyyy-MM-dd') as part_date from tmp_ods_monetary_consume;



"

$hive_home -e "$sql"

