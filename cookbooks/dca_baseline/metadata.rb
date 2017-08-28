name 'dca_baseline'
maintainer 'Nick Rycar'
maintainer_email 'nrycar@chef.io'
license 'All Rights Reserved'
description 'Installs/Configures dca_baseline'
long_description 'Installs/Configures dca_baseline'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/dca_baseline/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/dca_baseline'

depends 'audit'
depends 'os-hardening'
depends 'bjc-ecommerce'
