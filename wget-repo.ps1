param (
	[Parameter(Mandatory = $true)]
	[string]$workspace_dir,

	[Parameter(Mandatory = $true)]
	[string]$repo_url
)

$ErrorActionPreference = "Stop"

# 从 url 中获取文件名。例如从
# https://boostorg.jfrog.io/artifactory/main/release/1.84.0/source/boost_1_84_0_rc1.tar.gz
# 中提取出 boost_1_84_0_rc1.tar.gz
$file_name = [System.IO.Path]::GetFileName($repo_url)

# 获取扩展名。例如对于 boost_1_84_0_rc1.tar.gz 将会得到 gz
$extension = [System.IO.Path]::GetExtension($file_name).TrimStart('.')

# 确保工作区目录存在
if (-not (Test-Path -Path $workspace_dir))
{
	Write-Host '$workspace_dir 指定的工作区不存在'
	exit 1
}

# 切换到工作区
Set-Location $workspace_dir

$out_dir_name = get-base-file-name.ps1 -file_name $file_name

# 检查解压结果目录是否已存在，如果已经存在，就不要再次解压了。
if (Test-Path -Path $out_dir_name)
{
	Write-Host "解压后的目录已经存在，不解压了。"
	exit 0
}

# 解压后的目录不存在，检查压缩包是否存在
if (-not (Test-Path -Path $file_name))
{
	# 压缩包也不存在，先下载
	Invoke-WebRequest -Uri $repo_url -OutFile $file_name
}

# 创建输出目录
New-Item -ItemType Directory -Path $out_dir_name -Force

# 解压压缩包
# 根据文件扩展名确定解压命令和处理目录名
switch ($extension)
{
	"gz"
	{
		tar -vxf $file_name -C $out_dir_name
	}
	"xz"
	{
		tar -vJxf $file_name -C $out_dir_name
	}
	"bz2"
	{
		tar -vjxf $file_name -C $out_dir_name
	}
	"zip"
	{
		Expand-Archive -Path $file_name -DestinationPath $out_dir_name -Force
	}
	default
	{
		Write-Host '不支持的压缩格式'
		exit 1
	}
}

