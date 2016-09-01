#
# Cookbook Name:: bjc-chef-server
# Recipe:: cheffish
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home = Dir.home

delete_lines 'Temporarily remove chef server from hostsfile' do
  path '/etc/hosts'
  pattern "172.31.54.10 *"
end

append_if_no_line "Add temporary hostsfile entry: #{node['ipaddress']}" do
  path "/etc/hosts"
  line "#{node['ipaddress']} #{node['demo']['domain_prefix']}chef.#{node['demo']['domain']} chef"
end

%w( /home/ubuntu/.chef
    /home/ubuntu/.berkshelf
    /tmp/cookbooks).each do |structure|
  directory structure
end

file "#{home}/.chef/config.rb" do
  content <<-EOS
chef_server_url "https://127.0.0.1/organizations/#{node['demo']['org']}"
client_key '/etc/opscode/pivotal.pem'
node_name 'pivotal'
cookbook_path ["/tmp/cookbooks"]
ssl_verify_mode :verify_none
EOS
end

file "#{home}/.berkshelf/config.json" do
  content '{"ssl": { "verify": false } }'
end

package 'unzip'
package 'git'
include_recipe 'build-essential'

chef_gem 'berkshelf' do
	compile_time false
  version '4.3.5'
end

%w(push-jobs-3.2.0 site-config bjc-ecommerce).each do |cookbook|
  if cookbook == 'push-jobs-3.2.0'
  	cookbook_source = 'https://github.com/chef-cookbooks/push-jobs/archive/v3.2.0.zip'
  else
    cookbook_source = "https://s3-us-west-2.amazonaws.com/bjcpublic/#{cookbook}.zip"
  end

  remote_file "/tmp/cookbooks/#{cookbook}.zip" do
    source cookbook_source
  end

  execute "extract the #{cookbook} zipfile" do
    cwd '/tmp/cookbooks/'
    command "unzip #{cookbook}.zip"
    creates "/tmp/cookbooks/#{cookbook}"
    action :run
  end

  execute "berks install #{cookbook}" do
  	cwd "/tmp/cookbooks/#{cookbook}"
    command 'berks install'
    action :run
  end

  execute "berks upload #{cookbook}" do
    cwd "/tmp/cookbooks/#{cookbook}"
    command 'berks upload'
    action :run
  end
end

delete_lines "Remove temporary hostfile entry we added earlier" do
  path "/etc/hosts"
  pattern "^#{node['ipaddress']}.*#{node['demo']['domain_prefix']}chef\.#{node['demo']['domain']}.*chef"
end

append_if_no_line 'Revert the temporarily removed hostsfile entry' do
  path '/etc/hosts'
  line '172.31.54.10    chef.automate-demo.com chef'
end
