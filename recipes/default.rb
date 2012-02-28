#
# Cookbook Name:: apt-cyg
# Recipe:: default
#
# Copyright 2011, Stig Kleppe-Jørgensen
#
# All rights reserved - Do Not Redistribute
#

remote_file "/usr/local/bin/apt-cyg" do
  source "http://apt-cyg.googlecode.com/svn/trunk/apt-cyg"
  mode "0755"
  not_if { File.exists?("/usr/local/bin/apt-cyg") }
end

mirror = node["apt-cyg"]["mirror"]
cache_dir = node["apt-cyg"]["cache_dir"]
mirror_dir = "#{cache_dir}/#{mirror.gsub(":", "%3a").gsub("/", "%2f")}"

file "/etc/setup/last-cache" do
  content "#{cache_dir}"
end
file "/etc/setup/last-mirror" do
  content "#{mirror}"
end
directory "#{mirror_dir}" do
  recursive true
end
# This is run only once per run so should not need to add check for only downloading when modified
execute "fetch setup.bz2" do
  # TODO do we need to check for non-existing setup.bz2 and use setup.ini instead?
  command "wget -qO- #{mirror}/setup.bz2 | bzip2 -dc > #{mirror_dir}/setup.ini"
end

# FIXME should this be enabled; Google supports this
# If this is run for every invocation of a package in a recipe, then the above is better
#
#remote_file "/tmp/couch.png" do
#  source "http://couchdb.apache.org/img/sketch.png"
#  action :nothing
#end
#
#http_request "HEAD #{http://couchdb.apache.org/img/sketch.png}" do
#  message ""
#  url http://couchdb.apache.org/img/sketch.png
#  action :head
#
#  if File.exists?("/tmp/couch.png")
#    headers "If-Modified-Since" => File.mtime("/tmp/couch.png").httpdate
#  end
#
#  notifies :create, resources(:remote_file => "/tmp/couch.png"), :immediately
#end