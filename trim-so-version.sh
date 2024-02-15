#!/bin/bash
# 递归查找 so 文件，根据指定的版本号段数删除它们的版本号

# 检查是否至少提供了一个参数
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <directory> [version_segments]"
    exit 1
fi

directory=$1
version_segments=${2:-1} # 如果未提供第二个参数，默认保留一段版本号

# 检查目录是否存在
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# 检查版本段数是否为数字
if ! [[ $version_segments =~ ^[0-9]+$ ]]; then
    echo "Error: Version segments must be a number."
    exit 1
fi

# 递归查找所有的.so文件，包括带版本号的
find "$directory" -type f -name '*.so.*' | while read sofile; do
    # 根据指定的版本号段数，计算新的文件名
    if [ "$version_segments" -eq 0 ]; then
        newfile=$(echo "$sofile" | sed -r 's/(.*\.so)(\..*)?/\1/')
    else
        regex="(.+\.so)(\.[0-9]+){1,$version_segments}"
        newfile=$(echo "$sofile" | sed -r "s/$regex/\1\2/")
    fi

    # 检查新文件名是否已存在
    if [ ! -e "$newfile" ]; then
        # 如果不存在，重命名文件
        mv "$sofile" "$newfile"
        echo "Renamed $sofile to $newfile"
    else
        echo "Skipped: $newfile already exists."
    fi
done
