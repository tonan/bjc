#
# Cookbook Name:: bjc-workstation
# Recipe:: environment
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Do the needful
file "#{home}/.ssh/id_rsa.ppk" do
  # This won't work with Test Kitchen, we use a fixture cookbook for TK instead
  content lazy { IO.read("C:/Windows/Temp/putty.ppk") }
  action :create
end
