#
# Cookbook Name:: test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w(
  chef.crt
  automate.crt
  automate.key
  compliance.crt
  public.pub
  private.pem
  delivery.license
).each do |f|
  cookbook_file "/tmp/#{f}" do
    source f
    sensitive true
  end
end
