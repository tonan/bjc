require 'yaml'
require 'erb'
require 'json'

namespace :cookbook do
  desc 'Vendor cookbooks for a template'
  task :vendor, :template do |_t, args|
    # As new cookbooks are created, the has_cookbook array will need to be updated.
    has_cookbook = %w(bjc-compliance bjc-workstation bjc-chef-server bjc-delivery bjc-compliance)
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

  desc 'Build all AMIs from a wombat lock file.'
  task :build_amis do
    templates.each do |template|
      Rake::Task['packer:build_ami'].invoke("#{template}")
      Rake::Task['packer:build_ami'].reenable
    end
  end

end

def wombat_lock
  JSON(File.read('wombat.lock'))
end

def source_ami_from_lock(ami)
  region = wombat_lock['aws']['region']
  wombat_lock['amis'][region][ami]
end

def packer_build(template, builder)
  ami_name = template.split('-',2)[1]
  source_ami = source_ami_from_lock(ami_name)
  log_name = template

  cmd = %W(packer build packer/#{template}.json | tee packer/logs/ami-#{log_name}.log)
  cmd.insert(2, "--only #{builder}")
  cmd.insert(2, "--var org=#{wombat_lock['org']}") unless template =~ /delivery/
  cmd.insert(2, "--var domain=#{wombat_lock['domain']}")
  cmd.insert(2, "--var domain_prefix=#{wombat_lock['domain_prefix']}")
  cmd.insert(2, "--var enterprise=#{wombat_lock['enterprise']}") unless template =~ /chef-server/
  cmd.insert(2, "--var chefdk=#{wombat_lock['products']['chefdk']}") unless template =~ /chef-server/
  cmd.insert(2, "--var delivery=#{wombat_lock['products']['delivery']}") if template =~ /delivery/
  cmd.insert(2, "--var compliance=#{wombat_lock['products']['compliance']}") if template =~ /compliance/
  cmd.insert(2, "--var chef-server=#{wombat_lock['products']['chef-server']}") if template =~ /chef-server/
  cmd.insert(2, "--var source_ami=#{source_ami}")
  cmd.join(' ')
end

def templates
  %w(bjc-compliance bjc-chef-server bjc-delivery bjc-workstation)
end
