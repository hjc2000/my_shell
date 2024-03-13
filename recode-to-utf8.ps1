param (
	[Parameter(Mandatory = $true)]
	[string]$input_file_path,
	[Parameter(Mandatory = $true)]
	[string]$output_file_path
)
$ErrorActionPreference = "Stop"

iconv -f $(uchardet $input_file_path) -t UTF-8 $input_file_path > $output_file_path