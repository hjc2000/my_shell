#!/bin/bash

# 检查参数个数
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <WORKSPACE_DIR> <URL>"
    exit 1
fi

WORKSPACE_DIR=$1
URL=$2
FILENAME=$(basename "$URL")
EXTENSION="${FILENAME##*.}"
DIRNAME=""

# 根据文件扩展名确定解压命令和处理目录名
case "$EXTENSION" in
    gz) 
        DECOMPRESS_CMD="tar -vxf"
        DIRNAME=$(basename "$FILENAME" .tar.gz)
        ;;
    xz)
        DECOMPRESS_CMD="tar -vJxf"
        DIRNAME=$(basename "$FILENAME" .tar.xz)
        ;;
    bz2)
        DECOMPRESS_CMD="tar -vjxf"
        DIRNAME=$(basename "$FILENAME" .tar.bz2)
        ;;
    zip)
        DECOMPRESS_CMD="unzip"
        DIRNAME=$(basename "$FILENAME" .zip)
        ;;
    *)
        echo "Unsupported file extension: $EXTENSION"
        exit 1
        ;;
esac

# 确保工作区目录存在
if [ ! -d "$WORKSPACE_DIR" ]; then
    echo "Workspace directory does not exist. Exiting..."
    exit 1
fi

cd "$WORKSPACE_DIR"

# 检查目录是否已存在
if [ -d "$DIRNAME" ]; then
    echo "Directory $DIRNAME already exists in the workspace."
    exit 0
fi

# 如果目录不存在，检查压缩包是否存在
if [ ! -f "$FILENAME" ]; then
    echo "File $FILENAME does not exist in the workspace. Downloading from $URL..."
    wget "$URL"
else
    echo "File $FILENAME already exists in the workspace."
fi

# 解压压缩包
echo "Extracting $FILENAME..."
$DECOMPRESS_CMD "$FILENAME"

echo "Extraction complete. Directory $DIRNAME should now be in the workspace."