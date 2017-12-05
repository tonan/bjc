#
# Cookbook:: dca_hardening_linux
# Recipe:: default
#
# Copyright:: 2017, Nick Rycar, All Rights Reserved.

# Ensure /var/log has proper ownership permissions
directory '/var/log' do
  owner 'root'
  group 'syslog'
end

# Ensure auditd package is installed
package 'auditd'

# Ensure auditd is properly configured for audit.
cookbook_file '/etc/audit/auditd.conf' do
  source 'auditd.conf'
  owner 'root'
  group 'root'
  mode '0640'
end

# Include configurations defined in the DevSec Linux Hardening cookbook.
include_recipe 'os-hardening::default'
