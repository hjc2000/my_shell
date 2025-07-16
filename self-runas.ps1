param (
	[string]$ScriptPath  # 可选参数：指定要运行的脚本路径
)

# 如果没有传入参数，则自动获取当前脚本路径
if (-not $ScriptPath)
{
	$ScriptPath = $MyInvocation.MyCommand.Path
}

# 检查当前是否是管理员权限
$is_admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $is_admin)
{
	# 如果不是管理员，则使用 runas 动词重新启动脚本
	$arguments = "-File `"$ScriptPath`""

	Start-Process pwsh.exe -ArgumentList $arguments -Verb RunAs
	throw "当前不是管理员。"
}

# 以下是脚本的实际内容，只有管理员权限才会执行到这里
Write-Host "脚本以管理员权限运行"
