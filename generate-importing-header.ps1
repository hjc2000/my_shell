param (
	[string]$FileName = "include_all.h"
)
$ErrorActionPreference = "Stop"

if (Test-Path "./$FileName")
{
	throw "当前目录下已经存在 $FileName"
}

$base_path = Get-Location
$header_files = Get-ChildItem -Path "./*.h" -File -Recurse
$importing_header_file_content = ""
foreach ($header_file in $header_files)
{
	$full_path = $header_file.FullName
	$relative_ptah = get-relative-path.ps1 -BasePath $base_path -Path $full_path
	$relative_ptah = $relative_ptah.Replace("\", "/").Replace("//", "/")
	$importing_header_file_content += "#include<$relative_ptah>`n"
}

New-Item -Path "./$FileName" -ItemType File -Force
$importing_header_file_content.Trim() | Set-Content -Path "./$FileName"
