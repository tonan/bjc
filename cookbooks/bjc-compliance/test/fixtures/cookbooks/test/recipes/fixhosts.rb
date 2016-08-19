#
# Cookbook Name:: test
# Recipe:: fixhosts
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

hostsfile_entry node['ipaddress'] do
  hostname  'compliance.automate-demo.com'
  aliases   ['compliance']
  action    :create
end
