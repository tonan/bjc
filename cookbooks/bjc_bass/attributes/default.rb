default['push_jobs']['allow_unencrypted'] = true
default['audit']['reporter'] = 'chef-automate'

default['audit']['profiles'] = [
  {
    name: 'admin/ssl-benchmark',
    url: 'https://github.com/dev-sec/ssl-baseline/archive/v1.1.1.tar.gz'
  }
]
