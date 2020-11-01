#!/bin/bash


DBNAME=game_center

hive_home=/kkb/install/hive-1.1.0-cdh5.14.2/bin/hive


sql="
create database if not exists  game_center;
use game_center;
CREATE TABLE if not exists ods_death_log(
plat_id            string     comment '平台id',
server_id          int        comment '服务器ID ',
channel_id         string     comment '渠道ID ',
user_id            string     comment '用户ID ',
role_id            string     comment '角色ID ',
role_name          string     comment '角色名称 ',
client_ip          string     comment '客户端IP ',
event_time         int        comment '事件时间 ',
log_id             string     comment '日志ID',
map_id             int        comment '地图ID',
attacker_uid       string     comment '凶手用户ID/怪物id ',
attacker_rid       string     comment '凶手角色ID/怪物id ',
attacker_rname     string     comment '凶手/怪物名称',
attacker_level     int        comment '凶手/怪物等级',
death_level        int        comment '死亡等级',
hero_power         bigint     comment '当前玩家战斗力或者伤害',
death_detail       string     comment '死亡详细'
)
comment '玩家死亡日志'
PARTITIONED BY(part_date date)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

CREATE TABLE  if not exists tmp_ods_death_log(
plat_id            string     comment '平台id',
server_id          int        comment '服务器ID ',
channel_id         string     comment '渠道ID ',
user_id            string     comment '用户ID ',
role_id            string     comment '角色ID ',
role_name          string     comment '角色名称 ',
client_ip          string     comment '客户端IP ',
event_time         int        comment '事件时间 ',
log_id             string     comment '日志ID',
map_id             int        comment '地图ID',
attacker_uid       string     comment '凶手用户ID/怪物id ',
attacker_rid       string     comment '凶手角色ID/怪物id ',
attacker_rname     string     comment '凶手/怪物名称',
attacker_level     int        comment '凶手/怪物等级',
death_level        int        comment '死亡等级',
hero_power         bigint     comment '当前玩家战斗力或者伤害',
death_detail       string     comment '死亡详细'
)
comment '玩家死亡日志-临时表，用于将数据通过动态分区载入ods_death_log中'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

load data local inpath '/kkb/datas/gamecenter/ods_death_log.txt' overwrite into table tmp_ods_death_log;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nostrict;
set hive.exec.max.dynamic.partitions.pernode=1000;

insert overwrite table ods_death_log partition(part_date)
select plat_id,server_id,channel_id,user_id,role_id,role_name,client_ip,event_time,log_id,map_id,attacker_uid,attacker_rid,attacker_rname,attacker_level,death_level,hero_power,death_detail,from_unixtime(event_time,'yyyy-MM-dd') as part_date from tmp_ods_death_log;

"

$hive_home -e "$sql"

