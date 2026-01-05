param (
	[string]$commit_log = "auto commit"
)
$ErrorActionPreference = "Stop"

Write-Host "正在进行同步的目录是：$(Get-Location)"

while ($true)
{
	git pull
	if (-not $LASTEXITCODE)
	{
		break
	}
}

git add --all
git commit -m $commit_log

while ($true)
{
	git push
	if (-not $LASTEXITCODE)
	{
		break
	}
}
