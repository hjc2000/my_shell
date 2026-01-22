$ErrorActionPreference = "Stop"
Push-Location

try
{
	nusy.ps1
	nuget.exe init ./ $env:NUGET
	nusy.ps1
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
