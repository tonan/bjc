#
# Cookbook Name:: bjc_workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

home = Dir.home

describe 'bjc_workstation::cookbooks' do
  context 'When all attributes are default, on Windows Server 2012R2 platform' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node|
        node.normal['bjc_workstation']['cookbooks'] = ['bjc-ecommerce', 'bjc_bass', 'bjc-web-base']
      end.converge(described_recipe)
    end

    it 'creates the cookbooks directory' do
      expect(chef_run).to create_directory("#{home}/cookbooks")
    end

    it 'creates the .kitchen.yml file for bjc-ecommerce' do
      expect(chef_run).to render_file("#{home}/cookbooks/bjc-ecommerce/.kitchen.yml").with_content('sg-2560a741')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
