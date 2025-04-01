param (
	[Parameter(Mandatory = $true)]
	[string]$project_name
)
$ErrorActionPreference = "Stop"

if (Test-Path "$project_name")
{
	throw "已经存在 $project_name 目录，无法创建新项目。"
}

if (-not $env:cpp_lib_build_scripts_path)
{
	throw "环境变量 cpp_lib_build_scripts_path 未设置，请先配置。"
}

# 创建项目根目录
New-Item -Path $project_name -ItemType Directory

# 进入项目根目录开始初始化项目
Push-Location "$project_name"

try
{
	git init
	link-cpp-project-config-file.ps1

	New-Item -Path "include" -ItemType Directory
	New-Item -Path "src" -ItemType Directory
	New-Item -Path "private_src" -ItemType Directory
	New-Item -Path "private_include" -ItemType Directory

	Copy-Item -Path "${env:cpp_lib_build_scripts_path}/工具链配置文件/C++项目根目录配置文件/.gitignore" `
		-Destination ".gitignore"

	Copy-Item -Path "${env:cpp_lib_build_scripts_path}/工具链配置文件/C++项目根目录配置文件/.gitattributes" `
		-Destination ".gitattributes"

	Copy-Item -Path "${env:cpp_lib_build_scripts_path}/工具链配置文件/vscode配置文件/.vscode" `
		-Destination ".vscode" -Recurse

	Copy-Item -Path "${env:cpp_lib_build_scripts_path}/工具链配置文件/vscode配置文件/示例文件.code-workspace" `
		-Destination ".${project_name}.code-workspace"

}
finally
{
	Pop-Location
}
