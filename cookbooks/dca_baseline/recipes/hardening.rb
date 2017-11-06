if node['os'] == 'linux'
  include_recipe 'os-hardening'
elsif node['os'] == 'windows'
  include_recipe 'windows-hardening'
end
