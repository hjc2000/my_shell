param (
	[Parameter(Mandatory = $true)]
	[string]$DirectoryPath
)

# 拼接完整的.gitmodules文件路径
$gitModulesPath = Join-Path $DirectoryPath ".gitmodules"

# 创建一个空数组来存储子模块名称
$submoduleNames = @()

# 检查.gitmodules文件是否存在
if (Test-Path $gitModulesPath)
{
	# 读取文件内容
	$gitModulesContent = Get-Content $gitModulesPath -Raw

	# 使用正则表达式查找所有子模块名称
	[regex]::Matches($gitModulesContent, '\[submodule "(.+?)"\]') | ForEach-Object {
		$submoduleName = $_.Groups[1].Value
		$submoduleNames += $submoduleName
	}
}
else
{
	Write-Output "The .gitmodules file does not exist at the specified directory: $DirectoryPath"
}

# 返回子模块名称列表
return $submoduleNames
