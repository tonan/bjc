#
# Cookbook Name:: bjc_build_node
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'build_node'

template '/var/opt/delivery/workspace/.chef/knife.rb' do
  source 'knife.erb'
end
