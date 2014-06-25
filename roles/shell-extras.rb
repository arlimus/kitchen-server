name "shell-extras"
description "Install misc extra contents for your server"
run_list %w{
  role[base]
  recipe[zsh]
  recipe[service-foundation::extra_packages]
  recipe[service-foundation::gitconfig]
  }
default_attributes({
  "oh-my-zsh" => {
    "themes" => [
      "https://raw.githubusercontent.com/arlimus/zero.zsh/master/themes/zero.zsh-theme.base",
      "https://raw.githubusercontent.com/arlimus/zero.zsh/master/themes/zero-dark.zsh-theme",
      "https://raw.githubusercontent.com/arlimus/zero.zsh/master/themes/zero-light.zsh-theme"
    ],
    "plugins" => {
      "zero" => "https://raw.githubusercontent.com/arlimus/zero.zsh/master/plugins/zero/zero.plugin.zsh"
    }
  }
})

