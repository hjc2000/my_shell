
while ($true)
{
	git-verify-upstream-existence.ps1

	if ($LASTEXITCODE)
	{
		throw "远程仓库不存在当前的分支，无法拉取。"
	}

	git pull

	if (-not $LASTEXITCODE)
	{
		# 拉取成功
		exit 0
	}
}
