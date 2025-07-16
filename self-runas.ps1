# 检查当前是否是管理员权限
$is_admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $is_admin)
{
	# 如果不是管理员，则使用 runas 动词重新启动脚本
	$script_path = $MyInvocation.MyCommand.Path
	$arguments = "-File `"$script_path`""

	Start-Process pwsh.exe -Verb RunAs -ArgumentList $arguments
	exit
}

# 以下是脚本的实际内容，只有管理员权限才会执行到这里
Write-Host "脚本以管理员权限运行"
