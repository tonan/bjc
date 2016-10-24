#
# Cookbook Name:: bjc_chef_server
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

home = Dir.home

describe 'bjc_chef_server::content' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04')
      # runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'installs the unzip and git packages' do
      expect(chef_run).to install_package('unzip')
      expect(chef_run).to install_package('git')
    end

    it 'includes the build-essential default recipe' do
      expect(chef_run).to include_recipe('build-essential')
    end

    it 'creates the .chef and cookbooks directories' do
      expect(chef_run).to create_directory("#{home}/.chef")
      expect(chef_run).to create_directory("#{home}/cookbooks")
    end

    it 'renders the chef config.rb file' do
      expect(chef_run).to render_file("#{home}/.chef/config.rb").with_content("#{home}/cookbooks")
    end

    it 'runs berks install and upload for site-config' do
      expect(chef_run).to run_execute('berks install site-config')
      expect(chef_run).to run_execute('berks upload site-config')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
