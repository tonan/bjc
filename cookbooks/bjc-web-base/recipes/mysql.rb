#
# Cookbook Name:: bjc-web-base
# Recipe:: mysql
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w(mysql-server mysql-client).each do |p|
  package p do
    action :install
  end
end
