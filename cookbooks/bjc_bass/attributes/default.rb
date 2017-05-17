default['push_jobs']['allow_unencrypted'] = true
default['audit']['collector'] = 'chef-visibility'

# Currently pinned to version 1.19.2 due to a bug discovered in > 1.20.0
# Issue: https://github.com/dev-sec/ssl-baseline/issues/12
default['audit']['inspec_version'] = '1.19.2'

default['audit']['profiles'] = [
  {
    name: 'admin/ssl-benchmark',
    url: 'https://github.com/dev-sec/ssl-baseline/archive/v1.1.1.tar.gz'
  }
]
