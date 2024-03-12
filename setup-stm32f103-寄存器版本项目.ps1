param (
	[Parameter(Mandatory = $true)]
	[string]$project_name
)
$ErrorActionPreference = "Stop"

$project_full_path = "$(Get-Location)/$project_name"
New-Item -Path $project_full_path
New-Item -Path $project_full_path/Drivers
New-Item -Path $project_full_path/Middlewares
New-Item -Path $project_full_path/Output
New-Item -Path $project_full_path/Projects
New-Item -Path $project_full_path/User