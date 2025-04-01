$files = @(
	".clang-format"
	".gitattributes"
	"CMakePresets.json"
	"CMakeLists.txt"
)

foreach ($file in $files)
{
	try-remove-items.exe --paths $file

	create-symbol-link.ps1 -Path $file `
		-Target "../../../工具链配置文件/C++项目根目录配置文件/$file"
}
