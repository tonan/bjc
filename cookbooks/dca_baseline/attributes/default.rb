default['audit']['fetcher'] = 'chef-automate'
default['audit']['reporter'] = 'chef-automate'

case node['os']
when 'linux'
  default['audit']['profiles'] = [
    {
      name: 'Linux Baseline',
      compliance: 'leela/linux_baseline_wrapper',
    },
  ]
when 'windows'
  default['audit']['profiles'] = [
    {
      name: 'Windows Baseline',
      compliance: 'leela/windows_baseline_wrapper',
    },
  ]
end

default['bjc-ecommerce']['company-name'] = '&#128640; Planet Express (with Chef!) &#128640;'
