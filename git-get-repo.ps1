param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name
)
$ErrorActionPreference = "Stop"

$repoName = git-parse-repo-name.ps1 -git_url $git_url
if (-not (Test-Path "./$repoName"))
{
	# 不存在该仓库的文件夹，需要克隆
	while ($true)
	{
		git-clone.ps1 -git_url $git_url -branch_name $branch_name
		if (-not $LASTEXITCODE)
		{
			break
		}

		Write-Host "克隆失败。将在 5 秒后重试。"
		Start-Sleep -Seconds 5	
	}
}

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

	git pull
	$submodules = git-get-submodule-names.ps1 -DirectoryPath ./
	foreach ($submodule in $submodules)
	{
		git-get-submodule.ps1 -submoudle_name $submodule
	}

	return 0
}
finally
{
	Pop-Location
}
