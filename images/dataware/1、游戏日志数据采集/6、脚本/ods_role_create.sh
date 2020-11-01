#!/bin/bash


DBNAME=game_center

hive_home=/kkb/install/hive-1.1.0-cdh5.14.2/bin/hive


sql="


create database if not exists  game_center;
use game_center;

CREATE TABLE if not exists  ods_role_create(
plat_id            string     comment '平台id',
server_id         int         comment '角色创建服          ',
channel_id        string      comment '渠道(平台)ID        ',
user_id           string      comment '用户ID              ',
role_id           string      comment '角色ID              ',
role_name         string      comment '角色名称            ',
client_ip         string      comment '客户端IP            ',
event_time        int         comment '事件时间            ',
job_name          string      comment '职业名称            ',
role_sex          int         comment '角色性别(0:男,1:女) '
)
comment '角色创建日志'
PARTITIONED BY(part_date date)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS orc  TBLPROPERTIES ('orc.compress'='SNAPPY');

CREATE TABLE if not exists  tmp_ods_role_create(
plat_id            string     comment '平台id',
server_id         int         comment '角色创建服          ',
channel_id        string      comment '渠道(平台)ID        ',
user_id           string      comment '用户ID              ',
role_id           string      comment '角色ID              ',
role_name         string      comment '角色名称            ',
client_ip         string      comment '客户端IP            ',
event_time        int         comment '事件时间            ',
job_name          string      comment '职业名称            ',
role_sex          int         comment '角色性别(0:男,1:女) '
)
comment '角色创建日志-临时表，用于将数据通过动态分区载入ods_role_create中'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

load data local inpath '/kkb/datas/gamecenter/ods_role_create.txt' overwrite into table tmp_ods_role_create;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nostrict;
set hive.exec.max.dynamic.partitions.pernode=1000;

SET hive.exec.compress.output=true;
SET mapreduce.output.fileoutputformat.compress=true;
set mapred.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec;

insert overwrite table ods_role_create partition(part_date)
select plat_id,server_id,channel_id,user_id,role_id,role_name,client_ip,event_time,job_name,role_sex,from_unixtime(event_time,'yyyy-MM-dd') as part_date from tmp_ods_role_create;


"

$hive_home -e "$sql"

