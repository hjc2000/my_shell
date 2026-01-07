
while ($true)
{
	git-verify-upstream-existence.ps1

	if ($LASTEXITCODE)
	{
		throw "远程仓库不存在当前的分支，无法推送。"
	}

	git push

	if (-not $LASTEXITCODE)
	{
		# 拉取成功
		exit 0
	}
}
