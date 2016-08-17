#
# Cookbook Name:: bjc-compliance
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'compliance'

src_filename = 'apache.tar.gz'
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"

cookbook_file src_filepath do
  source src_filename
end

bash 'upload_profile' do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
  export API_URL="https://localhost/api"
  export API_TOKEN=$(curl -X POST $API_URL/login -k -s -d '{"userid": "workstation", "password": "workstation!"}')
  export AUTH="Authorization: Bearer $API_TOKEN"
  curl -X POST "$API_URL/owners/admin/compliance/apache_webserver/tar" -k -s -H "$AUTH" --data-binary "@#{src_filename}"
  EOH
  #not_if { ::File.exist?(src_filepath) }
end

include_recipe 'bjc-compliance::restore_backup'
