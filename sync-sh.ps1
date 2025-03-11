$ErrorActionPreference = "Stop"
$my_shell_path = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

Push-Location $my_shell_path
git-sync.ps1
Pop-Location
