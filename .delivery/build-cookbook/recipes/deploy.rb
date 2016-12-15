#
# Cookbook Name:: build-cookbook
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory "#{node['delivery']['workspace_path']}/stacks" do
  action :create
end

remote_file "#{node['delivery']['workspace_path']}/stacks/bjc-demo.json" do
  source 'https://s3-us-west-2.amazonaws.com/bjcpublic/bjc-demo.json'
  action :create
end

execute 'Copy wombat.yml' do
  command "cp #{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/acceptance/deploy/repo/wombat.yml #{node['delivery']['workspace_path']}/wombat.yml"
  action :run
end

execute 'Copy wombat.lock' do
  command "cp #{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/acceptance/deploy/repo/wombat.lock #{node['delivery']['workspace_path']}/wombat.lock"
  action :run
end

execute 'Deploy Demo Stack' do
  command "#{node['delivery']['workspace_path']}/wombat_deploy.sh"
  cwd node['delivery']['workspace_path']
  live_stream true
  action :run
end
