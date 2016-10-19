#
# Cookbook Name:: bjc_workstation
# Recipe:: desktop
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

# Ye olde startup script
template "#{home}\\Start_Demo.ps1" do
  action :create
  source "Start_Demo.ps1.erb"
end

windows_shortcut "#{home}\\Desktop\\start it up.lnk" do
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
