#
# Cookbook Name:: bjc_compliance
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

# Current list of profiles that we load into the demo
profiles = %w(
  apache.tar.gz
  cis-apachetomcat-5_5-6_0-level1.tar.gz
  cis-apachetomcat-5_5-6_0-level2.tar.gz
  cis-microsoftwindows2012r2-level1-memberserver.tar.gz
  ssl-benchmark.zip
  stig-redhat.zip
)

describe 'bjc_compliance::load_profiles' do
  context 'When all attributes are default, on Ubuntu 14.04 platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'loads the chef compliance profiles' do
	    profiles.each do |p|
        expect(chef_run).to render_file("/home/ubuntu/#{p}")
      end
    end

    it 'renders the upload_profiles.sh script' do
      expect(chef_run).to render_file('/home/ubuntu/upload_profiles.sh').with_content('Authorization: Bearer $API_TOKEN"')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
