#
# Cookbook Name:: bjc_chef_server
# Recipe:: chef_gate
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

remote_file '/tmp/chef-gate-latest.deb' do
  source 'https://s3-us-west-2.amazonaws.com/bjcpublic/chef-gate-latest.deb'
  checksum '778bd4aab9ac5a0d79c97f814ffa10551aa71971fa14936cbfbb43cf4c51fc88'
end

append_if_no_line "Add temporary hostsfile entry: #{node['ipaddress']}" do
  path "/etc/hosts"
  line "#{node['ipaddress']} #{node['demo']['domain_prefix']}chef.#{node['demo']['domain']} chef"
end

dpkg_package 'chef-gate' do
  action :install
  source '/tmp/chef-gate-latest.deb'
end

chef_ingredient 'chef-server' do
  action :reconfigure
  config <<-EOS

data_collector['root_url'] = 'https://#{node['demo']['domain_prefix']}automate.#{node['demo']['domain']}/data-collector/v0/'
data_collector['token'] = '93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'
oc_id['applications'] ||= {}
oc_id['applications']['chef_gate'] = {
     'redirect_uri' => 'https://#{node['demo']['domain_prefix']}compliance.#{node['demo']['domain']}/auth/oc_id/callback'
}
oc_id['administrators'] = ['admin']
EOS
end

file '/var/opt/opscode/nginx/etc/addon.d/50_compliance_upstreams.conf' do
	content <<-EOS
#
# Chef Compliance upstream definition
#
upstream compliance {
     server #{node['demo']['domain_prefix']}compliance.#{node['demo']['domain']}:443; # for compliance behind its nginx (incl. TLS)
}
EOS
end

omnibus_service 'chef-server/nginx' do
	action :stop
end

{	CHEF_GATE_CHEF_SERVER_URL: "https://#{node['demo']['domain_prefix']}chef.#{node['demo']['domain']}",
	CHEF_GATE_OIDC_ISSUER_URL: "https://#{node['demo']['domain_prefix']}compliance.#{node['demo']['domain']}",
	CHEF_GATE_OIDC_CLIENT_ID: "" #THIS WILL BE SET AT BJC LAUNCH BY THE WORKSTATION
	}.each do | door, key |
  file "/opt/opscode/sv/chef_gate/env/#{door}" do
    content key
  end
end

file '/opt/opscode/sv/chef_gate/env/CHEF_GATE_COMPLIANCE_SECRET' do
	content lazy { IO.read('/tmp/public.pub') }
	sensitive true
end

#STOPPING CHEF_GATE UNTIL CHEF_GATE_OIDC_CLIENT_ID IS GRABBED AT LAUNCH OF BJC BY THE WORKSTASTION
bash 'stop chef-gate' do
  code '/opt/opscode/embedded/bin/sv stop chef_gate'
end

delete_lines "Remove temporary hostfile entry we added earlier" do
  path "/etc/hosts"
  pattern "^#{node['ipaddress']}.*#{node['demo']['domain_prefix']}chef\.#{node['demo']['domain']}.*chef"
end
