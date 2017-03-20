#
# Cookbook Name:: bjc_workstation
# Recipe:: browser
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory "#{home}\\AppData\\Local\\Google\\Chrome\\User Data\\Default" do
  action :create
  recursive true
end

template "#{home}\\AppData\\Local\\Google\\Chrome\\User Data\\Default\\Bookmarks" do
  action :create
  source 'bookmarks.erb'
end

# Disable Google Chrome Updates
# https://www.chromium.org/administrators/turning-off-auto-updates
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Update' do
  values [{:name => 'AutoUpdateCheckPeriodMinutes', :type => :dword, :data => '00000000'}]
  action :create
  recursive true
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Update' do
  values [{:name => 'UpdateDefault', :type => :dword, :data => '00000000'}]
  action :create
  recursive true
end
