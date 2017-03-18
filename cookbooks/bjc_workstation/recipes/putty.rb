#
# Cookbook Name:: bjc_workstation
# Recipe:: putty
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Install the Putty
chocolatey 'putty' do
  options( '-allow-empty-checksums' => '' )
end

# Make the shortcut
windows_shortcut "#{home}/Desktop/putty.lnk" do
  target "C:\\ProgramData\\chocolatey\\bin\\PUTTY.EXE"
  description "PuTTY"
  iconlocation "C:\\ProgramData\\chocolatey\\bin\\PUTTY.EXE, 0"
end

# Create the settings
cookbook_file "#{home}/putty.reg" do
  action :create
  source 'putty.reg'
end

# Import the settings
batch 'Import PuTTY Settings' do
  code 'reg import putty.reg'
  cwd home
  action :run
end
