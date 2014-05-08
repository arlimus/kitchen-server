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

# install extra core packages
%w{
  htop
  curl
  build-essential
  vim
}.each{|p| package p}

if node['install_chef']
  %w{
    berkshelf
    chef
    foodcritic
  }.each{|g| gem_package g}
end

if node['install_puppet']
  %w{
    librarian-puppet
    puppet
    puppet-lint
  }.each{|g| gem_package g}
end

if node['install_vagrant']
  %w{
    kitchen-vagrant
    vagrant-berkshelf
  }.each{|g| gem_package g}
end