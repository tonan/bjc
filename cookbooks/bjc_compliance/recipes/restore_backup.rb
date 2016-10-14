#
# Cookbook Name:: bjc_compliance
# Recipe:: restore_backup
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Restores Chef Compliance data from a backup created with pg_dump.
# You can use this command to create the backup file:
# sudo -u chef-pgsql /opt/chef-compliance/embedded/bin/pg_dump -c chef_compliance > compliance_backup.sql

# Drop your backup file into the Chef file cache directory:
cookbook_file "#{Chef::Config[:file_cache_path]}/compliance_backup.sql" do
  action :create
  source 'compliance_backup.sql'
  sensitive true
end

# And run the psql command to restore the data
execute 'Restore Chef Compliance Backup' do
  command "/opt/chef-compliance/embedded/bin/psql -q chef_compliance < #{Chef::Config[:file_cache_path]}/compliance_backup.sql"
  user 'chef-pgsql'
  sensitive true
  # TO DO: write a guard for this
end

# Wait...
ruby_block 'Wait for compliance to get its act together' do
  block do
    sleep(60)
  end
end
