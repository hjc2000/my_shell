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

if ($IsWindows)
{
	Copy-Item -Path "$src_path/bin/*" -Destination "$dst_path/bin/" -Force -Recurse
	if (Test-Path "$src_path/lib/*")
	{
		Copy-Item -Path "$src_path/lib/*" -Destination "$dst_path/lib/" -Force -Recurse
	}
	elseif (Test-Path -Path "$src_path/lib64")
	{
		Copy-Item -Path "$src_path/lib64/*" -Destination "$dst_path/lib/" -Force -Recurse
	}
	elseif (Test-Path -Path "$src_path/lib32")
	{
		Copy-Item -Path "$src_path/lib32/*" -Destination "$dst_path/lib/" -Force -Recurse
	}


	Copy-Item -Path "$src_path/include/*" -Destination "$dst_path/include/" -Force -Recurse
}
else
{
	# linux 平台
	run-bash-cmd.ps1 @"
set -e

# 复制并保留符号链接
cp -a -r $src_path/bin/* $dst_path/bin/

if [ -d "$src_path/lib" ]; then
	cp -a -r "$src_path/lib/"* "$dst_path/lib/"
elif [ -d "$src_path/lib64" ]; then
	cp -a -r "$src_path/lib64/"* "$dst_path/lib/"
elif [ -d "$src_path/lib32" ]; then
	cp -a -r "$src_path/lib32/"* "$dst_path/lib/"
fi

cp -a -r $src_path/include/* $dst_path/include/
"@
}
