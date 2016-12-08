#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

log node['delivery']['workspace_path']

execute "build-the-things" do
  command "wombat build --parallel"
  cwd "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/build/publish/repo"
  action :run
end
