#
# Cookbook Name:: service-foundation
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install ruby for ubuntu 12.04
package "ruby1.9.3"
package "ruby1.9.1-full"
execute "update-alternatives --set ruby /usr/bin/ruby1.9.1"
execute "update-alternatives --set gem /usr/bin/gem1.9.1"

# install system-wide gems
%w{
  librarian-puppet
  puppet
  berkshelf
  vagrant-berkshelf
  chef
}.each{|g| gem_package g}

# install extra core packages
%w{
  htop
  curl
}.each{|p| package p}