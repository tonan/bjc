#
# Cookbook Name:: bjc_chef_server
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_chef_server::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04')
      # runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'includes the chef_server and other recipes' do
      # default throws some warnings due to an issue in the upstream cookbook
      expect(chef_run).to include_recipe('chef_server::default')
      expect(chef_run).to include_recipe('bjc_chef_server::content')
      expect(chef_run).to include_recipe('bjc_chef_server::chef_gate')
      expect(chef_run).to include_recipe('wombat::authorized-keys')
      expect(chef_run).to include_recipe('wombat::etc-hosts')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
