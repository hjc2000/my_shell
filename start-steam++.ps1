$cmd = @"
nohup $env:HOME/install/Steam++/Steam++.sh > /dev/null 2>&1 &
"@

$cmd | bash -norc
