#
# Cookbook Name:: bjc_workstation
# Recipe:: editors
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

chocolatey_package 'VisualStudioCode' do
  action :install
end

# Disable Visual Studio Code Updates
# https://code.visualstudio.com/docs/supporting/faq#_how-do-i-opt-out-of-vs-code-autoupdates
directory "#{home}/AppData/Roaming/Code/User" do
  recursive true
end

cookbook_file "#{home}/AppData/Roaming/Code/User/settings.json" do
  source 'vscode.settings.json'
  action :create
end

# Disable Atom Updates
directory "#{home}/.atom"

cookbook_file "#{home}/.atom/config.cson" do
  source 'atom.config.cson'
  action :create
end
