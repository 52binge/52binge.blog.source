#!/bin/bash

DBNAME=game_center

hive_home=/kkb/install/hive-1.1.0-cdh5.14.2/bin/hive


sql="
create database if not exists  game_center;
use game_center;

CREATE TABLE if not exists  ods_game_create(
plat_id            string     comment '平台id',
server_id          int        comment '服务器ID',
channel_id         string     comment '渠道id',
user_id            string     comment '用户ID',
client_ip          string     comment '客户端IP',
event_time         int        comment '事件时间',
device_brand       string     comment '设备品牌 ',
device_type        string     comment '设备型号 ',
operating_system   string     comment '操作系统名称',
operating_version  string     comment '操作系统版本'
)
comment '游戏创建创建日志'
PARTITIONED BY(part_date date)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS PARQUET TBLPROPERTIES('parquet.compression'='SNAPPY');

CREATE TABLE  if not exists  tmp_ods_game_create(
plat_id            string     comment '平台id',
server_id          int        comment '服务器ID',
channel_id         string     comment '渠道id',
user_id            string     comment '用户ID',
client_ip          string     comment '客户端IP',
event_time         int        comment '事件时间',
device_brand       string     comment '设备品牌 ',
device_type        string     comment '设备型号 ',
operating_system   string     comment '操作系统名称',
operating_version  string     comment '操作系统版本'
)
comment '游戏创建创建日志-临时表，用于将数据通过动态分区载入ods_game_create中'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

load data local inpath '/kkb/datas/gamecenter/ods_game_create.txt' overwrite into table tmp_ods_game_create;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nostrict;
set hive.exec.max.dynamic.partitions.pernode=1000;

SET hive.exec.compress.output=true;
SET mapreduce.output.fileoutputformat.compress=true;
set mapred.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec;


insert overwrite table ods_game_create partition(part_date)
select plat_id,server_id,channel_id,user_id,client_ip,event_time,device_brand,device_type,operating_system,operating_version,from_unixtime(event_time,'yyyy-MM-dd') as part_date from tmp_ods_game_create;

"

$hive_home -e "$sql"

