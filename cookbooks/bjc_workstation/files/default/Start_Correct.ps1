Write-Host -ForegroundColor Green "[1/3] Adding Audits to all servers"

Foreach ($node in @("stage1","stage2","prod1","prod2","prod3")) {
  knife node run_list add $node '''recipe[dca_baseline]'''
}

Write-Host -ForegroundColor Green "[2/3] Converging non-dev nodes"
knife ssh 'NOT chef_environment:development' 'sudo chef-client'

Write-Host -ForegroundColor Green "[3/3] Opening next e-mail"

# Uncomment to open e-mails.
# & ${env:userprofile}\dca\DCA_email_wk2.html

Read-Host -Prompt "Tasks complete! Press Enter to exit."
