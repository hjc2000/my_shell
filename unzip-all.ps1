# 检查是否提供了目录路径作为参数
param (
	[Parameter(Mandatory = $true)]
	[string]$dir
)

# 验证目录是否存在
if (-not (Test-Path -Path $dir))
{
	Write-Host "提供的路径不存在或不是一个目录: $dir"
	exit 1
}

# 使用 Get-ChildItem 命令递归查找所有 .zip 文件
$zipFiles = Get-ChildItem -Path $dir -Filter *.zip -Recurse -File

foreach ($file in $zipFiles)
{
	# 获取.zip文件所在的目录
	$dir = $file.dirName
	Write-Host "正在解压: $($file.FullName) 到 $dir"
    
	# 解压.zip文件到其所在目录
	Expand-Archive -Path $file.FullName -DestinationPath $dir -Force
}
