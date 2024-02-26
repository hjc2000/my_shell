$ErrorActionPreference = "Stop"

Write-Host "当前目录是：$(Get-Location)"
git pull
git add .
git commit -m "auto commit"
git push