$ErrorActionPreference = "Stop"
Push-Location

try
{
	$my_shell_path = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
	Set-Location $my_shell_path
	git-pull.ps1

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
