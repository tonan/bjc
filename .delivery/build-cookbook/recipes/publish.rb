#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute "build-the-things" do
  command <<-EOH
    echo "¯\_(ツ)_/¯"
  EOH
  cwd node['delivery']['workspace_path']
end
