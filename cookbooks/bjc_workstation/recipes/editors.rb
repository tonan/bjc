#
# Cookbook Name:: bjc_workstation
# Recipe:: editors
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

chocolatey_package 'visualstudiocode' do
  action :install
end

directory "#{home}/AppData/Roaming/Code/User" do
  recursive true
end

# Disable Visual Studio Code Updates, Crash Reporting, and Telemetry Reporting
# https://code.visualstudio.com/docs/supporting/faq#_how-do-i-opt-out-of-vs-code-autoupdates
cookbook_file "#{home}/AppData/Roaming/Code/User/settings.json" do
  source 'vscode.settings.json'
  action :create
end

directory "#{home}/AppData/Roaming/Code/Local Storage" do
  recursive true
end

# Set Visual Studio Code Color and Icon Theme, Disable Welcome Message
# Stubbed SLQite3 Database File from Visual Studio Code
cookbook_file "#{home}/AppData/Roaming/Code/Local Storage/file__0.localstorage" do
  source 'vscode.file__0.localstorage'
  action :create
end

vscode_chef_ver = '0.6.3'
vscode_dl_path = Chef::Config[:file_cache_path] + "/Pendrica.Chef-#{vscode_chef_ver}"
vscode_inst_path = "#{home}/.vscode/extensions/Pendrica.Chef-#{vscode_chef_ver}"

# Download and Unzip Chef Extension for Visual Studio Code
windows_zipfile vscode_dl_path do
  source "https://Pendrica.gallery.vsassets.io/_apis/public/gallery/publisher/Pendrica/extension/Chef/#{vscode_chef_ver}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
  action :unzip
  not_if { ::File.exist?(vscode_dl_path + "/extension/README.md") }
end

directory vscode_inst_path do
  recursive true
end

# Copy Chef Extension for Visual Studio Code Into Place
ruby_block 'Copy Chef Extension for Visual Studio Code' do
  block do
    FileUtils.cp_r vscode_dl_path + "/extension/.", vscode_inst_path
  end
  not_if { ::File.exist?(vscode_inst_path + "/README.md") }
end

# Disable Atom Updates, Crash Reporting, Telemetry Reporting, Set Color Theme, and Disable Welcome Message
directory "#{home}/.atom"

cookbook_file "#{home}/.atom/config.cson" do
  source 'atom.config.cson'
  action :create
end
