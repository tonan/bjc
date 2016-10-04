#
# Cookbook Name:: bjc-compliance
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'compliance'
include_recipe 'audit'
include_recipe 'bjc-compliance::restore_backup'
include_recipe 'bjc-compliance::load_profiles'
#include_recipe 'bjc-compliance::load_apache_profile'
#include_recipe 'bjc-compliance::load_ssl_profile'

#SETS CHEF_GATE_COMPLIANCE_SECRET TO MATCH THE ONE ON THE CHEF SERVER
file '/opt/chef-compliance/sv/core/env/CHEF_GATE_COMPLIANCE_SECRET' do
	content lazy { IO.read('/tmp/public.pub') }
	sensitive true
end
