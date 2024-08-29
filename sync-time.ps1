net stop w32time
net start w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"ntp.ntsc.ac.cn,time.windows.com" /update
while ($true)
{
	$result = w32tm /resync
	Write-Host $result
	if ($result.Contains("将 resync 命令发送到本地计算机 成功地执行了命令") -or
		$result.Contains("The command completed successfully"))
	{
		break
	}
}

Set-TimeZone -Id "China Standard Time"
