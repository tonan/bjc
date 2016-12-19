# encoding: utf-8
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# author: Sean Carolan

control 'bjc-listenports' do
  title 'RDP is listening on port 3389'
  describe port(3389) do
    it { should be_listening }
    its('processes') {should include 'TermService'}
  end
end

control 'bjc-packages' do
  title 'Required packages are installed'
  packages = [
    'Atom',
    'Microsoft Visual Studio Code',
    'Chef Client v12.15.19',
    'Chef Development Kit v0.16.28',
    'Git Extensions 2.48.05',
    'Git version 2.10.2',
    'Google Chrome',
    'Microsoft Git Credential Manager for Windows 1.5.0'
  ]

  packages.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end

  describe command('choco list putty') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end

end

control 'bjc-configfiles' do
  title 'Config files are set up correctly'
  describe file('C:\tools\cmder\config\ConEmu.xml') do
    it { should be_file }
  end
  describe file('C:\Users\Administrator\.gitconfig') do
    it { should be_file }
    its('content') { should match('automate-demo.com')}
  end
  describe file('C:\Users\Administrator\.delivery\cli.toml') do
    it { should be_file }
    its('content') { should match('automate.automate-demo.com')}
  end
  describe file('C:\Users\Administrator\.berkshelf\config.json') do
    it { should be_file }
    its('content') { should match('{"ssl": {"verify": false}}')}
  end
  describe file('C:\Users\Administrator\cookbooks\bjc-ecommerce\.kitchen.yml') do
    it { should be_file }
    its('content') { should match('sg-2560a741')}
  end
  describe file('C:\Users\Administrator\Desktop\Test_Kitchen\kitchen_windows.yml') do
    it { should be_file }
    its('content') { should match('sg-2560a741')}
  end
  describe file('C:\Users\Administrator\Desktop\Test_Kitchen\kitchen_linux.yml') do
    it { should be_file }
    its('content') { should match('sg-2560a741')}
  end
  describe file('C:\Users\Administrator\user_data') do
    it { should be_file }
    its('content') { should match('Defaults:centos !requiretty')}
  end
  describe file('C:\Users\Administrator\Start_Demo.ps1') do
    it { should be_file }
    its('content') { should match('Restart the jankmobile')}
  end
  describe file('C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default\Bookmarks') do
    it { should be_file }
    its('content') { should match('delivered.automate-demo.com')}
  end
  describe file('C:\Users\Administrator\.ssh\id_rsa.ppk') do
    it { should be_file }
    its('content') { should match('g4wKcFFd9aO0dA')}
  end
end

control "bjc-cookbooks" do
  title "Required cookbooks are downloaded from S3"
  cookbooks = %w(bjc-ecommerce.zip bjc_bass.zip bjc-web-base.zip)
  cookbooks.each do |cb|
    describe file("C:\\Users\\Administrator\\cookbooks\\#{cb}") do
      it { should be_file }
    end
  end
end
