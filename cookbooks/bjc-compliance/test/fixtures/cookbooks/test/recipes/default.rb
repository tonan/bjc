#
# Cookbook Name:: test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Copied from bjc-chef-server, not sure if needed here
%w(chef-server.crt chef-server.key delivery.crt compliance.crt compliance.key public.pub private.pem).each do |f|
  cookbook_file "/tmp/#{f}" do
  	source f
  	sensitive true
  end
end
