#
# Cookbook Name:: bjc_workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_workstation::environment' do
  context 'When all attributes are default, on Windows Server 2012R2 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    it 'creates the putty PPK file' do
      expect(chef_run).to render_file("#{home}/.ssh/id_rsa.ppk")
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
