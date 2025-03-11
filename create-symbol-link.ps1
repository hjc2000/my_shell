param (
	# 符号链接所在的路径
	[Parameter(Mandatory = $true)]
	[string]$Path,

	# 符号链接指向的路径
	[Parameter(Mandatory = $true)]
	[string]$Target
)
$ErrorActionPreference = "Stop"

New-Item -ItemType SymbolicLink -Path $Path -Target $Target
