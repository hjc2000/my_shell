$ErrorActionPreference = "Stop"
$my_shell_path = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

Push-Location $my_shell_path

try
{
	git-pull.ps1
}
finally
{
	Pop-Location
}
