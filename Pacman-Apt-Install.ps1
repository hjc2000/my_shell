param (
	[Parameter(Mandatory = $true)]
	[string]$pkg_to_install
)
$ErrorActionPreference = "Stop"

if ($IsWindows)
{
	pacman.exe -S $pkg_to_install
}

sudo apt-get install $pkg_to_install