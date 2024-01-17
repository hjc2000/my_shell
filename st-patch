#!/bin/bash

# 用来给 st 公司或正点原子的 linux SDK 打补丁。进入到源码目录，
# 源码目录的上层目录有一个 patch 文件，这就是补丁文件。
# 在源码目录中执行本脚本，即可打补丁。

for p in `ls -1 ../*.patch`; do patch -p1 < $p; done
