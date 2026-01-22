$ErrorActionPreference = "Stop"
Push-Location

try
{
	$cmd = @"
	nohup $env:HOME/install/Steam++/Steam++.sh > /dev/null 2>&1 &
"@

	$cmd | bash -norc
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
