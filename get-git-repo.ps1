param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name
)
$ErrorActionPreference = "Stop"

$repoName = & parse-git-repo-name.ps1 -git_url $git_url

# 检查当前目录下是否存在目标仓库的目录
if (Test-Path "./$repoName/")
{
	# 获取当前路径
	$current_path = Get-Location

	# 如果存在，进入该目录并更新代码
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

	# 返回到原始路径
	Set-Location $current_path
}
else
{
	# 如果不存在，尝试克隆仓库，如果失败则无限重试
	while ($true)
	{
		try
		{
			if (-not [string]::IsNullOrEmpty($branch_name))
			{
				git clone --branch $branch_name $git_url
				break
			}
			else
			{
				git clone $git_url
				break
			}
		}
		catch
		{
			Write-Host "Clone failed, retrying..."
			Start-Sleep -Seconds 5
		}
	}
}

Set-Location "./$repoName"