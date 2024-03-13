param (
	[Parameter(Mandatory = $true)]
	[string]$input_file_path
)
$ErrorActionPreference = "Stop"

$recode_result = iconv -f $(uchardet $input_file_path) -t UTF-8 $input_file_path
if (-not $LASTEXITCODE)
{
	Write-Host "转换成功"
	$recode_result | Set-Content -Path $input_file_path
	return
}

Write-Host "转换失败，猜测原始文件为 GB2312，再次尝试转换"
$recode_result = iconv -f GB2312 -t UTF-8 $input_file_path
if (-not $LASTEXITCODE)
{
	Write-Host "转换成功"
	$recode_result | Set-Content -Path $input_file_path
	return
}

Write-Host "转换失败"
