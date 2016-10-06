#
# Cookbook Name:: bjc-delivery
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'automate'

cookbook_file '/tmp/delivery_backup.tar' do
  source 'delivery_backup.tar'
  notifies :run, 'execute[restore backup data into automate]'
  checksum '65bdf7ba0597337fe7ea1e9371b8047e43bb37b26f387368c9bad811cf6827ec'
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
