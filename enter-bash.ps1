$env:MSYSTEM = "UCRT64"
$env:MSYS2_PATH_TYPE = "inherit"
$env:MSYSCON = "defterm"
$env:MSYSTEM_PREFIX = "/ucrt64"
$env:MINGW_PREFIX = "/ucrt64"
$env:MSYSTEM_CHOST = "x86_64-w64-mingw32"
$env:MSYSTEM_CARCH = "x86_64"
$env:CHERE_INVOKING = "enabled_from_arguments"
$env:MSYS2_NOSTART = "yes"
$env:CONTITLE = "MinGW UCRT x64"

bash -himBHs
