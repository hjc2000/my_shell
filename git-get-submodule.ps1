param (
	[Parameter(Mandatory = $true)]
	[string]$submoudle_name
)
$ErrorActionPreference = "Stop"

while ($true)
{
	git submodule init
	if ($LASTEXITCODE)
	{
		throw "初始化子模块失败。"
	}

	git submodule update --recursive $submoudle_name
	if (-not $LASTEXITCODE)
	{
		return 0
	}
}
