#!/bin/bash
# 递归查找指定目录中的符号链接并删除

# 检查是否提供了路径参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

# 读取命令行提供的路径
search_dir=$1

# 检查路径是否存在
if [ ! -d "$search_dir" ]; then
    echo "Error: Directory '$search_dir' does not exist."
    exit 1
fi

# 使用find命令递归查找所有的符号链接，并删除它们
find "$search_dir" -type l -exec rm {} \;

echo "All symbolic links in '$search_dir' have been removed."
