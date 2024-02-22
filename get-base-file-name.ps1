# 可以从类似 test.tar.bz 这样的文件名中提取出基础文件名： test
param (
	[Parameter(Mandatory = $true)]
	[string]$file_name
)

# 查找文件名中第一个点号的位置
$index = $file_name.IndexOf('.')

# 如果找到点号，提取并返回点号前的部分
if ($index -ne -1)
{
	$baseName = $file_name.Substring(0, $index)
}
else
{
	# 如果没有找到点号，返回整个文件名
	$baseName = $file_name
}

return $baseName