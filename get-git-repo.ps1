param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name,
	[switch]$recurse_submodules,
	[switch]$all_depth
)
$ErrorActionPreference = "Stop"

$repoName = & parse-git-repo-name.ps1 -git_url $git_url
while ($true)
{
	if (Test-Path "./$repoName/")
	{
		try
		{
			# 已经存在该仓库的文件夹
			Push-Location $repoName
			[string]$current_branch = git branch
			if (-not $current_branch.Contains($branch_name))
			{
				throw "仓库文件夹已经存在，且分支名与 $branch_name 不符，先手动删除仓库文件夹，重新克隆。"
			}

			git submodule update --init --recursive
			git pull --recurse-submodules
			if (-not $LASTEXITCODE)
			{
				# 如果上一个命令成功，则退出循环
				return 0
			}
		}
		finally
		{
			Pop-Location
		}
	}
	else
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
			# 克隆成功
			return 0
		} 
	}

	Write-Host "克隆或拉取失败。将在 5 秒后重试。"
	Start-Sleep -Seconds 5
}
