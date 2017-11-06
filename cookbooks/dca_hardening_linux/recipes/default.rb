#
# Cookbook:: dca_hardening_linux
# Recipe:: default
#
# Copyright:: 2017, Nick Rycar, All Rights Reserved.

# Ensure /var/log has proper ownership permissions
directory '/var/log' do
  owner 'root'
  group 'root'
end

# Include configurations defined in the DevSec Linux Hardening cookbook.
include_recipe 'os-hardening::default'
