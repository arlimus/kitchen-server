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

  package "libssl-dev"
end

# install extra core packages
%w{
  htop
  netcat
  nethogs
  curl
  build-essential
  autoconf
  vim
  pcregrep
  apparmor-utils
}.each{|p| package p}

cookbook_file 'swap-show' do
  path '/usr/bin/swap-show'
  mode 0755
  owner 'root'
  group 'root'
end

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
  # requirements for berkshelf (Ubuntu)
  %w{
    libxml2
    libxslt-dev
    libxml2-dev
    }.each{|p| package p}

  %w{
    dep-selector-libgecode
    berkshelf
    chef
    foodcritic
  }.each do |name|
    gem_package name do
      options '--no-ri --no-rdoc'
      timeout 1200
    end
  end
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