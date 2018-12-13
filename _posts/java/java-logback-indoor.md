---
title: Logback 入门初步
date: 2015-12-27 15:54:16
tags: logback
categories: java
toc: true
---

Logback 一个开源日志组件, SLF4J 这个简单的日志前端接口（Façade）来替代 Jakarta Commons-Logging 。

<!-- more -->

Logback 一个开源日志组件。
Logback 当前分成三个模块：logback-core  logback- classic  和  logback-access。

## 1. logback 简介

Ceki在Java日志领域世界知名。他创造了Log4J ，这个最早的Java日志框架即便在JRE内置日志功能的竞争下仍然非常流行。随后他又着手实现SLF4J 这个“简单的日志前端接口（Façade）”来替代Jakarta Commons-Logging 。
 
Logback，一个“可靠、通用、快速而又灵活的Java日志框架”。

**官网网址 :** http://logback.qos.ch/

## 2. 工程使用需要的 jar

要在工程里面使用 logback , 只需要以下jar文件：

        (1). slf4j-api.jar       
        (2). logback-access.jar
        (3). logback-classic.jar
        (4). logback-core.jar
        
        logback-core    是其它两个模块的基础模块。   
        logback-classic 是 log4j 的一个 改良版本。   
        logback-access  与Servlet容器集成提供通过Http来访问日志功能

logback-classic 完整实现 SLF4J API 使你可以很方便地更换成其它日志系统如 log4j 或 JDK Logging。
  

## 3. logback 常用配置详解

### 3.1 根节点< configuration >
 
 configuration | 说明
------- | -------
scan | 当此属性设置为true时，配置文件如果发生改变，将会被重新加载，默认值为true。
scanPeriod | 设置监测配置文件是否有修改的时间间隔，如果没有给出时间单位，默认单位是毫秒。当scan为true时，此属性生效。默认的时间间隔为1分钟。
debug | 当此属性设置为true时，将打印出 logback 内部日志信息，实时查看logback运行状态。默认值为false。

## 4. logback 配置示例

### 4.1 Myself resources/logback.xml example

```xml
<?xml version="1.0" encoding="UTF-8"?>

<!--当此属性设置为true时，将打印出logback内部日志信息，实时查看logback运行状态。默认值为false。-->
<configuration scan="true" scanPeriod="3600 seconds" debug="false">

    <property name="AppName" value="your_app_name"/>
    <property name="LogParentDir" value="/home/www/logs/"/>
    <contextName>${AppName}</contextName>

    <appender name="infoAppender" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <filter class="ch.qos.logback.classic.filter.LevelFilter">
            <level>INFO</level>
            <onMatch>ACCEPT</onMatch>
            <onMismatch>DENY</onMismatch>
        </filter>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${LogParentDir}/${AppName}/infoLogFile.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <appender name="errorAppender" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <filter class="ch.qos.logback.classic.filter.LevelFilter">
            <level>ERROR</level>
            <onMatch>ACCEPT</onMatch>
            <onMismatch>DENY</onMismatch>
        </filter>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${LogParentDir}/${AppName}/errorLogFile.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!--其中appender的配置表示打印到控制台-->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="com.x.dmt" level="ERROR" additivity="false">
        <appender-ref ref="errorAppender"/>
    </logger>

    <!--设置addtivity为false，将此loger的打印信息不向上级传递；-->
    <logger name="com.x.dmt.service" level="INFO" additivity="fasle">
        <appender-ref ref="infoAppender"/>
    </logger>

    <!-- 注意: logger 同名情况, 级别低的,需要放在下面,否则级别高的会覆盖级别低的权限,早晨级别低的打印不出来日志 -->

</configuration>
```

---

[更多参见 iteye1101260](http://aub.iteye.com/blog/1101260)

[官方网址](http://logback.qos.ch/)