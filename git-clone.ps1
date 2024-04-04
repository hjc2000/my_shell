param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name,
	[switch]$recurse_submodules,
	[switch]$all_depth
)
$ErrorActionPreference = "Stop"

while ($true)
{
	# 不存在该仓库的文件夹，需要克隆
	$clone_cmd = "git clone $git_url"
	if ($recurse_submodules)
	{
		$clone_cmd = "$clone_cmd --recurse-submodules"
	}

	if ($branch_name)
	{
		$clone_cmd = "$clone_cmd --branch $branch_name"
	}

	if (-not $all_depth)
	{
		$clone_cmd = "$clone_cmd --depth 1"
	}

	Invoke-Expression $clone_cmd
	if (-not $LASTEXITCODE)
	{
		return 0
	} 
}
