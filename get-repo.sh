# 检查是否至少提供了一个参数（Git仓库URL）
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <git-repo-url> [branch-name]"
    exit 1
fi

# 从命令行参数获取Git仓库URL
url="$1"
repo_name=$(parse-repo-name.sh "${url}")
source_root_path=$(pwd)

# 检查是否提供了第二个参数（分支名）
if [ "$#" -eq 2 ]; then
    branch_name="$2"
else
    branch_name=""
fi

# 检查当前目录下是否存在目标仓库的目录
if [ -d "./${repo_name}/" ]; then
    # 如果存在，进入该目录并更新代码
    cd "${repo_name}" &&
    if [ -n "${branch_name}" ]; then
        git pull origin "${branch_name}"
        git checkout "${branch_name}"
    else
        git pull
    fi
else
    # 如果不存在，克隆仓库
    if [ -n "${branch_name}" ]; then
        git clone --branch "${branch_name}" "${url}"
    else
        git clone "${url}"
    fi
fi

