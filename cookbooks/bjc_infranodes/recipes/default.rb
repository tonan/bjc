#
# Cookbook Name:: bjc_infranodes
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'infranodes'

template '/etc/rc.local' do
  action :create
  source 'rc.local.erb'
end

include_recipe 'wombat::authorized-keys'
include_recipe 'wombat::etc-hosts'
