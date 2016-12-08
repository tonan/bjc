#
# Cookbook Name:: bjc_workstation
# Recipe:: environment
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

# We need to drop this PuTTY-formatted SSH key in ~/.ssh so PuTTY will work.
# Packer drops keys into C:/Windows/Temp, so we mimic that behavior here.
cookbook_file "#{home}/.ssh/id_rsa.ppk" do
  source 'putty.ppk'
  action :create
end