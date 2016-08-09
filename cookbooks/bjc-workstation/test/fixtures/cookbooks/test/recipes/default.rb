#
# Cookbook Name:: test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
powershell_script 'bypass execution policy' do
	code 'set-executionpolicy -executionpolicy bypass -force'
end

%w(chef-server.crt
   delivery.crt
   compliance.crt
   public.pub
   private.pem).each do |f|
  cookbook_file "C:/Windows/Temp/#{f}" do
  	source f
  	sensitive true
  end
end
