Write-Host -ForegroundColor Green "[1/3] Adding remediation recipe to all machines"

cd ~
Foreach ($node in @("stage1","stage2","prod1","prod2","prod3"))
{
  knife node run_list add $node '''recipe[dca_baseline::hardening]'''
}

Write-Host -ForegroundColor Green "[2/3] Converge all nodes"

knife ssh '*:*' 'sudo chef-client'

Write-Host -ForegroundColor Green "[3/3] Add application recipe to all machines."

cd ~
Foreach ($node in @("dev1","dev2","stage1","stage2","prod1","prod2","prod3"))
{
  knife node run_list add $node '''recipe[dca_baseline::install_site]'''
}

Write-host -ForegroundColor White "All done!"
Read-Host -Prompt "Press Enter to exit"
