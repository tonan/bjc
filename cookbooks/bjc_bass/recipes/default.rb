#
# Cookbook Name:: bjc_bass
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
node.default['audit']['collector'] = 'chef-visibility'
node.default['audit']['profiles']['admin/ssl-benchmark'] = true
node.default['push_jobs']['allow_unencrypted'] = true

chef_gem 'inspec' do
  compile_time true
  version '0.33.2'
end

include_recipe 'push-jobs'
include_recipe 'audit'
