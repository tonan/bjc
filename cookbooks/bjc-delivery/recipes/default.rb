#
# Cookbook Name:: bjc-delivery
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'automate'

user_name = node['demo']['users']['admin']['first']
user_pass = node['demo']['users']['admin']['password']
api_uri = "https://#{node['bjc']['api_host']}/api/v0/e/#{node['bjc']['ent_name']}"

# bash 'create-project' do
#   code <<-EOH
#   #!/bin/bash
#   export API_TOKEN
#   API_TOKEN=$(curl -X POST #{api_uri}/users/#{user_name}/get-token -v -k -H 'Content-Type: application/json' -d '{ "username": "#{user_name}", "password": "#{user_pass}" }' | jq -r '.token')
#   curl -X POST #{api_uri}/orgs -v -k -H 'Content-Type: application/json' -H 'chef-delivery-user: '#{user_name}'' -H 'chef-delivery-token: '$API_TOKEN'' -d '{ "name": "#{node['bjc']['org']}" }'
#   curl -X POST #{api_uri}/orgs/#{node['bjc']['org']}/projects -v -k -H 'Content-Type: application/json' -H 'chef-delivery-user: '#{user_name}'' -H 'chef-delivery-token: '$API_TOKEN'' -d '{ "name": "#{node['bjc']['project']}" }'
#   EOH
# end

cookbook_file '/tmp/delivery_backup.tar' do
  source 'delivery_backup.tar'
  notifies :run, 'execute[restore backup data into automate]'
  checksum '65bdf7ba0597337fe7ea1e9371b8047e43bb37b26f387368c9bad811cf6827ec'
end

execute 'restore backup data into automate' do
  command 'delivery-ctl restore-data -b /tmp/delivery_backup.tar --no-confirm'
  notifies :restart, 'omnibus_service[ ]'
  action :nothing
end

omnibus_service ' ' do
  ctl_command 'delivery-ctl'
  action :nothing
end


# # Clone project cookbooks
# # Stage GitHub Deploy Key
# cookbook_file "#{Chef::Config['file_cache_path']}/bjc-deploy.key" do
#   source 'bjc-deploy.key'
# end
#
# # Stage Git SSH Wrapper
# file "#{Chef::Config['file_cache_path']}/git_wrapper.sh" do
#   content "#!/bin/sh\nexec /usr/bin/ssh -i #{Chef::Config['file_cache_path']}/bjc-deploy.key \"$@\""
# end
#
# # Get 'site-config' Cookbook
# git "#{Chef::Config['file_cache_path']}/project/#{default['bjc']['project']}" do
#   repository node['bjc']['applications'][project]['git_url']
#   ssh_wrapper "#{Chef::Config['file_cache_path']}/git_wrapper.sh"
# end
#
# # Create the project on the delivery server
# execute "Initializing #{default['bjc']['project']} Project" do
#   cwd "#{Chef::Config['file_cache_path']}/project/#{default['bjc']['project']}"
#   command "delivery init --org=#{node['bjc']['org']}"
#   ignore_failure true
# end
