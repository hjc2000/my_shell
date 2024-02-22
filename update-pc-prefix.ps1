param (
	[Parameter(Mandatory = $true)]
	[string]$path_to_pc_file
)

# 检查文件是否存在
if (-Not (Test-Path -Path $path_to_pc_file))
{
	Write-Host "File not found: $path_to_pc_file"
	exit 1
}

# 读取prefix行并提取prefix路径
$prefix_line = Get-Content $path_to_pc_file | Where-Object { $_ -match "^prefix=" }
if (-not $prefix_line)
{
	Write-Host "prefix line not found in file: $path_to_pc_file"
	exit 1
}
$old_prefix_path = $prefix_line -split "=" | Select-Object -Last 1

# 使用 cygpath 转换旧的prefix路径
$new_prefix_path = cygpath -u $old_prefix_path | Out-String | ForEach-Object { $_.Trim() }

# 读取文件内容
$content = Get-Content $path_to_pc_file -Raw

# 替换文件中所有旧的prefix路径
$new_content = $content -replace [regex]::Escape($old_prefix_path), $new_prefix_path

# 保存修改后的文件内容
$new_content | Set-Content $path_to_pc_file

Write-Host "Updated prefix in $path_to_pc_file to $new_prefix_path"