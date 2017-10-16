#
# Cookbook Name:: bjc_workstation
# Recipe:: dca
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Set up the necessary files and scriptes for Detect, Correct, Automate.

directory "#{home}/dca" do
  action :create
end

cookbook_file "#{home}/dca/linux_baseline_wrapper-0.1.0.tar.gz" do
  source 'linux_baseline_wrapper-0.1.0.tar.gz'
  mode '0644'
end

cookbook_file "#{home}\\Start_DCA.ps1" do
  action :create
  source "Start_DCA.ps1"
end

cookbook_file "#{home}\\Start_Correct.ps1" do
  action :create
  source "Start_Correct.ps1"
end

cookbook_file "#{home}\\Finish_DCA.ps1" do
  action :create
  source "Finish_DCA.ps1"
end

cookbook_file "#{home}\\dca\\DCA_functions.ps1" do
  action :create
  source 'DCA_functions.ps1'
end

cookbook_file "#{home}\\dca\\DCA_email_wk1.html" do
  action :create
  source "DCA_email_wk1.html"
end

cookbook_file "#{home}\\dca\\DCA_email_wk2.html" do
  action :create
  source "DCA_email_wk2.html"
end

cookbook_file "#{home}\\dca\\DCA_email_wk3.html" do
  action :create
  source "DCA_email_wk3.html"
end
