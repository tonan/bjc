#
# Cookbook Name:: base-web
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package ['curl','vim'] do
  action :install
end

case node['platform_family']
when 'rhel'
  include_recipe 'base-web::centos'
when 'debian'
  include_recipe 'base-web::ubuntu'
end
