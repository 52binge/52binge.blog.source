---
title: CentOS and RedHat Linux
date: 2016-04-19 07:54:16
tags: [centos]
categories: devops
toc: true
list_number: true
description: CentOS and RedHat Linux
---

> CentOS 是 Community ENTerprise Operating System 的简称，我们有很多人叫它社区企业操作系统，不管你怎么叫它，它都是 Linux操作系统的一个发行版本。CentOS 与 RHEL 有什么区别呢。

## 1. CentOS 简介

CentOS是Community ENTerprise Operating System的简称，我们有很多人叫它社区企业操作系统，不管你怎么叫它，它都是Linux操作系统的一个发行版本。

CentOS并不是全新的Linux发行版。在Red Hat家族中有企业版的产品，它是Red Hat Enterprise Linux（以下称之为RHEL），CentOS正是这个RHEL的克隆版本。

RHEL是很多企业采用的Linux发行版本，需要向Red Hat付费才可以使用，并能得到付过费用的服务和技术支持和版本升级。

CentOS可以像RHEL一样的构筑Linux系统环境，但不需要向Red Hat付任何的产品和服务费用，同时也得不到任何有偿技术支持和升级服务。

在构成RHEL的大多数软件包中，都是基于GPL协议发布的，也就是我们常说的开源软件。正因为是这样，Red Hat公司也遵循这个协议，将构成RHEL的软件包公开发布，只要是遵循GPL协议，任何人都可以在原有的软件构成的基础上再开发和发布。**CentOS** 就是这样在 RHEL 发布的基础上将RHEL的构成克隆再现的一个Linux发行版本。

虽然说是RHEL的克隆，但并不是一模一样，所说的克隆是具有100%的互换性（真的么？）。但并不保障对应RHEL的软件在CentOS上面也能够100%的正常工作。并且安全漏洞的修正和软件包的升级对应RHEL的有偿服务和技术支持来说，数日数星期数个月的延迟情况也有（其实也没看出来多慢）。

## 2. CentOS 特点

在CentOS的全称里面我们可以看到Enterprise OS，也就是说企业系统，这个企业系统并不是企业级别的系统，而是它可以提供企业级应用所需要的要素。
例如：

 1. 稳定的环境
 2. 长期的升级更新支持
 3. 保守性强
 4. 大规模的系统也能够发挥很好的性能

## 3. CentOS 与 RHEL 的区别

其实为什么有 CentOS？ CentOS 与 RHEL 有什么关系？

RHEL 在发行的时候，有两种方式。一种是二进制的发行方式，另外一种是源代码的发行方式。

无论是哪一种发行方式，你都可以免费获得（例如从网上下载），并再次发布。但如果你使用了他们的在线升级（包括补丁）或咨询服务，就必须要付费。

RHEL 一直都提供源代码的发行方式，CentOS 就是将 RHEL 发行的源代码从新编译一次，形成一个可使用的二进制版本。由于 LINUX 的源代码是 GNU，所以从获得 RHEL 的源代码到编译成新的二进制，都是合法。只是 REDHAT 是商标，所以必须在新的发行版里将 REDHAT 的商标去掉。

REDHAT 对这种发行版的态度是：“我们其实并不反对这种发行版，真正向我们付费的用户，他们重视的并不是系统本身，而是我们所提供的商业服务。”

一句话，选用 CentOS 还是 RHEL，取决于你所在公司是否拥有相应的技术力量。

## 4. Refence article

本文整理自网络文章