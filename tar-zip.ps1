param (
	[Parameter(Mandatory = $true)]
	[string]$Path,	# 要被打包压缩的目录
	[string]$Zip = "gzip"
)

$ErrorActionPreference = "Stop"
Push-Location

try
{
	if (-not (Test-Path $Path))
	{
		throw "不存在 $Path"
	}

	$Path = $Path.Replace('\', '/')
	$Path = $Path.Replace("//", '/')
	$split_options = [System.StringSplitOptions]::TrimEntries
	$split_options = $split_options -bor [System.StringSplitOptions]::RemoveEmptyEntries
	$last_path = $Path.Split('/', $split_options)[-1]

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
}
catch
{
	throw "
		$(get-script-position.ps1)
		$(${PSItem}.Exception.Message)
	"
}
finally
{
	Pop-Location
}
