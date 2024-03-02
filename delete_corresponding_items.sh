#!/bin/bash

# 确保提供了目标路径作为参数
if [ $# -eq 0 ]; then
    echo "请提供目标路径作为参数。"
    exit 1
fi

target_dir=$1

# 列出当前目录(A目录)下的所有文件和目录
for item in $(ls -A); do
    # 检查B目录下是否存在对应的文件或目录
    if [ -e "${target_dir}/${item}" ]; then
        # 如果存在，则删除该文件或目录
        if [ -d "${target_dir}/${item}" ]; then
            # 如果是目录，则递归删除
            echo "正在删除目录: ${target_dir}/${item}"
            rm -r "${target_dir}/${item}"
        else
            # 如果是文件，则直接删除
            echo "正在删除文件: ${target_dir}/${item}"
            rm "${target_dir}/${item}"
        fi
    else
        echo "在目标路径下未找到 ${item}，跳过。"
    fi
done

