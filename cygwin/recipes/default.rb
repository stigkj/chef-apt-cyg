#
# Cookbook Name:: cygwin
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/usr/local/bin/apt-cyg" do
  source "apt-cyg.sh"
  mode 0755
  only_if { File.exists?("/usr/local/bin/apt-cyg") }
end