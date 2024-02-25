# 用来给 st 公司或正点原子的 linux SDK 打补丁。进入到源码目录，
# 源码目录的上层目录有一个 patch 文件，这就是补丁文件。
# 在源码目录中执行本脚本，即可打补丁。
$patchFiles = Get-ChildItem -Path "../*.patch"

# 遍历每个文件
foreach ($file in $patchFiles)
{
	# 应用patch
	patch -p1 -i $file.FullName
}
