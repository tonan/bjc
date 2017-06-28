default['push_jobs']['allow_unencrypted'] = true
default['audit']['reporter'] = 'chef-server-automate'

default['audit']['profiles'] = [
  {
    name: 'Planet Express SSL',
    url: 'https://github.com/ChefRycar/planetexpress-ssl/archive/3.0.1.tar.gz'
  }
]
