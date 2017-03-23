#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'aws-sdk'

# Only run in the Union phase
if ['union'].include?(node['delivery']['change']['stage'])
  ruby_block 'Delete acceptance demo stack' do
    block do
      stack = Aws::CloudFormation::Client.new(region:'us-west-2')
      stack.delete_stack({
        stack_name: "acceptance-bjc-demo"
      })
    end
  end
end
