#
# Cookbook Name:: bjc-workstation
# Recipe:: cookbooks
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

directory "#{home}/cookbooks" do
  action :create
end


node['bjc-workstation']['cookbooks'].each do |cookbook|

  remote_file "#{home}/cookbooks/#{cookbook}.zip" do
    source "https://s3-us-west-2.amazonaws.com/bjcpublic/#{cookbook}.zip"
  end
  

  windows_zipfile "#{home}/cookbooks/" do
    source "#{home}/cookbooks/#{cookbook}.zip"
    action :unzip
  end

end

