# 递归读取各个层级仓库的 .gitmodules 文件，将各个层级仓库的 origin 远程仓库 URL
# 设置为父仓库的 .gitmodules 文件记录的 URL.
#
# 这有什么用呢，例如主仓库在 .gitmodules 文件中设置了 lib 子仓库的 URL 为
# http://github.com/lib/lib.git
# 初始化子模块后，子模块的远程仓库 URL 也就被设置成了这个。
#
# 后来主仓库在 .gitmodules 文件中将 lib 子仓库的 URL 改为
# http://gitee.com/lib/lib.git
# 此时执行
# git submodule sync --recursive
# 就可以把子仓库的 origin 远程仓库 URL 设置为父仓库的 .gitmodules 文件记录的
# http://gitee.com/lib/lib.git

while ($true)
{
	git submodule sync --recursive

	if (-not $LASTEXITCODE)
	{
		break
	}
}
