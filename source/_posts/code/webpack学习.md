---
title: webpack学习
categories: code
tags: [webpack]
date: 2018-05-29 20:21:40
updated: 2018-05-29 20:21:40
keywords:
description:
---
webpack学习中遇到的问题

- [webpack是什么](#webpack是什么)
- [开发环境和线上环境的配置文件分离](#开发环境和线上环境的配置文件分离)
    - [命令行传入参数](#命令行传入参数)
- [tree shaking 不起作用](#tree-shaking-不起作用)
- [参考](#参考)

<!-- more -->

## webpack是什么

webpack是一个JavaScript应用的静态模块打包器，除了会把通过`import`导入的模块打包成一个或多个bundle，还可以打包资源文件等等。
借由插件还可以实现更多的功能，比如优化压缩代码、定义环境变量等等。

webpack会通过一个*依赖关系图*将应用程序所需的模块打包。

> 依赖关系图
webpack从命令行或配置文件中定义的*入口起点*开始，递归一个依赖图，然后将所有这些模块打包为少量的 bundle - 通常只有一个 - 可由浏览器加载

webpack 的配置文件(`webpack.config.js`)，是导出一个对象的 JavaScript 文件。通过该配置文件来实现各种打包参数的配置。

通过webpack与npm的包管理，我们可以形成一套更加标准化的前端开发流程。

## 开发环境和线上环境的配置文件分离

前端开发中没有maven这样的工具可以通过profile来实现不同的环境使用不同的配置文件，但是可以借助webapck的环境变量来实现。

使用`webpack-merge`可以实现DRY原则（不重复原则，提取公共代码），借助该函数可以把`webpack.config.js`拆分为多个，也可以把环境变量等拆分为不同的环境。

使用`webpack.DefinePlugin`插件可以实现定义全局变量。
{% note info %}
注意，因为DefinePlugin这个插件直接执行文本替换，给定的值必须包含字符串本身内的实际引号。通常，有两种方式来达到这个效果，使用 '"production"', 或者使用 JSON.stringify('production')。
参考[DefinePlugin](https://www.webpackjs.com/plugins/define-plugin/)
{% endnote %}

在代码中可以直接调用process.env的值以及 webpack.DefinePlugin 中定义的变量

```bash 目录结构
webpack-demo
|- package.json
|- /src
  |- index.js
|- webpack.common.js
|- webpack.dev.js
|- webpack.prod.js
|- /config
  |- dev.env.js
  |- prod.env.js
```

```javascript webpack.dev.js
const merge = require('webpack-merge');
const common = require('./webpack.common.js');
const webpack = require('webpack');

module.exports = merge(common, {
  plugins: [
    new webpack.DefinePlugin({
       //引入变量
      'my.env': require('./config/dev.env.js')
    })
  ]
});
```

```javascript dev.env.js
'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./config/prod.env')

module.exports = merge(prodEnv, {
  //这里使用单引号加双引号才能表示字符串
  ENV_NAME: '"this is env"'
})
```

```javascript index.js
//在代码中可以直接调用process.env的值以及 webpack.DefinePlugin 中定义的变量
console.log('process.env.ENV_NAME:' process.env.ENV_NAME);
console.log('my.env.NODE_ENV:' my.env.NODE_ENV);
```

经过以上配置后，在调用webpack时指定config文件既可以区分不同的环境`npx webpack --config webpack.dev.js`。
通过配置npm的package.json中的脚本可以简化这一步骤

```json package.json
{
"scripts": {
     "start": "webpack-dev-server --open --config webpack.dev.js",
     "build": "webpack --config webpack.prod.js"
    }
}
```

这样配置之后，运行`npm start`则是启动dev环境的web服务。
运行`npm run build`则是生产线上环境

### 命令行传入参数

如果需要使用命令行传入env参数，那么`webpack.dev.js`需要做一些修改以接收参数,必须将 module.exports 转换成一个函数.
参考[webpack-使用环境变量](https://www.webpackjs.com/guides/environment-variables/)
调用的时候通过设置`--env`可以使你根据需要，传入尽可能多的环境变量`npx webpack --config webpack.dev.js --display-modules --env.NODE_ENV='"传入一个参数"' --progress`

```javascript webpack.dev.js
const merge = require('webpack-merge');
const common = require('./webpack.common.js');
const webpack = require('webpack');

module.exports = env => merge(common, {
  plugins: [
    new webpack.DefinePlugin({
      //引入变量
      'process.env': env,
      'my.env': require('./config/dev.env.js')
    })
  ]
});

//#######
//以下为不使用箭头函数的写法
module.exports = function (env) {
  console.log(env);
  return merge(common, {
    plugins: [
      new webpack.DefinePlugin({
        //引入变量
        'process.env': env,
        'my.env': require('./config/dev.env.js')
      })
    ]
  }
  )
};
```

## tree shaking 不起作用

在跟着[官方demo](https://www.webpackjs.com/guides/tree-shaking)学习中tree shaking 没有起作用。
原因是本应该删除不用的导出的js文件在`webpack.config.js`的`entry`中作为入口配置了，因此没有处理。

_tree shaking_ 的意思是移除未被引用的代码。在webpack中想要起作用的条件是：
{% blockquote webpack官方指南 https://www.webpackjs.com/guides/tree-shaking/#结论 %}

1. 使用 ES2015 模块语法（即 import 和 export）。
2. 在项目 package.json 文件中，添加一个 "sideEffects" 入口。
3. 引入一个能够删除未引用代码(dead code)的压缩工具(minifier)（例如 UglifyJSPlugin）。

{% endblockquote %}

**对于第二条“sideEffects”入口**
还没完全研究明白，理解上大概是说通过import引入的模块，可以在模块的`package.json`中配置`sideEffects`来控制`副作用`，换言之 这个参数是加在通过npm安装的模块的package.json文件中。
可以查看[官方demo](https://github.com/webpack/webpack/tree/master/examples/side-effects)

{% blockquote Webpack4进阶 https://www.colabug.com/2641390.html %}
官方提供了sideEffects属性，通过将其设置为false，可以主动标识该类库中的文件只执行简单输出，并没有执行其他操作，可以放心shaking。除了可以减小bundle文件的体积，同时也能够提升打包速度。为了检查side effects，Webpack需要在打包的时候将所有的文件执行一遍。而在设置sideEffects之后，则可以跳过执行那些未被引用的文件，毕竟已经明确标识了“我是平民”。因此对于一些我们自己开发的库，设置sideEffects为false大有裨益
{% endblockquote %}

**对于第三条引入压缩工具**
只要在`webpack.config.js`配置文件中添加`mode: "production"`将模式设置为生产环境便会自动引入`UglifyJSPlugin`。
也可以在命令行接口中使用 `--optimize-minimize` 标记，来使用 UglifyJSPlugin

**另外**
webpack4中，对`mode`做了调整。`mode:"development"`时,将不进行tree-shaking和Scope hoisting，在使用production时才会进行这些操作。不设置mode默认为development

## 参考

[Vue2 VueRouter2 webpack 构建项目实战（一）准备工作 - CSDN博客](https://blog.csdn.net/fungleo/article/details/53171052)
[webpack学习中遇到的坑 - 糊里糊涂撸代码 - SegmentFault 思否](https://segmentfault.com/a/1190000013998339?utm_source=tag-newest/*&^%$)
