#
# Cookbook Name:: bjc_automate
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'automate::default'

directory '/var/opt/delivery/backups' do
  action :create
  recursive true
end

cookbook_file '/var/opt/delivery/backups/chef-automate-backup.zst' do
  source 'chef-automate-backup.zst'
  notifies :run, 'execute[restore backup data into automate]'
  checksum 'd37ce9d5449254fef41d28ec8b97cbdf053d85264344613784e2804548c6ba0f'
end

execute 'restore backup data into automate' do
  command 'automate-ctl restore-backup chef-automate-backup.zst --force'
  cwd '/var/opt/delivery/backups'
  notifies :restart, 'omnibus_service[ ]'
  action :nothing
end

omnibus_service ' ' do
  ctl_command 'delivery-ctl'
  action :nothing
end

include_recipe 'wombat::authorized-keys'
