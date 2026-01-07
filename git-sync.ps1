param (
	[string]$commit_log = "auto commit"
)
$ErrorActionPreference = "Stop"

Write-Host "正在进行同步的目录是：$(Get-Location)"
git-pull.ps1

git add --all
git commit -m $commit_log

git-push.ps1
