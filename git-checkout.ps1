param (
	[Parameter(Mandatory = $true)]
	[string]$branch_name
)

$ErrorActionPreference = "Stop"
Push-Location

try
{
	while ($true)
	{
		git checkout --force $branch_name

		if (-not $LASTEXITCODE)
		{
			exit 0
		}
	}
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
