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
