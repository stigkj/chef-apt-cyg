#
# Cookbook Name:: nos
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cyg_package "mintty" do
  action :install
end

cyg_package "zsh" do
  action :install
end

gem_package "git-up" do
  action :install
end
