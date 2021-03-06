---
title: centos常用环境安装
categories: tech
tags: [centos]
date: 2018-08-31 20:57:28
updated: 2019-03-12 23:26:20
keywords: centos安装nodejs,centos安装docker
description:
---

- [安装nodejs](#安装nodejs)
- [安装docker (docker-ce)](#安装docker-docker-ce)
- [安装nginx](#安装nginx)
- [安装python](#安装python)
- [centos相关](#centos相关)

<!-- more -->

<link rel="stylesheet" type="text/css" href="/assets/asciinema-player.css" />

## 安装nodejs

<asciinema-player src="/assets/asciinema/i_nodejs.cast" poster="data:text/plain,安装nodejs演示" cols="100" rows="24"/>

参考：https://segmentfault.com/a/1190000007124759
~~nodejs 官网：https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora (已失效)~~
最新版的centos安装nodejs说明 https://github.com/nodesource/distributions/blob/master/README.md

`curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -`
`yum -y install nodejs`

安装cnpm，淘宝npm工具，提高npm下载包的速度

cnpm：https://npm.taobao.org/

`npm install -g cnpm --registry=https://registry.npm.taobao.org`
  
## 安装docker (docker-ce)

一键安装方式：  
`curl -sSL https://get.docker.com/ | sh`  

手动安装：  

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

**docker in docker**

[centos7-dind-node](https://hub.docker.com/r/cubedhost/centos7-dind-node)
[Docker in Docker dind](https://hub.docker.com/r/jpetazzo/dind/dockerfile)

**安装 docker-compose**

官方文档：https://docs.docker.com/compose/install/
step1:
注意这里的版本号，最新版请从这里获取[Compose repository release page on GitHub](https://github.com/docker/compose/releases)
`curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose`
step2:添加可执行权限
`chmod +x /usr/local/bin/docker-compose`

`docker-compose --version`

step3: [可选] 安装 命令行提示
[Command-line completion](https://docs.docker.com/compose/completion/)

**使用国内docker仓库源**

针对Docker客户端版本大于 1.10.0 的用户
您可以通过修改daemon配置文件/etc/docker/daemon.json来使用加速器(没有这个文件可以创建)
从这个地址获取aliyun专属源地址:https://cr.console.aliyun.com/cn-hangzhou/mirrors

```bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://****.mirror.aliyuncs.com","https://registry.docker-cn.com","https://hub-mirror.c.163.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## 安装nginx

参考：https://www.jianshu.com/p/1cad13e57c43

step1:添加CentOS 7 EPEL 仓库
`yum install epel-release`
step2:安装Nginx
`yum install nginx`

<script src="/assets/asciinema-player.js"></script>

## 安装python

[Linux 安装python3.7.0 - 非真 - 博客园](https://www.cnblogs.com/yhongji/p/9383857.html)

## centos相关

安装epel第三方源

```bash
yum install epel-release
yum update
```

安装bash-completion

```bash
#yum install epel-release  
yum install bash-completion
```

[centos7修改系统语言为简体中文](https://www.cnblogs.com/li5206610/p/7828618.html)

```bash
# 当前
locale
# 全部
locale -a
# 设置 修改完成之后并不会立刻生效，必须重启之后才会生效。
localectl  set-locale LANG=en_US.UTF8
```

设置hostname

```bash
#临时设置
hostname myhostname
#永久设置
hostnamectl set-hostname myhostname
```