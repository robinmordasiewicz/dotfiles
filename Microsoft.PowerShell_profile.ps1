Import-Module -Name Terminal-Icons
Import-Module -Name z
Import-Module -Name PowerShellAI

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/powerlevel10k.omp.json" | Invoke-Expression

