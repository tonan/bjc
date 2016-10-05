#
# Cookbook Name:: bjc-ecommerce
# Recipe:: ssl
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Enables SSL and mod_jk

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
  notifies :restart, 'service[apache2]'
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

execute 'Create proper SSL cert to match hostname' do
  command "openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj \"/C=US/ST=Washington/L=Seattle/O=SA/CN=#{node['hostname']}.automate-demo.com\" -keyout /etc/ssl/private/#{node['hostname']}.automate-demo.com.key -out /etc/ssl/certs/#{node['hostname']}.automate-demo.com.crt"
  action :run
  not_if "test -f /etc/ssl/certs/#{node['hostname']}.automate-demo.com.crt"
end

execute 'Create crt file for import into Workstation' do
  #command "openssl x509 -outform der -in /etc/ssl/certs/ssl-cert-snakeoil.pem -out /home/ubuntu/#{node['hostname']}.crt"
  command "cp /etc/ssl/certs/#{node['hostname']}.automate-demo.com.crt /home/ubuntu/#{node['hostname']}.automate-demo.com.crt"
  action :run
  not_if "test -f /home/ubuntu/#{node['hostname']}.automate-demo.com.crt"
end
