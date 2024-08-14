$result = w32tm /resync
Write-Host "结果：$result"
Write-Host "退出代码：$LASTEXITCODE"
