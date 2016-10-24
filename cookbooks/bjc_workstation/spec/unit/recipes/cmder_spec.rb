#
# Cookbook Name:: bjc_workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_workstation::cmder' do
  context 'When all attributes are default, on Windows Server 2012R2 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'renders the cmder config file' do
      expect(chef_run).to render_file('C:\tools\cmder\config\ConEmu.xml').with_content('<key name="ConEmu">')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
