default['push_jobs']['allow_unencrypted'] = true
default['audit']['collector'] = 'chef-visibility'
default['audit']['profiles'] = [
  {
    name: 'admin/ssl-benchmark',
    url: 'https://github.com/dev-sec/ssl-baseline/archive/master.zip'
  }
]
