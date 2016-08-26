#
# Cookbook Name:: bjc-compliance
# Recipe:: load_apache_profile
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

src_filename = 'apache.tar.gz'
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"

cookbook_file src_filepath do
  source src_filename
end

execute 'upload_profile' do
  cwd ::File.dirname(src_filepath)
  command <<-EOH
  export API_URL="https://localhost/api"
  export API_TOKEN=$(curl -X POST $API_URL/login -k -s -d '{"userid": "workstation-1", "password": "workstation!"}')
  export AUTH="Authorization: Bearer $API_TOKEN"
  curl -X POST "$API_URL/owners/admin/compliance/apache_webserver/tar" -k -H "$AUTH" --data-binary "@#{src_filepath}"
  EOH
  #not_if { ::File.exist?(src_filepath) }
end
