default['audit']['fetcher'] = 'chef-automate'
default['audit']['reporter'] = 'chef-automate'

default['audit']['profiles'] = [
  {
    name: 'Linux Baseline',
    compliance: 'leela/linux_baseline_wrapper',
  },
]

default['bjc-ecommerce']['company-name'] = '&#128640; Planet Express (with Chef!) &#128640;'
