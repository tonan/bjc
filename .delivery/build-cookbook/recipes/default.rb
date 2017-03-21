#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

if node['platform'] == 'ubuntu'
  apt_update 'update ubuntu packages' do
    action :update
  end
end

include_recipe 'packer'

chef_gem 'wombat-cli' do
  action :upgrade
end

chef_gem 'aws-sdk'

template "/var/opt/delivery/workspace/inspec_tests.sh" do
  action :create
  source "inspec_tests.sh.erb"
end
