---
title: docker使用技巧
categories: tech
tags: [docker]
date: 2019-04-02 17:46:18
updated: 2019-04-02 17:46:18
keywords: docker使用技巧
description:
---

- [docker容器当作linux应用使用 docker run --rm的应用](#docker容器当作linux应用使用-docker-run---rm的应用)

<!-- more -->

## docker容器当作linux应用使用 docker run --rm的应用

在linux系统中可以借助docker镜像来做程序，而不需要真的去安装程序。

以redis客户端为例

```bash
#!/bin/bash
docker run -it --rm registry.cn-hangzhou.aliyuncs.com/boshen-ns/redis:3 redis-cli $*
```

S1: 编写一个如上的shell脚本`redis-cli`。  
`--rm`参数类似于playground模式，让容器在停止之后自动删除，保持干净。
`$*`的意思是接收执行shell脚本时的所有参数。

S2: 然后把该脚本连接到`/usr/local/bin`目录`ln -s /home/dev/redis-cli /usr/local/bin/redis-cli`，当然也可以直接在这个目录编写该脚本也一样。

S3: 授权`chmod +x /usr/local/bin/redis-cli`  

这样就完成了，只要在终端输入redis-cli 就可以了