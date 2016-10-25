#
# Cookbook Name:: bjc_infranodes
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_infranodes::default' do
  context 'When all attributes are default, on Ubuntu 14.04 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'includes the infranodes recipe' do
      expect(chef_run).to include_recipe('infranodes')
    end

    it 'renders the /etc/rc.local template' do
      expect(chef_run).to render_file('/etc/rc.local').with_content('Waiting for Chef Server to be available')
    end

    it 'includes the wombat authorized-keys and etc-hosts recipes' do
      expect(chef_run).to include_recipe('wombat::authorized-keys')
      expect(chef_run).to include_recipe('wombat::etc-hosts')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
