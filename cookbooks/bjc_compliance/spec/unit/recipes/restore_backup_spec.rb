#
# Cookbook Name:: bjc_compliance
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_compliance::restore_backup' do
  context 'When all attributes are default, on Ubuntu 14.04 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'creates the backup .sql dump file' do
      expect(chef_run).to render_file("#{Chef::Config[:file_cache_path]}/compliance_backup.sql")
    end

    it 'executes the psql restore command' do
      expect(chef_run).to run_execute("/opt/chef-compliance/embedded/bin/psql -q chef_compliance < #{Chef::Config[:file_cache_path]}/compliance_backup.sql")
    end

    it 'waits for compliance to get its act together' do
      expect(chef_run).to run_ruby_block('Wait for compliance to get its act together')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
