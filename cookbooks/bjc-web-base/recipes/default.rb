#
# Cookbook Name:: bjc-web-base
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'bjc-web-base::java'
include_recipe 'bjc-web-base::mysql'
include_recipe 'bjc-web-base::tomcat'
include_recipe 'bjc-web-base::ssl'
