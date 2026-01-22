$path = $MyInvocation.ScriptName
$path = "$path"
$path = $path.Replace("\", "/")

return $path
