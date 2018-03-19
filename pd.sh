#!/bin/bash
set -e

mes=$1
git acm "${mes}"
git push
hexo d -g