param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name,
	[switch]$recurse_submodules,
	[string]$depth
)
$ErrorActionPreference = "Stop"

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

return Invoke-Expression $git_cmd
