#
# Cookbook Name:: bjc_workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'bjc_workstation::browser' do
  context 'When all attributes are default, on Windows Server 2012R2 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    before do
      allow(Dir).to receive(:home).and_return('C:\Users\Administrator')
    end

    it 'creates the Chrome bookmarks directory' do
      expect(chef_run).to create_directory('C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default')
    end

    it 'renders the Chrome bookmarks file' do
      expect(chef_run).to render_file('C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default\Bookmarks')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
