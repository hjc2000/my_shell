#!/bin/bash

# 检查是否提供了URL参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <git-repo-url>"
    exit 1
fi

# 从命令行参数获取Git仓库URL
url="$1"

# 使用字符串操作提取仓库名
# 这里使用了'##*/'来删除最后一个'/'之前的所有内容，包括最后一个'/'
# 然后使用'%.*'删除'.git'扩展名
repo_name="${url##*/}"
repo_name="${repo_name%.*}"

# 输出仓库名
echo $repo_name

