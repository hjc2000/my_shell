net start w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"ntp.ntsc.ac.cn" /update
w32tm /resync
Set-TimeZone -Id "China Standard Time"
