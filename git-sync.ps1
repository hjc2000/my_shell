param (
	[string]$commit_log = "auto commit"
)

$ErrorActionPreference = "Stop"
Push-Location

try
{
	Write-Host "正在进行同步的目录是：$(Get-Location)"
	git-pull.ps1

	git add --all
	git commit -m $commit_log

	git-push.ps1
}
catch
{
	throw "
		$(get-script-position.ps1)
		$(${PSItem}.Exception.Message)
	"
}
finally
{
	Pop-Location
}
