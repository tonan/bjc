Write-Host -ForegroundColor Green "[1/7] Warming up kitchen instance..."

cd ${env:userprofile}\cookbooks\dca_baseline
kitchen converge

sleep 5

Write-Host -ForegroundColor Green "[2/7] Deleting data from automate server & reconfiguring"
ssh automate "sudo curl -X DELETE 'http://localhost:9200/_all' && sudo automate-ctl reconfigure"

Write-Host -ForegroundColor Green "[3/7] Logging into automate with inspec"
inspec compliance login_automate https://automate.automate-demo.com --insecure --user='leela' --ent='automate-demo' --dctoken='93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'

Write-Host -ForegroundColor Green "[4/7] Uploading baseline wrapper profile"
inspec compliance upload C:\Users\chef\dca\linux_baseline_wrapper-0.1.0.tar.gz
inspec compliance login_automate https://automate.automate-demo.com --insecure --user='workstation-1' --ent='automate-demo' --dctoken='93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'

Write-Host -ForegroundColor Green "[5/7] Deleting existing bjc clients"
cd ~
foreach($node in @("ecomacceptance","union","rehearsal","delivered")) {
    knife node delete $node -y
    ssh $node "sudo rm -Rf /etc/chef"
}

Write-Host -ForegroundColor Green "[6/7] Updating hosts file with alternate hostnames"

$hostsfile = "C:\Windows\System32\drivers\etc\hosts"

"172.31.54.101" + "`t`t" + "prod2" | Out-File -encoding ASCII -append $hostsfile
"172.31.54.102" + "`t`t" + "dev" | Out-File -encoding ASCII -append $hostsfile
"172.31.54.103" + "`t`t" + "stage" | Out-File -encoding ASCII -append $hostsfile
"172.31.54.104" + "`t`t" + "prod1" | Out-File -encoding ASCII -append $hostsfile

Write-Host -ForegroundColor Green "[7/7] Opening Chrome Tabs"
start-process "chrome.exe" "https://automate.automate-demo.com",'--profile-directory="Default"'
start-process "chrome.exe" "https://prod1/cart",'--profile-directory="Default"'


Write-Host -ForegroundColor Yellow "You're all ready for DCA!"
Write-Host -ForegroundColor Yellow "After installing the security baseline, run it against a host like so:"
Write-Host -ForegroundColor White "..."
Write-Host -ForegroundColor White "inspec compliance exec workstation-1/linux-baseline -t ssh://ubuntu@prod1 -i ~/.ssh/id_rsa"
Write-Host -ForegroundColor Yellow "To converge your kitchen instance:"
Write-Host -ForegroundColor White "..."
Write-Host -ForegroundColor White "cd ~/dca/dca_baseline"
Write-Host -ForegroundColor White "kitchen converge"
Write-Host -ForegroundColor Red "......................................"
Write-Host -ForegroundColor Yellow "To bootstrap 'prod1':"
Write-Host -ForegroundColor White "..."
Write-Host -ForegroundColor White "knife bootstrap union -N prod1 -x ubuntu -i ~/.ssh/id_rsa --sudo -r 'recipe[dca_baseline]'"
Write-Host -ForegroundColor Red "......................................"
Write-Host -ForegroundColor Yellow "To show everything else, double-click 'Finish_DCA.ps1' on the desktop"

Read-Host -Prompt "Press Enter to exit"
