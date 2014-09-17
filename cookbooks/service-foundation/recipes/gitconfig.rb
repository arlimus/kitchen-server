# Add ~/.gitconfig

# per-user config
active_users.compact.
  find_all{|u| u['gitconfig'] == true }.
  each do |c|

  # presets
  u = get_userinfo c

  # package requirements
  package "git-core"

  # install the git configuration
  gc_home = File.join u[:home], '.gitconfig'
  template gc_home do
    source "gitconfig.erb"
    mode 0644
    owner u[:uid]
    group u[:gid]
    variables({
       :name  => c['comment'],
       :email => c['email']
    })
  end

end
