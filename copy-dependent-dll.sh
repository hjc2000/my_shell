#!/bin/bash

# 此脚本用于复制特定依赖到可执行文件目录。
# 它首先使用ldd命令分析指定可执行文件的依赖库，
# 然后通过grep根据提供的关键字筛选这些依赖，
# 最后将筛选出的依赖库复制到可执行文件所在的目录。
#
# 使用方法:
# ./script_name <executable_path> <grep_keyword>
#
# 参数:
# <executable_path> - 可执行文件的路径
# <grep_keyword> - 用于grep筛选的关键字

# 检查参数数量
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <executable_path> <grep_keyword>"
    exit 1
fi

# 获取命令行参数
executable_path=$1
grep_keyword=$2

# 使用ldd获取依赖并通过grep筛选，然后使用awk提取路径
dependencies=$(ldd $executable_path | grep $grep_keyword | awk '{print $(NF-1)}')

# 遍历依赖并复制到可执行文件目录
for dep in $dependencies; do
    if [ ! -z "$dep" ] && [ "$dep" != "=>" ]; then # 检查字符串非空且不等于 "=>"
        echo "Copying $dep to $(dirname $executable_path)"
        cp "$dep" $(dirname $executable_path)/
    fi
done

echo "Dependencies copied."