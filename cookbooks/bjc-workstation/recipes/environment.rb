#
# Cookbook Name:: bjc-workstation
# Recipe:: environment
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# NOTE:  This recipe did not work with Test Kitchen. 
# It is included in the packer/bjc-workstation.json run_list though.

home = Dir.home

# Do the needful
# We need to drop this PuTTY-formatted SSH key in ~/.ssh so PuTTY will work.
file "#{home}/.ssh/id_rsa.ppk" do
  content lazy { IO.read("C:/Windows/Temp/putty.ppk") }
  action :create
end
