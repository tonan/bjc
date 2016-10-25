#
# Cookbook Name:: bjc_build_node
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_build_node::default' do
  context 'When all attributes are default, on Ubuntu 14.04 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'includes required recipes' do
      expect(chef_run).to include_recipe('build_node::default')
      expect(chef_run).to include_recipe('wombat::authorized-keys')
      expect(chef_run).to include_recipe('wombat::etc-hosts')
    end

    it 'renders the knife config file' do
      expect(chef_run).to render_file('/var/opt/delivery/workspace/.chef/knife.rb')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
