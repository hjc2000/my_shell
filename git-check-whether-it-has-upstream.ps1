# 检查当前分支是否有 upstream
#
# 如果有，退出代码为 0.
# 如果没有，退出代码为 1.

git rev-parse --abbrev-ref --symbolic-full-name "@{u}"
exit $LASTEXITCODE
