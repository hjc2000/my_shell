param (
	[string]$OutFilePath = "include_all.h",
	[switch]$DoNotHoldTree,
	# 开启此开关，结果仅会打印到控制台，不会创建文件并写入。此时 $OutFilePath 参数会被忽略。
	[switch]$WriteHostOnly
)
$ErrorActionPreference = "Stop"

if ((Test-Path $OutFilePath) -and (-not $WriteHostOnly))
{
	throw "$OutFilePath 已存在"
}

$base_path = Get-Location
$header_files = Get-ChildItem -Path "./*.h" -File -Recurse
$importing_header_file_content = ""
foreach ($header_file in $header_files)
{
	if ($DoNotHoldTree)
	{
		# 不保持目录树。即 include 指令内不出现路径，只包含文件名。
		$path = $header_file.Name
		$importing_header_file_content += "#include<$path>`n"	
	}
	else
	{
		# 保持目录树。即 include 指令内的文件带有路径，相对于 $base_path。
		$full_path = $header_file.FullName
		$relative_path = get-relative-path.ps1 -BasePath $base_path -Path $full_path
		$importing_header_file_content += "#include<$relative_path>`r`n"
	}
}

$importing_header_file_content = $importing_header_file_content.Trim()
Write-Host $importing_header_file_content
if (-not $WriteHostOnly)
{
	New-Item -Path $OutFilePath -ItemType File -Force
	$importing_header_file_content | Set-Content -Path $OutFilePath
}
