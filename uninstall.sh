#!/bin/bash

# 检查是否提供了包名
if [ $# -eq 0 ]; then
    echo "请提供一个包名。"
    exit 1
fi

# 卸载指定的包
echo "正在卸载包：$1"
sudo apt remove --purge "$1"

# 自动删除不再需要的依赖
echo "正在删除不再需要的依赖..."
sudo apt autoremove

echo "卸载完成。"

