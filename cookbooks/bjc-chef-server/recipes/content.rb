#
# Cookbook Name:: bjc-chef-server
# Recipe:: cheffish
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

package 'unzip'
package 'git'
include_recipe 'build-essential'

%w( .chef
    cookbooks).each do |structure|
  directory "#{home}/#{structure}"
end

file "#{home}/.chef/config.rb" do
  content <<-EOS
chef_server_url "https://127.0.0.1/organizations/#{node['demo']['org']}"
client_key '/etc/opscode/pivotal.pem'
node_name 'pivotal'
cookbook_path ["#{home}/cookbooks"]
ssl_verify_mode :verify_none
EOS
end

%w( site-config
    bjc-ecommerce
    bjc_bass).each do |cookbook|
  cookbook_source = "https://s3-us-west-2.amazonaws.com/bjcpublic/#{cookbook}.zip"

  remote_file "#{home}/cookbooks/#{cookbook}.zip" do
    source cookbook_source
  end

  execute "extract the #{cookbook} zipfile" do
    cwd "#{home}/cookbooks/"
    command "unzip #{cookbook}.zip"
    creates "#{home}/cookbooks/#{cookbook}"
    action :run
  end

  execute "berks install #{cookbook}" do
  	cwd "#{home}/cookbooks/#{cookbook}"
    command '/opt/opscode/embedded/bin/berks install'
    action :run
  end

  execute "berks upload #{cookbook}" do
    cwd "#{home}/cookbooks/#{cookbook}"
    command '/opt/opscode/embedded/bin/berks upload --no-ssl-verify'
    action :run
  end
end
