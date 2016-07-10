#
# Cookbook Name:: bjc-workstation
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'workstation'
include_recipe 'bjc-workstation::cmder'
include_recipe 'bjc-workstation::cookbooks'
include_recipe 'bjc-workstation::gitconfig'
