#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Run inspec tests on the Windows workstation
execute 'Run inspec tests on workstation' do
  command "/var/opt/delivery/workspace/inspec_workstation.sh"
  action :run
end
