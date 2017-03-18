#
# Cookbook Name:: bjc_workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_workstation::editors' do
  context 'When all attributes are default, on Windows Server 2012R2 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'installs Visual Studio Code' do
      expect(chef_run).to install_chocolatey_package('visualstudiocode')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
