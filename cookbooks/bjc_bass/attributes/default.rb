default['push_jobs']['allow_unencrypted'] = true
default['audit']['collector'] = 'chef-visibility'
default['audit']['profiles'] = [
  {
    name: 'admin/ssl-benchmark',
    git: 'https://github.com/dev-sec/ssl-baseline.git'
  }
]
