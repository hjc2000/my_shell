$ErrorActionPreference = "Stop"

Write-Host "正在进行同步的目录是：$(Get-Location)"
git pull
git commit -m "auto commit" -a
git push