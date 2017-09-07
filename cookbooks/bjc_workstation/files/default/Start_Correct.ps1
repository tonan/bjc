Write-Host -ForegroundColor Green "[1/2] Adding Audits to all servers"

Foreach ($node in @("stage1","stage2","prod1","prod2","prod3")) {
  knife node run_list add $node '''recipe[dca_baseline]'''
}

Write-Host -ForegroundColor Green "[2/2] Adding remediation recipe to dev runlists"

Foreach ($node in @("dev1","dev2"))
{
  knife node run_list add $node '''recipe[dca_baseline::hardening'''
}

Read-Host -Prompt "Tasks complete! Press Enter to exit."
