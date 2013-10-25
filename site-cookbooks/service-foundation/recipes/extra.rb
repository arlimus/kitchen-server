# Install and configure a few misc. extra packages

%w{
  p7zip-full
  colordiff
}.each{|p| package p}

include_recipe "service-foundation::gitconfig"