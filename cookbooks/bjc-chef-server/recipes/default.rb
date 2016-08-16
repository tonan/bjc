#
# Cookbook Name:: bjc-chef-server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node.normal['demo']['build-nodes'] = 3
# this value wasn't taking from wombat.lock

include_recipe 'apt'
include_recipe 'chef-server'
