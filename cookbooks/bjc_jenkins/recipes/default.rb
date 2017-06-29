#
# Cookbook Name:: bjc_jenkins
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'java'

include_recipe 'jenkins::master'

#plugins = node['bjc_jenkins']['plugins']

#plugins.each do |p|
#  jenkins_plugin p
#end

package 'git'

remote_file "#{Chef::Config['file_cache_path']}/chefdk.rpm" do
  action :create
  source node['bjc_jenkins']['chefdk_url']
end

package "ChefDK" do
  action :install
  source "#{Chef::Config['file_cache_path']}/chefdk.rpm"
end
