param (
	[Parameter(Mandatory = $true)]
	[string]$cmd
)
$ErrorActionPreference = "Stop"


$cmd = $cmd.Trim()
$cmd = $cmd.Replace("`t", " ")
$cmd = $cmd.Replace("`r`n", "`n")

if ($IsWindows)
{
	# 如果是 msys 环境
	$env:MSYSTEM = "UCRT64"
	$env:MSYS2_PATH_TYPE = "inherit"
	$env:MSYSCON = "defterm"
	$env:MSYSTEM_PREFIX = "/ucrt64"
	$env:MINGW_PREFIX = "/ucrt64"
	$env:MSYSTEM_CHOST = "x86_64-w64-mingw32"
	$env:MSYSTEM_CARCH = "x86_64"
	$env:CHERE_INVOKING = "enabled_from_arguments"
	$env:MSYS2_NOSTART = "yes"
	$env:CONTITLE = "MinGW UCRT x64"

	$cmd | bash -himBHs
}
else
{
	@"
	set -e
	export PATH=$env:PATH
	$cmd
"@ | bash -norc
}