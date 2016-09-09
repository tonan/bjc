#
# Cookbook Name:: bjc-compliance
# Recipe:: load_ssl_profile
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# Cookbook Name:: bjc-compliance
# Recipe:: load_apache_profile
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Stage the Apache profile to prepare it to be loaded into compliance
cookbook_file '/home/ubuntu/ssl-benchmark.tar.gz' do
  action :create
  source 'ssl-benchmark.tar.gz'
end

cookbook_file "/home/ubuntu/upload_ssl_profile.sh" do
  action :create
  source 'upload_ssl_profile.sh'
  mode '0755'
end
