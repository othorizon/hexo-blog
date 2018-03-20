#!/bin/bash
#set -e

mes=$1
if [ -z "${mes}" ]; then
echo mesaage is empty;
exit 1
fi
git pull
git acm "${mes}"
git push
hexo d -g