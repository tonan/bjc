#
# Cookbook Name:: bjc_compliance
# Recipe:: load_profiles
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

profiles = %w(
  apache.tar.gz
  cis-apachetomcat-5.5-6.0-level1.zip
  cis-apachetomcat-5.5-6.0-level2.zip
  cis-microsoftwindows2012r2-level1-memberserver.tar.gz
  ssl-benchmark.zip
  stig-redhat.zip
)

profiles.each do |p|
  cookbook_file "/home/ubuntu/#{p}" do
    source "profiles/#{p}"
    action :create
  end
end

cookbook_file "/home/ubuntu/upload_profiles.sh" do
  action :create
  source 'upload_profiles.sh'
  mode '0755'
end
