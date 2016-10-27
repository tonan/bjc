#
# Copyright:: Copyright (c) 2015 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'delivery-truck::syntax'

ruby_block "verify_wombat_yaml" do
  block do
    require 'yaml'
    puts YAML.load_file("#{workflow_workspace_repo}/wombat.yml")
  end
end

ruby_block "verify_packer_templates" do
  block do
    require 'json'
    templates = Dir.glob("#{workflow_workspace_repo}/packer/*.json")
    templates.each do |t|
      puts JSON(File.read(t))
    end
  end
end
