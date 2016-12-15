#
# Cookbook Name:: build-cookbook
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory "#{node['delivery']['workspace_path']}/stacks" do
  action :create
end

# This is kind of an ugly hack but it allows us to use wombat as intended.
# Fetch the bjc-demo.json that was just created in the build stage
remote_file "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/acceptance/deploy/repo/stacks/bjc-demo.json" do
  source 'https://s3-us-west-2.amazonaws.com/bjcpublic/bjc-demo.json'
  action :create
end

execute 'Deploy Demo Stack' do
  command "#{node['delivery']['workspace_path']}/wombat_deploy.sh"
  cwd "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/acceptance/deploy/repo"
  live_stream true
  action :run
end
