
---
title: SpringMVC Demo
date: 2016-09-11 07:54:16
tags: [spring]
categories: java
---

写一个入门整洁的编写 java 后端程序的代码架, 主要使用了 java + springMvc + mybatis + logback + spring task 等技术.

[blair’s github springMvc_demo][1]

<!--more-->

## Starting Point

为一些新手和我个人备份，写一个入门`整洁`的编写 java 后端程序的代码架.

> 写这样的程序，最重要的是 `整洁与约定规范` 而不是多么高深的技术，让接手你代码的人不痛苦，这才是成功
 
## Involved Tech

 - Java
 - Restful
 - SpringMVC
 - Mybatis
 - logback
 - Spring-task

> logback : 一个“可靠、通用、快速而又灵活的Java日志框架”。
> Spring-task 编写非web程序，仅仅是后台需要定时跑的任务，经常被用到。

## How to Run

### 1. 修改数据库连接信息

编辑 ~/resources/props/db.properties 将其中的

```
# main mysql lib dataSource
main.jdbc.driverClassName=com.mysql.jdbc.Driver
main.jdbc.url=jdbc:mysql://192.168.***.**:3306/testdb01
main.jdbc.username=your_username
main.jdbc.password=your_password
```

改为你自己的 dataSource 连接信息

### 2. 数据库中建立你用到的表

参见语句  ~/resources/sql/projects.sql 在你的 数据库 中执行其中语句，建立 table `user`.

### 3. 确认需要的环境已准备好

> 确认 ~/resources/logback.xml 中，日志的打印路径，是否适合你的环境  
> 我这里是 /data0/www/logs/ ， 如有需要改变，请自行更改。（如果为 windows 环境，请注意路径是否正确）

### 4. 编译-打包-启动jetty

```
➜  github ll
total 0
drwxr-xr-x 13 hp staff 442 Sep 10 14:03 language/
➜  github cd language/java/springMVC_demo
➜  springMVC_demo git:(master) ✗ ll
total 24
-rw-r--r-- 1 hp staff   665 Sep 11 15:52 README.md
-rw-r--r-- 1 hp staff 10712 Sep 11 15:10 pom.xml
drwxr-xr-x 4 hp staff   136 Sep 10 13:30 src/
➜  springMVC_demo git:(master) ✗ mvn clean
➜  springMVC_demo git:(master) ✗ mvn compile
➜  springMVC_demo git:(master) ✗ mvn clean package
➜  springMVC_demo git:(master) ✗ mvn jetty:run
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building x_demo Maven Webapp 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] FrameworkServlet 'mvc-dispatcher': initialization completed in 572 ms
[INFO] Started SelectChannelConnector@0.0.0.0:8080
[INFO] Started Jetty Server
[INFO] Starting scanner at interval of 5 seconds.
```

> 当然你也可以通过 IDEA -> Maven Projects -> Plugins -> jetty:run 启动 (或者 Tomcat 启动)

启动成功后，这时你可以在你的浏览器分别访问以下接口，查看效果了

```
http://localhost:8080/
http://localhost:8080/user/getusers
http://localhost:8080/user/addusers
http://localhost:8080/user/getusers
http://localhost:8080/user/getuser/2

------

http://localhost:8080/user/getuser/2
{
  "status": 0,
  "errmsg": "success",
  "data": {
    "id": 2,
    "firstName": "Andy",
    "lastName": "Wong",
    "age": 31
  }
}
```

> 在你测试的时候，如果你想在浏览器中看到格式化后的json，请自行安装 chrome 相关的json插件等。

## Desc

1. 展示了前后端开发如何用json进行交互的主流方法，标志状态位与错误信息，返回结果呈现给前端，用一个 JsonResult 类来封装，同时在 web 层，用MappingJackson2HttpMessageConverter 配置，可自动将 Map\<String, Object\> 转换为 json 呈现给前端等。

2. 代码编写比较规范，用了主流日志框架，将 info 与 error 日志分开打印，不吞异常。分层规范，还特意写了两个数据源如何配置的样例等。

3. DAO 层不写实现，只写接口，用 Mybatis 来承接，类对象与数据库表 直接自动转换识别，包含了 数据库表字段下划线与java类字段驼峰标识 如何匹配等。

## Attentions

> 注意： 版本控制中，涉及的敏感 库地址，用户名，密码 等 不上传.

## Reference

- [blair's github springMVC_demo][1]

[1]: https://github.com/blair101/language/tree/master/java/springMVC_demo