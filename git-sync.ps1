param (
	[string]$commit_log = "auto commit"
)
$ErrorActionPreference = "Stop"

Write-Host "正在进行同步的目录是：$(Get-Location)"
Write-Host "本次的提交记录内容："
Write-Host $commit_log
git pull
git add --all
git commit -m $commit_log
git push
