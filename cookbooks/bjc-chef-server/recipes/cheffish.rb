#
# Cookbook Name:: bjc-chef-server
# Recipe:: cheffish
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'cheffish'
# there is only zuul
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

config = {
  :chef_server_url => 'https://chef-server',
  :options => {
    :client_name => 'pivotal',
    :signing_key_filename => '/etc/opscode/pivotal.pem',
    :ssl_verify_mode => :verify_none
  }
}

conf_with_org = config.merge({
  :chef_server_url => "#{config[:chef_server_url]}/organizations/#{node['demo']['org']}"
})

%w( acceptance-automate-demo-automate-site-config-master
	union
	rehearsal
	delivered).each do |e|
  chef_environment e do
  	description "#{node['demo']['org']} #{e} environment"
#  	cookbook_versions [ "site-config" => "0.2.1" ]
  end
end
