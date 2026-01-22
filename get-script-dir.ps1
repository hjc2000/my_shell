$path = $MyInvocation.ScriptName
$path = Split-Path -Path $path -Parent
$path = "$path"
$path = $path.Replace("\", "/")

return $path
