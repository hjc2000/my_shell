param (
	[Parameter(Mandatory = $true)]
	[string]$path_to_fix
)
$ErrorActionPreference = "Stop"

if ($IsWindows)
{
	return $(cygpath.exe $path_to_fix)
}

return $path_to_fix