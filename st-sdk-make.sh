#!/bin/bash

# 编译 st 公司或正点原子的 SDK。进入源码目录后执行此脚本。
# 源码目录的上层目录有一个叫 Makefile.sdk 的文件。

make -f ../Makefile.sdk -j12 all
