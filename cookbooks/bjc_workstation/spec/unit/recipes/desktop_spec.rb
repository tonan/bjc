#
# Cookbook Name:: bjc_workstation
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

home = Dir.home

describe 'bjc_workstation::desktop' do
  context 'When all attributes are default, on Windows Server 2012R2 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'creates the demo startup script' do
      expect(chef_run).to render_file("#{home}\\Start_Demo.ps1").with_content('C:\Program Files (x86)\Google\Chrome\Application\chrome.exe')
    end

    it 'removes the EC2 shortcuts' do
      expect(chef_run).to delete_file("#{home}/Desktop/EC2 Feedback.website")
      expect(chef_run).to delete_file("#{home}/Desktop/EC2 Microsoft Windows Guide.website")
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
