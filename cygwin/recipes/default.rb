#
# Cookbook Name:: cygwin
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/usr/local/bin/apt-cyg" do
  source "http://apt-cyg.googlecode.com/svn/trunk/apt-cyg"
  mode "0755"
  only_if { File.exists?("/usr/local/bin/apt-cyg") }
end