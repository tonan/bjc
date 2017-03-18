#
# Cookbook Name:: bjc_workstation
# Recipe:: desktop
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Ye olde startup script
template "#{home}\\Start_Demo.ps1" do
  action :create
  source "Start_Demo.ps1.erb"
  variables(
    :home => home
  )
end

windows_shortcut 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\start me up.lnk' do
  target "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"
  arguments " #{home}\\Start_Demo.ps1"
  description "Start the Chef demo"
end

# Remove EC2 shortcuts
file "#{home}/Desktop/EC2 Feedback.website" do
  action :delete
end

file "#{home}/Desktop/EC2 Microsoft Windows Guide.website" do
  action :delete
end

# Enable ClearType
registry_key "HKEY_CURRENT_USER\\Control Panel\\Desktop" do
  values [{
    :name => "FontSmoothing",
    :type => :string,
    :data => 2
  }, {
    :name => "FontSmoothingType",
    :type => :dword,
    :data => 2
  }]
  action :create
end

# Create sample kitchen configs directory
directory "#{home}/Desktop/Test_Kitchen" do
  action :create
end

# Render sample kitchen templates
template "#{home}/Desktop/Test_Kitchen/kitchen_windows.yml" do
  action :create
  source 'kitchen_windows.yml.erb'
  variables(
    :home => home
  )
end

template "#{home}/Desktop/Test_Kitchen/kitchen_linux.yml" do
  action :create
  source 'kitchen_linux.yml.erb'
  variables(
    :home => home
  )
end
