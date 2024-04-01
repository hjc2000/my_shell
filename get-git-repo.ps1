param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name
)
$ErrorActionPreference = "Stop"

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
			git checkout $branch_name
		}

		if ($LASTEXITCODE)
		{
			throw "没有该分支"
		}

		git submodule update --init --recursive
		git pull --recurse-submodules
	}
	else
	{
		# 不存在该仓库的文件夹，需要克隆
		while ($true)
		{
			if (-not [string]::IsNullOrEmpty($branch_name))
			{
				git clone $git_url --recurse-submodules --branch $branch_name
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
}
catch
{
	throw
}
finally
{
	Pop-Location
}
