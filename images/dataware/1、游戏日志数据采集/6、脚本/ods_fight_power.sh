#!/bin/bash


DBNAME=game_center

hive_home=/kkb/install/hive-1.1.0-cdh5.14.2/bin/hive


sql="
create database if not exists  game_center;
use game_center;
CREATE TABLE if not exists  ods_fight_power(
plat_id         string     comment '平台id',
server_id       int        comment '服务器ID  ',
channel_id      string     comment '渠道ID    ',
user_id         string     comment '用户ID    ',
role_id         string     comment '角色ID    ',
role_name       string     comment '角色名称  ', 
client_ip       string     comment '客户端IP  ',
event_time      int        comment '事件时间  ', 
change_count    bigint     comment '战斗力变化',  
combat_power    bigint     comment '当前战斗力'
)
comment '战斗力日志'
PARTITIONED BY(part_date date)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS sequencefile;

CREATE TABLE if not exists tmp_ods_fight_power(
plat_id         string     comment '平台id',
server_id       int        comment '服务器ID  ',
channel_id      string     comment '渠道ID    ',
user_id         string     comment '用户ID    ',
role_id         string     comment '角色ID    ',
role_name       string     comment '角色名称  ', 
client_ip       string     comment '客户端IP  ',
event_time      int        comment '事件时间  ', 
change_count    bigint     comment '战斗力变化',  
combat_power    bigint     comment '当前战斗力'
)
comment '战斗力日志-临时表，用于将数据通过动态分区载入ods_fight_power中'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

load data local inpath '/kkb/datas/gamecenter/ods_fight_power.txt' overwrite into table tmp_ods_fight_power;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nostrict;
set hive.exec.max.dynamic.partitions.pernode=1000;

set hive.exec.compress.output=true;
set mapred.output.compress=true;
set mapred.output.compression.codec=org.apache.hadoop.io.compress.GzipCodec;
set mapred.output.compression.type=BLOCK;


insert overwrite table ods_fight_power partition(part_date)
select plat_id,server_id,channel_id,user_id,role_id,role_name,client_ip,event_time,change_count,combat_power,from_unixtime(event_time,'yyyy-MM-dd') as part_date from tmp_ods_fight_power;

"

$hive_home -e "$sql"

