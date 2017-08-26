Write-Host -ForegroundColor Green "[1/3] Updating prod1"

cd ~
knife node run_list add prod1 'recipe[dca_baseline::hardening],recipe[dca_baseline::install_site]'
ssh prod1 'sudo chef-client'

Write-Host -ForegroundColor Green "[2/3] Bootstrap the rest of my servers"
knife bootstrap ecomacceptance -N dev -x ubuntu -i ~/.ssh/id_rsa --sudo -r 'recipe[dca_baseline],recipe[dca_baseline::hardening],recipe[dca_baseline::install_site]'
knife bootstrap rehearsal -N stage -x ubuntu -i ~/.ssh/id_rsa --sudo -r 'recipe[dca_baseline],recipe[dca_baseline::hardening],recipe[dca_baseline::install_site]'
knife bootstrap delivered -N prod2 -x ubuntu -i ~/.ssh/id_rsa --sudo -r 'recipe[dca_baseline],recipe[dca_baseline::hardening],recipe[dca_baseline::install_site]'

Write-Host -ForegroundColor Green "[3/3] Kick off another CCR everywhere"
knife job start 'chef-client' --search 'name:*build*'

Write-host -ForegroundColor White "All done!"
Read-Host -Prompt "Press Enter to exit"
