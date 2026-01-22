param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name,
	[switch]$recurse_submodules,
	[string]$depth
)

$ErrorActionPreference = "Stop"
Push-Location

try
{
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

	$repo_name = git-parse-repo-name.ps1 -git_url $git_url

	while ($true)
	{
		if (Test-Path "./$repo_name")
		{
			Write-Host "$repo_name 目录已存在，不克隆。"
			exit 0
		}

		Invoke-Expression $git_cmd

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
