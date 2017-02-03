#
# Cookbook Name:: bjc_workstation
# Recipe:: kitchen_templates
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
tk_dir = 'C:\Users\Administrator\Desktop\Test_Kitchen'

directory tk_dir

cookbook_file "#{tk_dir}\\kitchen_linux.yml" do
  source 'kitchen_linux.yml'
end

cookbook_file "#{tk_dir}\\kitchen_windows.yml" do
  source 'kitchen_windows.yml'
end

cookbook_file 'C:\Users\Administrator\user_data' do
  source 'user_data'
end

# OS-Specific user_data files to add the automate server to instances' hosts files.
# Required to send TK data to Visibility.
cookbook_file 'C:\Users\Administrator\ubuntu_user_data' do
  source 'ubuntu_user_data'
end

cookbook_file 'C:\Users\Administrator\windows_user_data' do
  source 'windows_user_data'
end
