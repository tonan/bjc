#
# Cookbook Name:: bjc-workstation
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

directory "#{home}/cookbooks/site-config/foo"
  action :create
end
