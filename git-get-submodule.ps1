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
		throw "初始化子模块失败。检查名称是否正确。"
	}

	git submodule update --remote --recursive $submoudle_name
	if (-not $LASTEXITCODE)
	{
		return 0
	}
}
