<#
判断目标文件是否比参考文件新。
#>
param (
	# 需要判断是否比参考文件新的目标文件路径。
	[Parameter(Mandatory = $true)]
	[string]$TargetFilePath,
	# 作为比较基准的参考文件路径。
	[Parameter(Mandatory = $true)]
	[string]$ReferenceFilePath
)

$targetFile = Get-Item -Path $TargetFilePath
$referenceFile = Get-Item -Path $ReferenceFilePath
return $targetFile.LastWriteTime -gt $referenceFile.LastWriteTime
