Push-Location $env:NUGET

try
{
	git-sync.ps1
}
finally
{
	Pop-Location
}
