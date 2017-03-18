#
# Cookbook Name:: bjc_workstation
# Recipe:: delivery
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory "#{home}/.delivery" do
  action :create
end

template "#{home}/.delivery/cli.toml" do
  source 'cli.toml.erb'
  variables(
    server: "#{node['demo']['domain_prefix']}automate.#{node['demo']['domain']}",
    ent: node['demo']['enterprise'],
    org: node['demo']['org'],
    user: "workstation-#{node['demo']['workstation-number']}"
  )
end
