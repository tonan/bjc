#
# Cookbook Name:: bjc-compliance
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'compliance'
include_recipe 'bjc-compliance::restore_backup'
include_recipe 'bjc-compliance::load_apache_profile'
include_recipe 'bjc-compliance::load_ssl_profile'
