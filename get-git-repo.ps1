param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name
)
$ErrorActionPreference = "Stop"

git config --global submodule.recurse true
$repoName = & parse-git-repo-name.ps1 -git_url $git_url

Push-Location
try
{
	if (Test-Path "./$repoName/")
	{
		# 已经存在该仓库的文件夹
		Set-Location $repoName
		if (-not [string]::IsNullOrEmpty($branch_name))
		{
			git pull origin $branch_name
			git checkout $branch_name
		}
		else
		{
			git pull
		}
	}
	else
	{
		# 不存在该仓库的文件夹，需要克隆
		while ($true)
		{
			if (-not [string]::IsNullOrEmpty($branch_name))
			{
				git clone --branch $branch_name $git_url
			}
			else
			{
				git clone $git_url
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
}
catch
{
}
finally
{
	Pop-Location
}
