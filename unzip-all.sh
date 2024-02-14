#!/bin/bash

# 检查是否提供了目录路径作为参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# 赋值给变量
directory=$1

# 使用 find 命令递归查找所有 .zip 文件，并对每个文件执行 unzip 操作
find "$directory" -type f -name '*.zip' -exec sh -c '
    for file do
        # 获取.zip文件所在的目录
        dir=$(dirname "$file")
        echo "正在解压: $file 到 $dir"
        # 解压.zip文件到其所在目录
        unzip -o "$file" -d "$dir"
    done
' sh {} +

