#!/bin/bash
#set -ex
set -x

mes=$1
if [ -z "${mes}" ]; then
echo mesaage is empty;
exit 1
fi

# check error
errorChar=`find source/_posts/ -name "*.md" |xargs grep  ""`
if [ -n "$errorChar" ]; then
echo "存在异常字符："
echo "$errorChar"
exit 1
fi

hexo clean
git pull
git acm "${mes}"
git push
hexo d -g -m "${mes}"