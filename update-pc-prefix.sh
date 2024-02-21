#!/bin/bash

# 检查参数数量
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_pc_file>"
    exit 1
fi

pc_file="$1"

# 检查文件是否存在
if [ ! -f "$pc_file" ]; then
    echo "File not found: $pc_file"
    exit 1
fi

# 读取prefix行
prefix_line=$(grep "^prefix=" "$pc_file")

# 如果没有找到prefix，退出
if [ -z "$prefix_line" ]; then
    echo "prefix line not found in file: $pc_file"
    exit 1
fi

# 提取prefix路径
prefix_path=$(echo "$prefix_line" | cut -d'=' -f2-)

# 使用cygpath转换路径
new_prefix_path=$(cygpath -u "$prefix_path")

# 生成新的prefix行
new_prefix_line="prefix=${new_prefix_path}"

# 获取原本prefix的路径，用于匹配
old_prefix_path=$(echo "$prefix_line" | cut -d'=' -f2-)

# 替换文件中的prefix行，并将其他位置的路径替换成基于新的prefix变量的路径
sed -i "s|^prefix=.*$|$new_prefix_line|" "$pc_file"
sed -i "s|\($old_prefix_path\)|$new_prefix_path|g" "$pc_file"

echo "Updated prefix in $pc_file to $new_prefix_path"
