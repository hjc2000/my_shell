#!/bin/bash

# 获取当前目录的绝对路径
current_dir=$(pwd)

# 获取上一级目录的路径
parent_dir=$(dirname "$current_dir")

# 使 Bash 在通配符展开时包含隐藏文件
shopt -s dotglob

# 将所有内容（包括隐藏文件）移动到上一级目录
mv "$current_dir"/* "$parent_dir" 2> /dev/null

# 恢复原始的 dotglob 设置（可选）
shopt -u dotglob

# 切换到上一级目录
cd "$parent_dir"

# 删除原始的当前目录
rmdir "$current_dir" 2> /dev/null

echo "操作完成，当前目录及其隐藏文件已移动到 $parent_dir 并删除了原始目录。"

