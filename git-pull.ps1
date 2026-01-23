
$ErrorActionPreference = "Stop"
Push-Location

try
{
	while ($true)
	{
		git-verify-upstream-existence.ps1

		if ($LASTEXITCODE)
		{
			[string]$current_branch = git branch --show-current

			throw "
				$(get-script-position.ps1)
				远程仓库不存在 `"${current_branch}`" 分支，无法拉取。
			"
		}

		git pull

		if (-not $LASTEXITCODE)
		{
			# 拉取成功
			exit 0
		}
	}
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
