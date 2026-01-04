param (
	[switch]$local
)
$ErrorActionPreference = "Stop"

$global_option = "--global"

if ($local)
{
	$global_option = ""
}

# 设置默认分支名为 main.
git config --global init.defaultBranch main



if ($IsWindows)
{
	git config $global_option core.editor notepad
}
else
{
	git config $global_option core.editor vim
}

git config $global_option core.symlinks true
git config $global_option core.longpaths true
git config $global_option core.autocrlf false
git config $global_option core.ignorecase false




# 远程分支删除后，git 分支列表里还会显示远程有该分支，也就是不会从远程仓库重新
# 获取分支列表更新本地的缓存信息。
#
# 设置了这个后，就可以自动更新缓存信息了。
git config $global_option fetch.prune true

git config $global_option safe.directory '*'
git config $global_option http.sslverify false
git config $global_option submodule.recurse true
git config $global_option credential.helper store
