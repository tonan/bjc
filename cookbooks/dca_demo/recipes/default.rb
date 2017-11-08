#
# Cookbook:: dca_demo
# Recipe:: default
#
# Copyright:: 2017, Nick Rycar, All Rights Reserved.

# For demonstration, recipes will typically be added individually
# to highlight the detect, correct, automate cycle.
# Enabling the default recipe, however, will pull in the changes
# from all three recipes, if you need a quick way to trigger the
# end state of the demo.

include_recipe 'dca_demo::audit'
include_recipe 'dca_demo::hardening'
include_recipe 'dca_demo::install_site'
