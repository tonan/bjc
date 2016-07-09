#
# Cookbook Name:: bjc-workstation
# Recipe:: cookbooks
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory "#{home}/cookbooks" do
  action :create
end


node['bjc-workstation']['cookbooks'].each do |cookbook|

  aws_s3_file "#{home}/cookbooks/#{cookbook}.zip" do
    bucket 'bjcpublic'
    remote_path "#{cookbook}.zip"
    region 'us-west-2'
  end

  windows_zipfile "#{home}/cookbooks/#{cookbook}" do
    source "#{home}/cookbooks/#{cookbook}.zip"
    action :unzip
  end

end

