#!/bin/bash
set -ex

find source/_posts/ -name "*.md" |xargs grep -l ""|xargs sed -i "" "s///g"
