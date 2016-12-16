#
# Cookbook Name:: build-cookbook
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'chef-sugar::default'

return unless ['acceptance'].include?(node['delivery']['change']['stage'])

workspace = "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/acceptance/deploy/repo"

# Copy keys into the packer directory
execute "copy-packer-keys" do
  command "tar -zxvf /var/opt/delivery/workspace/Downloads/keys.tar.gz -C packer/keys"
  live_stream true
  cwd workspace
  action :run
end

# This is kind of an ugly hack but it allows us to use wombat as intended.
# Fetch the bjc-demo.json that was just created in the build stage
remote_file "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/acceptance/deploy/repo/stacks/bjc-demo.json" do
  source 'https://s3-us-west-2.amazonaws.com/bjcpublic/bjc-demo.json'
  action :create
end

execute 'Deploy Demo Stack' do
  command "#{node['delivery']['workspace_path']}/wombat_deploy.sh"
  cwd workspace
  live_stream true
  action :run
end
