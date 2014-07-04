name "base"
description "Basic work server configuration"
override_attributes({
  'network' => {
    'forwarding' => true
  }
})

run_list %w{
  recipe[chef-solo-search]
  recipe[os-hardening]
  recipe[ssh-hardening]
  recipe[git]
  recipe[user::data_bag]
  recipe[user-unlock]
  recipe[sudo]
  recipe[service-foundation]
  }
