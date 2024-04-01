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
	while ($true)
	{
		if (Test-Path "./$repoName/")
		{
			# 已经存在该仓库的文件夹
			Set-Location $repoName
			if ($branch_name)
			{
				git checkout $branch_name
			}
	
			if ($LASTEXITCODE)
			{
				throw "没有该分支"
			}
	
			git submodule update --init --recursive
			git pull --recurse-submodules
			if (-not $LASTEXITCODE)
			{
				# 如果上一个命令成功，则退出循环
				return 
			} 
		}
		else
		{
			# 不存在该仓库的文件夹，需要克隆
			if ($branch_name)
			{
				git clone $git_url --recurse-submodules --branch $branch_name --depth 1
			}
			else
			{
				git clone $git_url --recurse-submodules --depth 1
			}
	
			if (-not $LASTEXITCODE)
			{
				# 如果上一个命令成功，则退出循环
				return 
			} 
		}
	
		Write-Host "克隆或拉取失败。将在 5 秒后重试。"
		Start-Sleep -Seconds 5
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
