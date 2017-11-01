Write-Host -ForegroundColor Green "[1/11] Warming up kitchen instance..."

cp ${env:userprofile}\Desktop\Test_Kitchen\kitchen.local.yml ${env:userprofile}\cookbooks\dca_baseline\.kitchen.local.yml
cd ${env:userprofile}\cookbooks\dca_baseline
kitchen converge

sleep 5

Write-Host -ForegroundColor Green "[2/11] Logging into automate with inspec"
inspec compliance login_automate https://automate.automate-demo.com --insecure --user='leela' --ent='automate-demo' --dctoken='93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'

Write-Host -ForegroundColor Green "[3/11] Uploading baseline wrapper profile"
inspec compliance upload C:\Users\chef\dca\linux_baseline_wrapper-0.1.0.tar.gz
inspec compliance login_automate https://automate.automate-demo.com --insecure --user='workstation-1' --ent='automate-demo' --dctoken='93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'

Write-Host -ForegroundColor Green "[4/11] Installing bjc-ecommerce on build nodes"
cd ~
foreach($node in @("build-node-1","build-node-2","build-node-3")) {
  ssh $node "sudo chef-client -o '''recipe[bjc-ecommerce::tksetup],recipe[bjc-ecommerce]'''"
}

Write-Host -ForegroundColor Green "[5/11] Deleting existing nodes from Chef Server"
foreach($node in @("ecomacceptance","union","rehearsal","delivered","build-node-1","build-node-2","build-node-3")) {
    knife node delete $node -y
    ssh $node "sudo rm -Rf /etc/chef"
}

Write-Host -ForegroundColor Green "[6/11] Assimilating Hostsfile"

$hostsfile = "C:\Windows\System32\drivers\etc\hosts"

"172.31.54.101" + "`t`t" + "dev1" | Out-File -encoding ASCII -append $hostsfile
"172.31.54.102" + "`t`t" + "dev2" | Out-File -encoding ASCII -append $hostsfile
"172.31.54.103" + "`t`t" + "stage1" | Out-File -encoding ASCII -append $hostsfile
"172.31.54.104" + "`t`t" + "stage2" | Out-File -encoding ASCII -append $hostsfile
"172.31.54.51" + "`t`t" + "prod1" | Out-File -encoding ASCII -append $hostsfile
"172.31.54.52" + "`t`t" + "prod2" | Out-File -encoding ASCII -append $hostsfile
"172.31.54.53" + "`t`t" + "prod3" | Out-File -encoding ASCII -append $hostsfile

Write-Host -ForegroundColor Green "[7/11] Deleting data from automate server & reconfiguring"
ssh automate "sudo curl -X DELETE 'http://localhost:9200/_all' && sudo automate-ctl reconfigure"

Write-Host -ForegroundColor Green "[8/11] Rebootstrapping nodes."
foreach ($env in @("development","staging","production")) {
  knife environment create $env -d $env
}

Foreach ($node in @("dev1","dev2")) {
  knife bootstrap $node -N $node -E development -i ~/.ssh/id_rsa -x ubuntu --sudo
}

Foreach ($node in @("stage1","stage2")) {
  knife bootstrap $node -N $node -E staging -i ~/.ssh/id_rsa -x ubuntu --sudo
}

Foreach ($node in @("prod1","prod2","prod3")) {
  knife bootstrap $node -N $node -E production -i ~/.ssh/id_rsa -x ubuntu --sudo
}

Write-Host -ForegroundColor Green "[9/11] Updating cmder directory"
ForEach ($file in @("C:\tools\cmder\config\user-ConEmu.xml","C:\tools\cmder\config\user-ConEmu.xml")){
if ( $(Try { Test-Path $file } Catch { $false }) ) {
   rm $file
 }
Else {
    Write-Host "Cmder config file not Found. Skipping."
 }
}
sed -i -e "s/bjc-ecommerce/dca_baseline/g" C:\tools\cmder\config\ConEmu.xml

Write-Host -ForegroundColor Green "[10/11] Opening Chrome Tabs & Cmder"
start-process "chrome.exe" "https://automate.automate-demo.com/", '--profile-directory="Default"'
start-process "chrome.exe" "https://dev1/cart",'--profile-directory="Default"'
start-process "chrome.exe" "https://dev2/cart",'--profile-directory="Default"'

Write-Host -ForegroundColor Green "[11/11] Updating path and loading custom functions."
$env:path = "C:\Users\chef\dca;$env:path"
Import-Module DCA_functions

# Uncomment to open e-mails.
# & ${env:userprofile}\dca\DCA_email_wk1.html

& C:\tools\cmder\Cmder.exe
cd ${env:userprofile}\cookbooks\dca_baseline
git init .
git add .
git commit -m "initial dca_baseline cookbook"
code .

Read-Host -Prompt "Press Enter to exit"
