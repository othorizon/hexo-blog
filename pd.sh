#!/bin/bash
set -e

mes=$1
git pull
git acm "${mes}"
git push
hexo d -g