param (
	[switch]$Debug,
	[string]$SolutionPath,
	[string]$Platform = "x64" # 默认平台为x64，但用户可以通过参数覆盖
)

# 检查解决方案路径是否有效
if (-Not (Test-Path $SolutionPath))
{
	Write-Host "解决方案路径无效或文件不存在。"
	exit
}

# 根据 $Debug 开关设置构建配置
$configuration = if ($Debug) { "Debug" } else { "Release" }

# 根据参数执行逻辑
Write-Host "开始构建 $($configuration) 配置，平台: $($Platform)..."
MSBuild.exe $SolutionPath /p:Configuration=$configuration /p:Platform=$Platform
Write-Host "主解决方案构建完成。"

# 构建 INSTALL 项目
# 获取解决方案所在的目录
$solutionDir = Split-Path -Parent $SolutionPath
# 定义 INSTALL 项目文件的路径
$installProjectPath = Join-Path $solutionDir "INSTALL.vcxproj"

if (Test-Path $installProjectPath)
{
	Write-Host "开始构建 INSTALL 项目..."
	MSBuild.exe $installProjectPath /p:Configuration=$configuration /p:Platform=$Platform
	Write-Host "INSTALL 项目构建完成。"
}
else
{
	Write-Host "未找到 INSTALL 项目，跳过此步骤。"
}
