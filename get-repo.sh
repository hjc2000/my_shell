# 检查是否提供了URL参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <git-repo-url>"
    exit 1
fi

# 从命令行参数获取Git仓库URL
url="$1"
repo_name=$(parse-repo-name.sh ${url})
source_root_path=$(pwd)

# 先看看当前目录下有没有
if [ -d ./${repo_name}/ ]; then
	# 当前目录下有
	cd ${repo_name} &&
	git pull
else
	# 当前目录下没有
	git clone ${url}
fi

