#
# Cookbook Name:: bjc-workstation
# Recipe:: desktop
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

# Ye olde startup script
template "#{home}/Desktop/Start_Demo.ps1" do
  action :create
  source "Start_Demo.ps1.erb"
end

# Your puny restrictions are no match for my powershell
powershell_script 'bypass execution policy' do
  code 'set-executionpolicy -executionpolicy bypass -force'
end

# Remove EC2 shortcuts
file "#{home}/Desktop/EC2 Feedback.website" do
  action :delete
end

file "#{home}/Desktop/EC2 Microsoft Windows Guide.website" do
  action :delete
end
