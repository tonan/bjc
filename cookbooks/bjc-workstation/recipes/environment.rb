#
# Cookbook Name:: bjc-workstation
# Recipe:: environment
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

# We need to drop this PuTTY-formatted SSH key in ~/.ssh so PuTTY will work.
# Packer drops keys into C:/Windows/Temp, so we mimic that behavior here.
file "#{home}/.ssh/id_rsa.ppk" do
  content lazy { IO.read("C:/Windows/Temp/putty.ppk") }
  action :create
end
