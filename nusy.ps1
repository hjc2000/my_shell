$ErrorActionPreference = "Stop"
Push-Location

try
{
	Set-Location $env:NUGET
	git-sync.ps1
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
