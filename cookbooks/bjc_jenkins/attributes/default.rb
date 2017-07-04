default['java']['jdk_version'] = '8'
default['jenkins']['master']['install_method'] = 'package'
#default['bjc_jenkins']['plugins'] = %w(greenballs git chef-identity slack internetmeme ansicolor)
#default['bjc_jenkins']['plugins'] = %w()
#default['bjc_jenkins']['chefdk_url'] = 'https://packages.chef.io/files/stable/chefdk/1.5.0/el/7/chefdk-1.5.0-1.el7.x86_64.rpm'
default['bjc_jenkins']['chefdk_url'] = 'https://packages.chef.io/files/stable/chefdk/1.5.0/el/7/chefdk-1.5.0-1.el7.x86_64.rpm'
default['jenkins']['master']['jvm_options'] = '-Djenkins.install.runSetupWizard=false'
