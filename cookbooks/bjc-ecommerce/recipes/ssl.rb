#
# Cookbook Name:: bjc-ecommerce
# Recipe:: ssl
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Enables SSL and mod_jk

home = Dir.home

file "/etc/ssl/private/#{node['hostname']}.automate-demo.com.key" do
  content lazy { IO.read("/#{home}/#{node['hostname']}.key") }
  action :create
  sensitive true
end

file "/etc/ssl/certs/#{node['hostname']}.automate-demo.com.crt" do
  content lazy { IO.read("/#{home}/#{node['hostname']}.crt") }
  action :create
  sensitive true
end

package 'apache2'

package 'libapache2-mod-jk'

execute 'a2enmod jk'

execute 'a2enmod ssl'

execute 'a2ensite default-ssl'

service 'tomcat7' do
  action :nothing
end

service 'apache2' do
  action :nothing
end

template '/etc/apache2/sites-available/default-ssl.conf' do
  action :create
  source 'default-ssl.conf.erb'
  notifies :restart, 'service[apache2]', :immediately
end

template '/etc/libapache2-mod-jk/workers.properties' do
  action :create
  source 'workers.properties.erb'
  notifies :restart, 'service[apache2]'
end

template '/etc/tomcat7/server.xml' do
  action :create
  source 'server.xml.erb'
  notifies :restart, 'service[tomcat7]'
end
