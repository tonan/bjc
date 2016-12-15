#
# Cookbook Name:: bjc_chef_server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Required to prevent pushy from wigging out when we enable data collection.
hostsfile_entry node['demo']['hosts']['automate'] do
  hostname "#{node['demo']['domain_prefix']}automate.#{node['demo']['domain']}"
  aliases ["automate"]
  action :create
end

include_recipe 'chef_server::default'

# Update the hosts file so that things can resolve on build.
append_if_no_line "Add temporary hostsfile entry: #{node['ipaddress']}" do
  path "/etc/hosts"
  line "#{node['ipaddress']} #{node['demo']['domain_prefix']}chef.#{node['demo']['domain']} chef"
end

include_recipe 'bjc_chef_server::content'
include_recipe 'bjc_chef_server::chef_gate'

# All done. Clean 'er up.
delete_lines "Remove temporary hostfile entry we added earlier" do
  path "/etc/hosts"
  pattern "^#{node['ipaddress']}.*#{node['demo']['domain_prefix']}chef\.#{node['demo']['domain']}.*chef"
end

include_recipe 'wombat::authorized-keys'
