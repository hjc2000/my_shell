param (
	[Parameter(Mandatory = $true)]
	[string]$git_url
)

# 检查是否提供了URL参数
if (-not $git_url)
{
	Write-Host "Usage: Get-GitRepoName -Url <git-repo-url>"
	return
}

# 使用字符串操作提取仓库名
# 从URL中提取仓库名称，假设URL以 ".git" 结尾
$repoName = $git_url.Split('/')[-1] -replace '\.git$', ''
return $repoName