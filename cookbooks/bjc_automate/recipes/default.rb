#
# Cookbook Name:: bjc_automate
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'automate::default'

cookbook_file '/tmp/delivery_backup.tar' do
  source 'delivery_backup.tar'
  notifies :run, 'execute[restore backup data into automate]'
  checksum '4427cb7f4b9cd235c0ccde8743eaf78f4cda8c74fc4163994c31bea2c774912b'
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
