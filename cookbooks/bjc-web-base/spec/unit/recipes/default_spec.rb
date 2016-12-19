#
# Cookbook Name:: bjc-web-base
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc-web-base::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |_node, server|
        stub_command("test -f /etc/ssl/certs/#{node['hostname']}.automate-demo.com.crt").and_return(false)
        stub_command("test -f /home/ubuntu/#{node['hostname']}.automate-demo.com.crt").and_return(false)        
      end.converge(described_recipe)
    end
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
