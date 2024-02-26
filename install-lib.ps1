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

Copy-Item -Path $src_path/bin/ `
	-Destination $dst_path/bin/ `
	-Force -Recurse

Copy-Item -Path $src_path/lib/ `
	-Destination $dst_path/lib/ `
	-Force -Recurse

Copy-Item -Path $src_path/include/ `
	-Destination $dst_path/include/ `
	-Force -Recurse