function Get-Mac {
    Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/network/interfaces/macs
}

function Get-Subnet {
    $mac = Get-Mac
    Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/network/interfaces/macs/$mac/subnet-id
}

function Get-SecurityGroup {
    $mac = Get-Mac
    Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/network/interfaces/macs/$mac/security-group-ids
}

function Write-KitchenYaml {
    Write-Host "Updating $args[0]"

    $subnet = Get-Subnet
    $sg = Get-SecurityGroup

    New-Item $args[0] -type file -value "driver:`n  security_group_ids: $sg`n  subnet_id: $subnet`n" -force
}

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Scope CurrentUser

Write-Host -ForegroundColor Green "[1/12] Preparing AURD nodes for demo..."
knife job start chef-client -s *:*
Start-Sleep -Seconds 90

Write-Host -ForegroundColor Green "[2/12] Second run to report compliance results..."
knife job start chef-client -s *:*

Write-Host -ForegroundColor Green "[3/12] Atomic Batteries to Power..."
ssh automate 'sudo delivery-ctl restart'

Write-Host -ForegroundColor Green "[4/12] Turbines to Speed..."
# Grab the public IP of the Chef and Automate servers for use in Test Kitchen.
$automateservermac = ssh automate curl -s curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/
$automateserverip = ssh automate curl -s curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$automateservermac/public-ipv4s
$chefservermac = ssh chef curl -s curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/
$chefserverip = ssh chef curl -s curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$chefservermac/public-ipv4s

Write-Host -ForegroundColor Green "[5/12] Inserting Breakfast Pastry..."
# Update our ubuntu user data with the right IPs.
(Get-Content ${env:userprofile}\ubuntu_user_data).replace('CHEF_SERVER_IP', $chefserverip) | Set-Content ${env:userprofile}\ubuntu_user_data
(Get-Content ${env:userprofile}\ubuntu_user_data).replace('AUTOMATE_SERVER_IP', $automateserverip) | Set-Content ${env:userprofile}\ubuntu_user_data

Write-Host -ForegroundColor Green "[6/12] Warming the Syrup...."
# Ditto for windows user data.
(Get-Content ${env:userprofile}\windows_user_data).replace('CHEF_SERVER_IP', $chefserverip) | Set-Content ${env:userprofile}\windows_user_data
(Get-Content ${env:userprofile}\windows_user_data).replace('AUTOMATE_SERVER_IP', $automateserverip) | Set-Content ${env:userprofile}\windows_user_data

Write-Host -ForegroundColor Green "[7/12] Increasing Flash Gordon Noise and Putting More Science Stuff Around....."
# Update Test Kitchen files to match the local subnet and security group.
Write-KitchenYaml ${env:userprofile}\cookbooks\bjc-ecommerce\.kitchen.local.yml
Write-KitchenYaml ${env:userprofile}\Desktop\Test_Kitchen\kitchen.local.yml

Write-Host -ForegroundColor Green "[8/12] Prepping the cookbook"
cd ${env:userprofile}\cookbooks\bjc-ecommerce
git checkout -b demo/remediate_ssl
code .

Write-Host -ForegroundColor Green "[9/12] Starting cmder..."
& "C:\tools\cmder\Cmder.exe"

Write-Host -ForegroundColor Green "[10/12] Checking email..."
& ${env:userprofile}\Desktop\email.html

Write-Host -ForegroundColor Green "[11/12] Visiting Automate"
& start chrome https://automate.automate-demo.com

Write-Host -ForegroundColor Green "[12/12] Start_Demo complete, you may close this console!"

Write-Host -ForegroundColor Yellow "Your Demo Is Ready! Run 'Generate_CCRs.ps1' if you'd like to generate client converges."
