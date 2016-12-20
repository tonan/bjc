#
# Cookbook Name:: build-cookbook
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'json'
include_recipe 'chef-sugar::default'

# This part runs only in 'Acceptance'.  Stand up a demo for testing.
if ['acceptance'].include?(node['delivery']['change']['stage'])
  workspace = "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/acceptance/deploy/repo"
  # Only build if we have changed cookbooks.
  unless changed_cookbooks.empty?
    # Copy keys into the packer directory
    execute "copy-packer-keys" do
      command "tar -zxvf #{node['delivery']['workspace_path']}/Downloads/keys.tar.gz -C packer/keys"
      live_stream true
      cwd workspace
      action :run
    end
    
    # This is kind of an ugly hack but it allows us to use wombat as intended.
    # Fetch the bjc-demo.json that was just created in the build stage
    remote_file "#{workspace}/stacks/bjc-demo.json" do
      source 'https://s3-us-west-2.amazonaws.com/bjcpublic/bjc-demo.json'
      action :create
    end
    
    execute 'Deploy Demo Stack' do
      command "#{node['delivery']['workspace_path']}/wombat_deploy.sh"
      cwd workspace
      live_stream true
      action :run
    end
  end
end

# This part only runs in 'Delivered'. Publish the new json to S3.
if ['delivered'].include?(node['delivery']['change']['stage'])

  workspace = "#{node['delivery']['workspace_path']}/bjc-automate-server-5g9aorii6yvcetdi.us-west-2.opsworks-cm.io/default/chef-sas/bjc/master/delivered/deploy/repo" 

  remote_file "#{workspace}/stacks/bjc-demo.json" do
    action :create
    source 'https://s3-us-west-2.amazonaws.com/bjcpublic/bjc-demo.json'
  end

  cfjson = File.read("#{workspace}/stacks/bjc-demo.json")
 
  data_hash = JSON.parse(cfjson)

  version = data_hash['Parameters']['Version']['Default']

  ruby_block "Publish bjc-demo.json to S3" do
    block do
      s3 = Aws::S3::Resource.new(region:'us-west-2')
      obj = s3.bucket('bjcpublic').object("cloudformation/bjc-demo-#{version}.json")
      obj.upload_file("#{workspace}/stacks/bjc-demo.json", acl:'public-read')
    end
  end
end
