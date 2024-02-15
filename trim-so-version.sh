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
    # 计算新的文件名（去掉版本号）
    newfile=$(echo "$sofile" | sed -r 's/(.*\.so)(\..*)?/\1/')
    # 检查新文件名是否已存在
    if [ ! -e "$newfile" ]; then
        # 如果不存在，重命名文件
        mv "$sofile" "$newfile"
        echo "Renamed $sofile to $newfile"
    else
        echo "Skipped: $newfile already exists."
    fi
done

