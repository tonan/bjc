#
# Cookbook Name:: bjc_compliance
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'compliance'
include_recipe 'audit'
include_recipe 'bjc_compliance::restore_backup'
include_recipe 'bjc_compliance::load_profiles'

#SETS CHEF_GATE_COMPLIANCE_SECRET TO MATCH THE ONE ON THE CHEF SERVER
file '/opt/chef-compliance/sv/core/env/CHEF_GATE_COMPLIANCE_SECRET' do
	content lazy { IO.read('/tmp/public.pub') }
	sensitive true
end

include_recipe 'wombat::authorized-keys'
include_recipe 'wombat::etc-hosts'
