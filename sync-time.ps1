net start w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"ntp.ntsc.ac.cn" /update
while ($true)
{
	w32tm /resync
	if (-not $LASTEXITCODE)
	{
		break
	}
}

Set-TimeZone -Id "China Standard Time"
