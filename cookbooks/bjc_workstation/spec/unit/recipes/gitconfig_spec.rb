#
# Cookbook Name:: bjc_workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

home = Dir.home

describe 'bjc_workstation::gitconfig' do
  context 'When all attributes are default, on Windows Server 2012R2 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    it 'creates the .gitconfig file' do
      expect(chef_run).to render_file("#{home}/.gitconfig")
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
