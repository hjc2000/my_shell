#!/bin/bash

# 确保脚本以 root 权限执行
if [ "$(id -u)" != "0" ]; then
   echo "该脚本必须以 root 权限运行" 1>&2
   exit 1
fi

# 检查是否有通过管道传递的输入
if [ -p /dev/stdin ]; then
    # 如果有管道输入，则从标准输入读取目录名
    while IFS= read -r line; do
        dirs+=("$line")
    done
else
    # 否则，将命令行参数作为目录名
    dirs=("$@")
fi

# 遍历目录名数组
for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "复制 $dir 到 /usr/..."
        sudo cp -rv "$dir"/* /usr/
    else
        echo "目录 $dir 不存在。"
    fi
done

echo "复制完成。"