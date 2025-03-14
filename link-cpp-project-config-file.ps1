try-remove-items.exe --paths ".clang-format"
create-symbol-link.ps1 -Path ".clang-format" `
	-Target "../../../工具链配置文件/C++项目根目录配置文件/.clang-format"

try-remove-items.exe --paths "CMakePresets.json"
create-symbol-link.ps1 -Path "CMakePresets.json" `
	-Target "../../../工具链配置文件/C++项目根目录配置文件/CMakePresets.json"

git-sync.ps1
