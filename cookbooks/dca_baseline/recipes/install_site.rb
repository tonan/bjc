case node['os']
when 'linux'
  include_recipe 'bjc-ecommerce::tksetup'
  include_recipe 'bjc-ecommerce::default'
end
