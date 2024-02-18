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
	# 先看看本地仓库有没有
	if [ -d ${repos}/${repo_name}/ ]; then
		# 本地仓库有
		cd ${repos}/${repo_name}/ && git pull
		cp -r ${repos}/${repo_name}/ ${source_root_path}
	else
		# 本地仓库没有
		cd ${repos} && git clone ${url} &&
		cp -r ${repos}/${repo_name} ${source_root_path}
	fi
fi

