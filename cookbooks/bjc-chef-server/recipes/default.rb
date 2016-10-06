#
# Cookbook Name:: bjc-chef-server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'chef_server'
include_recipe 'bjc-chef-server::content'
include_recipe 'bjc-chef-server::chef_gate'
include_recipe 'wombat::authorized-keys'
include_recipe 'wombat::etc-hosts'
