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

# Disable Atom Updates
directory "#{home}/AppData/Roaming/Code/Local Storage" do
  recursive true
end

# Set Visual Studio Code Color and Icon Theme, Disable Welcome Message
# Stubbed SLQite3 Database File from Visual Studio Code
cookbook_file "#{home}/AppData/Roaming/Code/Local Storage/file__0.localstorage" do
  source 'vscode.file__0.localstorage'
  action :create
end
directory "#{home}/.atom"

cookbook_file "#{home}/.atom/config.cson" do
  source 'atom.config.cson'
  action :create
end
