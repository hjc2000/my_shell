# 将此文件放置到开机启动目录，然后在 bin 目录中放置一个 start-up.ps1 文件
Start-Process pwsh -ArgumentList "-Command start-up.ps1" -Verb RunAs
