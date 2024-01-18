#!/bin/bash

# 检查参数数量
if [ $# -ne 1 ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

# 存储次数
REPEAT_COUNT=$1

# 检查参数是否为数字
if ! [[ $REPEAT_COUNT =~ ^[0-9]+$ ]]; then
    echo "Error: The argument must be a positive integer."
    exit 1
fi

# 执行 move-up 命令指定的次数
for ((i = 0; i < REPEAT_COUNT; i++)); do
    move-up
    cd ..
done

