#
# Cookbook Name:: service-foundation
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform'].downcase
when 'ubuntu'
  if ['12.04','12.10','13.04','13.10'].include?(node['platform_version'])

    # install ruby for ubuntu 12.04
    package "ruby1.9.3"
    package "ruby1.9.1-full"
    execute "update-alternatives --set ruby /usr/bin/ruby1.9.1"
    execute "update-alternatives --set gem /usr/bin/gem1.9.1"

  else

    package "ruby2.0"
    package "ruby1.9.1-dev"
    package "ruby2.0-dev"

  end
end

# install extra core packages
%w{
  htop
  curl
  build-essential
  vim
  pcregrep
}.each{|p| package p}


template '/etc/vim/vimrc.local' do
  source 'vimrc.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables({
    :tabwidth    => 2,
    :colorscheme => 'monokai'
  })
end

%w{vimcurrent vim74 vim73 vim72 vim71 vim70}.each do |vimfolder|
  cookbook_file 'monokai.vim' do
    path "/usr/share/vim/#{vimfolder}/colors/monokai.vim"
    mode 0644
    owner 'root'
    group 'root'
    only_if do File::directory? "/usr/share/vim/#{vimfolder}/colors" end
  end
end

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