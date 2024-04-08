param (
	[Parameter(Mandatory = $true)]
	[string]$Path,	# 要被打包压缩的目录
	[string]$Zip = "gzip"
)
$ErrorActionPreference = "Stop"

if (-not (Test-Path $Path))
{
	throw "不存在 $Path"
}

$Path = $Path.Replace('\', '/')
$Path = $Path.Replace("//", '/')
$last_path = $Path.Split('/', ([System.StringSplitOptions]::TrimEntries -bor [System.StringSplitOptions]::RemoveEmptyEntries))[-1]

if ($IsWindows)
{
	run-bash-cmd.ps1 @"
	/usr/bin/tar -cf "${last_path}.tar" "$Path"
	$Zip "./${last_path}.tar"
"@
}
else
{
	tar -cf "${last_path}.tar" "$Path"
	& $Zip "./${last_path}.tar"
}
