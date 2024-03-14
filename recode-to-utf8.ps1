param (
	[Parameter(Mandatory = $true)]
	[string]$input_file_path,
	[switch]$Recurse
)
$ErrorActionPreference = "Stop"

$file_list = Get-ChildItem -Path $input_file_path -Recurse:$Recurse -File
foreach ($file in $file_list)
{
	$conv_result = iconv -f $(uchardet $file.FullName) -t UTF-8 $file.FullName
	if (-not $LASTEXITCODE)
	{
		Write-Host "$($file.FullName) 转换成功"
		$conv_result | Out-File $file.FullName
		continue
	}
	
	Write-Host "转换失败，猜测原始文件为 GB18030, 再次尝试转换"
	$conv_result = iconv -f GB18030 -t UTF-8 $file.FullName
	if (-not $LASTEXITCODE)
	{
		Write-Host "$($file.FullName) 转换成功"
		$conv_result | Out-File $file.FullName
		continue
	}
	
	Write-Host "$($file.FullName) 转换失败"
}
