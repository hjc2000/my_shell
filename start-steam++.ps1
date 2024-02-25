$cmd = @"
bash
nohup $env:HOME/install/Steam++/Steam++.sh > /dev/null 2>&1 &
"@

run-bash-cmd.ps1 $cmd