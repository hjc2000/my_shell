# 定义枚举类型
Add-Type -TypeDefinition @"
    public enum BuildConfiguration {
        Debug,
        Release
    }
"@

# 使用param定义参数，包括使用枚举类型的参数
param (
	[BuildConfiguration]$Configuration,
	[string]$SolutionPath
)

# 检查解决方案路径是否有效
if (-Not (Test-Path $SolutionPath))
{
	Write-Host "解决方案路径无效或文件不存在。"
	exit
}

# 根据参数执行逻辑
Write-Host "开始构建 $($Configuration) 配置..."
msbuild $SolutionPath /p:Configuration=$Configuration /p:Platform="Any CPU"
Write-Host "构建完成。"