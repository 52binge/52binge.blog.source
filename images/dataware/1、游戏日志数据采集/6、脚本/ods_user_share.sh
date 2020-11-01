#!/bin/bash


DBNAME=game_center

hive_home=/kkb/install/hive-1.1.0-cdh5.14.2/bin/hive


sql="

create database if not exists  game_center;
use game_center;

CREATE TABLE if not exists ods_user_share(
plat_id            string     comment '平台id',
channel_id         int        comment '渠道ID',
game_channel_id    int        comment '子渠道id',
advertisement_id   int        comment '广告ID',
material_id        int        comment '素材ID',
material_number    int        comment '素材编号',
template_id        int        comment '模板ID',
package_id         int        comment '包ID',
package_name       string     comment '包名称',
user_id            string     comment '用户ID',
event_time          int        comment '分享时间',
share_id           string     comment '分享ID',
share_content      string     comment '分享自定义内容',
log_id             string     comment '日志id',
share_result       int        comment '分享结果:0:失败,1:成功'
)
comment '玩家分享行为日志'
PARTITIONED BY(part_date date)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

CREATE TABLE if not exists tmp_ods_user_share(
plat_id            string     comment '平台id',
channel_id         int        comment '渠道ID',
game_channel_id    int        comment '子渠道id',
advertisement_id   int        comment '广告ID',
material_id        int        comment '素材ID',
material_number    int        comment '素材编号',
template_id        int        comment '模板ID',
package_id         int        comment '包ID',
package_name       string     comment '包名称',
user_id            string     comment '用户ID',
event_time          int        comment '分享时间',
share_id           string     comment '分享ID',
share_content      string     comment '分享自定义内容',
log_id             string     comment '日志id',
share_result       int        comment '分享结果:0:失败,1:成功'
)
comment '玩家分享行为日志-临时表，用于将数据通过动态分区载入ods_user_share中'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

load data local inpath '/kkb/datas/gamecenter/ods_user_share.txt' overwrite into table tmp_ods_user_share;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nostrict;
set hive.exec.max.dynamic.partitions.pernode=1000;

insert overwrite table ods_user_share partition(part_date)
select plat_id,channel_id,game_channel_id,advertisement_id,material_id,material_number,template_id,package_id,package_name,user_id,event_time,share_id,share_content,log_id,share_result,from_unixtime(event_time,'yyyy-MM-dd') as part_date from tmp_ods_user_share;



"

$hive_home -e "$sql"

