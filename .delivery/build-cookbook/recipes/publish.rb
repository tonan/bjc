#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute "build-the-things" do
  command "cd #{['delivery']['workspace_path']}; wombat build --parallel"
  cwd node['delivery']['workspace_path']
  action :run
end
