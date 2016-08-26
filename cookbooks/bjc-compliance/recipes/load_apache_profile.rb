#
# Cookbook Name:: bjc-compliance
# Recipe:: load_apache_profile
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_filename = 'apache.tar.gz'
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"

cookbook_file src_filepath do
  source src_filename
end

cookbook_file "#{Chef::Config['file_cache_path']}/upload_apache_profile.sh" do
  action :create
  source 'upload_apache_profile.sh'
  mode '0755'
end

# This doesn't work. You MUST run this script manually or via SSH
#bash "Import Apache Compliance profile" do
#  code "#{Chef::Config['file_cache_path']}/upload_apache_profile.sh"
#  action :run
#end
