#
# Cookbook Name:: bjc_compliance
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'compliance::default'
include_recipe 'audit::default'
include_recipe 'bjc_compliance::restore_backup'
include_recipe 'bjc_compliance::load_profiles'

#SETS CHEF_GATE_COMPLIANCE_SECRET TO MATCH THE ONE ON THE CHEF SERVER
file '/opt/chef-compliance/sv/core/env/CHEF_GATE_COMPLIANCE_SECRET' do
  content lazy { IO.read('/tmp/public.pub') }
  sensitive true
end

#Run startup commands to populate profiles via /etc/rc.local
template '/etc/rc.local' do
  action :create
  source 'rc.local.erb'
end

include_recipe 'wombat::authorized-keys'
include_recipe 'wombat::etc-hosts'

package 'git' do
  action :install
end

#Sync so we can get all our compliance profiles downloaded
git '/home/ubuntu/bjc' do
  action :sync
  repository 'https://github.com/chef-cft/bjc'
end
