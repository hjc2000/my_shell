$files = @(
	".clang-format"
	"CMakePresets.json"
	"CMakeLists.txt"
)

$ErrorActionPreference = "Stop"
Push-Location

try
{
	foreach ($file in $files)
	{
		try-remove-items.exe --paths $file

		New-Item -ItemType SymbolicLink `
			-Path $file `
			-Target "../../../工具链配置文件/C++项目根目录配置文件/$file"
	}
}
catch
{
	throw "
		$(get-script-position.ps1)
		$(${PSItem}.Exception.Message)
	"
}
finally
{
	Pop-Location
}
