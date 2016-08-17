require 'yaml'
require 'erb'
require 'json'

namespace :cookbook do
  desc 'Vendor cookbooks for a template'
  task :vendor, :template do |_t, args|
    # As new cookbooks are created, the has_cookbook array will need to be updated.
    has_cookbook = %w(bjc_infranodes bjc_build_node bjc-compliance bjc-workstation bjc-chef-server bjc-delivery bjc-compliance)
    base = args[:template].split('.json')[0]
    if has_cookbook.any? { |t| args[:template].include? t }
      sh "rm -rf vendored-cookbooks/#{base}"
      sh "berks vendor -b cookbooks/#{base}/Berksfile vendored-cookbooks/#{base}"
    else
      puts 'No cookbooks - not vendoring'
    end
  end
end

namespace :packer do

  desc 'Build an AMI. Syntax: rake packer:build_ami[TEMPLATE-NAME]'
  task :build_ami, :template do |_t, args|
    Rake::Task['cookbook:vendor'].invoke(args[:template])
    Rake::Task['cookbook:vendor'].reenable
    sh packer_build(args[:template], 'amazon-ebs')
  end

  desc 'Build all build-nodes AMIs'
  task :build_builders do
    Rake::Task['cookbook:vendor'].invoke('bjc_build_node')
    Rake::Task['cookbook:vendor'].reenable
    build_nodes.each do |name, num|
      sh packer_build('bjc-build-node', 'amazon-ebs', {'node-number' => num})
    end
  end

  desc 'Build all infranodes listed in wombat.yml'
  task :build_infra do
    Rake::Task['cookbook:vendor'].invoke('bjc_infranodes')
    Rake::Task['cookbook:vendor'].reenable
    unless infranodes.nil?
      infranodes.each do |name, _rl|
        sh packer_build('bjc-infranodes', 'amazon-ebs', {'node-name' => name})
      end
    else
      puts 'No infranodes to build!'
    end
  end

  desc 'Build all AMIs from a wombat lock file.'
  task :build_amis do
    templates.each do |template|
      Rake::Task['packer:build_ami'].invoke("#{template}")
      Rake::Task['packer:build_ami'].reenable
    end
  end

end

namespace :cfn do
  desc 'Generate Cloud Formation Template'
  task :create_template do
    puts 'Generating CloudFormation template from lockfile'
    region = wombat_lock['aws']['region']
    @chef_server_ami = wombat_lock['amis'][region]['chef-server']
    @delivery_ami = wombat_lock['amis'][region]['delivery']
    @compliance_ami = wombat_lock['amis'][region]['compliance']
    @build_nodes = wombat_lock['build-nodes'].to_i
    @build_node_ami = {}
    1.upto(@build_nodes) do |i|
      @build_node_ami[i] = wombat_lock['amis'][region]['build-node'][i.to_s]
    end
    @infra = {}
    infranodes.each do |name, _rl|
      @infra[name] = wombat_lock['amis'][region]['infranodes'][name]
    end
    @workstation_ami = wombat_lock['amis'][region]['workstation']
    @availability_zone = wombat_lock['aws']['az']
    @demo = wombat_lock['name']
    @version = wombat_lock['version']
    rendered_cfn = ERB.new(File.read('cloudformation/cfn.json.erb'), nil, '-').result
    File.open("cloudformation/#{@demo}.json", 'w') { |file| file.puts rendered_cfn }
    puts "Generated cloudformation/#{@demo}.json"
  end

  desc 'Deploy a CloudFormation Stack from template'
  task :deploy_stack do
    sh create_stack(wombat_lock['name'], wombat_lock['aws']['region'], wombat_lock['aws']['keypair'])
  end

  desc 'Build AMIs, update lockfile, and create CFN template'
  task do_all: ['packer:build_amis', 'update_lock', 'cfn:create_template']
end

def create_stack(stack, region, keypair)
  template_file = "file://#{File.dirname(__FILE__)}/cloudformation/#{stack}.json"
  timestamp = Time.now.gmtime.strftime('%Y%m%d%H%M%S')
  cmd = %w(aws cloudformation create-stack)
  cmd.insert(3, "--template-body \"#{template_file}\"")
  cmd.insert(3, "--parameters ParameterKey='KeyName',ParameterValue='#{keypair}'")
  cmd.insert(3, "--region #{region}")
  cmd.insert(3, "--stack-name #{ENV['USER']}-#{stack}-#{timestamp}")
  cmd.join(' ')
end

def infranodes
  unless wombat_lock['infranodes'].empty?
    wombat_lock['infranodes'].sort
  else
    {}
  end
end

def wombat_lock
  JSON(File.read('wombat.lock'))
end

def source_ami_from_lock(ami)
  region = wombat_lock['aws']['region']
  wombat_lock['amis'][region][ami]
end

def packer_build(template, builder, options={})
  create_infranodes_json
    if template == 'bjc-build-node'
     log_name = "build-node-#{options['node-number']}"
  elsif template == 'workstation'
     log_name = "workstation-#{options['workstation-number']}"
  elsif template == 'bjc_infranodes'
     log_name = "infranodes-#{options['node-name']}"
  else
     log_name = template
  end

  ami_name = template.split('-', 2)[1]
#  source_ami = source_ami_from_lock(ami_name)
# disabling this because I always want to build from a clean AMI
  if template == 'bjc-workstation'
    source_ami = wombat_lock['aws']['source_ami']['windows']
  else
    source_ami = wombat_lock['aws']['source_ami']['ubuntu']
  end
  log_name = template

  if ENV['AWS_REGION']
    puts "Region set by environment: #{ENV['AWS_REGION']}"
  else
    puts "$AWS_REGION not set, setting to #{wombat['aws']['region']}"
    ENV['AWS_REGION'] = wombat['aws']['region']
  end

  cmd = %W(packer build packer/#{template}.json | tee packer/logs/ami-#{log_name}.log)
  cmd.insert(2, "--only #{builder}")
  cmd.insert(2, "--var org=#{wombat_lock['org']}")
  cmd.insert(2, "--var domain=#{wombat_lock['domain']}")
  cmd.insert(2, "--var domain_prefix=#{wombat_lock['domain_prefix']}")
  cmd.insert(2, "--var enterprise=#{wombat_lock['enterprise']}")
  cmd.insert(2, "--var chefdk=#{wombat_lock['products']['chefdk']}")
  cmd.insert(2, "--var chef_ver=#{wombat_lock['products']['chef'].split('-')[1]}")
  cmd.insert(2, "--var chef_channel=#{wombat_lock['products']['chef'].split('-')[0]}")
  cmd.insert(2, "--var delivery=#{wombat_lock['products']['delivery']}")
  cmd.insert(2, "--var compliance=#{wombat_lock['products']['compliance']}")
  cmd.insert(2, "--var chef-server=#{wombat_lock['products']['chef-server']}")
  cmd.insert(2, "--var node-name=#{options['node-name']}") if template =~ /bjc-infranodes/
  cmd.insert(2, "--var node-number=#{options['node-number']}") if template =~ /bjc-build-node/
  cmd.insert(2, "--var build-nodes=#{wombat_lock['build-nodes']}")
  cmd.insert(2, "--var workstation-number=#{options['workstation-number']}") if template =~ /bjc-workstation/
  cmd.insert(2, "--var workstations=#{wombat_lock['workstations']}")
  cmd.insert(2, "--var source_ami=#{source_ami}")
  cmd.join(' ')
end

def templates
  %w(bjc-compliance bjc-chef-server bjc-delivery bjc-workstation)
end

def create_infranodes_json
  if File.exists?('packer/file/infranodes-info.json')
    current_state = JSON(File.read('files/infranodes-info.json'))
  else
    current_state = nil
  end
  return if current_state == infranodes # yay idempotence
  File.open('packer/files/infranodes-info.json', 'w') do |f|
    f.puts JSON.pretty_generate(infranodes)
  end
end

def build_nodes
  build_nodes = {}
  1.upto(wombat_lock['build-nodes'].to_i) do |i|
    build_nodes["build-node-#{i}"] = i
  end
  build_nodes
end
