
while ($true)
{
	$output = git pull
	$output = "$output"

	if ($output.Contains("but no such ref was fetched"))
	{
		throw "远程仓库不存在当前的分支，无法拉取。"
	}

	if ($output.Contains("git branch --set-upstream-to="))
	{
		throw "此分支还没有设置要跟踪的上游的远程分支。"
	}

	if (-not $LASTEXITCODE)
	{
		# 拉取成功
		exit 0
	}
}
