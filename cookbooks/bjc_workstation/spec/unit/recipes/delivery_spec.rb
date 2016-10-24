#
# Cookbook Name:: bjc_workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

home = Dir.home

describe 'bjc_workstation::delivery' do
  context 'When all attributes are default, on Windows Server 2012R2 platform' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node|
        node.normal['demo']['domain'] = 'chef-demo.com'
      end.converge(described_recipe)
    end

    it 'creates the .delivery directory' do
      expect(chef_run).to create_directory("#{home}/.delivery")
    end

    it 'renders the cli.toml file' do
      expect(chef_run).to render_file("#{home}/.delivery/cli.toml").with_content('')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
