param (
	[Parameter(Mandatory = $true)]
	$repo_path,
	[Parameter(Mandatory = $true)]
	[string]$submoudle_name
)
$ErrorActionPreference = "Stop"

Push-Location $repo_path
try
{
	while ($true)
	{
		git submodule init $submoudle_name
		if ($LASTEXITCODE)
		{
			continue
		}
	
		git submodule update --remote --recursive $submoudle_name
		if (-not $LASTEXITCODE)
		{
			return 0
		}
	}
}
finally
{
	Pop-Location
}
