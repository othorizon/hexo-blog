---
title: centos常用环境安装
categories: tech
tags: [centos]
date: 2018-08-31 20:57:28
updated: 2018-08-31 20:57:28
keywords: centos安装nodejs,centos安装docker
description:
---

- [安装nodejs](#安装nodejs)
- [安装docker (docker-ce)](#安装docker-docker-ce)
- [安装nginx](#安装nginx)

<!-- more -->

<link rel="stylesheet" type="text/css" href="/assets/asciinema-player.css" />

## 安装nodejs

<asciinema-player src="/assets/asciinema/i_nodejs.cast" poster="data:text/plain,安装nodejs演示" cols="100" rows="24"/>

参考：https://segmentfault.com/a/1190000007124759
nodejs 官网：https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora
`curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -`
`yum -y install nodejs`

安装cnpm，淘宝npm工具，提高npm下载包的速度

cnpm：https://npm.taobao.org/

`npm install -g cnpm --registry=https://registry.npm.taobao.org`
  
## 安装docker (docker-ce)

<asciinema-player src="/assets/asciinema/i_docker.cast" poster="data:text/plain,安装docker演示" cols="100" rows="24"/>

官方文档：https://docs.docker.com/install/linux/docker-ce/centos/
参考：http://www.runoob.com/docker/centos-docker-install.html

step1:Docker 要求 CentOS 系统的内核版本高于 3.10
`uname -r`

step2:移除旧版本

```bash
yum remove docker \
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-selinux \
           docker-engine-selinux \
           docker-engine
```

step3: 安装一些必要的系统工具

```bash
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
```

step4: 添加软件源信息，这里使用aliyun的。 官方源：https://download.docker.com/linux/centos/docker-ce.repo
`yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo`
step5:更新 yum 缓存
`yum makecache fast`
step6:安装 Docker-ce
`yum -y install docker-ce`
step7:启动 Docker 后台服务
`systemctl start docker`
step8:测试运行 hello-world
`docker run hello-world`

## 安装nginx

参考：https://www.jianshu.com/p/1cad13e57c43

step1:添加CentOS 7 EPEL 仓库
`yum install epel-release`
step2:安装Nginx
`yum install nginx`

<script src="/assets/asciinema-player.js"></script>