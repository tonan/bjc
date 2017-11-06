name 'dca_hardening_windows'
maintainer 'Nick Rycar'
maintainer_email 'nrycar@chef.io'
license 'All Rights Reserved'
description 'Windows Baseline Hardening'
long_description 'Updates Windows security configs per industry best practices'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'windows-hardening'

supports 'windows'
