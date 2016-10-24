#
# Cookbook Name:: bjc_automate
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'automate::default'

cookbook_file '/tmp/delivery_backup.tar' do
  source 'delivery_backup.tar'
  notifies :run, 'execute[restore backup data into automate]'
  checksum 'e0196441114e86c6c94b50cae2a83c9c573fecba9709e0aab3fb2f2bc56bad32'
end

execute 'restore backup data into automate' do
  command 'delivery-ctl restore-data -b /tmp/delivery_backup.tar --no-confirm'
  notifies :restart, 'omnibus_service[ ]'
  action :nothing
end

omnibus_service ' ' do
  ctl_command 'delivery-ctl'
  action :nothing
end

include_recipe 'wombat::authorized-keys'
include_recipe 'wombat::etc-hosts'
