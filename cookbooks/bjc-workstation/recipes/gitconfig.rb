#
# Cookbook Name:: bjc-workstation
# Recipe:: gitconfig
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

template "#{home}/.gitconfig" do
  source 'gitconfig.erb'
  variables(
    domain: node['demo']['domain'],
    user: node['demo']['users']['automate']['first']
  )
end
