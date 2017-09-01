#
# Cookbook:: bjc_workstation
# Recipe:: freedoms
#
# Copyright:: 2017, The Authors, All Rights Reserved.

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Oobe' do
  values [{
    name: 'DoNotOpenInitialConfigurationTasksAtLogon',
    type: :dword,
    data: 1
  }]
  action :create
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager' do
  values [{
    name: 'DoNotOpenServerManagerAtLogon',
    type: :dword,
    data: 1
  }]
  action :create
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}' do
  values [{
    name: 'IsInstalled',
    type: :dword,
    data: 0
  }]
  action :create
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}' do
  values [{
    name: 'IsInstalled',
    type: :dword,
    data: 0
  }]
  action :create
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
  values [
    {
      name: 'EnableLUA',
      type: :dword,
      data: 0
    },
    {
      name: 'ConsentPromptBehaviorAdmin',
      type: :dword,
      data: 0
    }
  ]
  action :create
end

powershell_script 'Set Network Connection Profile to Private' do
  code "$net = Get-NetConnectionProfile; Set-NetConnectionProfile -Name $net.Name -NetworkCategory Private"
end
