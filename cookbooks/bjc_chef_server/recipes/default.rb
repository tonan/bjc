#
# Cookbook Name:: bjc_chef_server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'wombat::etc-hosts'
include_recipe 'chef_server::default'
include_recipe 'bjc_chef_server::content'
include_recipe 'bjc_chef_server::chef_gate'
include_recipe 'wombat::authorized-keys'
