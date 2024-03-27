param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name
)
$ErrorActionPreference = "Stop"

$repoName = & parse-git-repo-name.ps1 -git_url $git_url

if (Test-Path "./$repoName/")
{
	$current_path = Get-Location
	Set-Location $repoName
	if ($branch_name)
	{
		git pull origin $branch_name --recurse-submodules
		git checkout $branch_name --recurse-submodules
	}
	else
	{
		git pull --recurse-submodules
	}
	
	Set-Location $current_path
}
else
{
	while ($true)
	{
		if (-not [string]::IsNullOrEmpty($branch_name))
		{
			git clone --branch $branch_name $git_url --recurse-submodules
		}
		else
		{
			git clone $git_url --recurse-submodules
		}

		if ($?)
		{
			# 如果上一个命令成功，则退出循环
			break 
		} 
		Write-Host "Clone failed, retrying..."
		Start-Sleep -Seconds 5
	}
}
