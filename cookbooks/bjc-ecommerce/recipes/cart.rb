#
# Cookbook Name:: bjc-ecommerce
# Recipe:: cart
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Why not use remote_file you ask?  Because it's buggy and throws this error:
# Encoding::UndefinedConversionError
# ----------------------------------
# "\x9A" from ASCII-8BIT to UTF-8

# remote_file "#{Chef::Config['file_cache_path']}/softslate-3.3.5.war" do
#  action :create
#  source 'https://www.softslate.com/distributions/community/3.3.5/softslate-3.3.5.war'
# end

execute "Download Shopping Cart" do
  command "wget -O #{Chef::Config['file_cache_path']}/softslate-3.3.5.war https://www.softslate.com/distributions/community/3.3.5/softslate-3.3.5.war"
  action :run
end

execute "Install Shopping Cart" do
  command "cp #{Chef::Config['file_cache_path']}/softslate-3.3.5.war /var/lib/tomcat7/webapps/cart.war"
  action :run
  not_if { File.exist?("/var/lib/tomcat7/webapps/cart.war") }
end

ruby_block "Sleep my pretty..." do
  block do
    sleep(60)
  end
end

basedir = '/var/lib/tomcat7/webapps/cart/WEB-INF'

directory "#{basedir}/src" do
  action :create
end

directory "#{basedir}/classes" do
  action :create
end

%w(appSettings hibernate log4j).each do |f|
  template "#{basedir}/src/#{f}.properties" do
    source "src/#{f}.properties.erb"
    action :create
  end
end

%w(appSettings hibernate log4j).each do |f|
  template "#{basedir}/classes/#{f}.properties" do
    source "classes/#{f}.properties.erb"
    action :create
  end
end

template "#{Chef::Config['file_cache_path']}/backup.sql" do
  action :create
  source 'backup.sql.erb'
end

execute "Restore database backup" do
  command "mysql -u root softslate < #{Chef::Config['file_cache_path']}/backup.sql"
  action :run
  not_if "echo 'show tables;' | mysql -u root softslate | grep sscProductSetting"
end

%w(f73e89fd.0 sdk-seller.p12 twoWay.key).each do |f|
  cookbook_file "/var/lib/tomcat7/webapps/cart/WEB-INF/conf/keys/#{f}" do
    action :create
    source f
  end
end

service 'tomcat7' do
  action :restart
end


