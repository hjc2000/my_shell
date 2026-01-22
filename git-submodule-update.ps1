# 递归读取各个层级仓库的 .gitmodules 文件，读取其中记录的
# 各个子模块的 URL，并读取仓库中另一个地方记录的 .gitmodules 中的
# 子模块们所处的提交哈希。
#
# 如果子模块还没克隆过就克隆，这称为初始化。并且会递归初始化子模块的子模块。
#
# 如果子模块已经初始化过了，则直接根据父仓库记录的 URL 和提交哈希拉取子模块的更新，
# 并且会递归进行，最终确保每一层级的仓库都处于父仓库的所记录的 URL 指向的远程仓库的
# 那个提交哈希的状态。
#
# 因此，只要每个层级的仓库都维护好自己的 .gitmodules 文件，并且将子仓库签出到某个
# 游离提交后，回到父仓库，提交这个更改，即让父仓库更新所记录的子仓库所处的提交哈希，
# 然后推送到远程储存库。最终整个仓库树在经历过
# git submodule update --init --recursive --force
# 后都会是某个特定的历史状态。

$ErrorActionPreference = "Stop"
Push-Location

try
{
	while ($true)
	{
		git submodule update --init --recursive --force

		if (-not $LASTEXITCODE)
		{
			exit 0
		}
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
