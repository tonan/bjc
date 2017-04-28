#
# Cookbook Name:: bjc_infranodes
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

include_recipe 'infranodes::default'

file "/etc/ssl/private/#{node['demo']['domain_prefix']}#{node['demo']['node-name']}.#{node['demo']['domain']}.key" do
  content lazy { IO.read("/tmp/#{node['demo']['node-name']}.key") }
  action :create
  sensitive true
end

file "/etc/ssl/certs/#{node['demo']['domain_prefix']}#{node['demo']['node-name']}.#{node['demo']['domain']}.crt" do
  content lazy { IO.read("/tmp/#{node['demo']['node-name']}.crt") }
  action :create
  sensitive true
end

file "/#{home}/#{node['demo']['node-name']}.crt" do
  content lazy { IO.read("/tmp/#{node['demo']['node-name']}.crt") }
  action :create
  sensitive true
end

file "/#{home}/#{node['demo']['node-name']}.key" do
  content lazy { IO.read("/tmp/#{node['demo']['node-name']}.key") }
  action :create
  sensitive true
end

template '/etc/rc.local' do
  action :create
  source 'rc.local.erb'
end

include_recipe 'wombat::authorized-keys'
include_recipe 'wombat::etc-hosts'
