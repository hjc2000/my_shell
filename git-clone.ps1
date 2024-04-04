param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name,
	[switch]$recurse_submodules,
	[string]$depth
)
$ErrorActionPreference = "Stop"

$repoName = git-parse-repo-name.ps1 -git_url $git_url
if (Test-Path "./$repoName")
{
	throw "$repoName 目录已存在，请先删除目录后再克隆"
}

$git_cmd = "git clone $git_url"
if ($branch_name)
{
	$git_cmd = "$git_cmd --branch $branch_name"
}

if ($recurse_submodules)
{
	$git_cmd = "$git_cmd --recurse-submodules"
}

if ($depth)
{
	$git_cmd = "$git_cmd --depth $depth"
}

while ($true)
{
	Invoke-Expression $git_cmd
	if (-not $LASTEXITCODE)
	{
		return 0
	}
}
