case node['os']
when 'linux'
  include_recipe 'os-hardening'
when 'windows'
  include_recipe 'windows-hardening'
end
