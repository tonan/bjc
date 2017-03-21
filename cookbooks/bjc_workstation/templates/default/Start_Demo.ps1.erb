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

function Import-RemoteCertificate {
    $name = $args[0]
    Write-Host ${Unix-Path $env:userprofile}/Downloads
    scp ${name}:/home/ubuntu/${name}.automate-demo.com.crt /c/Users/${env:USERNAME}/Downloads 
    Import-Certificate -FilePath  ${env:userprofile}\Downloads\${name}.automate-demo.com.crt -CertStoreLocation Cert:/LocalMachine/Root
}

set-executionpolicy -executionpolicy unrestricted -force -scope CurrentUser

Write-Host "Copying compliance OIDC_CLIENT_ID to chef CHEF_GATE_OIDC_CLIENT_ID"
scp ~/.ssh/id_rsa.pub compliance:/tmp/CHEF_GATE_COMPLIANCE_SECRET
ssh compliance 'sudo mv /tmp/CHEF_GATE_COMPLIANCE_SECRET /opt/chef-compliance/sv/core/env/CHEF_GATE_COMPLIANCE_SECRET && sudo chef-compliance-ctl restart core'
ssh compliance 'sudo cp /opt/chef-compliance/sv/core/env/OIDC_CLIENT_ID /tmp && sudo chmod +r /tmp/OIDC_CLIENT_ID'
scp -3 compliance:/tmp/OIDC_CLIENT_ID chef:/tmp/CHEF_GATE_OIDC_CLIENT_ID
ssh chef 'sudo mv /tmp/CHEF_GATE_OIDC_CLIENT_ID /opt/opscode/sv/chef_gate/env/CHEF_GATE_OIDC_CLIENT_ID && sudo /opt/opscode/embedded/bin/sv restart chef_gate'

Write-Host "Preparing AURD nodes for demo..."
knife job start chef-client -s *:*

Write-Host "Importing infrastructure SSL certs..."
Import-RemoteCertificate "ecomacceptance"
Import-RemoteCertificate "union"
Import-RemoteCertificate "rehearsal"
Import-RemoteCertificate "delivered"
sleep 100
Write-Host "second run to report compliance results"
knife job start chef-client -s *:*
Write-Host "Atomic Batteries to Power."
ssh automate 'sudo delivery-ctl restart'
Write-Host "Turbines to Speed.."

# Grab the public IP of the Chef and Automate servers for use in Test Kitchen.
Write-Host "Inserting Breakfast Pastry..."
$automateservermac = ssh automate curl -s curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/
$automateserverip = ssh automate curl -s curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$automateservermac/public-ipv4s
$chefservermac = ssh chef curl -s curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/
$chefserverip = ssh chef curl -s curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$chefservermac/public-ipv4s
# Update our ubuntu user data with the right IPs.
Write-Host "Warming the Syrup...."
(Get-Content ${env:userprofile}\ubuntu_user_data).replace('CHEF_SERVER_IP', $chefserverip) | Set-Content ${env:userprofile}\ubuntu_user_data
(Get-Content ${env:userprofile}\ubuntu_user_data).replace('AUTOMATE_SERVER_IP', $automateserverip) | Set-Content ${env:userprofile}\ubuntu_user_data
# Ditto for windows user data.
Write-Host "Increasing Flash Gordon Noise and Putting More Science Stuff Around....."
(Get-Content ${env:userprofile}\windows_user_data).replace('CHEF_SERVER_IP', $chefserverip) | Set-Content ${env:userprofile}\windows_user_data
(Get-Content ${env:userprofile}\windows_user_data).replace('AUTOMATE_SERVER_IP', $automateserverip) | Set-Content ${env:userprofile}\windows_user_data
# Update Test Kitchen files to match the local subnet and security group.
Write-KitchenYaml ${env:userprofile}\cookbooks\bjc-ecommerce\.kitchen.local.yml
Write-KitchenYaml ${env:userprofile}\Desktop\Test_Kitchen\kitchen_linux.yml
Write-KitchenYaml ${env:userprofile}\Desktop\Test_Kitchen\kitchen_windows.yml

$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")


Write-Host "Starting cmder..."
& "C:\tools\cmder\Cmder.exe"


