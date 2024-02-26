param (
	[Parameter(Mandatory = $true)]
	[string]$src_path,

	[Parameter(Mandatory = $true)]
	[string]$dst_path
)
$ErrorActionPreference = "Stop"

Write-Host "将 $src_path 安装到 $dst_path"

New-Item -Path $dst_path/bin/ -ItemType Directory -Force
New-Item -Path $dst_path/lib/ -ItemType Directory -Force
New-Item -Path $dst_path/include/ -ItemType Directory -Force

run-bash-cmd.ps1 @"
set -e

# 复制并保留符号链接
cp -a -r $src_path/bin/* $dst_path/bin/
cp -a -r $src_path/lib/* $dst_path/lib/
cp -a -r $src_path/include/* $dst_path/include/
"@