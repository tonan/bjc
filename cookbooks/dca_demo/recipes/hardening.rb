# Triggers recipes in either of the hardening wrapper cookbooks
# based on node OS. These wrap the Supermarket os-hardening and
# windows-hardening cookbooks, and add extra functionality where
# required.

if node['os'] == 'linux'
  include_recipe 'dca_hardening_linux::default'
elsif node['os'] == 'windows'
  include_recipe 'dca_hardening_windows::default'
end
