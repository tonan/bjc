#
# Cookbook Name:: bjc_workstation
# Recipe:: editors
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

chocolatey_package 'VisualStudioCode' do
  action :install
end
