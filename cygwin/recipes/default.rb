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


# FIXME check if this can be used against Google Code, that is, if it handles if-modified-since headers
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