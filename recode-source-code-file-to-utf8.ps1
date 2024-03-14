param (
	[Parameter(Mandatory = $true)]
	[string]$input_file_path
)

recode-to-utf8.ps1 -input_file_path "$input_file_path/*.h" -Recurse
recode-to-utf8.ps1 -input_file_path "$input_file_path/*.c" -Recurse
recode-to-utf8.ps1 -input_file_path "$input_file_path/*.cpp" -Recurse
recode-to-utf8.ps1 -input_file_path "$input_file_path/*.js" -Recurse
recode-to-utf8.ps1 -input_file_path "$input_file_path/*.html" -Recurse
recode-to-utf8.ps1 -input_file_path "$input_file_path/*.txt" -Recurse
recode-to-utf8.ps1 -input_file_path "$input_file_path/*.s" -Recurse
recode-to-utf8.ps1 -input_file_path "$input_file_path/*.py" -Recurse