# 获取最近一条提交记录
log=$(git log -1)
# 保存工作目录到变量
work_dir=$(pwd)
# 先拉取
cd $NUGET
git pull
# 回到工作目录，发布新包
cd $work_dir
nuget.exe init ./ $NUGET
# 切到包源并推动到 github
cd $NUGET
git add .
git commit -m "$log"
git push
