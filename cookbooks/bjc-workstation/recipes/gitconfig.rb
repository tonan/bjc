#
# Cookbook Name:: bjc-workstation
# Recipe:: gitconfig
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

file "#{home}/.gitconfig" do
  action :create
  content <<-EOS
[credential]
    helper = manager
[user]
    email = delivery@automate-demo.com
    name = delivery
  EOS
end
