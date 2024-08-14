# 将此文件放置到开机启动目录，然后在 bin 目录中放置一个 invoked-by-start-up-runas.ps1 文件
Start-Process pwsh -ArgumentList "-Command invoked-by-start-up-runas.ps1" -Verb RunAs
