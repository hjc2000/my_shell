param (
	[Parameter(Mandatory = $true)]
	[string]$configure_cmd
)
$ErrorActionPreference = "Stop"

bash.exe -c "${configure_cmd} && exit"