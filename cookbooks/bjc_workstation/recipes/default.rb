#
# Cookbook Name:: bjc_workstation
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'workstation'
include_recipe 'bjc_workstation::cmder'
include_recipe 'bjc_workstation::cookbooks'
include_recipe 'bjc_workstation::gitconfig'
include_recipe 'bjc_workstation::delivery'
include_recipe 'bjc_workstation::berksconfig'
include_recipe 'bjc_workstation::putty'
include_recipe 'bjc_workstation::editors'
include_recipe 'bjc_workstation::desktop'
include_recipe 'bjc_workstation::browser'
include_recipe 'bjc_workstation::environment'
