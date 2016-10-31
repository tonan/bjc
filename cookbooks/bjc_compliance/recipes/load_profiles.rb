#
# Cookbook Name:: bjc_compliance
# Recipe:: load_profiles
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

profiles = %w(
  apache.tar.gz
  cis-apachetomcat-5_5-6_0-level1.tar.gz
  cis-apachetomcat-5_5-6_0-level2.tar.gz
  cis-microsoftwindows2012r2-level1-memberserver.tar.gz
  linux-patch-benchmark.zip
  windows-patch-benchmark.zip
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
