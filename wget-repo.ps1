param (
	[Parameter(Mandatory = $true)]
	[string]$workspace_dir,

	[Parameter(Mandatory = $true)]
	[string]$repo_url,

	[Parameter(Mandatory = $true)]
	[string]$out_dir_name
)
$ErrorActionPreference = "Stop"

# 从 url 中获取文件名
$file_name = ([System.Uri]$repo_url).Segments[-1]
Write-Host $file_name

# 获取扩展名。例如对于 boost_1_84_0_rc1.tar.gz 将会得到 gz
$extension = [System.IO.Path]::GetExtension($file_name).TrimStart('.')

# 确保工作区目录存在
if (-not (Test-Path -Path $workspace_dir))
{
	throw '$workspace_dir 指定的工作区不存在'
}

# 切换到工作区
Set-Location $workspace_dir

# 检查解压结果目录是否已存在，如果已经存在，就不要再次解压了。
if (Test-Path -Path $out_dir_name)
{
	Write-Host "解压后的目录已经存在，不解压了。"
	return 0
}

# 解压后的目录不存在，检查压缩包是否存在
if (-not (Test-Path -Path $file_name))
{
	# 忽略SSL/TLS证书验证
	[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

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
	"7z"
	{
		7z x $file_name -o$out_dir_name
	}
	"zip"
	{
		Expand-Archive -Path $file_name -DestinationPath $out_dir_name -Force
	}
	default
	{
		throw '不支持的压缩格式'
	}
}
