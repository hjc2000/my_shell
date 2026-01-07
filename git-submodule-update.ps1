

while ($true)
{
	git submodule update --init --recursive --force

	if (-not $LASTEXITCODE)
	{
		exit 0
	}
}
