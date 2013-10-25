# Install and configure zsh
# * oh-my-zsh
# * zshrc
# * per-user configuration, depending on databags

def get_userinfo c
  [
    c['id'],
    c['gid'] || 'users',
    c['home'] || File.join('home',uid)
  ]
end

search("users","gitconfig:*").each do |c|
  Chef::Log.info "gitconfig: setting git config for user #{c['id']}"

  # presets
  uid, gid, home = get_userinfo c

  # package requirements
  package "git-core"

  # install the git configuration
  gc_home = File.join home, '.gitconfig'
  template gc_home do
    source "gitconfig.erb"
    mode 0644
    owner uid
    group gid
    variables({
       :name  => c['comment'],
       :email => c['email']
    })
  end

end
