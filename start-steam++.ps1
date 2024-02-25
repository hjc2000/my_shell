$cmd = @"
nohup $env:HOME/install/Steam++/Steam++.sh > /dev/null 2>&1 &
"@

bash -c $cmd
