#!/bin/bash


DBNAME=game_center

hive_home=/kkb/install/hive-1.1.0-cdh5.14.2/bin/hive


sql="
create database if not exists  game_center;
use game_center;

create table if not exists ods_dim_game_button(
plat_id              string       comment '游戏',
button_id            int          comment '按钮ID',
button_name          string       comment '按钮名称',
system_type          string       comment '按钮类型名称'
) comment '游戏按钮字典'
row format delimited fields terminated by '\t'
collection items terminated by ','
map keys terminated by ':'
lines terminated by '\n'
stored as textfile;

load data local inpath '/kkb/datas/gamecenter/ods_dim_game_button.txt' overwrite into table ods_dim_game_button;




"

$hive_home -e "$sql"

