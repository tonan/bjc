#
# Cookbook Name:: bjc_workstation
# Recipe:: editors
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

chocolatey_package 'VisualStudioCode' do
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

# Download and Unzip Chef Extension for Visual Studio Code
windows_zipfile Chef::Config[:file_cache_path] + '/Pendrica.Chef-0.6.2' do
  source "https://Pendrica.gallery.vsassets.io/_apis/public/gallery/publisher/Pendrica/extension/Chef/0.6.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
  checksum '0436ca5b7ed0e46cbc1059f9ec509cb74cf8e913eacd6c2b7e805d88f0ce953f'
  action :unzip
  not_if {::File.exists?(Chef::Config[:file_cache_path] + '/Pendrica.Chef-0.6.2/extension/README.md')}
end

directory "#{home}/.vscode/extensions/Pendrica.Chef-0.6.2" do
  recursive true
end

# Copy Chef Extension for Visual Studio Code Into Place
ruby_block 'Copy Chef Extension for Visual Studio Code' do
  block do
    FileUtils.cp_r Chef::Config[:file_cache_path] + '/Pendrica.Chef-0.6.2/extension/.', "#{home}/.vscode/extensions/Pendrica.Chef-0.6.2"
  end
  not_if {::File.exists?("#{home}/.vscode/extensions/Pendrica.Chef-0.6.2/README.md")}
end

# Disable Atom Updates, Crash Reporting, Telemetry Reporting, Set Color Theme, and Disable Welcome Message
directory "#{home}/.atom"

cookbook_file "#{home}/.atom/config.cson" do
  source 'atom.config.cson'
  action :create
end
