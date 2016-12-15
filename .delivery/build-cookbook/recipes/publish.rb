#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# log node['delivery']['workspace_path']

# Copy keys into the packer directory
execute "copy-packer-keys" do
  command "tar -zxvf /var/opt/delivery/workspace/Downloads/keys.tar.gz -C packer/keys"
  live_stream true
  cwd "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/build/publish/repo"
  action :run
end

# Build new Chef Demo AMIs and associated Cloudformation Template
execute "build-the-things" do
  command "/var/opt/delivery/workspace/wombat_build.sh"
  live_stream true
  cwd "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/build/publish/repo"
  action :run
end

execute "generate-json" do
  command "/var/opt/delivery/workspace/wombat_update.sh"
  live_stream true
  cwd "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/build/publish/repo"
  action :run
end

# Here is where we will use the Ruby AWS SDK to upload bjc-demo.json to S3
