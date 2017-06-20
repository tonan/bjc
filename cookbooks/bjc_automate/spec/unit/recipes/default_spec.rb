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
      stub_command("delivery-ctl list-users mammals | grep automate").and_return(true)
      stub_command("delivery-ctl list-users mammals | grep workstation-1").and_return(true)
    end

    it 'includes required recipes from other cookbooks' do
      expect(chef_run).to include_recipe('automate::default')
      expect(chef_run).to include_recipe('wombat::authorized-keys')
      # etc-hosts recipe moved to either .kitchen.yml or Packer template
      # expect(chef_run).to include_recipe('wombat::etc-hosts')
    end

    it 'creates the chef-automate-backup.zst file' do
      expect(chef_run).to create_cookbook_file('/var/opt/delivery/backups/chef-automate-backup.zst')
    end

    it 'runs the restore backup command' do
      expect(chef_run).to_not run_execute('automate-ctl restore-backup chef-automate-backup.zst --force')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
