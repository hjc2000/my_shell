param (
	[string]$branch_name
)

while ($true)
{
	git checkout --force $branch_name

	if (-not $LASTEXITCODE)
	{
		exit 0
	}
}
