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

	# 如果 $branch_name 参数指定了分支名，但是与当前分支名不符，要求重新克隆
	# 本脚本不具备签出到分支的能力。因为带有子模块时，签出到分支非常麻烦。
	[string]$current_branch = git branch --show-current

	# -cne 是大小写不敏感的 “不等” 比较运算符。
	if (($branch_name -ne "") -and ($current_branch -cne $branch_name))
	{
		# 本脚本调用者传入了 $branch_name 参数，且不等于空字符串，
		# 并且传入的 $branch_name 不等于 git 实际检查到的当前分支名。
		git reset --hard

		git-pull.ps1

		while ($true)
		{
			git checkout --force $branch_name
			if (-not $LASTEXITCODE)
			{
				break
			}
		}
	}

	git-pull.ps1

	while ($true)
	{
		git submodule sync --recursive
		if (-not $LASTEXITCODE)
		{
			break
		}
	}

	while ($true)
	{
		git submodule update --init --recursive --force
		if (-not $LASTEXITCODE)
		{
			break
		}
	}

	exit 0
}
finally
{
	Pop-Location
}
