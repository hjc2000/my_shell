param (
	[Parameter(Mandatory = $true)]
	[string]$input_file_path,
	[switch]$Recurse
)

$ErrorActionPreference = "Stop"
Push-Location

try
{
	function TryChangeCode
	{
		param (
			[Parameter(Mandatory = $true)]
			$code_list,
			[Parameter(Mandatory = $true)]
			$file_path
		)

		# 遍历编码列表，尝试将源文件当作该编码。
		foreach ($code in $code_list)
		{
			$conv_result = iconv -f $code -t UTF-8 "$file_path"
			if (-not $LASTEXITCODE)
			{
				Write-Host "$($file.FullName) 转换成功"
				$conv_result | Out-File "$file_path"
				return
			}
		}

		Write-Warning "$($file.FullName) 转换失败"
	}

	$file_list = Get-ChildItem -Path $input_file_path -Recurse:$Recurse -File

	foreach ($file in $file_list)
	{
		$code_list = @(
			"$(uchardet $file.FullName)"
			"GB18030"
			"GBK"
			"HZ"
			"HZ-GB-2312"
		)

		TryChangeCode -code_list $code_list -file_path "$($file.FullName)"
	}
}
catch
{
	throw "
		$(get-script-position.ps1)
		$(${PSItem}.Exception.Message)
	"
}
finally
{
	Pop-Location
}
