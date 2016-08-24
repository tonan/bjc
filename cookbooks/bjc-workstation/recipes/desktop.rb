#
# Cookbook Name:: bjc-workstation
# Recipe:: desktop
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

template "#{home}/Desktop/Start_Demo.ps1" do
  action :create
  source "Start_Demo.ps1.erb"
end

powershell_script 'Set-ExecutionPolicy Unrestricted' do
  action :run
end
