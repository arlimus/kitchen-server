# Install and configure a few misc. extra packages

%w{
  p7zip-full
  colordiff
  tree
}.each{|p| package p}
