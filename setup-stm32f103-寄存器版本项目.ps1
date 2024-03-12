param (
	[Parameter(Mandatory = $true)]
	[string]$project_name
)
$ErrorActionPreference = "Stop"

$project_full_path = "$(Get-Location)/$project_name"
New-Item -ItemType Directory -Force -Path "$project_full_path"
New-Item -ItemType Directory -Force -Path "$project_full_path/Drivers"
New-Item -ItemType Directory -Force -Path "$project_full_path/Drivers/BSP"
New-Item -ItemType Directory -Force -Path "$project_full_path/Drivers/CMSIS"
New-Item -ItemType Directory -Force -Path "$project_full_path/Drivers/SYSTEM"
New-Item -ItemType Directory -Force -Path "$project_full_path/Middlewares"
New-Item -ItemType Directory -Force -Path "$project_full_path/Output"
New-Item -ItemType Directory -Force -Path "$project_full_path/Projects"
New-Item -ItemType Directory -Force -Path "$project_full_path/User"