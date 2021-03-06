---
title: webpack学习
categories: code
tags: [code,webpack]
date: 2018-05-29 20:21:40
updated: 2018-05-29 20:21:40
keywords: webpack
description:
---
webpack学习中遇到的问题

- [webpack是什么](#webpack是什么)
- [遇到的问题 踩坑](#遇到的问题-踩坑)
- [技巧](#技巧)
  - [ProvidePlugin插件](#provideplugin插件)
  - [懒加载](#懒加载)
- [开发环境和线上环境的配置文件分离](#开发环境和线上环境的配置文件分离)
  - [命令行传入参数](#命令行传入参数)
- [external 外部扩展](#external-外部扩展)
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

## 遇到的问题 踩坑

**webpack导致控制台不能获取变量**
webpack打包会将全局变量封装到闭包内，因此访问不到的。可以将变量绑定到`window`对象。

```javascript
window.vm= new Vue({
  data: {
    count: 0,
    name: '全局名称'
  }
})
window['testVar']='testValue'
//在浏览器控制台只要 输入 `vm`、`testVar` 既可以拿到对象
```

## 技巧

### ProvidePlugin插件

[ProvidePlugin | webpack 中文网](https://www.webpackjs.com/plugins/provide-plugin/)
`webpack.ProvidePlugin`插件：不必import或require模块， 当调用的变量不存在时便会从模块加载。

**注意这里不是懒加载，不是在调用的时候才加载，而是打包的时候便把模块引入了。**
该插件只是用于省去每个地方都要写一遍import和require这件事。如果想要实现懒加载请查看[懒加载 | webpack 中文网](https://www.webpackjs.com/guides/lazy-loading/)

示例

```javascript
 plugins: [
    new webpack.ProvidePlugin({
      globalModule: ['./globalModule.js'],
    })]
```

CommonJs中的使用

```javascript globalModule.js

console.log("globalModule loaded")

// commonjs中的默认导出写法1
module.exports = "globalModule";
// commonjs中的默认导出写法2
module.exports = function(){
        return "globalModule"
    };
// es2015/es6中的默认导出写法
export default function () {
    return "globalModule";
}
```

```javascript index.js
//调用代码
//直接调用而无需 require或者 import
// commonjs中调用默认导出
console.log(globalModule())
// es2015/es6中调用默认导出
console.log(globalModule.default())
```

{% note warning %}
对于 ES6/ES2015 模块的 default export，你必须显示指定模块的 default 属性`module.default`。
[JS - CommonJS、ES2015、AMD、CMD模块规范对比与介绍（附样例）](http://www.hangge.com/blog/cache/detail_1686.html)
{% endnote %}

### 懒加载

[懒加载 | webpack 中文网](https://www.webpackjs.com/guides/lazy-loading/)
通过import方式导入模块存在的一个问题是，可能导入的模块只在一些特定的场景下才会使用，而有些时候并不会用到，
如果直接import的方式（`import module from './module'`）会导致代码被执行，
为了优化网页我们对此应该采取`懒加载的方式`。

示例

```javascript lazyModule.js
console.log('loaded lazyModule');

export default () => {
  console.log('print hello_wolrd');
}
```

```javascript index.js
//懒加载，不要事先import而是在调用的地方import
import('./lazyModule.js').then(module => {
      var print = module.default;
      print()
    })
```

{% note info %}
懒加载的import只会执行一次，
通过示例可以看到：示例中的`import('./lazyModule.js')....`代码即使被多次重复执行，lazyModule.js文件中的`console.log('loaded lazyModule');`也只会在控制台打印一次
{% endnote %}

## 开发环境和线上环境的配置文件分离

前端开发中没有maven这样的工具可以通过profile来实现不同的环境使用不同的配置文件，但是可以借助webapck的环境变量来实现。

使用`webpack-merge`可以实现DRY原则（不重复原则，提取公共代码），借助该函数可以把`webpack.config.js`拆分为多个，也可以把环境变量等拆分为不同的环境。

使用`webpack.DefinePlugin`插件可以实现定义全局变量。
{% note info %}
注意，因为DefinePlugin这个插件直接执行文本替换，给定的值必须包含字符串本身内的实际引号。通常，有两种方式来达到这个效果，使用 '"production"', 或者使用 JSON.stringify('production')。
参考[DefinePlugin](https://www.webpackjs.com/plugins/define-plugin/)
{% endnote %}

在代码中可以直接调用process.env的值以及 webpack.DefinePlugin 中定义的变量。变量是在打包时通过做文本替换来实现的，打包后就是直接使用变量值来呈现了。

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

## external 外部扩展

externals 配置 防止将某些 import 的包(package)打包到 bundle 中，而是在运行时(runtime)再去从外部获取这些扩展依赖。
例如 我们开发了一个自己的库，里面引用了lodash这个包，经过webpack打包的时候，发现如果把这个lodash包打入进去，打包文件就会非常大。那么我们就可以externals的方式引入。也就是说，自己的库本身不打包这个lodash，需要用户环境提供。
externals属性是一个由key-value组成的对象，key值 就是import语句的模块名，如属性名称是 `jquery`，表示应该排除 `import $ from 'jquery'` 中的 jquery 模块。
value值则是模块导出的变量。
参考[在.vue文件中引入第三方非NPM模块](https://segmentfault.com/a/1190000007020623#articleHeader1),[webpack externals 深入理解 - 不长写的日志 - SegmentFault 思否](https://segmentfault.com/a/1190000012113011)

例如 js中导入lodash模块`import _ from 'lodash'`，那么对应的 externals写法是 `externals: { lodash: '_' }`

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
