param (
	[Parameter(Mandatory = $true)]
	[string]$git_url,
	[string]$branch_name
)
$ErrorActionPreference = "Stop"

git-clone.ps1 -git_url $git_url -branch_name $branch_name
try
{
	$repoName = git-parse-repo-name.ps1 -git_url $git_url
	Push-Location $repoName

	# 如果 $branch_name 参数制定了分支名，但是与当前分支名不符，要求重新克隆
	# 本脚本不具备签出到分支的能力。因为带有子模块时，签出到分支非常麻烦。
	[string]$current_branch = git branch
	if (-not $current_branch.Contains($branch_name))
	{
		throw "仓库文件夹已经存在，且分支名与 $branch_name 不符。"
	}

	git pull
	while ($true)
	{
		git submodule sync --recursive
		git submodule update --init --recursive
		if (-not $LASTEXITCODE)
		{
			break
		}
	}

	return 0
}
finally
{
	Pop-Location
}
