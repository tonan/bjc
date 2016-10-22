#
# Cookbook Name:: bjc_workstation
# Recipe:: browser
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory 'C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default' do
  action :create
  recursive true
end

template 'C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default\Bookmarks' do
  action :create
  source 'bookmarks.erb'
end
