#
# Cookbook Name:: bjc_automate
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_automate::default' do
  context 'When all attributes are default, on Ubuntu 14.04 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("delivery-ctl list-enterprises | grep mammals").and_return(true)
    end

    it 'includes required recipes from other cookbooks' do
      expect(chef_run).to include_recipe('automate::default')
      expect(chef_run).to include_recipe('wombat::authorized-keys')
      expect(chef_run).to include_recipe('wombat::etc-hosts')
    end

    it 'creates the delivery_backup tar file' do
      expect(chef_run).to create_cookbook_file('/tmp/delivery_backup.tar')
    end

    it 'runs the restore backup command' do
      expect(chef_run).to_not run_execute('delivery-ctl restore-data -b /tmp/delivery_backup.tar --no-confirm')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
