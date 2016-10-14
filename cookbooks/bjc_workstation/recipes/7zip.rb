#
# Cookbook Name:: bjc_workstation
# Recipe:: 7zip
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

chocolatey_package '7zip' do
  action :install
end
