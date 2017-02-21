#
# Cookbook Name:: planex-ecommerce
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'planex-ecommerce::java'
include_recipe 'planex-ecommerce::mysql'
include_recipe 'planex-ecommerce::tomcat'
include_recipe 'planex-ecommerce::cart'
include_recipe 'planex-ecommerce::ssl'
