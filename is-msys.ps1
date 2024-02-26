$uname = uname -a
if ($uname.Contains("Msys"))
{
	Write-Host "是 msys"
	return 1
}

Write-Host "不是 msys"
return 0