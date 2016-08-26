#
# Cookbook Name:: bjc-compliance
# Recipe:: load_apache_profile
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Stage the Apache profile to prepare it to be loaded into compliance
cookbook_file '/home/ubuntu/apache.tar.gz' do
  action :create
  source 'apache.tar.gz'
end

cookbook_file "/home/ubuntu/upload_apache_profile.sh" do
  action :create
  source 'upload_apache_profile.sh'
  mode '0755'
end
