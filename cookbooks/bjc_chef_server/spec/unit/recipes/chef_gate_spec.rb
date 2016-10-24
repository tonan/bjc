#
# Cookbook Name:: bjc_chef_server
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_chef_server::chef_gate' do
  context 'When all attributes are default, on Ubuntu 14.04 platform' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node|
				node.normal['ipaddress'] = '192.168.13.37'
			  node.normal['demo']['domain'] = 'chef-demo.com'
      end.converge(described_recipe)
    end

    it 'stops the omnibus service' do
      expect(chef_run).to stop_omnibus_service('chef-server/nginx')
    end

    it 'runs the bash command to stop chef-gate' do
      expect(chef_run).to run_bash('stop chef-gate')
    end

    it 'deletes the temporary hostfile entry' do
      expect(chef_run).to edit_delete_lines('Remove temporary hostfile entry we added earlier')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
