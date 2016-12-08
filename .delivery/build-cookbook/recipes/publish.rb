#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

log node['delivery']['workspace_path']

execute "build-the-things" do
  command "wombat --version"
  cwd node['delivery']['workspace_path']
  action :run
end
