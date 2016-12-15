#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'aws-sdk'

# This could probably be refactored a bit
workspace = "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/build/publish/repo"

# Copy keys into the packer directory
execute "copy-packer-keys" do
  command "tar -zxvf /var/opt/delivery/workspace/Downloads/keys.tar.gz -C packer/keys"
  live_stream true
  cwd workspace
  action :run
end

# Build new Chef Demo AMIs
execute "build-the-things" do
  command "/var/opt/delivery/workspace/wombat_build.sh"
  live_stream true
  cwd workspace
  action :run
end

# Create a new bjc-demo.json template
execute "generate-json" do
  command "/var/opt/delivery/workspace/wombat_update.sh"
  live_stream true
  cwd workspace
  action :run
end

# Use the Ruby AWS SDK to upload bjc-demo.json to S3
s3 = Aws::S3::Resource.new(region:'us-west-2')
obj = s3.bucket('bjcpublic').object('bjc-demo.json')
obj.upload_file("#{workspace}/stacks/bjc-demo.json", acl:'public_read')
