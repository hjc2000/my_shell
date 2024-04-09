param (
	[string]$FileName = "include_all.h",
	[switch]$DoNotHoldTree,
	[switch]$WriteHostOnly # 开启此开关，结果仅会打印到控制台，不会创建文件并写入
)
$ErrorActionPreference = "Stop"

if ((Test-Path "./$FileName") -and (-not $WriteHostOnly))
{
	throw "当前目录下已经存在 $FileName"
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
		$relative_ptah = get-relative-path.ps1 -BasePath $base_path -Path $full_path
		$relative_ptah = $relative_ptah.Replace("\", "/").Replace("//", "/")
		$importing_header_file_content += "#include<$relative_ptah>`n"
	}
}

$importing_header_file_content = $importing_header_file_content.Trim()
Write-Host $importing_header_file_content
if (-not $WriteHostOnly)
{
	New-Item -Path "./$FileName" -ItemType File -Force
	$importing_header_file_content | Set-Content -Path "./$FileName"
}
