---
title: moco-超简单mock接口服务
categories: code
tags: [code,tool]
date: 2018-03-28 22:49:28
updated: 2018-03-28 22:49:28
keywords: 超简单mock接口服务,moco,
description: 一个简单快速的mock接口服务,一个jar包一个配置文件,命令行直接启动无需复杂安装
---

## 何谓mock接口

mock接口就是模拟接口的意思。
做开发中mock接口是经常需要的，服务直接依赖接口，而在开发中往往不适合或者无法直接调用对方的接口，这时候可以写一个假的接口，当这个接口被请求后直接返回事先设定的数据。

可以做mock的方法非常多，这里介绍一个非常简单小巧的命令行工具moco，其实就是一个jar包

## moco

官网：https://github.com/dreamhead/moco
独立jar包下载地址：：[Standalone Moco Runner Download（v 0.11.1)](http://central.maven.org/maven2/com/github/dreamhead/moco-runner/0.11.1/moco-runner-0.11.1-standalone.jar)

### 简单使用 （Standalone Moco Runner）

[Qucik Start 官方说明](https://github.com/dreamhead/moco#quick-start)

### 启动

`java -jar moco-runner-<version>-standalone.jar http -p 12306 -s 22306 -c setting.json`
`-p`启动端口
`-s`shutdown端口，可以不指定，会默认分配。
 shutdown的命令`java -jar moco-runner-<version>-standalone.jar shutdown -s 22306`
`-c`配置文件

### 配置

更多的配置方法可以看官方文档介绍 [HTTP(s) APIs](https://github.com/dreamhead/moco/blob/master/moco-doc/apis.md)

```json setting.json
[
    {
        "request":
          {
            "uri": "/json",
            "method" : "post" //如果不指定method则get、post均可以
          },
        "response":
          {
            "json": //json格式返回值
              {
                "foo" : "bar"
              }
          }
    },
    {
        "request":
          {
            "uri": "/text",
            "method" : "get"
          },
        "response":
          {
             "text" : "bar" //text格式返回值
          }
    }
]
```

### 实际使用的示例

```bash
$ tree
.
├── foo.json
├── log.log
├── moco-runner-0.11.1-standalone.jar
├── settings.json
├── shutdown.sh
└── start.sh

$ cat start.sh
java -jar moco-runner-0.11.1-standalone.jar http -p 8100 -s 8101 -c settings.json > log.log &

$ cat shutdown.sh
java -jar moco-runner-0.11.1-standalone.jar shutdown -s 8101
```

```json settings.json
[
    {
        "request": {
            "uri": "/activiti/thrid/calApi"
        },
        "response": {
            "json": {
                "code": 200,
                "message": "模拟计费成功"
            }
        }
    },
    {
        "request": {
            "uri": "/api/bossConvertAll"
        },
        "response": {
            "json": {
                "code": 200,
                "message": "转换成功",
                "requestId": "cg2uAs3P"
            }
        }
    }
]
```

```json foo.json
[
  {
    "response" :
      {
        "text" : "foo"
      }
  }
]
```