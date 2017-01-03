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
chef_gem 'wombat-cli'
chef_gem 'aws-sdk'

%w(build update deploy).each do |s|
  template "/var/opt/delivery/workspace/wombat_#{s}.sh" do
    source "wombat_#{s}.sh.erb"
    action :create
  end
end

template "/var/opt/delivery/workspace/inspec_tests.sh" do
  action :create
  source "inspec_tests.sh.erb"
end
