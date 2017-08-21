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
  checksum 'acc72db06d8f0dbe1e836113e243df2ba7fc3d6512522c328a49df42e24ccdf9'
end

execute 'restore backup data into automate' do
  command 'automate-ctl restore-backup chef-automate-backup.zst --force'
  cwd '/var/opt/delivery/backups'
  notifies :restart, 'omnibus_service[automate-server/cli]'
  action :nothing
end

omnibus_service 'automate-server/cli' do
  ctl_command 'automate-ctl'
  action :nothing
end

include_recipe 'wombat::authorized-keys'
