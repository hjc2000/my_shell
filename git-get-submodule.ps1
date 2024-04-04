param (
	[Parameter(Mandatory = $true)]
	[string]$submoudle_name
)
$ErrorActionPreference = "Stop"

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
