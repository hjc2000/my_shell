param (
	[Parameter(Mandatory = $true)]
	[string]$cmd
)
$ErrorActionPreference = "Stop"

$cmd.Trim()
bash.exe -c "${cmd} && exit"