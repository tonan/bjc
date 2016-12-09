#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# log node['delivery']['workspace_path']

# Build new Chef Demo AMIs and associated Cloudformation Template
execute "build-the-things" do
  command "source /var/opt/delivery/workspace/.bashrc; wombat build --parallel"
  live_stream true
  cwd "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/build/publish/repo"
  action :run
end

execute "generate-json" do
  command "source /var/opt/delivery/workspace/.bashrc; wombat update"
  live_stream true
  cwd "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/build/publish/repo"
  action :run
end
