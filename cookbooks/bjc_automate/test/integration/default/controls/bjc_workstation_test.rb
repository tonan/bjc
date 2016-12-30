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

control 'bjc-automate-listenports' do
  title 'RDP is listening on port 443'
  describe port(443) do
    it { should be_listening }
  end
end

control 'bjc-automate-configfiles' do
  title 'Config files and directories are set up correctly'
  describe file('/var/opt/delivery/backups') do
    it { should be_directory }
  end
  describe file('/var/opt/delivery/backups/chef-automate-backup.zst') do
    it { should be_file }
  end
end
