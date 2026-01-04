param(
	[Parameter(Mandatory = $true)]
	[string[]]$packages
)

foreach ($pkg in $packages)
{
	Write-Output "检查包: $pkg"

	run-bash-cmd.ps1 @"
	pacman -Q $pkg
"@

	if ($LASTEXITCODE)
	{
		Write-Output "$pkg 还没被安装. 尝试安装："

		run-bash-cmd.ps1 @"
		pacman -S $pkg --noconfirm --overwrite '*'
"@

	}
	else
	{
		Write-Output "$pkg 已经安装。"
	}
}
