#
# Cookbook Name:: test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

powershell_script 'bypass execution policy' do
  code 'set-executionpolicy -executionpolicy bypass -force'
end

%w(
  chef.crt
  automate.crt
  compliance.crt
  ecomacceptance.crt
  union.crt
  rehearsal.crt
  delivered.crt
  public.pub
  private.pem
  putty.ppk
).each do |f|
  cookbook_file "C:/Windows/Temp/#{f}" do
    source f
    sensitive true
  end
end
