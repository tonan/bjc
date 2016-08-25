#
# Cookbook Name:: test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
home = Dir.home

powershell_script 'bypass execution policy' do
	code 'set-executionpolicy -executionpolicy bypass -force'
end

%w(chef.crt
   automate.crt
   compliance.crt
   public.pub
   private.pem).each do |f|
  cookbook_file "C:/Windows/Temp/#{f}" do
  	source f
  	sensitive true
  end
end

cookbook_file "#{home}/.ssh/id_rsa.ppk" do
  action :create
  source 'putty.ppk'
  sensitive true
end
