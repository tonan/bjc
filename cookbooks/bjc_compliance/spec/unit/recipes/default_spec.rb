#
# Cookbook Name:: bjc_compliance
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_compliance::default' do
  context 'When all attributes are default, on Ubuntu 14.04 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'includes required recipes for setup' do
      expect(chef_run).to include_recipe('compliance::default')
      expect(chef_run).to include_recipe('bjc_compliance::restore_backup')
      expect(chef_run).to include_recipe('bjc_compliance::load_profiles')
      expect(chef_run).to include_recipe('wombat::authorized-keys')
      expect(chef_run).to include_recipe('wombat::etc-hosts')
    end

    it 'renders the chef gate compliance secret' do
      expect(chef_run).to render_file('/opt/chef-compliance/sv/core/env/CHEF_GATE_COMPLIANCE_SECRET')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
