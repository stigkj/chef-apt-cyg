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