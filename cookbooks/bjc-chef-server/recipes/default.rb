#
# Cookbook Name:: bjc-chef-server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt'
include_recipe 'chef_server'

chef_ingredient 'chef-server' do
  action :reconfigure
  config <<-EOS

data_collector['root_url'] = 'https://#{node['demo']['domain_prefix']}automate.#{node['demo']['domain']}/data-collector/v0/'
data_collector['token'] = '93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'
EOS
end

include_recipe 'bjc-chef-server::content'
