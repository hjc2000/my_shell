param (
	[Parameter(Mandatory = $true)]
	[string]$input_file_path,
	[Parameter(Mandatory = $true)]
	[string]$output_file_path
)
$ErrorActionPreference = "Stop"

iconv -f $(uchardet $input_file_path) -t UTF-8 $input_file_path | Out-File $output_file_path
if (-not $LASTEXITCODE)
{
	Write-Host "转换成功"
	return
}

Write-Host "转换失败，猜测原始文件为 GB18030，再次尝试转换"
iconv -f GB18030 -t UTF-8 $input_file_path | Out-File $output_file_path
if (-not $LASTEXITCODE)
{
	Write-Host "转换成功"
	return
}

Write-Host "转换失败"
