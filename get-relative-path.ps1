# 获取 $Path 相对于 $BasePath 的路径
param (
	[Parameter(Mandatory = $true)]
	[string]$BasePath,
	[Parameter(Mandatory = $true)]
	[string]$Path
)
$ErrorActionPreference = "Stop"

$BasePath = $BasePath.Replace("\", "/").Replace("//", "/")
$Path = $Path.Replace("\", "/").Replace("//", "/")
$relative_path = [System.IO.Path]::GetRelativePath($BasePath, $Path)
return $relative_path
