# 检查当前分支的 upstream 是否真实存在
# 即远程仓库中必须真的有这个分支。

git rev-parse --verify "@{u}"
exit $LASTEXITCODE
