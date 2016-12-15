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

execute 'Deploy Demo Stack' do
  command "wombat deploy bjc-demo"
  cwd node['delivery']['workspace_path']
  live_stream true
  action :run
end

ruby_block 'Wait for demo to spin up...' do
  block do
    sleep 120
  end
end

execute 'Fetch workstation IP' do
  command 'wombat outputs bjc-demo'
  live_stream true
  action :run
end
