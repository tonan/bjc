#
# Cookbook Name:: bjc_bass
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

chef_gem 'inspec' do
  compile_time true
  version '0.33.2'
end

include_recipe 'push-jobs'
include_recipe 'audit'
