param (
	[Parameter(Mandatory = $true)]
	[string]$git_url
)

# 使用字符串操作提取仓库名
# 从URL中提取仓库名称，不管URL是否以 ".git" 结尾
$repoName = $git_url.Split('/')[-1] # 首先按照 "/" 分割URL，取最后一部分

# 检查$repoName是否以 ".git" 结尾
if ($repoName.EndsWith('.git'))
{
	$repoName = $repoName.Substring(0, $repoName.Length - 4) # 如果是，去除".git"
}

return $repoName
