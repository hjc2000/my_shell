#!/bin/bash
# 递归查找 so，删除它们的版本号

# 检查是否提供了目录参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory=$1

# 检查目录是否存在
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# 递归查找所有的.so文件，包括带版本号的
find "$directory" -type f -name '*.so.*' | while read sofile; do
    # 获取文件所在目录
    dir=$(dirname "$sofile")
    # 生成无版本号的链接名称
    basefile=$(echo "$sofile" | sed -r 's/(.*\.so)(\..*)?/\1/')
    basefilename=$(basename "$basefile")
    # 检查无版本号的文件或链接是否已经存在
    if [ ! -e "$dir/$basefilename" ]; then
        # 在原文件所在目录创建一个指向最新版本的符号链接
        ln -s "$(basename "$sofile")" "$dir/$basefilename"
        echo "Created symlink: $dir/$basefilename -> $(basename "$sofile")"
    else
        echo "Skipped: $dir/$basefilename already exists."
    fi
done
