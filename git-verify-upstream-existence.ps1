# 检查当前分支的 upstream 是否真实存在
# 即远程仓库中必须真的有这个分支。

$ErrorActionPreference = "Stop"
Push-Location

try
{
	git rev-parse --verify "@{u}"
	exit $LASTEXITCODE
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
