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
		# 已经存在该仓库的文件夹
		try
		{
			Push-Location $repoName

			# 如果 $branch_name 参数制定了分支名，但是与当前分支名不符，要求重新克隆
			# 本脚本不具备签出到分支的能力。因为带有子模块时，签出到分支非常麻烦。
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
		if ($all_depth)
		{
			$depth = ""
		}
		else
		{
			$depth = "1"
		}

		git-clone.ps1 -git_url $git_url `
			-branch_name $branch_name `
			-recurse_submodules:$recurse_submodules `
			-depth $depth

		if (-not $LASTEXITCODE)
		{
			return 0
		}
	}

	Write-Host "克隆或拉取失败。将在 5 秒后重试。"
	Start-Sleep -Seconds 5
}
