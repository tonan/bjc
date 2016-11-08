#
# Cookbook Name:: bjc_automate
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'automate::default'

cookbook_file '/tmp/delivery_backup.tar' do
  source 'delivery_backup.tar'
  notifies :run, 'execute[restore backup data into automate]'
  checksum 'f3384ca41bb0785ecdc2cb0d9382fee827cf1549c2d2c143a36c4aed7ed02839'
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
