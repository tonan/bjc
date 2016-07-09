#
# Cookbook Name:: bjc-workstation
# Recipe:: cmder
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

cookbook_file 'C:\tools\cmder\config\ConEmu.xml' do
  source 'cmder.xml'
  sensitive true
  action :create
end