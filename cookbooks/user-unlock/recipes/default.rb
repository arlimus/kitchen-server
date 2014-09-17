#
# Cookbook Name:: user-unlock
# Recipe:: default
#
# Copyright 2014, Dominik Richter
#
# Licensed under Apache 2.0
#

users_with_unlock_without_password.each do |user|
  # Users which are to be unlocked but
  # don't have a password set, should still be
  # unlocked with an impossible password.
  #
  # This may be necessary to unlock an account for SSH
  # without reverting to setting a password.
  id = user['id']
  execute "unlock user account without password for #{id}" do
    command "usermod -p '*' #{id} && usermod -U #{id}"
    only_if "test -n \"$(grep '^#{id}:\\!' /etc/shadow)\""
  end
end