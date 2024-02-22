param (
	[Parameter(Mandatory = $true)]
	[string]$cmd
)
$ErrorActionPreference = "Stop"

$cmd.Trim()
$env:MSYSTEM = "UCRT64"
bash -c "${cmd} && exit"