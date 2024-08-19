net start w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"time.windows.com" /update
w32tm /resync
Set-TimeZone -Id "China Standard Time"
