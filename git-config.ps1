param (
	[switch]$local
)
$ErrorActionPreference = "Stop"

$global_option = "--global"
if ($local)
{
	$global_option = ""
}

git config $global_option core.editor notepad
git config $global_option core.symlinks true
git config $global_option core.longpaths true
git config $global_option core.autocrlf false
git config $global_option core.ignorecase false

git config $global_option safe.directory '*'
git config $global_option http.sslverify false
git config $global_option submodule.recurse true
git config $global_option credential.helper store
