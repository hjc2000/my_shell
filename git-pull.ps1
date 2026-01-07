
while ($true)
{
	$output = git pull
	$output = "$output"

	git-verify-upstream-existence.ps1

	if ($LASTEXITCODE)
	{
		throw "远程仓库不存在当前的分支，无法拉取。"
	}

	git-check-whether-it-has-upstream.ps1

	if ($LASTEXITCODE)
	{
		throw "此分支还没有设置要跟踪的上游的远程分支。"
	}

	if (-not $LASTEXITCODE)
	{
		# 拉取成功
		exit 0
	}
}
