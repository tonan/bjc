default['audit']['fetcher'] = 'chef-automate'
default['audit']['reporter'] = 'chef-automate'

if node['os'] == 'linux'
  default['audit']['profiles'] = [
    {
      name: 'Linux Baseline',
      compliance: 'leela/linux_baseline_wrapper',
    },
  ]
elsif node['os'] == 'windows'
  default['audit']['profiles'] = [
    {
      name: 'Windows Baseline',
      compliance: 'leela/windows_baseline_wrapper',
    },
  ]
end
