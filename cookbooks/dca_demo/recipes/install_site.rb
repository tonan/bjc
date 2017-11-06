# Installs the Planet Express application on linux systems.
# A windows analog is planned to follow shortly.

if node['os'] == 'linux'
  include_recipe 'bjc-ecommerce::tksetup'
  include_recipe 'bjc-ecommerce::default'
end
